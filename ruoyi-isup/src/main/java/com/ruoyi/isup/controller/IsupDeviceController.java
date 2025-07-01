package com.ruoyi.isup.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.isup.domain.IsupDevice;
import com.ruoyi.isup.service.IIsupDeviceService;
import com.ruoyi.isup.service.cmsService.CMS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * isup设备Controller
 *
 * @author fengcheng
 * @date 2025-04-22
 */
@RestController
@RequestMapping("/isup/lsupDevice")
public class IsupDeviceController extends BaseController {
    @Autowired
    private IIsupDeviceService isupDeviceService;

    @Autowired
    private CMS cms;

    /**
     * 云台控制
     *
     * @param lUserID
     * @param direction 方向 1-右 2-左 3-上 4-下
     * @param controSpeed 速度
     * @return
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:ptzCtrl')")
    @GetMapping("/ptzCtrl")
    public AjaxResult ptzCtrl(Integer lUserID, Integer direction, Integer controSpeed) {
        cms.PTZCtrl(lUserID, direction, controSpeed);
        return success();
    }

    /**
     * 查询isup设备列表
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:list')")
    @GetMapping("/list")
    public TableDataInfo list(IsupDevice isupDevice) {
        startPage();
        List<IsupDevice> list = isupDeviceService.selectIsupDeviceList(isupDevice);
        return getDataTable(list);
    }

    /**
     * 查询isup设备列表
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:list')")
    @GetMapping("/lsupDeviceList")
    public AjaxResult lsupDeviceList(IsupDevice isupDevice) {
        List<IsupDevice> list = isupDeviceService.selectIsupDeviceList(isupDevice);
        return success(list);
    }

    /**
     * 获取isup设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(isupDeviceService.selectIsupDeviceById(id));
    }

    /**
     * 修改isup设备
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:edit')")
    @Log(title = "isup设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IsupDevice isupDevice) {
        return toAjax(isupDeviceService.updateIsupDevice(isupDevice));
    }

    /**
     * 删除isup设备
     */
    @PreAuthorize("@ss.hasPermi('isup:lsupDevice:remove')")
    @Log(title = "isup设备", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(isupDeviceService.deleteIsupDeviceByIds(ids));
    }
}
