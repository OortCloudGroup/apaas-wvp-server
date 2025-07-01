package com.ruoyi.framework.web.service;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONConfig;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.AddressUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.framework.dto.PlatformLoginUser;
import com.ruoyi.system.domain.SysUserRole;
import com.ruoyi.system.mapper.SysRoleMapper;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.mapper.SysUserRoleMapper;
import com.ruoyi.system.service.ISysUserService;
import eu.bitwalker.useragentutils.UserAgent;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.TimeUnit;

import static com.ruoyi.framework.constant.PlatformConstants.*;

/**
 * token验证处理
 *
 * @author qdata
 */
@Component
public class TokenService
{
    private static final Logger log = LoggerFactory.getLogger(TokenService.class);

    // 令牌自定义标识
    @Value("${token.header}")
    private String header;

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    @Value("${token.verifyTokenAddress}")
    private String verifyTokenAddress;

    // 令牌有效期（默认30分钟）
    @Value("${token.expireTime}")
    private int expireTime;

    protected static final long MILLIS_SECOND = 1000;

    protected static final long MILLIS_MINUTE = 60 * MILLIS_SECOND;

    private static final Long MILLIS_MINUTE_TEN = 20 * 60 * 1000L;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    @Autowired
    private SysRoleMapper sysRoleMapper;

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(HttpServletRequest request)
    {
        // 获取请求携带的令牌
        String accessToken = getToken(request);
        if (StringUtils.isBlank(accessToken)) {
            log.error("accessToken为空：{}", request.getRequestURI());
            throw new ServiceException("accessToken为空");
        }

        String userKey = getTokenKey(accessToken);

        log.info("检查redis缓存：{}", userKey);
        log.info("检查平台token和登录：{}", accessToken);
        PlatformLoginUser platformLoginUser = getPlatformLoginUser(request, accessToken);

        SysUser sysUser = sysUserMapper.selectUserByPlatformUserId(platformLoginUser.getUserId());
        if (sysUser == null) {
            sysUser = new SysUser();
            sysUser.setDeptId(100L);
            sysUser.setNickName(platformLoginUser.getUserName());
            sysUser.setUserName(platformLoginUser.getUserName());
            sysUser.setPassword("");
            sysUser.setPassword(SecurityUtils.encryptPassword("123456"));
            sysUser.setCreateTime(new Date());
            sysUser.setPlatformUserId(platformLoginUser.getUserId());
            sysUserService.insertUser(sysUser);

            List<SysUserRole> userRoleList = new ArrayList<>();
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setRoleId(1L);
            sysUserRole.setUserId(sysUser.getUserId());
            userRoleList.add(sysUserRole);
            userRoleMapper.batchUserRole(userRoleList);
        }
        SysRole sysRole = new SysRole();
        sysRole.setRoleIds(Collections.singletonList(1L));
        sysUser.setRoles(sysRoleMapper.selectRoleList(sysRole));

        LoginUser loginUser = new LoginUser(sysUser.getUserId(), sysUser.getDeptId(), sysUser, permissionService.getMenuPermission(sysUser));
        loginUser.setToken(accessToken);
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(expireTime * MILLIS_MINUTE);
        redisCache.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
        return loginUser;
    }

