#CRMS系统说明

##数据库更新记录
**2016-04-11 16:59:46**  
由于添加了邮箱找回密码的功能，在user表增加了4个字段，执行以下sql更新user表即可:
```sql
alter table `user` add
(`user_email` varchar(255) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  `email_key` varchar(512) DEFAULT NULL,
  `out_date` datetime DEFAULT NULL);
```
**2016-04-20 21:27:54**  
cloudfile表加入一些数据，如下(直接执行即可)：  
```sql
insert  into `cloudfile`(`file_id`,`file_name`,`file_url`,`file_date`,`file_descript`,`file_state`) values (1,'黑名单-S01E12','o_1a8rcen951h803jvam5gl3fue9.flv','2016-01-13 01:00:43','123喀喀喀',0),(2,'苹果Surface Pro 3触控笔使用演示','o_1a9bqpsnn1rp8a25rbifgga7s9.mp4','2016-02-17 14:23:32','surface pro3的演示233',0),(3,'苹果Apple Ad iPad mini Piano','o_1a9br7ao61brgu23bodb8q12gu9.mp4','2016-02-17 14:22:59','Apple iPad very good! Do you like Apple! ',0),(4,'苹果Apple iPhone Brilliant','o_1a9braq4od52d2nlesoar5979.mp4','2016-02-17 14:23:08','',0),(5,'【爱范儿评测】Surface Pro 3 上手评测_高清','o_1abve48gr12loibd6r91gnc5r09.mp4','2016-02-20 21:33:25','',0);
```
**2016-05-15 **
数据库表更新，更新内容为cloudfile添加了新的字段，user_file表增加和更改了字段。具体情况，请查看resource底下的sql文件
