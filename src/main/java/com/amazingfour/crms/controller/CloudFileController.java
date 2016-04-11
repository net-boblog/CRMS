package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.PageUtil;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.common.utils.qiniu.ConfigToken;
import com.amazingfour.common.utils.qiniu.MyBucketManager;
import com.amazingfour.common.utils.qiniu.MyUploadToken;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by HelloHuy on 2016-01-05.
 */
@Controller
@RequestMapping("/filec")
public class CloudFileController {
    @Resource
    private CloudFileService cloudFileService;

    //跳转到视频管理页面
    @RequestMapping("/init")
    public String init(){
        return "file/fileMain";
    }

    //跳转到上传页面
    @RequestMapping("/gotoUpload")
    public String gotoUpload(){
        return "file/upload";
    }

    /**
     * 获得上传凭证
     * @param response
     */
    @RequestMapping("/getTokenJs")
    public void getUploadTokenJs(HttpServletResponse response){
        String token = MyUploadToken.getMyUpToken();
        JSONObject obj = new JSONObject();
        obj.put("uptoken",token);
        //System.out.println(obj);
        ResponseUtil.renderJson(response,obj.toString());
    }

    /**
     * 新增文件信息
     * @param cloudFile
     * @param response
     */
    @RequestMapping("/addFile")
    public void addFile(CloudFile cloudFile,HttpServletResponse response){
        cloudFile.setFileDate(new Date());
        //cloudFile.setFileState((byte)0);
        cloudFileService.insert(cloudFile);
        JSONObject obj = new JSONObject();
        obj.put("message","保存成功!");
        ResponseUtil.renderJson(response,obj.toString());
    }

    /**
     * 分页模糊查询文件(包含查询所有)
     * @param page
     * @param cloudFile
     * @return
     */
    @RequestMapping("/listFile")
    public ModelAndView listFile(
            @RequestParam(value = "page", required = false) String page,
            CloudFile cloudFile) {
        ModelAndView mav = new ModelAndView();
        int pageSize = 8; // 页容量

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
        //查询数据库并加入视频帧地址
        List<CloudFile> cloudFileList = MyUploadToken.getVframes(cloudFileService.find(map));

        int total =cloudFileService.count(cloudFile);   //查询记录总数

        Map<String,Object> params = new HashMap<String,Object>();
        params.put("fileName",fileName);
        params.put("fileState",fileState);
        String pageCode = PageUtil.getPagation("/filec/listFile.htm",params,
                total, Integer.parseInt(page),pageSize);

        mav.addObject("pageCode", pageCode);
        mav.addObject("cloudFileList", cloudFileList);
        mav.setViewName("file/fileMain");
        return mav;
    }

    /**
     * 获得七牛云文件下载URL
     * @param key
     * @param response
     */
    @RequestMapping("/getDownloadUrl")
    public void getDownloadUrl(@RequestParam(value="key") String key,HttpServletResponse response){
        ConfigToken ct = new ConfigToken();
        //System.out.println(key);
        String downloadUrl = ct.getDownloadToken(key);
        //System.out.println(downloadUrl);
        JSONObject obj = new JSONObject();
        obj.put("downloadUrl",downloadUrl);
        ResponseUtil.renderJson(response, obj.toString());
    }

    /**
     * 批量删除文件
     * @param fileUrl
     * @param response
     */
    @RequestMapping("/delFiles")
    public void delFiles(String[] fileUrl,HttpServletResponse response){
        JSONObject obj = new JSONObject();

        //判断fileUrl是否为空
        if(fileUrl==null || fileUrl.length==0){
            obj.put("mes", "请至少选择一项!");
            ResponseUtil.renderJson(response, obj.toString());
            return;
        }

        //批量删除七牛云文件
        MyBucketManager bm = new MyBucketManager();
        List<String> fileUrlList = bm.deleteBatch(fileUrl);

        if(fileUrlList==null || fileUrlList.isEmpty()) {
            obj.put("mes", "Qiniu删除失败!");
        }else{
            int rows = cloudFileService.deleteBatch(fileUrlList);
            int len = fileUrl.length;
            if(rows==0){
                obj.put("mes", "Database删除失败!");
            }else if(rows<len){
                obj.put("mes", "部分删除失败!");
            }else if(rows==len){
                obj.put("mes", "删除成功!");
            }else{
                obj.put("mes", "未知错误!");
            }
        }
        ResponseUtil.renderJson(response, obj.toString());
    }

    /**
     * 文件信息更新前置
     * @param fileId
     * @return
     */
    @RequestMapping("/preUpdate")
    public ModelAndView preUpdate(@RequestParam(value="fileId") String fileId){
        ModelAndView mav = new ModelAndView();
        CloudFile cloudFile = cloudFileService.findById(Long.parseLong(fileId));
        mav.addObject("cloudFile",cloudFile);
        mav.setViewName("file/editFile");
        return mav;
    }

    /**
     * 获得更新视频的重新上传凭证
     * @param key
     * @param response
     */
    @RequestMapping("/getReTokenJs")
    public void getReUpTokenJs(@RequestParam(value="key") String key,HttpServletResponse response){
        String token = MyUploadToken.getReUpToken(key);
        JSONObject obj = new JSONObject();
        obj.put("uptoken",token);
        //System.out.println(obj);
        ResponseUtil.renderJson(response,obj.toString());
    }

    /**
     * 更新文件信息
     * @param cloudFile
     * @param response
     */
    @RequestMapping("/updateFile")
    public void updateFile(CloudFile cloudFile,String key,HttpServletResponse response){
        cloudFile.setFileDate(new Date());
        JSONObject obj = new JSONObject();
        if(cloudFileService.update(cloudFile)){
            if(key!=null){
                MyBucketManager bm = new MyBucketManager();
                bm.delete(key);
            }
            obj.put("mes","更新成功!");
        }else{
            obj.put("mes","更新失败!");
        }
        ResponseUtil.renderJson(response,obj.toString());
    }
}
