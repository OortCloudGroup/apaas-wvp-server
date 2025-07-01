package com.ruoyi.isup.service.cmsService;

import cn.hutool.core.util.ObjectUtil;
import com.ruoyi.isup.common.SdkFunctionWrapUtil;
import com.ruoyi.isup.common.osSelect;
import com.ruoyi.isup.config.IsupConfig;
import com.ruoyi.isup.domain.IsupDevice;
import com.ruoyi.isup.service.IIsupDeviceService;
import com.sun.jna.Native;
import com.sun.jna.Pointer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;

/**
 * @Author: fengcheng
 */
@Slf4j
@Component
public class CMS {

    public static HCISUPCMS hCEhomeCMS = null;

    /**
     * CMS监听句柄
     */
    public static int CmsHandle = -1;

    /**
     * 注册回调函数实现
     */
    static FRegisterCallBack fRegisterCallBack;

    HCISUPCMS.NET_EHOME_CMS_LISTEN_PARAM struCMSListenPara = new HCISUPCMS.NET_EHOME_CMS_LISTEN_PARAM();

    @Autowired
    private IsupConfig isupConfig;

    @Autowired
    private IIsupDeviceService isupDeviceService;

    /**
     * 根据不同操作系统选择不同的库文件和库路径
     *
     * @return
     */
    private static boolean CreateSDKInstance() {
        if (hCEhomeCMS == null) {
            synchronized (HCISUPCMS.class) {
                String strDllPath = "";
                try {
                    //System.setProperty("jna.debug_load", "true");
                    if (osSelect.isWindows()) {
                        //win系统加载库路径(路径不要带中文)
                        strDllPath = System.getProperty("user.dir") + "\\ruoyi-isup\\win-lib\\HCISUPCMS.dll";
                        hCEhomeCMS = (HCISUPCMS) Native.loadLibrary(strDllPath, HCISUPCMS.class);
                    } else if (osSelect.isLinux()) {
                        //Linux系统加载库路径(路径不要带中文)
                        strDllPath = System.getProperty("user.dir") + "/linux-lib/libHCISUPCMS.so";
                        hCEhomeCMS = (HCISUPCMS) Native.loadLibrary(strDllPath, HCISUPCMS.class);
                    }
                } catch (Exception ex) {
                    log.info("加载: " + strDllPath + " 错误: " + ex.getMessage());
                    return false;
                }
            }
        }
        return true;
    }