    /**
     * 校验平台token有效性获取平台用户信息
     *
     * @param request
     * @param accessToken
     * @return
     */
    private PlatformLoginUser getPlatformLoginUser(HttpServletRequest request, String accessToken) {
        // body是具体进入应用时的验证
        String requestBody = "{\"accesstoken\": \"" + accessToken + "\"}";

        HttpResponse response = HttpRequest.post(verifyTokenAddress)
                .header(HEADER_REQUEST_TYPE, request.getHeader(HEADER_REQUEST_TYPE))
                .header(HEADER_APP_ID, request.getHeader(HEADER_APP_ID))
                .header(HEADER_SERVER_KEY, request.getHeader(HEADER_SERVER_KEY))
                .header(HEADER_ACCESS_TOKEN, accessToken).body(requestBody).timeout(1500).execute();

        String respBody = response.body();
        log.info("verifyToken respBody ================== " + respBody);

        JSONObject bodyJson = JSONUtil.parseObj(respBody);
        PlatformLoginUser platformLoginUser;
        if (200 == bodyJson.getInt("code")) {
            JSONConfig jsonConfig = JSONConfig.create().setIgnoreError(true);
            //联通环境
            String data = bodyJson.getStr("data");
            platformLoginUser = JSONUtil.toBean(data, jsonConfig, PlatformLoginUser.class);
        } else {
            log.error("网关verifyToken失败：{}", respBody);
            throw new ServiceException("网关verifyToken失败！");
        }
        return platformLoginUser;
    }

    /**
     * 设置用户身份信息
     */
    public void setLoginUser(LoginUser loginUser)
    {
        if (StringUtils.isNotNull(loginUser) && StringUtils.isNotEmpty(loginUser.getToken()))
        {
            refreshToken(loginUser);
        }
    }

    /**
     * 删除用户身份信息
     */
    public void delLoginUser(String token)
    {
        if (StringUtils.isNotEmpty(token))
        {
            String userKey = getTokenKey(token);
            redisCache.deleteObject(userKey);
        }
    }

    /**
     * 创建令牌
     *
     * @param loginUser 用户信息
     * @return 令牌
     */
    public String createToken(LoginUser loginUser)
    {
        String token = IdUtils.fastUUID();
        loginUser.setToken(token);
        setUserAgent(loginUser);
        refreshToken(loginUser);

        Map<String, Object> claims = new HashMap<>();
        claims.put(Constants.LOGIN_USER_KEY, token);
        return createToken(claims);
    }

    /**
     * 验证令牌有效期，相差不足20分钟，自动刷新缓存
     *
     * @param loginUser
     * @return 令牌
     */
    public void verifyToken(LoginUser loginUser)
    {
        long expireTime = loginUser.getExpireTime();
        long currentTime = System.currentTimeMillis();
        if (expireTime - currentTime <= MILLIS_MINUTE_TEN)
        {
            refreshToken(loginUser);
        }
    }

    /**
     * 刷新令牌有效期
     *
     * @param loginUser 登录信息
     */
    public void refreshToken(LoginUser loginUser)
    {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * MILLIS_MINUTE);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        redisCache.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
    }

    /**
     * 设置用户代理信息
     *
     * @param loginUser 登录信息
     */
    public void setUserAgent(LoginUser loginUser)
    {
        UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtils.getRequest().getHeader("User-Agent"));
        String ip = IpUtils.getIpAddr();
        loginUser.setIpaddr(ip);
        loginUser.setLoginLocation(AddressUtils.getRealAddressByIP(ip));
        loginUser.setBrowser(userAgent.getBrowser().getName());
        loginUser.setOs(userAgent.getOperatingSystem().getName());
    }

    /**
     * 从数据声明生成令牌
     *
     * @param claims 数据声明
     * @return 令牌
     */
    private String createToken(Map<String, Object> claims)
    {
        String token = Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();
        return token;
    }

    /**
     * 从令牌中获取数据声明
     *
     * @param token 令牌
     * @return 数据声明
     */
    private Claims parseToken(String token)
    {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
    }

    /**
     * 从令牌中获取用户名
     *
     * @param token 令牌
     * @return 用户名
     */
    public String getUsernameFromToken(String token)
    {
        Claims claims = parseToken(token);
        return claims.getSubject();
    }

    /**
     * 获取请求token
     *
     * @param request
     * @return token
     */
    private String getToken(HttpServletRequest request)
    {
        return request.getHeader(HEADER_ACCESS_TOKEN);
    }

    private String getTokenKey(String uuid)
    {
        return CacheConstants.LOGIN_TOKEN_KEY + uuid;
    }
}
