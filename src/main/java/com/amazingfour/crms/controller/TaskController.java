package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.common.utils.qiniu.MyBucketManager;
import com.amazingfour.common.utils.qiniu.MyUploadToken;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.domain.Role;
import com.amazingfour.crms.domain.User;
import com.amazingfour.crms.service.CloudFileService;
import com.amazingfour.crms.service.impl.TaskServiceImp;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hmaccelerate on 2016/4/28.
 */
@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    private TaskServiceImp taskServiceImp;
    @Autowired
    private CloudFileService cloudFileService;
    static Logger logger = Logger.getLogger(TaskController.class.getName());

    /**
     * 待领任务列表/查询待办任务
     *
     * @param page
     * @param httpServletRequest
     * @return
     */
    @RequestMapping("/taskList")
    public ModelAndView showTaskList(@RequestParam(value = "page", required = false) String page, String taskState,
                                     HttpServletRequest httpServletRequest) {
        ModelAndView modelAndView = new ModelAndView("task/taskMain");
        int pageSize = 9; // 页容量

        if (page == null || page == "") {
            page = "1";
        }
        User user = (User) httpServletRequest.getSession().getAttribute("currentUser");
        String userId = user.getUserId().toString();
        int firstResults = (Integer.parseInt(page) - 1) * pageSize;
        int maxResults = Integer.parseInt(page) * pageSize;
        Map<String, Object> mapTask = null;
        HttpSession session = httpServletRequest.getSession();
//       查询待领任务/查询待办任务
        if (taskState.equals("0")) {
            mapTask = taskServiceImp.findToDoTasks(userId, firstResults, maxResults, 0);
        } else {
            mapTask = taskServiceImp.findToDoTasks(userId, firstResults, maxResults, 1);
        }
        List<CloudFile> cloudFileTaskList = (List<CloudFile>) mapTask.get("taskList");
        List<CloudFile> cloudFileList = MyUploadToken.getVframes(cloudFileTaskList);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("taskState", taskState);
        int total = (Integer) mapTask.get("total");
        String pageCode = PageUtil.getPagation("/task/taskList.htm", map,
                total, Integer.parseInt(page), pageSize);
        modelAndView.addObject("pageCode", pageCode);
        modelAndView.addObject("cloudFileList", cloudFileList);
        modelAndView.addObject("taskState", taskState);
        return modelAndView;
    }

    /**
     * 签收任务
     *
     * @param taskId
     * @param session
     * @param response
     * @return
     */
    @RequestMapping("/taskClaim")
    public void taskClaim(String taskId, String fileId, HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("currentUser");
        taskServiceImp.claimTask(taskId, user.getUserId());
        //        设置文件状态为审核中（1）
        Long Id = Long.parseLong(fileId);
        CloudFile cloudFile = cloudFileService.findById(Id);
        String state = "1";
        cloudFile.setFileState(Byte.parseByte(state));
        cloudFileService.update(cloudFile);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "success");
        ResponseUtil.renderJson(response, jsonObject.toString());
    }

    /**
     * 审核通过
     *
     * @param taskId
     * @param fileId
     * @param response
     */
    @RequestMapping("/taskFinish")
    public void taskFinish(String taskId, String fileId, HttpServletResponse response) {
        taskServiceImp.dealWithTask(taskId, "normal", "yes", "");
//        设置文件状态为已审核（2）
        Long Id = Long.parseLong(fileId);
        CloudFile cloudFile = cloudFileService.findById(Id);
        String state = "2";
        cloudFile.setFileState(Byte.parseByte(state));
        cloudFileService.update(cloudFile);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "success");
        ResponseUtil.renderJson(response, jsonObject.toString());
    }

    @RequestMapping("/gotoRejectForm")
    public String gotoReject() {
        return "task/rejectForm";
    }

    /**
     * 审核拒绝
     *
     * @param taskId
     * @param response
     */
    @RequestMapping("/taskReject")
    public void taskReject(String taskId, String fileId, String rejectReseaon, HttpServletResponse response) {
        String state = "3";
        taskServiceImp.dealWithTask(taskId, "normal", "no", rejectReseaon);
        //        设置文件状态为审核未通过（3）
        Long Id = Long.parseLong(fileId);
        CloudFile cloudFile = cloudFileService.findById(Id);
        cloudFile.setFileState(Byte.parseByte(state));
        cloudFileService.update(cloudFile);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "success");
        ResponseUtil.renderJson(response, jsonObject.toString());
    }

    /**
     * 申请二级审核
     *
     * @param taskId
     * @param response
     */
    @RequestMapping("/taskUp")
    public void taskUp(String taskId, HttpServletResponse response) {
        taskServiceImp.dealWithTask(taskId, "important", "", "");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "success");
        ResponseUtil.renderJson(response, jsonObject.toString());
    }

    /**
     * 显示历史任务
     *
     * @param page
     * @param httpServletRequest
     * @return
     */
    @RequestMapping("/showHistroicTask")
    public ModelAndView showHistroicTask(@RequestParam(value = "page", required = false) String page,
                                         HttpServletRequest httpServletRequest) {
        ModelAndView modelAndView = new ModelAndView("task/taskMain");
        int pageSize = 9; // 页容量
        if (page == null || page == "") {
            page = "1";
        }
        User user = (User) httpServletRequest.getSession().getAttribute("currentUser");
        String userId = user.getUserId().toString();
        int firstResults = (Integer.parseInt(page) - 1) * pageSize;
        int maxResults = Integer.parseInt(page) * pageSize;
        Map<String, Object> mapTask = null;
        mapTask = taskServiceImp.showHistoryTasks(userId, firstResults, maxResults);
        List<CloudFile> cloudFileTaskList = (List<CloudFile>) mapTask.get("taskList");
        if (cloudFileTaskList!=null){
            logger.debug("这不是空6666666666666666");
        }
//        List<CloudFile> cloudFileList = MyUploadToken.getVframes(cloudFileTaskList);
        int total = (Integer) mapTask.get("total");
        String pageCode = PageUtil.getPagation("/task/showHistroicTask.htm", null,
                total, Integer.parseInt(page), pageSize);
        modelAndView.addObject("pageCode", pageCode);
        modelAndView.addObject("cloudFileList", cloudFileTaskList);
        return modelAndView;
    }

    @RequestMapping("/listMyFile")
    public ModelAndView listMyFile(
            @RequestParam(value = "page", required = false) String page,
            CloudFile cloudFile, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        int pageSize = 9; // 页容量
        logger.debug("fuck");
        if (page == null || page == "") {
            page = "1";
        }
        String fileName = cloudFile.getFileName();
        Byte fileState = cloudFile.getFileState();
        Map<String, Object> map = new HashMap<String, Object>(); // 使用Map传值到mapper处理
        map.put("start", (Integer.parseInt(page) - 1) * pageSize); // 起始记录
        map.put("size", pageSize);
        map.put("fileName", fileName);
        map.put("fileState", fileState);
        User user = (User) session.getAttribute("currentUser");
        map.put("user_id", user.getUserId());
        //查询数据库并加入视频帧地址
        List<CloudFile> cloudFileList = MyUploadToken.getVframes(cloudFileService.findByUserId(map));
        int total = cloudFileService.countById(map);   //查询记录总数
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("fileName", fileName);
        params.put("fileState", fileState);
        String pageCode = PageUtil.getPagation("/task/listMyFile.htm", params,
                total, Integer.parseInt(page), pageSize);
        mav.addObject("pageCode", pageCode);
        mav.addObject("cloudFileList", cloudFileList);
        mav.setViewName("task/myList");
        return mav;
    }


    /**
     * 查看拒绝理由
     * @param instanceId
     * @param response
     */
    @RequestMapping("/lookReseaon")
    public void lookReseaon(String instanceId, HttpServletResponse response) {
        String reseaon = taskServiceImp.getReseaon(instanceId);
        JSONObject object = new JSONObject();
        object.put("reseaon", reseaon);
        ResponseUtil.renderJson(response, object.toString());
    }

    @RequestMapping("/preAdjust")
    public ModelAndView preAdjust(@RequestParam(value = "fileId") String fileId) {
        ModelAndView mav = new ModelAndView();
        CloudFile cloudFile = cloudFileService.findById(Long.parseLong(fileId));
        mav.addObject("cloudFile", cloudFile);
        mav.setViewName("task/adjustFile");
        return mav;
    }



    @RequestMapping("/receiveAdjust")
    public void receiveAdjust(CloudFile cloudFile, String key, HttpServletResponse response){
        taskServiceImp.dealWithAdjust(cloudFile.getInstanceId(),"yes");
        String state = "0";
        cloudFile.setFileState(Byte.parseByte(state));
        cloudFile.setFileDate(new Date());
        JSONObject obj = new JSONObject();
        if (cloudFileService.update(cloudFile)) {
            if (key != null) {
                MyBucketManager bm = new MyBucketManager();
                bm.delete(key);
            }
            obj.put("mes", "更新成功!");
        } else {
            obj.put("mes", "更新失败!");
        }
        ResponseUtil.renderJson(response, obj.toString());

    }

    @RequestMapping("/rejectAdjust")
    public void rejectAdjust(String instanceId,String fileId, HttpServletResponse response){
        taskServiceImp.dealWithAdjust(instanceId,"no");
        Long id=Long.valueOf(fileId);
        cloudFileService.delete(id);
        JSONObject object = new JSONObject();
        object.put("status", "success");
        ResponseUtil.renderJson(response, object.toString());
    }

}