    /**
     * cms服务初始化，开启监听
     *
     * @throws IOException
     */
    @PostConstruct
    public void cMS_Init() throws IOException {
        if (hCEhomeCMS == null) {
            if (!CreateSDKInstance()) {
                log.error("加载CMS SDK 失败");
                return;
            }
        }

        if (osSelect.isWindows()) {
            HCISUPCMS.BYTE_ARRAY ptrByteArrayCrypto = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathCrypto = System.getProperty("user.dir") + "\\ruoyi-isup\\win-lib\\libeay32.dll"; //Linux版本是libcrypto.so库文件的路径
            System.arraycopy(strPathCrypto.getBytes(), 0, ptrByteArrayCrypto.byValue, 0, strPathCrypto.length());
            ptrByteArrayCrypto.write();
            hCEhomeCMS.NET_ECMS_SetSDKInitCfg(0, ptrByteArrayCrypto.getPointer());

            //设置libssl.so所在路径
            HCISUPCMS.BYTE_ARRAY ptrByteArraySsl = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathSsl = System.getProperty("user.dir") + "\\ruoyi-isup\\win-lib\\ssleay32.dll";    //Linux版本是libssl.so库文件的路径
            System.arraycopy(strPathSsl.getBytes(), 0, ptrByteArraySsl.byValue, 0, strPathSsl.length());
            ptrByteArraySsl.write();
            hCEhomeCMS.NET_ECMS_SetSDKInitCfg(1, ptrByteArraySsl.getPointer());
            //注册服务初始化
            boolean binit = hCEhomeCMS.NET_ECMS_Init();
            if (binit) {
                log.info("CMS 注册中心初始化成功!");
                startCmsListen();
            } else {
                log.error("CMS 注册中心初始化失败! 错误码:" + hCEhomeCMS.NET_ECMS_GetLastError());
            }
            //设置HCAapSDKCom组件库文件夹所在路径
            HCISUPCMS.BYTE_ARRAY ptrByteArrayCom = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathCom = System.getProperty("user.dir") + "\\ruoyi-isup\\win-lib\\HCAapSDKCom";        //只支持绝对路径，建议使用英文路径
            System.arraycopy(strPathCom.getBytes(), 0, ptrByteArrayCom.byValue, 0, strPathCom.length());
            ptrByteArrayCom.write();
            hCEhomeCMS.NET_ECMS_SetSDKLocalCfg(5, ptrByteArrayCom.getPointer());

        } else if (osSelect.isLinux()) {
            HCISUPCMS.BYTE_ARRAY ptrByteArrayCrypto = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathCrypto = System.getProperty("user.dir") + "/linux-lib/libcrypto.so"; //Linux版本是libcrypto.so库文件的路径
            System.arraycopy(strPathCrypto.getBytes(), 0, ptrByteArrayCrypto.byValue, 0, strPathCrypto.length());
            ptrByteArrayCrypto.write();
            hCEhomeCMS.NET_ECMS_SetSDKInitCfg(0, ptrByteArrayCrypto.getPointer());

            //设置libssl.so所在路径
            HCISUPCMS.BYTE_ARRAY ptrByteArraySsl = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathSsl = System.getProperty("user.dir") + "/linux-lib/libssl.so";    //Linux版本是libssl.so库文件的路径
            System.arraycopy(strPathSsl.getBytes(), 0, ptrByteArraySsl.byValue, 0, strPathSsl.length());
            ptrByteArraySsl.write();
            hCEhomeCMS.NET_ECMS_SetSDKInitCfg(1, ptrByteArraySsl.getPointer());
            //注册服务初始化
            boolean binit = hCEhomeCMS.NET_ECMS_Init();
            if (binit) {
                log.info("CMS 注册中心初始化成功!");
                startCmsListen();
            } else {
                log.error("CMS 注册中心初始化失败! 错误码:" + hCEhomeCMS.NET_ECMS_GetLastError());
            }
            //设置HCAapSDKCom组件库文件夹所在路径
            HCISUPCMS.BYTE_ARRAY ptrByteArrayCom = new HCISUPCMS.BYTE_ARRAY(256);
            String strPathCom = System.getProperty("user.dir") + "/linux-lib/HCAapSDKCom/";        //只支持绝对路径，建议使用英文路径
            System.arraycopy(strPathCom.getBytes(), 0, ptrByteArrayCom.byValue, 0, strPathCom.length());
            ptrByteArrayCom.write();
            hCEhomeCMS.NET_ECMS_SetSDKLocalCfg(5, ptrByteArrayCom.getPointer());
        }
    }

    public void startCmsListen() {
        if (fRegisterCallBack == null) {
            fRegisterCallBack = new FRegisterCallBack();
        }
        //设置CMS监听参数
        System.arraycopy(isupConfig.getIp().getBytes(), 0, struCMSListenPara.struAddress.szIP, 0, isupConfig.getIp().length());
        struCMSListenPara.struAddress.wPort = (short) isupConfig.getCmsServerPort();
        struCMSListenPara.fnCB = fRegisterCallBack;
        struCMSListenPara.write();

        //启动监听，接收设备注册信息
        CmsHandle = hCEhomeCMS.NET_ECMS_StartListen(struCMSListenPara);
        if (CmsHandle < 0) {
            log.error("CMS注册中心监听失败, 错误码:" + hCEhomeCMS.NET_ECMS_GetLastError());
            hCEhomeCMS.NET_ECMS_Fini();
            return;
        }
        String CmsListenInfo = new String(struCMSListenPara.struAddress.szIP).trim() + "_" + struCMSListenPara.struAddress.wPort;
        log.info("CMS注册服务器:" + CmsListenInfo + "监听成功!");
    }

