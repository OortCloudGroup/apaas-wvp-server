-- VLStream native MQTT device module. This domain is intentionally separate
-- from the legacy/custom-protocol device tables.
CREATE TABLE IF NOT EXISTS `wvp_vlstream_device` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` varchar(100) NOT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  `device_serial` varchar(128) DEFAULT NULL,
  `firmware_version` varchar(64) DEFAULT NULL,
  `face_version` varchar(64) DEFAULT NULL,
  `ip_addr` varchar(64) DEFAULT NULL,
  `mac` varchar(32) DEFAULT NULL,
  `online` tinyint(1) NOT NULL DEFAULT 0,
  `online_reason` varchar(64) DEFAULT NULL,
  `heartbeat_index` bigint DEFAULT NULL,
  `last_message_id` varchar(64) DEFAULT NULL,
  `last_reported_at` datetime DEFAULT NULL,
  `last_heartbeat_time` datetime DEFAULT NULL,
  `telemetry_json` text,
  `service_status_json` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_vlstream_device_id` (`device_id`),
  KEY `idx_wvp_vlstream_online_heartbeat` (`online`,`last_heartbeat_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VLStream MQTT device';

CREATE TABLE IF NOT EXISTS `wvp_vlstream_device_stream` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_row_id` bigint NOT NULL,
  `channel_id` varchar(64) NOT NULL,
  `stream_name` varchar(255) DEFAULT NULL,
  `stream_type` varchar(32) NOT NULL,
  `protocol` varchar(16) NOT NULL,
  `source_url` varchar(2048) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `zlm_app` varchar(64) DEFAULT NULL,
  `zlm_stream` varchar(128) DEFAULT NULL,
  `zlm_proxy_key` varchar(255) DEFAULT NULL,
  `last_report_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_vlstream_stream` (`device_row_id`,`channel_id`,`stream_type`),
  KEY `idx_wvp_vlstream_stream_available` (`device_row_id`,`available`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VLStream MQTT device stream';

CREATE TABLE IF NOT EXISTS `wvp_vlstream_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` varchar(100) NOT NULL,
  `message_id` varchar(64) NOT NULL,
  `reported_at` datetime DEFAULT NULL,
  `received_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_vlstream_message` (`device_id`,`message_id`),
  KEY `idx_wvp_vlstream_message_received` (`received_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VLStream MQTT message idempotency';

-- No role is hard-coded. Administrators see the menu automatically; other
-- roles can be granted these menu entries through the existing role UI.
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2300,'VLStream',0,5,'vlstream',NULL,NULL,'VLStream',1,0,'M','0','0','', 'monitor','admin',NOW(),'admin',NOW(),'VLStream原生MQTT设备'
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2300 OR (`parent_id`=0 AND `path`='vlstream'));

INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2301,'设备管理',2300,1,'device','vlstream/device/index',NULL,'VlStreamDevice',1,0,'C','0','0','vlstream:device:list','rtspDevice','admin',NOW(),'admin',NOW(),'VLStream设备管理'
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2301 OR (`parent_id`=2300 AND `path`='device'));

INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2302,'设备查询',2301,1,'#','',NULL,'',1,0,'F','0','0','vlstream:device:list','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2302);

INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2303,'视频预览',2301,2,'#','',NULL,'',1,0,'F','0','0','vlstream:device:play','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2303);
