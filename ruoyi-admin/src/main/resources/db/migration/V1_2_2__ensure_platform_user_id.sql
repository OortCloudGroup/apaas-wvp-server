-- Compatibility migration for WVP databases initialized before platform-user federation.
-- Fresh deployments receive this column from deploy/release/sql/init/10-ry-wvp.sql.

SET @ddl = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE `sys_user` ADD COLUMN `platform_user_id` varchar(255) NULL DEFAULT NULL COMMENT ''Platform user ID'' AFTER `remark`',
        'SELECT 1'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'sys_user'
      AND COLUMN_NAME = 'platform_user_id'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