    /**
     * 注册回调函数
     */
    public class FRegisterCallBack implements HCISUPCMS.DEVICE_REGISTER_CB {
        @Override
        public boolean invoke(int lUserID, int dwDataType, Pointer pOutBuffer, int dwOutLen, Pointer pInBuffer, int dwInLen, Pointer pUser) {
            log.info("注册回调 ,dwDataType:" + dwDataType + ", lUserID:" + lUserID, " dwOutLen:" + dwOutLen + ", dwInLen:" + dwInLen);
            log.info("pUser" + pUser);
            switch (dwDataType) {
                case HCISUPCMS.EHOME_REGISTER_TYPE.ENUM_DEV_ON: {
                    HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12 strDevRegInfo = new HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12();
                    strDevRegInfo.write();
                    Pointer pDevRegInfo = strDevRegInfo.getPointer();
                    pDevRegInfo.write(0, pOutBuffer.getByteArray(0, strDevRegInfo.size()), 0, strDevRegInfo.size());
                    strDevRegInfo.read();

                    log.info("设备上线==========>,DeviceID:" + new String(strDevRegInfo.struRegInfo.byDeviceID).trim());
                    log.info("设备上线==========>,dwSize:" + strDevRegInfo.struRegInfo.dwSize);
                    log.info("设备上线==========>,dwNetUnitType:" + strDevRegInfo.struRegInfo.dwNetUnitType);
                    log.info("设备上线==========>,byFirmwareVersion:" + new String(strDevRegInfo.struRegInfo.byFirmwareVersion).trim());
                    log.info("设备上线==========>,struDevAdd:" + new String(strDevRegInfo.struRegInfo.struDevAdd.szIP).trim(), strDevRegInfo.struRegInfo.struDevAdd.wPort, new String(strDevRegInfo.struRegInfo.struDevAdd.byRes).trim());
                    log.info("设备上线==========>,dwDevType:" + strDevRegInfo.struRegInfo.dwDevType);
                    log.info("设备上线==========>,dwManufacture:" + strDevRegInfo.struRegInfo.dwManufacture);
                    log.info("设备上线==========>,byPassWord:" + new String(strDevRegInfo.struRegInfo.byPassWord).trim());
                    log.info("设备上线==========>,sDeviceSerial:" + new String(strDevRegInfo.struRegInfo.sDeviceSerial).trim());
                    log.info("设备上线==========>,byReliableTransmission:" + strDevRegInfo.struRegInfo.byReliableTransmission);
                    log.info("设备上线==========>,byWebSocketTransmission:" + strDevRegInfo.struRegInfo.byWebSocketTransmission);
                    log.info("设备上线==========>,bySupportRedirect:" + strDevRegInfo.struRegInfo.bySupportRedirect);
                    log.info("设备上线==========>,byDevProtocolVersion:" + new String(strDevRegInfo.struRegInfo.byDevProtocolVersion).trim());
                    log.info("设备上线==========>,bySessionKey:" + new String(strDevRegInfo.struRegInfo.bySessionKey).trim());
                    log.info("设备上线==========>,byRes:" + new String(strDevRegInfo.struRegInfo.byRes).trim());
                    log.info("设备上线==========>,byMarketType:" + strDevRegInfo.struRegInfo.byMarketType);
                    log.info("设备上线==========>,lUserID:" + lUserID);

                    if (ObjectUtil.isNotNull(isupDeviceService.selectIsupDeviceByLuserIdAndIp(lUserID, new String(strDevRegInfo.struRegInfo.struDevAdd.szIP).trim()))) {
                        isupDeviceService.updateIsupDeviceStatusByLuserId(lUserID, new String(strDevRegInfo.struRegInfo.struDevAdd.szIP).trim(), "1");
                    } else {
                        IsupDevice isupDevice = new IsupDevice();
                        isupDevice.setDeviceId(new String(strDevRegInfo.struRegInfo.byDeviceID).trim());
                        isupDevice.setDwSize(strDevRegInfo.struRegInfo.dwSize);
                        isupDevice.setDwNetUnitType(strDevRegInfo.struRegInfo.dwNetUnitType);
                        isupDevice.setFirmwareVersion(new String(strDevRegInfo.struRegInfo.byFirmwareVersion).trim());
                        isupDevice.setIpAddress(new String(strDevRegInfo.struRegInfo.struDevAdd.szIP).trim());
                        isupDevice.setPort(strDevRegInfo.struRegInfo.struDevAdd.wPort);
                        isupDevice.setDeviceRes(new String(strDevRegInfo.struRegInfo.struDevAdd.byRes).trim());
                        isupDevice.setDevType(strDevRegInfo.struRegInfo.dwDevType);
                        isupDevice.setManufacture(strDevRegInfo.struRegInfo.dwManufacture);
                        isupDevice.setPassword(new String(strDevRegInfo.struRegInfo.byPassWord).trim());
                        isupDevice.setDeviceSerial(new String(strDevRegInfo.struRegInfo.sDeviceSerial).trim());
                        isupDevice.setReliableTransmission(strDevRegInfo.struRegInfo.byReliableTransmission);
                        isupDevice.setWebsocketTransmission(strDevRegInfo.struRegInfo.byWebSocketTransmission);
                        isupDevice.setSupportRedirect(strDevRegInfo.struRegInfo.bySupportRedirect);
                        isupDevice.setDevProtocolVersion(new String(strDevRegInfo.struRegInfo.byDevProtocolVersion).trim());
                        isupDevice.setSessionKey(new String(strDevRegInfo.struRegInfo.bySessionKey).trim());
                        isupDevice.setRes(new String(strDevRegInfo.struRegInfo.byRes).trim());
                        isupDevice.setMarketType(strDevRegInfo.struRegInfo.byMarketType);
                        isupDevice.setLuserId(lUserID);
                        isupDevice.setStatus("ON");
                        isupDeviceService.insertIsupDevice(isupDevice);
                    }
                    return true;
                }
                case HCISUPCMS.EHOME_REGISTER_TYPE.ENUM_DEV_AUTH: {
                    HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12 strDevRegInfo = new HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12();
                    strDevRegInfo.write();
                    Pointer pDevRegInfo = strDevRegInfo.getPointer();
                    pDevRegInfo.write(0, pOutBuffer.getByteArray(0, strDevRegInfo.size()), 0, strDevRegInfo.size());
                    strDevRegInfo.read();
                    byte[] bs = new byte[0];
                    //ISUP5.0登录校验值
                    String szEHomeKey = isupConfig.getIsupKey();
                    bs = szEHomeKey.getBytes();
                    pInBuffer.write(0, bs, 0, szEHomeKey.length());
                    break;
                }
                case HCISUPCMS.EHOME_REGISTER_TYPE.ENUM_DEV_SESSIONKEY: {
                    HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12 strDevRegInfo = new HCISUPCMS.NET_EHOME_DEV_REG_INFO_V12();
                    strDevRegInfo.write();
                    Pointer pDevRegInfo = strDevRegInfo.getPointer();
                    pDevRegInfo.write(0, pOutBuffer.getByteArray(0, strDevRegInfo.size()), 0, strDevRegInfo.size());
                    strDevRegInfo.read();
                    HCISUPCMS.NET_EHOME_DEV_SESSIONKEY struSessionKey = new HCISUPCMS.NET_EHOME_DEV_SESSIONKEY();
                    System.arraycopy(strDevRegInfo.struRegInfo.byDeviceID, 0, struSessionKey.sDeviceID, 0, strDevRegInfo.struRegInfo.byDeviceID.length);
                    System.arraycopy(strDevRegInfo.struRegInfo.bySessionKey, 0, struSessionKey.sSessionKey, 0, strDevRegInfo.struRegInfo.bySessionKey.length);
                    struSessionKey.write();
                    Pointer pSessionKey = struSessionKey.getPointer();
                    hCEhomeCMS.NET_ECMS_SetDeviceSessionKey(pSessionKey);
//                    AlarmDemo.hcEHomeAlarm.NET_EALARM_SetDeviceSessionKey(pSessionKey);
                    break;
                }
                case HCISUPCMS.EHOME_REGISTER_TYPE.ENUM_DEV_DAS_REQ: {
                    String dasInfo = "{\n" +
                            "    \"Type\":\"DAS\",\n" +
                            "    \"DasInfo\": {\n" +
                            "        \"Address\":\"" + isupConfig.getIp() + "\",\n" +
                            "        \"Domain\":\"\",\n" +
                            "        \"ServerID\":\"\",\n" +
                            "        \"Port\":" + isupConfig.getCmsServerPort() + ",\n" +
                            "        \"UdpPort\":\n" +
                            "    }\n" +
                            "}";
                    log.info(dasInfo);
                    byte[] bs1 = dasInfo.getBytes();
                    pInBuffer.write(0, bs1, 0, dasInfo.length());
                    break;
                }
                case HCISUPCMS.EHOME_REGISTER_TYPE.ENUM_DEV_OFF: {
                    // 设备掉线
                    // 输出设备信息
                    log.info("[设备掉线] DeviceID is " + lUserID + "\n");
                    break;
                }
                default:
                    log.info("回调类型为:" + dwDataType);
                    break;
            }
            return true;
        }
    }


