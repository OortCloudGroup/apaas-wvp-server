-- WVP 六协议设备的全局区域、分组、标签分类。
CREATE TABLE IF NOT EXISTS `wvp_device_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_type` varchar(16) NOT NULL COMMENT 'REGION/GROUP/TAG',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父分类ID，0为根节点',
  `ancestors` varchar(1000) NOT NULL DEFAULT '0' COMMENT '祖级列表',
  `category_name` varchar(100) NOT NULL COMMENT '分类名称',
  `sort_num` int NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_sibling_name` (`category_type`,`parent_id`,`category_name`),
  KEY `idx_category_parent` (`category_type`,`parent_id`,`sort_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='WVP设备全局分类';

CREATE TABLE IF NOT EXISTS `wvp_device_category_relation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `category_type` varchar(16) NOT NULL COMMENT 'REGION/GROUP/TAG',
  `protocol_type` varchar(16) NOT NULL COMMENT 'ISUP/RTSP/ONVIF/GB28181/DAHUA/VLSTREAM',
  `device_key` varchar(128) NOT NULL COMMENT '协议设备表主键，按字符串保存',
  `create_by` varchar(64) DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_device_category` (`protocol_type`,`device_key`,`category_id`),
  KEY `idx_category_protocol` (`category_id`,`protocol_type`),
  KEY `idx_device_category_type` (`protocol_type`,`device_key`,`category_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='WVP设备分类关系';
