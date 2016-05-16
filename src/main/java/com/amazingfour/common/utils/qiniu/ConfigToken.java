package com.amazingfour.common.utils.qiniu;

import com.amazingfour.common.utils.PropertiesUtil;
import com.qiniu.storage.BucketManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;

/**
 * Created by HelloHuy on 2016-01-05.
 */
public class ConfigToken {
    //您的七牛云AccessKey
    private static final String ACCESS_KEY = "BJWnHcjnG5CTmqM7pb4ah0F6Yz1PrBFN-CKUkmlq";
    //您的七牛云SecretKey
    private static final String SECRET_KEY = "yq8CV89NOa534EHydvrh_zUdkYOAF5tGS8f2Xm7d";
    //您在七牛云创建的空间名称(bucket)
    public static final String BUCKETNAME = "testbucket";
    //七牛云下载域名
    private static final String DOWNLOAD_URL="http://7xpdvw.com1.z0.glb.clouddn.com/";


    //初步生成上传下载策略
    private Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);

    /*-----以下4个方法为生成上传凭证的重载方法-----*/
    // 简单上传，使用默认策略
    public String getUpToken(){
        return auth.uploadToken(BUCKETNAME);
    }

    // 覆盖上传
    public String getUpToken(String key){
        return auth.uploadToken(BUCKETNAME, key);
    }

    // 设置指定上传策略
    public String getUpToken(String key, long expires, StringMap policy){
        return auth.uploadToken(BUCKETNAME, key, expires, policy);
    }

    /**
     * 生成上传token
     *
     * @param key     key，资源名称，可为 null
     * @param expires 有效时长，单位秒。默认3600s
     * @param policy  上传策略的其它参数，如 new StringMap().put("endUser", "uid").putNotEmpty("returnBody", "")。
     *                scope通过 bucket、key间接设置，deadline 通过 expires 间接设置
     * @param strict  是否去除非限定的策略字段，默认true
     * @return 生成的上传token
     */
    public String getUpToken(String key, long expires, StringMap policy, boolean strict){
        return auth.uploadToken(BUCKETNAME, key, expires, policy, strict);
    }

    /**
     * 根据资源key名生成下载URL
     * @param key
     * @return 生成的下载URL
     */
    public String getDownloadToken(String key){
        return auth.privateDownloadUrl(DOWNLOAD_URL+key, 3600 * 24);    //指定Token失效时长为24小时
    }

    /**
     * 获得视频元信息的URL
     * @param key
     * @return
     */
    public String getAvinfo(String key){
        return auth.privateDownloadUrl(DOWNLOAD_URL+key+"?avinfo");
    }

    /**
     * 获得视频帧缩略图的URL
     * @param key
     * @return
     */
    public String getVfUrl(String key){
        return auth.privateDownloadUrl(DOWNLOAD_URL+key+"?vframe/png/offset/10/w/256/h/256");
    }

    /**
     * 获得资源管理接口实例
     * @return
     */
    public BucketManager getBucketManager(){
        return new BucketManager(auth);
    }
}
