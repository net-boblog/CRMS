package com.amazingfour.common.utils.qiniu;

import com.qiniu.util.StringMap;

/**
 * Created by Huy on 2016-01-07.
 */
public class MyUploadToken {
    //自定义上传凭证
    public static String getMyUpToken(){
        ConfigToken ct = new ConfigToken();
        long expires = 3600*24;     //设置Token失效时长为24小时
        StringMap policy = new StringMap();
        boolean strict = true;

        //policy.put("","");
        String token = ct.getUpToken(null,expires,policy,strict);
        return token;
    }
}