    /**
     * 获取设备信息（型号、版本、序列号等）
     *
     * @param lUserID
     */
    public boolean getDevInfo(int lUserID) {
        String getDevInfoURL = "GET /ISAPI/System/deviceInfo";
        return SdkFunctionWrapUtil.isapiPassThrough(lUserID, getDevInfoURL, "");
    }

    /**
     * 云台控制 ISUP5.0透传接口
     *
     * @param lUserID
     * @param direction   方向 1-右 2-左 3-上 4-下
     * @param controSpeed 速度
     * @param lUserID
     */
    public boolean PTZCtrl(Integer lUserID, Integer direction, Integer controSpeed) {
        String pan = "0";
        String tilt = "0";
        if (1 == direction) {
            pan = controSpeed.toString();
            tilt = "0";
        } else if (2 == direction) {
            pan = "-" + controSpeed.toString();
            tilt = "0";
        } else if (3 == direction) {
            pan = "0";
            tilt = controSpeed.toString();
        } else if (4 == direction) {
            pan = "0";
            tilt = "-" + controSpeed.toString();
        }

        String PTZCtrlUrl = "PUT /ISAPI/PTZCtrl/channels/1/continuous";
        String PTZCtrlInput = "<?xml version: \"1.0\" encoding=\"UTF-8\"?>\n" +
                "<PTZData>\n" +
                "    <pan>" + pan + "</pan>\n" +
                "    <tilt>" + tilt + "</tilt>\n" +
                "</PTZData>";
        //接口调用成功
        SdkFunctionWrapUtil.isapiPassThrough(lUserID, PTZCtrlUrl, PTZCtrlInput);

        //云台运动持续时间1s后调用停止云台运动接口
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //发送云台运动停止请求
        String PTZCtrlStopInput = "<?xml version: \"1.0\" encoding=\"UTF-8\"?>\n" +
                "<PTZData>\n" +
                "    <pan>0</pan>\n" +
                "    <tilt>0</tilt>\n" +
                "</PTZData>";
        SdkFunctionWrapUtil.isapiPassThrough(lUserID, PTZCtrlUrl, PTZCtrlStopInput);
        return true;
    }
}
