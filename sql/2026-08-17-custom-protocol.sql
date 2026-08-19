-- 自定义协议设备、录像计划与菜单。执行前应先执行 2026-08-13-device-classification.sql。
CREATE TABLE IF NOT EXISTS `wvp_custom_device` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_name` varchar(100) NOT NULL,
  `device_code` varchar(100) NOT NULL,
  `stream_url` varchar(1000) NOT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'UNKNOWN',
  `longitude` decimal(10,7) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_custom_device_code` (`device_code`),
  KEY `idx_wvp_custom_device_name` (`device_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义协议设备';

CREATE TABLE IF NOT EXISTS `wvp_custom_record_plan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` bigint NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `week_days` varchar(20) NOT NULL DEFAULT '1,2,3,4,5,6,7',
  `start_time` varchar(5) NOT NULL DEFAULT '00:00',
  `end_time` varchar(5) NOT NULL DEFAULT '23:59',
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_custom_record_plan_device` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义协议录像计划';

CREATE TABLE IF NOT EXISTS `wvp_custom_record_session` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` bigint NOT NULL,
  `media_server_id` varchar(50) NOT NULL,
  `app` varchar(100) NOT NULL,
  `stream` varchar(255) NOT NULL,
  `proxy_key` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `stop_time` datetime DEFAULT NULL,
  `stop_reason` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_wvp_custom_record_session_device_status` (`device_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义协议录像会话';

INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2400,'自定义协议',0,8,'custom',NULL,NULL,'',1,0,'M','0','0','', 'monitor','admin',NOW(),'admin',NOW(),'自定义协议设备'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2400 OR path='custom');

INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2401,'设备管理',2400,1,'device','custom/device/index',NULL,'CustomDevice',1,0,'C','0','0','custom:device:list','monitor','admin',NOW(),'admin',NOW(),'自定义协议设备管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2401 OR component='custom/device/index');

INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2402,'设备查询',2401,1,'#','',NULL,'',1,0,'F','0','0','custom:device:query','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2402);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2403,'设备新增',2401,2,'#','',NULL,'',1,0,'F','0','0','custom:device:add','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2403);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2404,'设备修改',2401,3,'#','',NULL,'',1,0,'F','0','0','custom:device:edit','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2404);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2405,'设备删除',2401,4,'#','',NULL,'',1,0,'F','0','0','custom:device:remove','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2405);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2406,'视频预览',2401,5,'#','',NULL,'',1,0,'F','0','0','custom:device:play','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2406);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2407,'录像管理',2401,6,'#','',NULL,'',1,0,'F','0','0','custom:device:record','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2407);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark)
SELECT 2408,'设备导出',2401,7,'#','',NULL,'',1,0,'F','0','0','custom:device:export','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id=2408);
