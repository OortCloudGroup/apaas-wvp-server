/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : localhost:3306
 Source Schema         : ry-wvp

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 07/10/2025 14:38:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dahua_device
-- ----------------------------
DROP TABLE IF EXISTS `dahua_device`;
CREATE TABLE `dahua_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `device_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备编号',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'ip',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '摄像头名称',
  `port` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '端口',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '密码',
  `channel` bigint(10) NULL DEFAULT NULL COMMENT '通道号',
  `play_type` char(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '播放类型（1=本地，2=推流，3=EasyNTS）',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '直播流播放地址',
  `stream_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '流id',
  `easy_NTS_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'EasyNTS播放地址',
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `address_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地图定位地址',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '大华sdk设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dahua_device
-- ----------------------------

-- ----------------------------
-- Table structure for dahua_device_screenshot
-- ----------------------------
DROP TABLE IF EXISTS `dahua_device_screenshot`;
CREATE TABLE `dahua_device_screenshot`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dahua_device_id` bigint(20) NULL DEFAULT NULL COMMENT '大华设备编号',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '抓图路径',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '大华设备抓图表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dahua_device_screenshot
-- ----------------------------

-- ----------------------------
-- Table structure for g_goview_project
-- ----------------------------
DROP TABLE IF EXISTS `g_goview_project`;
CREATE TABLE `g_goview_project`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '项目名称',
  `state` bigint(20) NULL DEFAULT -1 COMMENT '状态',
  `index_image` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '索引图像',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '大屏显示项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of g_goview_project
-- ----------------------------

-- ----------------------------
-- Table structure for g_goview_project_data
-- ----------------------------
DROP TABLE IF EXISTS `g_goview_project_data`;
CREATE TABLE `g_goview_project_data`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `content` longblob NULL COMMENT '索引图像',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '大屏显示项目内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of g_goview_project_data
-- ----------------------------

-- ----------------------------
-- Table structure for g_sqlite_master
-- ----------------------------
DROP TABLE IF EXISTS `g_sqlite_master`;
CREATE TABLE `g_sqlite_master`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '类型',
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `tbl_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '项目名称',
  `rootpage` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '根页面',
  `SQL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'SQL',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'SQLmaster表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of g_sqlite_master
-- ----------------------------

-- ----------------------------
-- Table structure for g_sys_file
-- ----------------------------
DROP TABLE IF EXISTS `g_sys_file`;
CREATE TABLE `g_sys_file`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文件名',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `file_suffix` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '文件名',
  `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'MD5',
  `relative_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '相对路径',
  `absolute_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '绝对路径',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '大屏显示文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of g_sys_file
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for isup_device
-- ----------------------------
DROP TABLE IF EXISTS `isup_device`;
CREATE TABLE `isup_device`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `device_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `channel` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '通道',
  `play_type` char(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '播放类型（1=本地，2=推流，3=EasyNTS）',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '播放路径',
  `stream_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '流id',
  `easy_NTS_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'EasyNTS播放地址',
  `dw_size` int(11) NULL DEFAULT NULL COMMENT '设备注册信息的大小',
  `dw_net_unit_type` int(11) NULL DEFAULT NULL COMMENT '网络单元类型',
  `firmware_version` varchar(24) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '固件版本',
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备的 IP 地址',
  `port` int(11) NULL DEFAULT NULL COMMENT '设备的端口号',
  `device_res` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备的保留字段',
  `dev_type` int(11) NULL DEFAULT NULL COMMENT '设备类型',
  `manufacture` int(11) NULL DEFAULT NULL COMMENT '设备的制造商标识',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '密码',
  `device_serial` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备的序列号',
  `reliable_transmission` tinyint(4) NULL DEFAULT NULL COMMENT '可靠传输标志',
  `websocket_transmission` tinyint(4) NULL DEFAULT NULL COMMENT 'WebSocket 传输标志',
  `support_redirect` tinyint(4) NULL DEFAULT NULL COMMENT '设备支持重定向注册 0-不支持 1-支持',
  `dev_protocol_version` varchar(6) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备协议版本',
  `session_key` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'Ehome5.0设备SessionKey',
  `res` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '0-无效（未知类型）,1-经销型，2-行业型',
  `market_type` tinyint(4) NULL DEFAULT NULL COMMENT '保留字段',
  `luser_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '1' COMMENT '状态（OFFLINE=离线,ON=在线）',
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `address_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地图定位地址',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'isup设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of isup_device
-- ----------------------------

-- ----------------------------
-- Table structure for lc_capture
-- ----------------------------
DROP TABLE IF EXISTS `lc_capture`;
CREATE TABLE `lc_capture`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片地址',
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备id',
  `channel_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '通道id',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '设备抓拍表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lc_capture
-- ----------------------------

-- ----------------------------
-- Table structure for lc_config
-- ----------------------------
DROP TABLE IF EXISTS `lc_config`;
CREATE TABLE `lc_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '应用名称',
  `app_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户appKey',
  `secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户secret',
  `enable` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '启用状态（0=启用,1=禁用）',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'access_token',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '乐橙监控配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lc_config
-- ----------------------------

-- ----------------------------
-- Table structure for onvif_device
-- ----------------------------
DROP TABLE IF EXISTS `onvif_device`;
CREATE TABLE `onvif_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'ip',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '摄像头名称',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '密码',
  `play_type` char(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '播放类型（1=本地，2=推流，3=EasyNTS）',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '默认直播流播放地址',
  `stream_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '流id',
  `easy_NTS_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'EasyNTS播放地址',
  `firm` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备厂商',
  `model` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备型号',
  `channel` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '通道',
  `firmware_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '固件版本',
  `stream_uris` json NULL COMMENT '球机多条播放',
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `address_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地图定位地址',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'onvif 设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onvif_device
-- ----------------------------

-- ----------------------------
-- Table structure for plug_zlm_rtmp
-- ----------------------------
DROP TABLE IF EXISTS `plug_zlm_rtmp`;
CREATE TABLE `plug_zlm_rtmp`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rtmp_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'zlm rtmp地址',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '认证签名',
  `call_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义播放鉴权Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plug_zlm_rtmp
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for rtsp_device
-- ----------------------------
DROP TABLE IF EXISTS `rtsp_device`;
CREATE TABLE `rtsp_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'ip',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '摄像头名称',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '密码',
  `channel` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '通道号',
  `play_type` char(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '播放类型（1=本地，2=推流，3=EasyNTS）',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '直播流播放地址',
  `stream_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '流id',
  `easy_NTS_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'EasyNTS播放地址',
  `firm` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备厂商',
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `address_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地图定位地址',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'rtsp设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rtsp_device
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-04-03 09:03:39', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-04-03 09:03:39', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-04-03 09:03:39', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-04-03 09:03:39', 'admin', '2025-07-17 22:00:09', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-04-03 09:03:39', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-04-03 09:03:39', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (8, '是否开启关注公众号演示', 'sys_public_demonstrate', 'false', 'Y', 'admin', '2025-04-21 14:43:00', 'admin', '2025-05-14 11:55:47', '（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (9, 'rtsp播放地址', 'sys_rtsp_address', 'http://127.0.0.1:4000', 'Y', 'admin', '2025-04-24 11:12:45', 'admin', '2025-09-20 12:40:37', NULL);
INSERT INTO `sys_config` VALUES (10, '大屏地址', 'sys_large_address', 'http://localhost:8112/', 'Y', 'admin', '2025-05-06 09:06:41', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (11, '是否开启点击star演示', 'sys_gitee_star', 'false', 'Y', 'admin', '2025-05-14 15:20:35', 'admin', '2025-05-16 11:04:21', '（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (12, '高德密钥', 'amap.security.key', '', 'Y', 'admin', '2025-05-26 09:38:38', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (13, '高德key', 'amap.key', '', 'Y', 'admin', '2025-05-26 09:39:16', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (14, 'goview大屏地址', 'sys_goview_address', 'http://localhost:3000/#/project/items', 'Y', 'admin', '2025-05-26 15:17:25', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (15, '后台管理端登录地址', 'sys_web_address', 'http://localhost/login', 'Y', 'admin', '2025-05-28 09:01:54', 'admin', '2025-05-28 09:02:44', NULL);
INSERT INTO `sys_config` VALUES (17, '地图中心点', 'map_center', '39.906217, 116.3912757', 'Y', 'admin', '2025-08-01 15:58:59', '', NULL, '纬度, 经度');
INSERT INTO `sys_config` VALUES (18, '乐橙播放地址', 'sys_lecheng_play_address', 'http://localhost:4002/', 'Y', 'admin', '2025-08-25 16:27:52', 'admin', '2025-09-09 15:36:18', '乐橙播放地址');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'ry-wvp', 0, 'ry-wvp', '15888888888', 'ry-wvp@qq.com', '0', '0', 'admin', '2025-04-03 09:03:39', 'admin', '2025-04-18 10:55:40');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '广州总公司', 1, 'ry-wvp', '15888888888', 'ry-wvp@qq.com', '0', '0', 'admin', '2025-04-03 09:03:39', 'admin', '2025-04-18 10:56:23');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-03 09:03:39', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (30, 1, '海康', '1', 'rtsp_manufacturer', NULL, 'primary', 'N', '0', 'admin', '2025-04-22 10:15:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (31, 2, '大华', '2', 'rtsp_manufacturer', NULL, 'primary', 'N', '0', 'admin', '2025-04-22 10:15:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (32, 3, '宇视', '3', 'rtsp_manufacturer', NULL, 'primary', 'N', '0', 'admin', '2025-04-22 10:15:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (33, 4, '水星', '4', 'rtsp_manufacturer', NULL, 'primary', 'N', '0', 'admin', '2025-04-22 10:15:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (34, 1, '本地', '1', 'play_type', NULL, 'primary', 'N', '0', 'admin', '2025-06-21 05:10:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (35, 2, '推流', '2', 'play_type', NULL, 'primary', 'N', '0', 'admin', '2025-06-21 05:10:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (36, 3, 'EasyNTS', '3', 'play_type', NULL, 'primary', 'N', '0', 'admin', '2025-06-21 05:10:25', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (37, 0, '启用', '0', 'yingshi_enable', NULL, 'success', 'N', '0', 'admin', '2025-07-31 12:55:06', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (38, 1, '禁用', '1', 'yingshi_enable', NULL, 'danger', 'N', '0', 'admin', '2025-07-31 12:55:38', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (39, 1, '在线', '1', 'yingshi_online_status', NULL, 'success', 'N', '0', 'admin', '2025-07-31 15:20:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (40, 0, '离线', '0', 'yingshi_online_status', NULL, 'danger', 'N', '0', 'admin', '2025-07-31 15:20:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (41, 1, '高清（主码流）', '1', 'yingshi_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 17:23:02', 'admin', '2025-07-31 17:23:23', NULL);
INSERT INTO `sys_dict_data` VALUES (42, 2, '流畅（子码流）', '2', 'yingshi_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 17:23:12', 'admin', '2025-07-31 17:23:31', NULL);
INSERT INTO `sys_dict_data` VALUES (43, 1, '预览', '1', 'yingshi_address_type', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 17:23:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (44, 2, '本地录像回放', '2', 'yingshi_address_type', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 17:23:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (45, 3, '云存储录像回放', '3', 'yingshi_address_type', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 17:24:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (46, 0, '不在线', '0', 'yingshi_monitoring_status', NULL, 'default', 'N', '0', 'admin', '2025-07-31 18:09:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (47, 1, '在线', '1', 'yingshi_monitoring_status', NULL, 'success', 'N', '0', 'admin', '2025-07-31 18:09:57', 'admin', '2025-07-31 18:10:02', NULL);
INSERT INTO `sys_dict_data` VALUES (48, 0, '隐藏', '0', 'yingshi_camera_is_add', NULL, 'default', 'N', '0', 'admin', '2025-07-31 18:10:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (49, 1, '显示', '1', 'yingshi_camera_is_add', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 18:11:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (50, 0, '流畅', '0', 'yingshi_camera_video_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 18:12:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (51, 1, '均衡', '1', 'yingshi_camera_video_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 18:12:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (52, 2, '高清', '2', 'yingshi_camera_video_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 18:12:18', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (53, 3, '超清', '3', 'yingshi_camera_video_quality', NULL, 'primary', 'N', '0', 'admin', '2025-07-31 18:12:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (54, 0, '不加密', '0', 'yingshi_camera_is_encrypt', NULL, 'default', 'N', '0', 'admin', '2025-07-31 18:13:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (55, 1, '加密', '1', 'yingshi_camera_is_encrypt', NULL, 'default', 'N', '0', 'admin', '2025-07-31 18:13:29', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (56, 1, 'ezopen', '1', 'yingshi_protocol', NULL, 'primary', 'N', '0', 'admin', '2025-08-01 12:39:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (57, 2, 'hls', '2', 'yingshi_protocol', NULL, 'primary', 'N', '0', 'admin', '2025-08-01 12:39:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (58, 3, 'rtmp', '3', 'yingshi_protocol', NULL, 'primary', 'N', '0', 'admin', '2025-08-01 12:39:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (59, 0, '启用', '0', 'lecheng_enable', NULL, 'success', 'N', '0', 'admin', '2025-08-06 13:17:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (60, 1, '禁用', '1', 'lecheng_enable', NULL, 'danger', 'N', '0', 'admin', '2025-08-06 13:18:28', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (61, 4, 'SDK播放', '4', 'play_type', NULL, 'primary', 'N', '0', 'admin', '2025-09-22 12:44:21', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, 'rtsp厂商', 'rtsp_manufacturer', '0', 'admin', '2025-04-22 10:14:46', '', NULL, 'rtsp厂商');
INSERT INTO `sys_dict_type` VALUES (12, '播放类型', 'play_type', '0', 'admin', '2025-06-21 05:08:11', '', NULL, '播放类型');
INSERT INTO `sys_dict_type` VALUES (13, '萤石配置启用状态', 'yingshi_enable', '0', 'admin', '2025-07-31 12:54:53', '', NULL, '萤石配置启用状态');
INSERT INTO `sys_dict_type` VALUES (14, '设备在线状态', 'yingshi_online_status', '0', 'admin', '2025-07-31 15:19:45', '', NULL, '设备在线状态');
INSERT INTO `sys_dict_type` VALUES (15, '视频清晰度', 'yingshi_quality', '0', 'admin', '2025-07-31 17:22:20', '', NULL, '视频清晰度');
INSERT INTO `sys_dict_type` VALUES (16, '地址类型', 'yingshi_address_type', '0', 'admin', '2025-07-31 17:22:43', '', NULL, '地址类型');
INSERT INTO `sys_dict_type` VALUES (17, '通道在线状态', 'yingshi_monitoring_status', '0', 'admin', '2025-07-31 18:09:27', '', NULL, '通道在线状态');
INSERT INTO `sys_dict_type` VALUES (18, '通道是否显示', 'yingshi_camera_is_add', '0', 'admin', '2025-07-31 18:10:27', '', NULL, '通道是否显示');
INSERT INTO `sys_dict_type` VALUES (19, '通道视频质量', 'yingshi_camera_video_quality', '0', 'admin', '2025-07-31 18:11:49', 'admin', '2025-07-31 18:13:06', '通道视频质量');
INSERT INTO `sys_dict_type` VALUES (20, '通道是否加密', 'yingshi_camera_is_encrypt', '0', 'admin', '2025-07-31 18:12:59', 'admin', '2025-07-31 18:13:10', '通道是否加密');
INSERT INTO `sys_dict_type` VALUES (21, '萤石播放协议', 'yingshi_protocol', '0', 'admin', '2025-08-01 12:38:51', '', NULL, '萤石播放协议');
INSERT INTO `sys_dict_type` VALUES (22, '乐橙配置启用状态', 'lecheng_enable', '0', 'admin', '2025-08-06 13:17:42', '', NULL, '乐橙配置启用状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 676 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2161 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 17, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-04-03 09:03:39', 'admin', '2025-04-03 09:07:49', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 18, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-04-03 09:03:39', 'admin', '2025-04-03 09:07:45', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 19, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-04-03 09:03:39', 'admin', '2025-04-03 09:07:41', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-04-03 09:03:39', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-04-03 09:03:39', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-04-03 09:03:39', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-04-03 09:03:39', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-04-03 09:03:39', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-04-03 09:03:39', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-04-03 09:03:39', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-04-03 09:03:39', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-04-03 09:03:39', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-04-03 09:03:39', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-04-03 09:03:39', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-04-03 09:03:39', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-04-03 09:03:39', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-04-03 09:03:39', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-04-03 09:03:39', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-04-03 09:03:39', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-04-03 09:03:39', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-04-03 09:03:39', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-04-03 09:03:39', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-04-03 09:03:39', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '节点管理', 2015, 10, 'node', 'wvp/mediaServer/index', NULL, 'node', 1, 0, 'C', '0', '0', 'wvp:server:list', 'mediaServer', 'admin', '2025-04-03 09:08:16', 'admin', '2025-07-13 18:10:48', '');
INSERT INTO `sys_menu` VALUES (2001, 'onvif协议', 0, 9, 'onvif', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'onvif', 'admin', '2025-04-09 14:29:15', 'admin', '2025-06-11 06:50:18', '');
INSERT INTO `sys_menu` VALUES (2003, '国标设备', 2015, 1, 'device', 'wvp/device/index', NULL, 'device', 1, 0, 'C', '0', '0', 'wvp:device:list', 'rtspDevice', 'admin', '2025-04-09 14:54:29', 'admin', '2025-06-11 06:55:47', '');
INSERT INTO `sys_menu` VALUES (2004, '设备管理', 2001, 2, 'cameraManage', 'onvif/cameraManage/index', NULL, 'cameraManage', 1, 0, 'C', '0', '0', 'onvif:device:list', 'rtspDevice', 'admin', '2025-04-09 17:31:15', 'admin', '2025-06-11 06:57:00', '');
INSERT INTO `sys_menu` VALUES (2006, '云端录像', 2015, 2, 'cloudRecord', 'wvp/cloudRecord/index', NULL, 'cloudRecord', 1, 0, 'C', '0', '0', 'wvp:record:list', 'cloudRecord', 'admin', '2025-04-11 11:31:09', 'admin', '2025-06-11 06:58:07', '');
INSERT INTO `sys_menu` VALUES (2007, '推流列表', 2015, 3, 'streamPush', 'wvp/streamPush/index', NULL, 'streamPush', 1, 0, 'C', '0', '0', 'wvp:push:list', 'streamPush', 'admin', '2025-04-11 14:53:58', 'admin', '2025-06-11 07:02:45', '');
INSERT INTO `sys_menu` VALUES (2008, '拉流列表', 2015, 4, 'streamProxy', 'wvp/streamProxy/index', NULL, 'streamProxy', 1, 1, 'C', '0', '0', 'wvp:proxy:list', 'streamProxy', 'admin', '2025-04-12 09:13:44', 'admin', '2025-06-11 07:04:51', '');
INSERT INTO `sys_menu` VALUES (2009, '行政分组', 2015, 7, 'administrativeGrouping', 'wvp/administrativeGrouping/index', NULL, 'administrativeGrouping', 1, 0, 'C', '0', '0', 'wvp:administrativeGrouping:list', 'drag', 'admin', '2025-04-12 10:23:03', 'admin', '2025-04-18 11:32:35', '');
INSERT INTO `sys_menu` VALUES (2011, '通道管理', 2015, 8, 'thoroughfare', 'wvp/thoroughfare/index', NULL, 'thoroughfare', 1, 0, 'C', '0', '0', 'wvp:thoroughfare:list', 'thoroughfare', 'admin', '2025-04-14 08:56:17', 'admin', '2025-06-11 07:11:10', '');
INSERT INTO `sys_menu` VALUES (2012, '录像计划', 2015, 6, 'recordPlan', 'wvp/recordPlan/index', NULL, 'recordPlan', 1, 0, 'C', '0', '0', 'wvp:record:list', 'recordPlan', 'admin', '2025-04-14 11:02:38', 'admin', '2025-06-11 07:09:10', '');
INSERT INTO `sys_menu` VALUES (2013, '分屏监控', 2015, 11, 'wvpLive', 'wvp/live/index', NULL, 'wvpLive', 1, 0, 'C', '0', '0', 'wvp:live:list', 'live', 'admin', '2025-04-14 11:03:37', 'admin', '2025-07-13 18:10:45', '');
INSERT INTO `sys_menu` VALUES (2014, '国标级联', 2015, 5, 'platform', 'wvp/platform/index', NULL, 'platform', 1, 0, 'C', '0', '0', 'wvp:platform:list', 'platform', 'admin', '2025-04-16 10:06:03', 'admin', '2025-06-11 07:06:37', '');
INSERT INTO `sys_menu` VALUES (2015, '国标协议', 0, 10, 'gbmanger', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'gb', 'admin', '2025-04-16 14:05:21', 'admin', '2025-06-11 06:51:24', '');
INSERT INTO `sys_menu` VALUES (2016, '删除设备', 2003, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:remove', '#', 'admin', '2025-04-18 09:01:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '同步设备', 2003, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:sync', '#', 'admin', '2025-04-18 09:02:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '查询设备', 2003, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:query', '#', 'admin', '2025-04-18 09:03:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '开启/关闭目录订阅', 2003, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:subscribeCatalog', '#', 'admin', '2025-04-18 09:04:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '开启/关闭移动位置订阅', 2003, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:subscribeMobilePosition', '#', 'admin', '2025-04-18 09:05:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '更新设备信息', 2003, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:edit', '#', 'admin', '2025-04-18 09:06:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '修改数据流传输模式', 2003, 8, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:updateTransport', '#', 'admin', '2025-04-18 09:07:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '获取平台配置信息', 2003, 9, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:configInfo', '#', 'admin', '2025-04-18 09:09:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '获取流媒体服务列表', 2003, 10, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:listOnline', '#', 'admin', '2025-04-18 09:10:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '报警布防/撤防命令', 2003, 11, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:control:guardApi', '#', 'admin', '2025-04-18 09:12:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '设备配置查询', 2003, 12, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:config:cdownloadApi', '#', 'admin', '2025-04-18 09:13:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '通道列表', 2003, 13, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:channels', '#', 'admin', '2025-04-18 10:29:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '修改通道码流', 2003, 14, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:device:channelStreamIdentification', '#', 'admin', '2025-04-18 10:32:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '播放视频', 2003, 15, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:play:start', '#', 'admin', '2025-04-18 10:39:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '停止播放', 2003, 16, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:play:stop', '#', 'admin', '2025-04-18 10:40:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '查询通道', 2003, 17, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:query', '#', 'admin', '2025-04-18 10:42:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '修改通道', 2003, 18, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:edit', '#', 'admin', '2025-04-18 10:43:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '录像控制命令', 2003, 19, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:control:recordApi', '#', 'admin', '2025-04-18 10:46:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '播放', 2006, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:play', '#', 'admin', '2025-04-18 10:54:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '下载', 2006, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:download', '#', 'admin', '2025-04-18 10:55:06', 'admin', '2025-04-18 10:56:03', '');
INSERT INTO `sys_menu` VALUES (2037, '新增', 2007, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:push:add', '#', 'admin', '2025-04-18 10:58:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '修改', 2007, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:push:edit', '#', 'admin', '2025-04-18 10:59:31', 'admin', '2025-04-18 10:59:37', '');
INSERT INTO `sys_menu` VALUES (2039, '删除', 2007, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:push:remove', '#', 'admin', '2025-04-18 11:00:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '播放', 2007, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:push:play', '#', 'admin', '2025-04-18 11:01:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '删除', 2008, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:proxy:delete', '#', 'admin', '2025-04-18 11:05:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '新增', 2008, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:proxy:add', '#', 'admin', '2025-04-18 11:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '修改', 2008, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:proxy:edit', '#', 'admin', '2025-04-18 11:09:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '播放', 2008, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:proxy:play', '#', 'admin', '2025-04-18 11:09:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '停止', 2008, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:proxy:stop', '#', 'admin', '2025-04-18 11:09:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '新增', 2014, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:add', '#', 'admin', '2025-04-18 11:12:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '编辑', 2014, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:edit', '#', 'admin', '2025-04-18 11:13:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '删除', 2014, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:delete', '#', 'admin', '2025-04-18 11:13:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '导出', 2004, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:export', '#', 'admin', '2025-04-18 11:14:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '修改', 2004, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:edit', '#', 'admin', '2025-04-18 11:14:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '获取详情', 2051, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:query', '#', 'admin', '2025-04-18 11:15:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '推送通道', 2014, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:push', '#', 'admin', '2025-04-18 11:15:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '播放', 2004, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:play', '#', 'admin', '2025-04-18 11:16:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '通道共享', 2014, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:channelList', '#', 'admin', '2025-04-18 11:17:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '新增设备', 2014, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:channelAdd', '#', 'admin', '2025-04-18 11:18:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '删除设备', 2014, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:platform:channelRemove', '#', 'admin', '2025-04-18 11:19:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '删除', 2004, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:remove', '#', 'admin', '2025-04-18 11:21:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '新塘', 2012, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:add', '#', 'admin', '2025-04-18 11:23:48', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '修改', 2012, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:edit', '#', 'admin', '2025-04-18 11:24:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2062, '删除', 2012, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:delete', '#', 'admin', '2025-04-18 11:24:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '关联通道', 2012, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:channelList', '#', 'admin', '2025-04-18 11:27:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '新增通道关联', 2012, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:channelAdd', '#', 'admin', '2025-04-18 11:29:23', 'admin', '2025-04-18 11:30:41', '');
INSERT INTO `sys_menu` VALUES (2065, '删除通道关联', 2012, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:record:channelDelete', '#', 'admin', '2025-04-18 11:29:48', 'admin', '2025-04-18 11:30:46', '');
INSERT INTO `sys_menu` VALUES (2066, '查询区域', 2009, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:region:list', '#', 'admin', '2025-04-18 11:33:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '修改区域', 2009, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:region:edit', '#', 'admin', '2025-04-18 11:34:27', 'admin', '2025-04-18 11:38:27', '');
INSERT INTO `sys_menu` VALUES (2068, '新增区域', 2009, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:region:add', '#', 'admin', '2025-04-18 11:34:43', 'admin', '2025-04-18 11:38:31', '');
INSERT INTO `sys_menu` VALUES (2069, '删除区域', 2009, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:region:delete', '#', 'admin', '2025-04-18 11:34:54', 'admin', '2025-04-18 11:38:34', '');
INSERT INTO `sys_menu` VALUES (2070, '查询分组', 2009, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:group:list', '#', 'admin', '2025-04-18 11:37:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '新增分组', 2009, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:group:add', '#', 'admin', '2025-04-18 11:37:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '修改分组', 2009, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:group:edit', '#', 'admin', '2025-04-18 11:38:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '删除分组', 2009, 8, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:group:delete', '#', 'admin', '2025-04-18 11:38:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2074, '通道列表', 2011, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:civilcodeList', '#', 'admin', '2025-04-18 11:41:43', 'admin', '2025-04-18 11:46:46', '');
INSERT INTO `sys_menu` VALUES (2075, '删除区域通道', 2011, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:deleteRegionChannel', '#', 'admin', '2025-04-18 11:44:51', 'admin', '2025-04-18 11:49:55', '');
INSERT INTO `sys_menu` VALUES (2076, '新增区域通道', 2011, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:addRegionChannel', '#', 'admin', '2025-04-18 11:45:39', 'admin', '2025-04-18 11:49:49', '');
INSERT INTO `sys_menu` VALUES (2077, '新增分组通道', 2011, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:addGroupChannel', '#', 'admin', '2025-04-18 11:49:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2078, '删除分组通道', 2011, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:channel:deleteGroupChannel', '#', 'admin', '2025-04-18 11:49:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, '查看', 2000, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:view', '#', 'admin', '2025-04-18 11:58:39', 'admin', '2025-05-12 14:42:18', '');
INSERT INTO `sys_menu` VALUES (2080, 'rtsp协议', 0, 8, 'rtsp', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'rtsp', 'admin', '2025-04-22 10:11:00', 'admin', '2025-06-11 06:50:22', '');
INSERT INTO `sys_menu` VALUES (2081, '设备列表', 2080, 1, 'rtspDevice', 'rtsp/RtspDevice/index', NULL, '', 1, 0, 'C', '0', '0', 'rtsp:RtspDevice:list', 'rtspDevice', 'admin', '2025-04-22 10:27:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '播放', 2081, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rtsp:RtspDevice:view', '#', 'admin', '2025-04-22 11:06:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '修改', 2081, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rtsp:RtspDevice:edit', '#', 'admin', '2025-04-22 11:07:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '删除', 2081, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rtsp:RtspDevice:remove', '#', 'admin', '2025-04-22 11:07:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '新增', 2081, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rtsp:RtspDevice:add', '#', 'admin', '2025-04-22 11:07:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '获取详细信息', 2083, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rtsp:RtspDevice:query', '#', 'admin', '2025-04-22 11:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '海康协议', 0, 3, 'isup', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'haikang', 'admin', '2025-04-22 15:01:14', 'admin', '2025-06-11 06:49:58', '');
INSERT INTO `sys_menu` VALUES (2088, '设备管理', 2087, 1, 'isupDevice', 'isup/lsupDevice/index', NULL, 'isupDevice', 1, 0, 'C', '0', '0', 'isup:lsupDevice:list', 'rtspDevice', 'admin', '2025-04-22 15:01:48', 'admin', '2025-06-11 06:49:27', '');
INSERT INTO `sys_menu` VALUES (2089, '查询设备', 2088, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'isup:lsupDevice:query', '#', 'admin', '2025-04-24 11:49:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '修改设备', 2088, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'isup:lsupDevice:edit', '#', 'admin', '2025-04-24 11:49:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '删除设备', 2088, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'sup:lsupDevice:remove', '#', 'admin', '2025-04-24 11:49:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2092, '播放视频', 2088, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'isup:lsupDevice:start', '#', 'admin', '2025-04-24 11:50:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2093, '云台控制', 2088, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'isup:lsupDevice:ptzCtrl', '#', 'admin', '2025-04-24 11:50:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2094, '设备录像', 2003, 99, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'gb:record:query', '#', 'admin', '2025-04-24 16:26:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2095, '播放', 2094, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'gb:playback:start', '#', 'admin', '2025-04-24 16:26:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2096, '下载', 2094, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'gb:record:download', '#', 'admin', '2025-04-24 16:26:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2097, '工作台', 0, 1, 'work', 'work/index', NULL, 'work', 1, 0, 'C', '0', '0', 'system:work:list', 'row', 'admin', '2025-04-30 09:17:28', 'admin', '2025-05-07 07:27:00', '');
INSERT INTO `sys_menu` VALUES (2098, '添加', 2004, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:device:add', '#', 'admin', '2025-05-07 09:20:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2099, '探测', 2004, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'onvif:service:getInfo', '#', 'admin', '2025-05-07 09:20:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '修改', 2097, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:work:edit', '#', 'admin', '2025-05-07 07:27:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '新增', 2000, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:add', '#', 'admin', '2025-05-12 10:17:38', 'admin', '2025-05-12 14:42:21', '');
INSERT INTO `sys_menu` VALUES (2102, '测试', 2000, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:check', '#', 'admin', '2025-05-12 14:20:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '查询', 2000, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:query', '#', 'admin', '2025-05-12 14:41:36', 'admin', '2025-05-12 14:42:24', '');
INSERT INTO `sys_menu` VALUES (2104, '修改', 2000, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:edit', '#', 'admin', '2025-05-12 14:42:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2105, '删除', 2000, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:server:delete', '#', 'admin', '2025-05-12 14:46:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2106, '电子地图', 0, 2, 'gIsMap', 'gIsMap/index', NULL, 'gIsMap', 1, 1, 'C', '0', '0', 'system:gIsMap:list', 'gls', 'admin', '2025-05-28 14:21:39', 'admin', '2025-06-22 18:30:01', '');
INSERT INTO `sys_menu` VALUES (2107, '大华协议', 0, 4, 'dahua', NULL, NULL, 'dahua', 1, 0, 'M', '0', '0', '', 'dahua', 'admin', '2025-06-06 03:53:40', 'admin', '2025-06-11 06:50:27', '');
INSERT INTO `sys_menu` VALUES (2108, '设备管理', 2107, 1, 'dahuaDevice', 'dahua/device/index', NULL, 'dahuaDevice', 1, 0, 'C', '0', '0', '', 'rtspDevice', 'admin', '2025-06-06 03:55:06', 'admin', '2025-06-11 06:47:05', '');
INSERT INTO `sys_menu` VALUES (2109, '报警管理', 2015, 9, 'alarm', 'wvp/alarm/index', NULL, 'alarm', 1, 0, 'C', '0', '0', 'wvp:alarm:list', 'color', 'admin', '2025-07-13 18:11:14', 'admin', '2025-07-13 18:11:29', '');
INSERT INTO `sys_menu` VALUES (2110, '删除', 2109, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'wvp:alarm:delete', '#', 'admin', '2025-07-13 18:19:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '萤石协议', 0, 5, 'yingshi', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'cascader', 'admin', '2025-07-31 13:03:05', 'admin', '2025-08-01 18:02:19', '');
INSERT INTO `sys_menu` VALUES (2112, '萤石配置', 2111, 1, 'ysConfig', 'yingshi/ysConfig/index', NULL, 'ysConfig', 1, 0, 'C', '0', '0', 'yingshi:ysConfig:list', 'checkbox', 'admin', '2025-07-31 13:03:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '导出', 2112, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ysConfig:export', '#', 'admin', '2025-07-31 13:07:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2114, '查询', 2112, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ysConfig:query', '#', 'admin', '2025-07-31 13:08:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2115, '新增', 2112, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ysConfig:add', '#', 'admin', '2025-07-31 13:08:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2116, '修改', 2112, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ysConfig:edit', '#', 'admin', '2025-07-31 13:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2117, '删除', 2112, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ysConfig:remove', '#', 'admin', '2025-07-31 13:08:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2118, '设备管理', 2111, 2, 'ysDevice', 'yingshi/ysDevice/index', NULL, 'ysDevice', 1, 0, 'C', '0', '0', 'yingshi:ys:list', 'haikang', 'admin', '2025-07-31 14:40:54', 'admin', '2025-08-02 15:52:47', '');
INSERT INTO `sys_menu` VALUES (2119, '添加设备', 2118, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:add', '#', 'admin', '2025-08-02 15:53:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '删除设备', 2118, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:remove', '#', 'admin', '2025-08-02 15:53:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '支持萤石协议', 2118, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:equipmentSupport', '#', 'admin', '2025-08-02 15:54:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '播放地址', 2118, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:play', '#', 'admin', '2025-08-02 15:54:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '云台', 2118, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:channel', '#', 'admin', '2025-08-02 15:54:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '镜像翻转', 2118, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:mirror', '#', 'admin', '2025-08-02 15:55:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '预置点', 2118, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:preset', '#', 'admin', '2025-08-02 15:55:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2126, '抓拍图片', 2118, 8, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:capture', '#', 'admin', '2025-08-02 15:55:48', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, ' 修改云端设备名称', 2118, 9, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:updateDeviceName', '#', 'admin', '2025-08-03 15:35:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '修改云端通道名称', 2118, 10, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:cameraNameUpdate', '#', 'admin', '2025-08-03 15:36:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '设备信息', 2118, 11, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceInfo', '#', 'admin', '2025-08-03 15:36:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '关闭设备视频加密', 2118, 12, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceEncryptOff', '#', 'admin', '2025-08-03 15:36:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '开启设备视频加密', 2118, 13, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceEncryptOn', '#', 'admin', '2025-08-03 15:37:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '修改设备视频加密密码', 2118, 14, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:devicePasswordUpdate', '#', 'admin', '2025-08-03 15:37:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '获取设备版本信息', 2118, 15, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceVersionInfo', '#', 'admin', '2025-08-03 15:37:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2134, '设备升级固件', 2118, 16, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceUpgrade', '#', 'admin', '2025-08-03 15:37:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2135, '获取设备升级状态', 2118, 17, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceUpgradeStatus', '#', 'admin', '2025-08-03 15:38:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2136, '视图库', 0, 6, 'gat1400', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '1400', 'admin', '2025-08-04 16:15:09', 'admin', '2025-09-22 13:09:16', '');
INSERT INTO `sys_menu` VALUES (2138, '设备撤/布防', 2118, 18, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceDefenceSet', '#', 'admin', '2025-08-05 13:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2139, '设备布撤防时间计划', 2118, 19, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'yingshi:ys:deviceDefencePlan', '#', 'admin', '2025-08-05 13:39:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '乐橙协议', 0, 7, 'lecheng', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'clipboard', 'admin', '2025-08-06 12:32:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2141, '乐橙配置', 2140, 1, 'LcConfig', 'lecheng/lcConfig/index', NULL, 'LcConfig', 1, 0, 'C', '0', '0', 'lecheng:lcConfig:list', 'clipboard', 'admin', '2025-08-06 13:07:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2142, '导出', 2141, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'lecheng:lcConfig:export', '#', 'admin', '2025-08-06 13:08:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, '查询', 2141, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'lecheng:lcConfig:query', '#', 'admin', '2025-08-06 13:08:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2144, '新增', 2141, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'lecheng:lcConfig:add', '#', 'admin', '2025-08-06 13:09:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2145, '修改', 2141, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'lecheng:lcConfig:edit', '#', 'admin', '2025-08-06 13:09:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2146, '删除', 2141, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'lecheng:lcConfig:remove', '#', 'admin', '2025-08-06 13:09:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2147, '节点配置', 2136, 1, 'nodeConf', 'gat1400/nodeConf/index', NULL, 'nodeConf', 1, 0, 'C', '0', '0', '', '1400node', 'admin', '2025-08-06 15:35:21', 'admin', '2025-08-28 13:33:10', '');
INSERT INTO `sys_menu` VALUES (2148, '视图库管理', 2136, 2, 'serverManage', 'gat1400/serverManage/index', NULL, 'serverManage', 1, 0, 'C', '0', '0', '', '1400server', 'admin', '2025-08-06 16:48:35', 'admin', '2025-08-28 13:41:39', '');
INSERT INTO `sys_menu` VALUES (2149, '设备管理', 2140, 2, 'lcDevice', 'lecheng/lcDevice/index', NULL, 'lcDevice', 1, 0, 'C', '0', '0', 'lecheng:lc:listDeviceDetailsByPage', 'checkbox', 'admin', '2025-08-08 13:10:56', 'admin', '2025-08-08 13:11:06', '');
INSERT INTO `sys_menu` VALUES (2150, '卡口管理', 2136, 3, 'tollgateManage', 'gat1400/tollgateManage/index', NULL, '', 1, 0, 'C', '0', '0', '', '1400tollgate', 'admin', '2025-08-08 14:05:53', 'admin', '2025-08-28 13:40:36', '');
INSERT INTO `sys_menu` VALUES (2151, '车道管理', 2136, 4, 'laneManage', 'gat1400/laneManage/index', NULL, '', 1, 0, 'C', '0', '0', '', '1400lane', 'admin', '2025-08-12 11:32:13', 'admin', '2025-08-28 13:40:46', '');
INSERT INTO `sys_menu` VALUES (2152, 'APE设备管理', 2136, 5, 'deviceManage', 'gat1400/deviceManage/index', NULL, '', 1, 0, 'C', '0', '0', '', '1400device', 'admin', '2025-08-12 11:41:43', 'admin', '2025-08-28 13:40:24', '');
INSERT INTO `sys_menu` VALUES (2156, '下级订阅', 2136, 20, 'subscribe', 'gat1400/subscribe/index', NULL, '', 1, 0, 'C', '0', '0', '', '1400subscribe', 'admin', '2025-08-20 12:46:37', 'admin', '2025-08-28 13:40:58', '');
INSERT INTO `sys_menu` VALUES (2157, '上级推送', 2136, 25, 'publish', 'gat1400/publish/index', NULL, '', 1, 0, 'C', '0', '0', '', '1400publish', 'admin', '2025-08-20 12:47:20', 'admin', '2025-08-28 13:41:06', '');
INSERT INTO `sys_menu` VALUES (2158, '收藏管理', 2015, 13, 'favorites', 'wvp/favorites/index', NULL, '', 1, 0, 'C', '0', '0', 'wvp:favorites:list', 'color', 'admin', '2025-08-21 13:56:18', 'admin', '2025-09-20 17:33:52', '');
INSERT INTO `sys_menu` VALUES (2159, '标记管理', 2015, 14, 'mark', 'wvp/mark/index', NULL, '', 1, 0, 'C', '0', '0', 'wvp:mark:list', 'cloudRecord', 'admin', '2025-08-22 13:26:11', 'admin', '2025-09-20 17:34:14', '');
INSERT INTO `sys_menu` VALUES (2160, '采集列表', 2136, 14, 'gatherList', 'gat1400/gatherManage/index', NULL, '', 1, 0, 'C', '1', '0', '', 'bug', 'admin', '2025-08-27 13:21:50', 'admin', '2025-08-27 13:53:04', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1808 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-04-03 09:03:39', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-04-03 09:03:39', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-04-03 09:03:39', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-04-03 09:03:39', 'admin', '2025-09-19 16:35:21', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `push_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2025/06/17/透明底logo_20250617143004A001.png', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-07 12:55:40', '3e80d1762a324d5b0ff636e0bd16f1e3', 'admin', '2025-04-03 09:03:39', '', '2025-10-07 12:55:42', '管理员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for viid_ape_device
-- ----------------------------
DROP TABLE IF EXISTS `viid_ape_device`;
CREATE TABLE `viid_ape_device`  (
  `ape_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备型号',
  `ip_addr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备地址',
  `ipv6_addr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备IPV6地址',
  `port` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备端口',
  `longitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `latitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `place_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区编码',
  `place` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置名',
  `org_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管辖单位代码',
  `cap_direction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆抓拍方向',
  `monitor_direction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监视方向',
  `monitor_area_desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监视区域说明',
  `owner_aps_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属采集系统',
  `is_online` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '2' COMMENT '是否在线',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户标识',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权密码',
  `function_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能集',
  `ext_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联外部设备ID',
  PRIMARY KEY (`ape_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库APE设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_ape_device
-- ----------------------------

-- ----------------------------
-- Table structure for viid_disposition
-- ----------------------------
DROP TABLE IF EXISTS `viid_disposition`;
CREATE TABLE `viid_disposition`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `disposition_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '布控ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '布控标题',
  `disposition_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '布控类别',
  `target_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标特征',
  `target_image_uri` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标图片路径',
  `priority_level` int(11) NULL DEFAULT NULL COMMENT '优先等级',
  `applicant_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `applicant_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用信息',
  `applicant_org` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用组织机构',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '布控开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '布控结束时间',
  `operate_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `disposition_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '布控状态',
  `disposition_range` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '布控范围',
  `tollgate_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '布控卡口',
  `disposition_area` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '布控行政区域',
  `receive_addr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '告警信息接收地址',
  `receive_mobile` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '告警信息接收手机号',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '布控理由',
  `sub_image_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片信息',
  `server_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节点ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '布控' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_disposition
-- ----------------------------

-- ----------------------------
-- Table structure for viid_faces
-- ----------------------------
DROP TABLE IF EXISTS `viid_faces`;
CREATE TABLE `viid_faces`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `data_time` timestamp NULL DEFAULT NULL COMMENT '数据时间',
  `face_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人脸标识',
  `info_kind` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '信息分类',
  `source_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源标识',
  `device_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备编码',
  `left_top_x` int(11) NULL DEFAULT NULL COMMENT '左上角X坐标',
  `left_top_y` int(11) NULL DEFAULT NULL COMMENT '左上角Y坐标',
  `right_btm_x` int(11) NULL DEFAULT NULL COMMENT '右下角X坐标',
  `right_btm_y` int(11) NULL DEFAULT NULL COMMENT '右下角Y坐标',
  `id_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件种类',
  `id_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `used_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '曾用名',
  `alias` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '绰号',
  `gender_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别代码',
  `age_up_limit` int(11) NULL DEFAULT NULL COMMENT '年龄上限',
  `age_lower_limit` int(11) NULL DEFAULT NULL COMMENT '年龄下限',
  `ethic_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '民族代码',
  `nationality_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国籍代码',
  `native_city_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '籍贯省市县代码',
  `residence_admin_division` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '居住地行政区划',
  `chinese_accent_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '汉语口音代码',
  `job_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业类别代码',
  `accompany_number` int(11) NULL DEFAULT NULL COMMENT '同行人脸数',
  `skin_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '肤色',
  `face_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '脸型',
  `facial_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '脸部特征',
  `physical_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体貌特征',
  `is_driver` int(11) NULL DEFAULT NULL COMMENT '是否驾驶员',
  `is_foreigner` int(11) NULL DEFAULT NULL COMMENT '是否涉外人员',
  `immigrant_type_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出入境人员类别代码',
  `is_suspected_terrorist` int(11) NULL DEFAULT NULL COMMENT '是否涉恐人员',
  `suspected_terrorist_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涉恐人员编号',
  `is_criminal_involved` int(11) NULL DEFAULT NULL COMMENT '是否涉案人员',
  `criminal_involved_specilisation_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涉案人员专长代码',
  `body_speciall_mark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体表特殊标记',
  `crime_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作案手段',
  `crime_character_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作案特点代码',
  `escaped_criminal_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在逃人员编号',
  `is_detainees` int(11) NULL DEFAULT NULL COMMENT '是否在押人员',
  `detention_house_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '看守所编码',
  `detainees_special_identity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在押人员特殊身份',
  `member_type_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '成员类型代码',
  `is_victim` int(11) NULL DEFAULT NULL COMMENT '是否被害人',
  `victim_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '被害人种类',
  `corpse_condition_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尸体状况代码',
  `is_suspicious_person` int(11) NULL DEFAULT NULL COMMENT '是否可疑人',
  `attitude` int(11) NULL DEFAULT NULL COMMENT '姿态分布',
  `similaritydegree` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相似度',
  `eyebrow_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '眉型',
  `nose_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鼻型',
  `mustache_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '胡型',
  `lip_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '嘴唇',
  `wrinkle_pouch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '皱纹眼袋',
  `acne_stain` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '痤疮色斑',
  `freckle_birthmark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '黑痣胎记',
  `scar_dimple` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '疤痕酒窝',
  `other_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其他特征',
  `maritalstatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `family_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `location_mark_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置标记时间',
  `face_appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人脸出现时间',
  `face_dis_appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人脸消失时间',
  `shot_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '镜头时间',
  `hair_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发型',
  `hair_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发色',
  `respirator_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '口罩颜色',
  `cap_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '帽子款式',
  `cap_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '帽子颜色',
  `glass_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '眼镜款式',
  `glass_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '眼镜颜色',
  `passport_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '护照证件种类',
  `detainees_identity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在押人员身份',
  `injured_degree` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '受伤害程度',
  `sub_image_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库_人脸' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_faces
-- ----------------------------

-- ----------------------------
-- Table structure for viid_lanes
-- ----------------------------
DROP TABLE IF EXISTS `viid_lanes`;
CREATE TABLE `viid_lanes`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `tollgate_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡口编号',
  `lane_id` int(11) NOT NULL COMMENT '车道ID',
  `lane_no` int(11) NULL DEFAULT NULL COMMENT '车道编号',
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车道名称',
  `direction` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车道方向',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车道描述',
  `max_speed` int(11) NULL DEFAULT NULL COMMENT '限速',
  `city_pass` int(11) NULL DEFAULT NULL COMMENT '车道出入城',
  `ape_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `viid_lanes_UN`(`tollgate_id`, `lane_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '车道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_lanes
-- ----------------------------

-- ----------------------------
-- Table structure for viid_motor_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `viid_motor_vehicle`;
CREATE TABLE `viid_motor_vehicle`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `data_time` timestamp NULL DEFAULT NULL COMMENT '数据时间',
  `motor_vehicle_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆ID',
  `info_kind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '信息分类',
  `source_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源标识',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `left_top_x` int(11) NULL DEFAULT NULL COMMENT '左上角X坐标',
  `left_top_y` int(11) NULL DEFAULT NULL COMMENT '左上角Y坐标',
  `right_btm_x` int(11) NULL DEFAULT NULL COMMENT '右下角X坐标',
  `right_btm_y` int(11) NULL DEFAULT NULL COMMENT '右下角Y坐标',
  `mark_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置标记时间',
  `appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆出现时间',
  `disappear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆消失时间',
  `tollgate_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卡口编号',
  `pass_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '过车时间',
  `lane_no` int(11) NULL DEFAULT NULL COMMENT '车道号',
  `has_plate` tinyint(1) NULL DEFAULT NULL COMMENT '有无车牌',
  `plate_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '号牌种类',
  `plate_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '号牌颜色',
  `plate_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌号',
  `speed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '速度',
  `vehicle_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车身颜色',
  `vehicle_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆类型',
  `vehicle_brand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆型号',
  `vehicle_length` int(11) NULL DEFAULT NULL COMMENT '车辆长度',
  `direction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行驶方向',
  `storage_url1` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片1',
  `storage_url2` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片2',
  `sub_image_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库机动车信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_motor_vehicle
-- ----------------------------

-- ----------------------------
-- Table structure for viid_non_motor_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `viid_non_motor_vehicle`;
CREATE TABLE `viid_non_motor_vehicle`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `data_time` timestamp NULL DEFAULT NULL COMMENT '数据时间',
  `non_motor_vehicle_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆标识',
  `info_kind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '信息分类',
  `source_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源标识',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `left_top_x` int(11) NULL DEFAULT NULL COMMENT '左上角X坐标',
  `left_top_y` int(11) NULL DEFAULT NULL COMMENT '左上角Y坐标',
  `right_btm_x` int(11) NULL DEFAULT NULL COMMENT '右下角X坐标',
  `right_btm_y` int(11) NULL DEFAULT NULL COMMENT '右下角Y坐标',
  `mark_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置标记时间',
  `appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆出现时间',
  `disappear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆消失时间',
  `has_plate` tinyint(1) NULL DEFAULT NULL COMMENT '有无车牌',
  `plate_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '号牌种类',
  `plate_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌颜色',
  `plate_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌号',
  `plate_no_attach` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '挂车牌号',
  `plate_describe` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车牌描述',
  `is_decked` tinyint(1) NULL DEFAULT NULL COMMENT '是否套牌',
  `is_altered` tinyint(1) NULL DEFAULT NULL COMMENT '是否涂改',
  `is_covered` tinyint(1) NULL DEFAULT NULL COMMENT '是否遮挡',
  `speed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行驶速度',
  `driving_status_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行驶状态代码',
  `using_properties_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆使用性质代码',
  `vehicle_brand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆品牌',
  `vehicle_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆款型',
  `vehicle_length` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆长度',
  `vehicle_width` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆宽度',
  `vehicle_height` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆高度',
  `vehicle_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车身颜色',
  `vehicle_hood` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车前盖',
  `vehicle_trunk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车后盖',
  `vehicle_wheel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车轮',
  `wheel_printed_pattern` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车轮印花纹',
  `vehicle_window` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车窗',
  `vehicle_roof` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车顶',
  `vehicle_door` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车门',
  `side_of_vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车侧',
  `car_of_vehicle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车厢',
  `rearview_mirror` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后视镜',
  `vehicle_chassis` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '底盘',
  `vehicle_shielding` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '遮挡',
  `film_color` int(11) NULL DEFAULT NULL COMMENT '贴膜颜色',
  `is_modified` int(11) NULL DEFAULT NULL COMMENT '改装标志',
  `sub_image_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库非机动车信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_non_motor_vehicle
-- ----------------------------

-- ----------------------------
-- Table structure for viid_persons
-- ----------------------------
DROP TABLE IF EXISTS `viid_persons`;
CREATE TABLE `viid_persons`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `data_time` timestamp NULL DEFAULT NULL COMMENT '数据时间',
  `person_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人员标识',
  `info_kind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '信息分类',
  `source_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源标识',
  `device_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备编码',
  `left_top_x` int(11) NULL DEFAULT NULL COMMENT '左上角X坐标',
  `left_top_y` int(11) NULL DEFAULT NULL COMMENT '左上角Y坐标',
  `right_btm_x` int(11) NULL DEFAULT NULL COMMENT '右下角X坐标',
  `right_btm_y` int(11) NULL DEFAULT NULL COMMENT '右下角Y坐标',
  `location_mark_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置标记时间',
  `person_appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人员出现时间',
  `person_dis_appear_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人员消失时间',
  `id_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件种类',
  `id_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `used_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '曾用名',
  `alias` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '绰号',
  `gender_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别代码',
  `age_up_limit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '年龄上限',
  `age_lower_limit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '年龄下限',
  `ethic_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '民族代码',
  `nationality_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国籍代码',
  `native_city_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '籍贯省市县代码',
  `residence_admin_division` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '居住地行政区划',
  `chinese_accent_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '汉语口音代码',
  `person_org` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位名称',
  `job_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业类别代码',
  `accompany_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '同行人数',
  `height_up_limit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身高上限',
  `height_lower_limit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身高下限',
  `body_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体型',
  `skin_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '肤色',
  `hair_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发型',
  `hair_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发色',
  `gesture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姿态',
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `face_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '脸型',
  `facial_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '脸部特征',
  `physical_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体貌特征',
  `body_feature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体表特征',
  `habitual_movement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '习惯动作',
  `behavior` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行为',
  `behavior_description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行为描述',
  `appendant` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附属物',
  `appendant_description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附属物描述',
  `umbrella_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '伞颜色',
  `respirator_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '口罩颜色',
  `cap_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '帽子款式',
  `cap_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '帽子颜色',
  `glass_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '眼镜款式',
  `glass_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '眼镜颜色',
  `scarf_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '围巾颜色',
  `bag_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '包款式',
  `bag_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '包颜色',
  `coat_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上衣款式',
  `coat_length` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上衣长度',
  `coat_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上衣颜色',
  `trousers_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '裤子款式',
  `trousers_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '裤子颜色',
  `trousers_len` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '裤子长度',
  `shoes_style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鞋子款式',
  `shoes_color` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鞋子颜色',
  `is_driver` int(11) NULL DEFAULT NULL COMMENT '是否驾驶员',
  `is_foreigner` int(11) NULL DEFAULT NULL COMMENT '是否涉外人员',
  `passport_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '护照证件种类',
  `immigrant_type_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出入境人员类别代码',
  `is_suspected_terrorist` int(11) NULL DEFAULT NULL COMMENT '是否涉恐人员',
  `suspected_terrorist_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涉恐人员编号',
  `is_criminal_involved` int(11) NULL DEFAULT NULL COMMENT '是否涉案人员',
  `criminal_involved_specilisation_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '涉案人员专长代码',
  `body_speciall_mark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体表特殊标记',
  `crime_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作案手段',
  `crime_character_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作案特点代码',
  `escaped_criminal_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在逃人员编号',
  `is_detainees` int(11) NULL DEFAULT NULL COMMENT '是否在押人员',
  `detention_house_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '看守所编码',
  `detainees_identity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在押人员身份',
  `detainees_special_identity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在押特殊人员身份',
  `member_type_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '成员类型代码',
  `is_victim` int(11) NULL DEFAULT NULL COMMENT '是否被害人',
  `victim_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '被害人种类',
  `injured_degree` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '受伤害程度',
  `corpse_condition_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尸体状况代码',
  `is_suspicious_person` int(11) NULL DEFAULT NULL COMMENT '是否可疑人',
  `sub_image_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图像列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库_人员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_persons
-- ----------------------------

-- ----------------------------
-- Table structure for viid_publish
-- ----------------------------
DROP TABLE IF EXISTS `viid_publish`;
CREATE TABLE `viid_publish`  (
  `subscribe_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订阅标识符',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅标题',
  `subscribe_detail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅类型',
  `resource_uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '资源ID',
  `application_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `application_org` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请单位',
  `begin_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `receive_addr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅回调地址',
  `report_interval` int(11) NULL DEFAULT NULL COMMENT '数据上报间隔',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '理由',
  `operate_type` int(11) NULL DEFAULT NULL COMMENT '操作类型',
  `subscribe_status` int(11) NULL DEFAULT NULL COMMENT '订阅状态',
  `resource_class` int(11) NULL DEFAULT NULL COMMENT '资源类型',
  `result_image_declare` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '未知属性',
  `result_feature_declare` int(11) NULL DEFAULT NULL COMMENT '未知属性',
  `server_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节点ID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`subscribe_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库发布信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_publish
-- ----------------------------

-- ----------------------------
-- Table structure for viid_server
-- ----------------------------
DROP TABLE IF EXISTS `viid_server`;
CREATE TABLE `viid_server`  (
  `server_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视图库编号',
  `server_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视图库名称',
  `scheme` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交互协议',
  `host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视图库地址',
  `port` int(11) NULL DEFAULT NULL COMMENT '视图库端口',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权用户',
  `authenticate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权凭证',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节点类别',
  `keepalive` tinyint(1) NULL DEFAULT NULL COMMENT '是否开启双向保活',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `transmission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'http' COMMENT '数据传输类型',
  `proxy_network` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理网络类型',
  `online` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '2' COMMENT '是否在线',
  PRIMARY KEY (`server_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '1400视图库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_server
-- ----------------------------

-- ----------------------------
-- Table structure for viid_subscrube
-- ----------------------------
DROP TABLE IF EXISTS `viid_subscrube`;
CREATE TABLE `viid_subscrube`  (
  `subscribe_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订阅标识符',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅标题',
  `subscribe_detail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅类型',
  `resource_uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '资源ID',
  `application_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `application_org` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请单位',
  `begin_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `receive_addr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅回调地址',
  `report_interval` int(11) NULL DEFAULT NULL COMMENT '数据上报间隔',
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '理由',
  `operate_type` int(11) NULL DEFAULT NULL COMMENT '操作类型',
  `subscribe_status` int(11) NULL DEFAULT NULL COMMENT '订阅状态',
  `resource_class` int(11) NULL DEFAULT NULL COMMENT '资源类型',
  `result_image_declare` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '未知属性',
  `result_feature_declare` int(11) NULL DEFAULT NULL COMMENT '未知属性',
  `server_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节点ID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`subscribe_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库订阅信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_subscrube
-- ----------------------------

-- ----------------------------
-- Table structure for viid_tollgate_device
-- ----------------------------
DROP TABLE IF EXISTS `viid_tollgate_device`;
CREATE TABLE `viid_tollgate_device`  (
  `tollgate_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备标识',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卡口名称',
  `longitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `latitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  `place_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '位置编码',
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  `tollgate_cat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卡口方向',
  `tollgate_usage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关卡使用',
  `lane_num` int(11) NULL DEFAULT NULL COMMENT '车道数量',
  `org_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `device_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  PRIMARY KEY (`tollgate_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视图库卡口设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of viid_tollgate_device
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_cloud_record
-- ----------------------------
DROP TABLE IF EXISTS `wvp_cloud_record`;
CREATE TABLE `wvp_cloud_record`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `call_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `start_time` bigint(20) NULL DEFAULT NULL,
  `end_time` bigint(20) NULL DEFAULT NULL,
  `media_server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `folder` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `collect` tinyint(1) NULL DEFAULT 0,
  `file_size` bigint(20) NULL DEFAULT NULL,
  `time_len` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_cloud_record
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_common_group
-- ----------------------------
DROP TABLE IF EXISTS `wvp_common_group`;
CREATE TABLE `wvp_common_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  `parent_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `business_group` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `civil_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_common_group_device_platform`(`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_common_group
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_common_region
-- ----------------------------
DROP TABLE IF EXISTS `wvp_common_region`;
CREATE TABLE `wvp_common_region`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  `parent_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_common_region_device_id`(`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_common_region
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_device
-- ----------------------------
DROP TABLE IF EXISTS `wvp_device`;
CREATE TABLE `wvp_device`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `manufacturer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `firmware` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `transport` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream_mode` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `on_line` tinyint(1) NULL DEFAULT 0,
  `register_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `keepalive_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `port` int(11) NULL DEFAULT NULL,
  `expires` int(11) NULL DEFAULT NULL,
  `subscribe_cycle_for_catalog` int(11) NULL DEFAULT 0,
  `subscribe_cycle_for_mobile_position` int(11) NULL DEFAULT 0,
  `mobile_position_submission_interval` int(11) NULL DEFAULT 5,
  `subscribe_cycle_for_alarm` int(11) NULL DEFAULT 0,
  `host_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `charset` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ssrc_check` tinyint(1) NULL DEFAULT 0,
  `geo_coord_sys` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `media_server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'auto',
  `custom_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `sdp_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `local_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `as_message_channel` tinyint(1) NULL DEFAULT 0,
  `heart_beat_interval` int(11) NULL DEFAULT NULL,
  `heart_beat_count` int(11) NULL DEFAULT NULL,
  `position_capability` int(11) NULL DEFAULT NULL,
  `broadcast_push_after_ack` tinyint(1) NULL DEFAULT 0,
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `address_map` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地图定位地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_device_device`(`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_device
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_device_alarm
-- ----------------------------
DROP TABLE IF EXISTS `wvp_device_alarm`;
CREATE TABLE `wvp_device_alarm`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `channel_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `alarm_priority` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `alarm_method` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `alarm_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `alarm_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `longitude` double NULL DEFAULT NULL,
  `latitude` double NULL DEFAULT NULL,
  `alarm_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_device_alarm
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_device_channel
-- ----------------------------
DROP TABLE IF EXISTS `wvp_device_channel`;
CREATE TABLE `wvp_device_channel`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `manufacturer` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `model` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `civil_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `block` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `parental` int(11) NULL DEFAULT NULL,
  `parent_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `safety_way` int(11) NULL DEFAULT NULL,
  `register_way` int(11) NULL DEFAULT NULL,
  `cert_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `certifiable` int(11) NULL DEFAULT NULL,
  `err_code` int(11) NULL DEFAULT NULL,
  `end_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `secrecy` int(11) NULL DEFAULT NULL,
  `ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `port` int(11) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'OFF',
  `longitude` double NULL DEFAULT NULL,
  `latitude` double NULL DEFAULT NULL,
  `ptz_type` int(11) NULL DEFAULT NULL,
  `position_type` int(11) NULL DEFAULT NULL,
  `room_type` int(11) NULL DEFAULT NULL,
  `use_type` int(11) NULL DEFAULT NULL,
  `supply_light_type` int(11) NULL DEFAULT NULL,
  `direction_type` int(11) NULL DEFAULT NULL,
  `resolution` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `business_group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `download_speed` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `svc_space_support_mod` int(11) NULL DEFAULT NULL,
  `svc_time_support_mode` int(11) NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sub_count` int(11) NULL DEFAULT NULL,
  `stream_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `has_audio` tinyint(1) NULL DEFAULT 0,
  `gps_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream_identification` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `channel_type` int(11) NOT NULL DEFAULT 0,
  `gb_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_manufacturer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_civil_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_block` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_parental` int(11) NULL DEFAULT NULL,
  `gb_parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_safety_way` int(11) NULL DEFAULT NULL,
  `gb_register_way` int(11) NULL DEFAULT NULL,
  `gb_cert_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_certifiable` int(11) NULL DEFAULT NULL,
  `gb_err_code` int(11) NULL DEFAULT NULL,
  `gb_end_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_secrecy` int(11) NULL DEFAULT NULL,
  `gb_ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_port` int(11) NULL DEFAULT NULL,
  `gb_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_longitude` double NULL DEFAULT NULL,
  `gb_latitude` double NULL DEFAULT NULL,
  `gb_business_group_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_ptz_type` int(11) NULL DEFAULT NULL,
  `gb_position_type` int(11) NULL DEFAULT NULL,
  `gb_room_type` int(11) NULL DEFAULT NULL,
  `gb_use_type` int(11) NULL DEFAULT NULL,
  `gb_supply_light_type` int(11) NULL DEFAULT NULL,
  `gb_direction_type` int(11) NULL DEFAULT NULL,
  `gb_resolution` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_download_speed` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gb_svc_space_support_mod` int(11) NULL DEFAULT NULL,
  `gb_svc_time_support_mode` int(11) NULL DEFAULT NULL,
  `record_plan_id` int(11) NULL DEFAULT NULL,
  `data_type` int(11) NOT NULL,
  `data_device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_device_channel
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_device_mobile_position
-- ----------------------------
DROP TABLE IF EXISTS `wvp_device_mobile_position`;
CREATE TABLE `wvp_device_mobile_position`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `channel_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `longitude` double NULL DEFAULT NULL,
  `latitude` double NULL DEFAULT NULL,
  `altitude` double NULL DEFAULT NULL,
  `speed` double NULL DEFAULT NULL,
  `direction` double NULL DEFAULT NULL,
  `report_source` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_device_mobile_position
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_favorites
-- ----------------------------
DROP TABLE IF EXISTS `wvp_favorites`;
CREATE TABLE `wvp_favorites`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `favorites_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收藏夹名称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '国标通道收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_favorites_channel
-- ----------------------------
DROP TABLE IF EXISTS `wvp_favorites_channel`;
CREATE TABLE `wvp_favorites_channel`  (
  `channel_id` bigint(20) NOT NULL COMMENT '国标通道id',
  `favorites_id` bigint(20) NULL DEFAULT NULL COMMENT '收藏夹id',
  `gb_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通道名称',
  `gb_parentId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备id',
  `gb_deviceId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通道id',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏夹国标通道表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_favorites_channel
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_mark
-- ----------------------------
DROP TABLE IF EXISTS `wvp_mark`;
CREATE TABLE `wvp_mark`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `mark_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标记照片',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'wvp通道标记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_mark
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_mark_channel
-- ----------------------------
DROP TABLE IF EXISTS `wvp_mark_channel`;
CREATE TABLE `wvp_mark_channel`  (
  `channel_id` bigint(20) NOT NULL COMMENT '国标通道id',
  `mark_id` bigint(20) NULL DEFAULT NULL COMMENT '标记id',
  `gb_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通道名称',
  `gb_parentId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备id',
  `gb_deviceId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通道id',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'wvp国标通道标记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_mark_channel
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_media_server
-- ----------------------------
DROP TABLE IF EXISTS `wvp_media_server`;
CREATE TABLE `wvp_media_server`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `hook_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `sdp_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `http_port` int(11) NULL DEFAULT NULL,
  `http_ssl_port` int(11) NULL DEFAULT NULL,
  `rtmp_port` int(11) NULL DEFAULT NULL,
  `rtmp_ssl_port` int(11) NULL DEFAULT NULL,
  `rtp_proxy_port` int(11) NULL DEFAULT NULL,
  `rtsp_port` int(11) NULL DEFAULT NULL,
  `rtsp_ssl_port` int(11) NULL DEFAULT NULL,
  `flv_port` int(11) NULL DEFAULT NULL,
  `flv_ssl_port` int(11) NULL DEFAULT NULL,
  `ws_flv_port` int(11) NULL DEFAULT NULL,
  `ws_flv_ssl_port` int(11) NULL DEFAULT NULL,
  `auto_config` tinyint(1) NULL DEFAULT 0,
  `secret` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'zlm',
  `rtp_enable` tinyint(1) NULL DEFAULT 0,
  `rtp_port_range` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `send_rtp_port_range` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `record_assist_port` int(11) NULL DEFAULT NULL,
  `default_server` tinyint(1) NULL DEFAULT 0,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `hook_alive_interval` int(11) NULL DEFAULT NULL,
  `record_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `record_day` int(11) NULL DEFAULT 7,
  `transcode_suffix` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_media_server_unique_ip_http_port`(`ip`, `http_port`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_media_server
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_platform
-- ----------------------------
DROP TABLE IF EXISTS `wvp_platform`;
CREATE TABLE `wvp_platform`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `enable` tinyint(1) NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `server_gb_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `server_gb_domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `server_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `server_port` int(11) NULL DEFAULT NULL,
  `device_gb_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `device_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `device_port` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `expires` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `keep_timeout` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `transport` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `civil_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `manufacturer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `character_set` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ptz` tinyint(1) NULL DEFAULT 0,
  `rtcp` tinyint(1) NULL DEFAULT 0,
  `status` tinyint(1) NULL DEFAULT 0,
  `catalog_group` int(11) NULL DEFAULT NULL,
  `register_way` int(11) NULL DEFAULT NULL,
  `secrecy` int(11) NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `as_message_channel` tinyint(1) NULL DEFAULT 0,
  `catalog_with_platform` int(11) NULL DEFAULT 1,
  `catalog_with_group` int(11) NULL DEFAULT 1,
  `catalog_with_region` int(11) NULL DEFAULT 1,
  `auto_push_channel` tinyint(1) NULL DEFAULT 1,
  `send_stream_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_platform_unique_server_gb_id`(`server_gb_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_platform
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_platform_channel
-- ----------------------------
DROP TABLE IF EXISTS `wvp_platform_channel`;
CREATE TABLE `wvp_platform_channel`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) NULL DEFAULT NULL,
  `device_channel_id` int(11) NULL DEFAULT NULL,
  `custom_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_manufacturer` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_civil_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_block` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_parental` int(11) NULL DEFAULT NULL,
  `custom_parent_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_safety_way` int(11) NULL DEFAULT NULL,
  `custom_register_way` int(11) NULL DEFAULT NULL,
  `custom_cert_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_certifiable` int(11) NULL DEFAULT NULL,
  `custom_err_code` int(11) NULL DEFAULT NULL,
  `custom_end_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_secrecy` int(11) NULL DEFAULT NULL,
  `custom_ip_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_port` int(11) NULL DEFAULT NULL,
  `custom_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_longitude` double NULL DEFAULT NULL,
  `custom_latitude` double NULL DEFAULT NULL,
  `custom_ptz_type` int(11) NULL DEFAULT NULL,
  `custom_position_type` int(11) NULL DEFAULT NULL,
  `custom_room_type` int(11) NULL DEFAULT NULL,
  `custom_use_type` int(11) NULL DEFAULT NULL,
  `custom_supply_light_type` int(11) NULL DEFAULT NULL,
  `custom_direction_type` int(11) NULL DEFAULT NULL,
  `custom_resolution` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_business_group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_download_speed` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `custom_svc_space_support_mod` int(11) NULL DEFAULT NULL,
  `custom_svc_time_support_mode` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_platform_gb_channel_platform_id_catalog_id_device_channel_id`(`platform_id`, `device_channel_id`) USING BTREE,
  UNIQUE INDEX `uk_platform_gb_channel_device_id`(`custom_device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_platform_channel
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_platform_group
-- ----------------------------
DROP TABLE IF EXISTS `wvp_platform_group`;
CREATE TABLE `wvp_platform_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) NULL DEFAULT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_wvp_platform_group_platform_id_group_id`(`platform_id`, `group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_platform_group
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_platform_region
-- ----------------------------
DROP TABLE IF EXISTS `wvp_platform_region`;
CREATE TABLE `wvp_platform_region`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) NULL DEFAULT NULL,
  `region_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_wvp_platform_region_platform_id_group_id`(`platform_id`, `region_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_platform_region
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_record_plan
-- ----------------------------
DROP TABLE IF EXISTS `wvp_record_plan`;
CREATE TABLE `wvp_record_plan`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `snap` tinyint(1) NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_record_plan
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_record_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `wvp_record_plan_item`;
CREATE TABLE `wvp_record_plan_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `start` int(11) NULL DEFAULT NULL,
  `stop` int(11) NULL DEFAULT NULL,
  `week_day` int(11) NULL DEFAULT NULL,
  `plan_id` int(11) NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_record_plan_item
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_resources_tree
-- ----------------------------
DROP TABLE IF EXISTS `wvp_resources_tree`;
CREATE TABLE `wvp_resources_tree`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_catalog` tinyint(1) NULL DEFAULT 1,
  `device_channel_id` int(11) NULL DEFAULT NULL,
  `gb_stream_id` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_resources_tree
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_stream_proxy
-- ----------------------------
DROP TABLE IF EXISTS `wvp_stream_proxy`;
CREATE TABLE `wvp_stream_proxy`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `src_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `timeout` int(11) NULL DEFAULT NULL,
  `ffmpeg_cmd_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `rtsp_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `media_server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `enable_audio` tinyint(1) NULL DEFAULT 0,
  `enable_mp4` tinyint(1) NULL DEFAULT 0,
  `pulling` tinyint(1) NULL DEFAULT 0,
  `enable` tinyint(1) NULL DEFAULT 0,
  `enable_remove_none_reader` tinyint(1) NULL DEFAULT 0,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `enable_disable_none_reader` tinyint(1) NULL DEFAULT 0,
  `relates_media_server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_stream_proxy_app_stream`(`app`, `stream`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_stream_proxy
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_stream_push
-- ----------------------------
DROP TABLE IF EXISTS `wvp_stream_push`;
CREATE TABLE `wvp_stream_push`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `stream` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `media_server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `push_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 0,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `pushing` tinyint(1) NULL DEFAULT 0,
  `self` tinyint(1) NULL DEFAULT 0,
  `start_offline_push` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `uk_stream_push_app_stream`(`app`, `stream`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_stream_push
-- ----------------------------

-- ----------------------------
-- Table structure for wvp_user_api_key
-- ----------------------------
DROP TABLE IF EXISTS `wvp_user_api_key`;
CREATE TABLE `wvp_user_api_key`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `api_key` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `expired_at` bigint(20) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `enable` tinyint(1) NULL DEFAULT 1,
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wvp_user_api_key
-- ----------------------------

-- ----------------------------
-- Table structure for ys_capture
-- ----------------------------
DROP TABLE IF EXISTS `ys_capture`;
CREATE TABLE `ys_capture`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片地址',
  `device_serial` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备序列号',
  `channel_no` bigint(10) NULL DEFAULT NULL COMMENT '通道号',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '设备抓拍表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_capture
-- ----------------------------

-- ----------------------------
-- Table structure for ys_config
-- ----------------------------
DROP TABLE IF EXISTS `ys_config`;
CREATE TABLE `ys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '应用名称',
  `app_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户appKey',
  `secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户secret',
  `enable` char(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '启用状态（0=启用,1=禁用）',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'access_token',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '萤石监控配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_config
-- ----------------------------

-- ----------------------------
-- Table structure for ys_preset
-- ----------------------------
DROP TABLE IF EXISTS `ys_preset`;
CREATE TABLE `ys_preset`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `index` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '预置点序号',
  `device_serial` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备序列号',
  `channel_no` bigint(10) NULL DEFAULT NULL COMMENT '通道号',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '预置点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_preset
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
