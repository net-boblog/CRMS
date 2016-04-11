#CRMS系统说明

##数据库更新记录
2016-04-11 16:59:46
由于添加了邮箱找回密码的功能，在user表增加了4个字段，执行以下sql更新user表即可：
alter table `user` add
(`user_email` varchar(255) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  `email_key` varchar(512) DEFAULT NULL,
  `out_date` datetime DEFAULT NULL);
  
