//初始化上传文件的方法
//function initUploader(){
$(function() {
    /*var form,fileName,fileDes;
    form = $("#fileForm");
    fileName = $("#fileNameId").val();
    fileDes = $("#fileIntroId").val();*/

    $("#start_upload").click(function(){
        uploader.start();
    });

    var uploader = Qiniu.uploader({
        runtimes: 'html5,html4',    //上传模式,依次退化
        browse_button: 'pickfiles',       //上传选择的点选按钮，**必需**
        uptoken_url: '/filec/getTokenJs.htm',   //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
        // uptoken : '<Your upload token>',
        //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
        unique_names: true, // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
        // save_key: true,
        // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
        domain: 'http://7xpdvw.com1.z0.glb.clouddn.com/',   //bucket 域名，下载资源时用到，**必需**
        container: 'container',           //上传区域DOM ID，默认是browser_button的父元素，
        max_file_size: '100mb',           //最大文件体积限制
        //flash_swf_url: 'js/plupload/Moxie.swf',  //引入flash,相对路径
        max_retries: 3,                   //上传失败最大重试次数
        dragdrop: true,                   //开启可拖曳上传
        drop_element: 'container',        //拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
        chunk_size: '4mb',                //分块上传时，每片的体积
        auto_start: false,                //选择文件后自动上传，若关闭需要自己绑定事件触发上传
        multi_selection: false,           //设置一次只能选择单个文件上传
        init: {
            'FilesAdded': function (up, files) {
                plupload.each(files, function (file) {
                    // 文件添加进队列后,处理相关的事情
                    //限制为单文件上传
                    //console.log("文件为:"+file.name);
                    if (up.files.length <= 1) {
                        //return;
                    }else{
                        up.removeFile(up.files[0]);    //删除之前已添加的文件
                        //up.splice(1,99);  //表示删除从1到99的文件，不包括1
                    }
                    var fName = up.files[0].name;
                    var fsname = fName.substring(0,fName.lastIndexOf("."));
                    $("#fileNameId").val(fsname);
                });
            },
            'BeforeUpload': function (up, file) {
                // 每个文件上传前,处理相关的事情
            },
            'UploadProgress': function (up, file) {
                // 每个文件上传时,处理相关的事情
            },
            'FileUploaded': function (up, file, info) {
                // 每个文件上传成功后,处理相关的事情
                // 其中 info 是文件上传成功后，服务端返回的json，形式如
                // {
                //    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                //    "key": "gogopher.jpg"
                //  }
                // 参考http://developer.qiniu.com/docs/v6/api/overview/up/response/simple-response.html
                //var domain = up.getOption('domain');
                var res = Qiniu.parseJSON(info);
                var keyName = res.key;
                //var sourceLink = domain + res.key; //获取上传成功后的文件的Url
                /*//使用formData方式格式化数据(不可用)
                var form = $("#fileForm");
                var fileName = $("#fileNameId").val();
                var fileDes = $("#fileIntroId").val();
                var formData = new FormData();
                formData.append("fileName",fileName);
                formData.append("fileDescript",fileDes);
                formData.append("fileUrl",sourceLink);*/
                //序列化表单数据
                var params = $("#fileForm").serializeArray();
                params.push({name:"fileUrl",value:keyName});
                //异步保存上传文件信息
                $.ajax({
                    type:"POST",
                    url:"/filec/addFile.htm",
                    data:params,
                    cache:false,
                    //contentType:false,    //使用formData时，contentType不交给jquery处理，由xhr处理
                    //processData:false,    //使用formData时，processData不交给jquery处理,由xhr处理
                    success:function(data,status){

                        alert(status + data.message);
                    },
                    error:function(xhr,status,ex){
                        alert(status+":保存失败");
                    }
                });

            },
            'Error': function (up, err, errTip) {
                //上传出错时,处理相关的事情
            },
            'UploadComplete': function () {
                //队列文件处理完毕后,处理相关的事情
            },
            'Key': function (up, file) {
                // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
                // 该配置必须要在 unique_names: false , save_key: false 时才生效
                var key = "";
                // do something with key here
                return key
            }
        }
    });
    // domain 为七牛空间（bucket)对应的域名，选择某个空间后，可通过"空间设置->基本设置->域名设置"查看获取
    // uploader 为一个plupload对象，继承了所有plupload的方法，参考http://plupload.com/docs
//}

});