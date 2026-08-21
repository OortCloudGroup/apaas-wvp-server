-- WVP-owned VLStream RootFS firmware repository and OTA task state machine.
-- Existing WVP schemas are baselined at 1.2.0, so this migration runs on the next startup.

SET @vlstream_device_model_exists = (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'wvp_vlstream_device'
    AND COLUMN_NAME = 'device_model'
);
SET @vlstream_device_model_ddl = IF(
  @vlstream_device_model_exists = 0,
  'ALTER TABLE `wvp_vlstream_device` ADD COLUMN `device_model` varchar(128) DEFAULT NULL AFTER `device_serial`',
  'SELECT 1'
);
PREPARE vlstream_device_model_stmt FROM @vlstream_device_model_ddl;
EXECUTE vlstream_device_model_stmt;
DEALLOCATE PREPARE vlstream_device_model_stmt;

CREATE TABLE IF NOT EXISTS `wvp_vlstream_firmware` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `camera_model` varchar(128) NOT NULL,
  `target` varchar(16) NOT NULL DEFAULT 'rootfs',
  `firmware_version` varchar(64) NOT NULL,
  `bucket` varchar(128) NOT NULL,
  `object_key` varchar(512) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `content_type` varchar(128) NOT NULL,
  `file_size` bigint NOT NULL,
  `sha256` char(64) DEFAULT NULL,
  `upload_status` varchar(20) NOT NULL,
  `upload_expires_at` datetime NOT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_vlstream_firmware_version` (`camera_model`,`target`,`firmware_version`),
  UNIQUE KEY `uk_wvp_vlstream_firmware_object` (`bucket`,`object_key`),
  KEY `idx_wvp_vlstream_firmware_ready` (`camera_model`,`target`,`upload_status`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VLStream RootFS firmware repository';

CREATE TABLE IF NOT EXISTS `wvp_vlstream_firmware_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_id` varchar(64) NOT NULL,
  `mqtt_message_id` varchar(64) NOT NULL,
  `device_row_id` bigint NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `device_model` varchar(128) NOT NULL,
  `target` varchar(16) NOT NULL DEFAULT 'rootfs',
  `current_version` varchar(64) NOT NULL,
  `target_version` varchar(64) NOT NULL,
  `firmware_id` bigint NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_size` bigint NOT NULL,
  `sha256` char(64) NOT NULL,
  `rollback_enable` tinyint(1) NOT NULL DEFAULT 1,
  `reboot_after` tinyint(1) NOT NULL DEFAULT 1,
  `deploy_status` varchar(24) NOT NULL,
  `mqtt_topic` varchar(255) NOT NULL,
  `download_expires_at` bigint NOT NULL,
  `published_at` datetime DEFAULT NULL,
  `last_reply_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `failure_reason` varchar(2000) DEFAULT NULL,
  `reply_payload` text,
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `active_slot` tinyint GENERATED ALWAYS AS (
    CASE WHEN `deploy_status` IN ('CREATED','PUBLISHED','ACCEPTED','DOWNLOADING','VERIFYING','INSTALLING','REBOOTING') THEN 1 ELSE NULL END
  ) STORED,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_wvp_vlstream_firmware_task_request` (`request_id`),
  UNIQUE KEY `uk_wvp_vlstream_firmware_task_message` (`mqtt_message_id`),
  UNIQUE KEY `uk_wvp_vlstream_firmware_task_active` (`device_row_id`,`target`,`active_slot`),
  KEY `idx_wvp_vlstream_firmware_task_device` (`device_row_id`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VLStream RootFS OTA task';

INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2310,'固件查询',2301,10,'#','',NULL,'',1,0,'F','0','0','vlstream:firmware:list','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2310);
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2311,'固件上传',2301,11,'#','',NULL,'',1,0,'F','0','0','vlstream:firmware:upload','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2311);
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2312,'固件下载',2301,12,'#','',NULL,'',1,0,'F','0','0','vlstream:firmware:download','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2312);
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2313,'固件删除',2301,13,'#','',NULL,'',1,0,'F','0','0','vlstream:firmware:remove','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2313);
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`)
SELECT 2314,'固件下发',2301,14,'#','',NULL,'',1,0,'F','0','0','vlstream:firmware:deploy','#','admin',NOW(),'admin',NOW(),''
WHERE NOT EXISTS (SELECT 1 FROM `sys_menu` WHERE `menu_id`=2314);
