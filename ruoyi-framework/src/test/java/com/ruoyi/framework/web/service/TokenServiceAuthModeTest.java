package com.ruoyi.framework.web.service;

import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.framework.config.properties.AuthModeProperties;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertSame;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

public class TokenServiceAuthModeTest
{
    private static final String TOKEN_HEADER = "accessToken";
    private static final String TOKEN_SECRET = "abcdefghijklmnopqrstuvwxyz";

    private TokenService tokenService;
    private RedisCache redisCache;
    private AuthModeProperties authModeProperties;

    @Before
    public void setUp()
    {
        tokenService = new TokenService();
        redisCache = mock(RedisCache.class);
        authModeProperties = new AuthModeProperties();
        authModeProperties.setMode(AuthModeProperties.Mode.LOCAL);

        ReflectionTestUtils.setField(tokenService, "redisCache", redisCache);
        ReflectionTestUtils.setField(tokenService, "authModeProperties", authModeProperties);
        ReflectionTestUtils.setField(tokenService, "header", TOKEN_HEADER);
        ReflectionTestUtils.setField(tokenService, "secret", TOKEN_SECRET);
    }

    @Test
    public void defaultAuthModeKeepsExistingSsoBehavior()
    {
        AuthModeProperties properties = new AuthModeProperties();

        assertEquals(AuthModeProperties.Mode.SSO, properties.getMode());
        assertEquals("sso", properties.getModeValue());
    }

    @Test
    public void localModeReadsLoginUserFromJwtAndRedis()
    {
        String uuid = "local-login-uuid";
        String jwt = createJwt(uuid);
        LoginUser expected = new LoginUser();
        when(redisCache.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY + uuid)).thenReturn(expected);

        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader(TOKEN_HEADER, Constants.TOKEN_PREFIX + jwt);

        assertSame(expected, tokenService.getLoginUser(request));
    }

    @Test
    public void localModeReturnsNullForInvalidJwt()
    {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader(TOKEN_HEADER, "not-a-jwt");

        assertNull(tokenService.getLoginUser(request));
        verifyNoInteractions(redisCache);
    }

    @Test
    public void requestWithoutTokenIsAnonymousInBothModes()
    {
        MockHttpServletRequest request = new MockHttpServletRequest();

        assertNull(tokenService.getLoginUser(request));
        authModeProperties.setMode(AuthModeProperties.Mode.SSO);
        assertNull(tokenService.getLoginUser(request));
        verifyNoInteractions(redisCache);
    }

    private String createJwt(String uuid)
    {
        return Jwts.builder()
                .claim(Constants.LOGIN_USER_KEY, uuid)
                .signWith(SignatureAlgorithm.HS512, TOKEN_SECRET)
                .compact();
    }
}
