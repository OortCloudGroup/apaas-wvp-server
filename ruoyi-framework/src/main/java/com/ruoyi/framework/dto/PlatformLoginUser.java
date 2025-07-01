package com.ruoyi.framework.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PlatformLoginUser {

    private static final long serialVersionUID = 4170843890468921757L;

    private String userId;
    private String tenantId;
    private String userName;
    private int isTenantAdmin;
    private int isAdmin;
    private String uniqueId;
    private Date loginTime;
    private Date lastRequestTime;
    private String loginIP;
    private int loginType;
    private String client;
    private String accessToken;
}
