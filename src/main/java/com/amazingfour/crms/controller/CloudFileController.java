package com.amazingfour.crms.controller;

import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.ResponseUtil;
import com.amazingfour.common.utils.qiniu.ConfigToken;
import com.amazingfour.common.utils.qiniu.MyUploadToken;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * Created by HelloHuy on 2016-01-05.
 */
@Controller
@RequestMapping("/filec")
public class CloudFileController {
    @Resource
    private CloudFileService cloudFileService;

    /**
     * 跳转到上传页面
     * @return 上传页面地址
     */
    @RequestMapping("/init.htm")
    public String init(){
        return "file/upload";
    }

    /**
     * 获得上传凭证
     * @param response
     */
    @RequestMapping("/getTokenJs.htm")
    public void getUploadTokenJs(HttpServletResponse response){
        String token = MyUploadToken.getMyUpToken();
        JSONObject obj = new JSONObject();
        obj.put("uptoken",token);
        System.out.println(obj);
        ResponseUtil.renderJson(response,obj.toString());
    }

    /**
     * 新增文件信息
     * @param cloudFile
     * @param response
     */
    @RequestMapping("/addFile.htm")
    public void addFile(CloudFile cloudFile,HttpServletResponse response){
        /*System.out.println(cloudFile.getFileName());
        System.out.println(cloudFile.getFileDescript());
        System.out.println(cloudFile.getFileUrl());*/
        cloudFile.setFileDate(new Date());
        cloudFile.setFileState((byte)0);
        cloudFileService.insert(cloudFile);
        JSONObject obj = new JSONObject();
        obj.put("message","插入数据成功");
        ResponseUtil.renderJson(response,obj.toString());
    }
}
