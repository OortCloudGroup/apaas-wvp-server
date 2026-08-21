package com.ruoyi.vlstream.controller;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.vlstream.domain.dto.FirmwareUploadRequest;
import com.ruoyi.vlstream.service.VlStreamFirmwareDeploymentService;
import com.ruoyi.vlstream.service.VlStreamFirmwareService;
import org.apache.commons.io.IOUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;

@RestController
@RequestMapping("/vlstream/firmware")
public class VlStreamFirmwareController {
    private final VlStreamFirmwareService firmwareService;
    private final VlStreamFirmwareDeploymentService deploymentService;

    public VlStreamFirmwareController(VlStreamFirmwareService firmwareService,
                                      VlStreamFirmwareDeploymentService deploymentService) {
        this.firmwareService = firmwareService;
        this.deploymentService = deploymentService;
    }

    @PreAuthorize("@ss.hasPermi('vlstream:firmware:list')")
    @GetMapping("/page")
    public AjaxResult page(@RequestParam(defaultValue = "1") long current,
                           @RequestParam(defaultValue = "10") long size,
                           @RequestParam(required = false) String cameraModel,
                           @RequestParam(required = false) String firmwareVersion) {
        return AjaxResult.success(firmwareService.page(current, size, cameraModel, firmwareVersion));
    }

    @PreAuthorize("@ss.hasPermi('vlstream:firmware:upload')")
    @PostMapping("/upload-grant")
    public AjaxResult uploadGrant(@RequestBody FirmwareUploadRequest request) {
        return AjaxResult.success(firmwareService.issueUpload(request));
    }

    @PreAuthorize("@ss.hasPermi('vlstream:firmware:upload')")
    @PostMapping("/{id}/complete")
    public AjaxResult complete(@PathVariable Long id) { return AjaxResult.success(firmwareService.complete(id)); }

    @PreAuthorize("@ss.hasPermi('vlstream:firmware:download')")
    @GetMapping("/{id}/download-url")
    public AjaxResult downloadUrl(@PathVariable Long id) { return AjaxResult.success(firmwareService.downloadUrl(id)); }

    @PreAuthorize("@ss.hasPermi('vlstream:firmware:remove')")
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) {
        firmwareService.remove(id);
        return AjaxResult.success();
    }

    @Anonymous
    @GetMapping("/ota/{requestId}/{messageId}")
    public void ota(@PathVariable String requestId, @PathVariable String messageId,
                    HttpServletResponse response) throws Exception {
        VlStreamFirmwareDeploymentService.Download download = deploymentService.openDownload(requestId, messageId);
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType(download.getContentType());
        response.setContentLengthLong(download.getSize());
        String encoded = URLEncoder.encode(download.getFileName(), "UTF-8").replace("+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encoded);
        try (InputStream input = download.getInput()) {
            IOUtils.copyLarge(input, response.getOutputStream());
        }
    }
}
