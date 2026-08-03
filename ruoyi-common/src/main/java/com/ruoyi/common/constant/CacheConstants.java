package com.ruoyi.common.constant;

/**
 * 缓存的key 常量
 *
 * @author ruoyi
 */
public class CacheConstants
{
    /**
     * 登录用户 redis key
     */
    public static final String LOGIN_TOKEN_KEY = "wvp_login_tokens:";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "wvp_captcha_codes:";

    /**
     * 参数管理 cache key
     */
    public static final String SYS_CONFIG_KEY = "wvp_sys_config:";

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "wvp_sys_dict:";

    /**
     * 防重提交 redis key
     */
    public static final String REPEAT_SUBMIT_KEY = "wvp_repeat_submit:";

    /**
     * 限流 redis key
     */
    public static final String RATE_LIMIT_KEY = "wvp_rate_limit:";

    /**
     * 登录账户密码错误次数 redis key
     */
    public static final String PWD_ERR_CNT_KEY = "wvp_pwd_err_cnt:";

    /**
     * 工作台数据 redis key
     */
    public static final String SYS_WORK_LIST = "sys_work_list:";

    /**
     * goview工作台数据 redis key
     */
    public static final String SYS_GOVIEW_WORK_LIST = "sys_goview_work_list:";
}
