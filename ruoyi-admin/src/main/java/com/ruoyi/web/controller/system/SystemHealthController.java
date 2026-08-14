package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Lightweight health endpoint used by container orchestration.
 */
@RestController
public class SystemHealthController
{
    @Anonymous
    @GetMapping("/health")
    public AjaxResult health()
    {
        return AjaxResult.success("OK");
    }
}
