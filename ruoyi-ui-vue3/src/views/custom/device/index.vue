<template>
  <DeviceClassificationLayout protocol-type="CUSTOM" :selected-device-keys="classificationDeviceKeys"
    @filter-change="handleClassificationFilter" @assigned="getList">
    <div class="app-container">
      <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
        <el-form-item label="设备名称" prop="deviceName">
          <el-input v-model="queryParams.deviceName" placeholder="请输入设备名称" clearable @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="设备ID" prop="deviceCode">
          <el-input v-model="queryParams.deviceCode" placeholder="请输入设备ID" clearable @keyup.enter="handleQuery" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="全部状态" clearable style="width: 140px">
            <el-option label="在线" value="ONLINE"/><el-option label="离线" value="OFFLINE"/><el-option label="未知" value="UNKNOWN"/>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-row :gutter="10" class="mb8" align="middle">
        <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['custom:device:add']">新增</el-button></el-col>
        <el-col :span="1.5"><el-button type="success" plain icon="Edit" :disabled="single" @click="handleEdit" v-hasPermi="['custom:device:edit']">修改</el-button></el-col>
        <el-col :span="1.5"><el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['custom:device:remove']">删除</el-button></el-col>
        <el-col :span="1.5"><el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['custom:device:export']">导出</el-button></el-col>
        <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
      </el-row>

      <el-table v-loading="loading" :data="deviceList" border @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"/>
        <el-table-column type="index" label="序号" width="70" align="center"/>
        <el-table-column prop="deviceName" label="设备名称" min-width="140" show-overflow-tooltip/>
        <el-table-column prop="deviceCode" label="设备ID" min-width="150" show-overflow-tooltip/>
        <el-table-column prop="deviceType" label="设备类型" width="110"/>
        <el-table-column label="区域" min-width="100"><template #default="scope">{{ scope.row.regionName || '未设置' }}</template></el-table-column>
        <el-table-column label="分组" min-width="100"><template #default="scope">{{ scope.row.groupName || '未设置' }}</template></el-table-column>
        <el-table-column label="标签" min-width="160">
          <template #default="scope"><template v-if="scope.row.tagNames"><el-tag v-for="tag in scope.row.tagNames.split(',')" :key="tag" size="small" class="tag-item">{{ tag }}</el-tag></template><span v-else>未设置</span></template>
        </el-table-column>
        <el-table-column prop="streamUrl" label="视频流路径" min-width="240" show-overflow-tooltip/>
        <el-table-column label="状态" width="85" align="center"><template #default="scope"><el-tag :type="statusType(scope.row.status)">{{ statusText(scope.row.status) }}</el-tag></template></el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="165"/>
        <el-table-column label="操作" width="240" align="center" fixed="right">
          <template #default="scope">
            <el-button link type="primary" @click="handlePreview(scope.row)" v-hasPermi="['custom:device:play']">预览</el-button>
            <el-button link type="primary" @click="openRecord(scope.row)" v-hasPermi="['custom:device:record']">录像</el-button>
            <el-button link type="primary" @click="handleEdit(scope.row)" v-hasPermi="['custom:device:edit']">编辑</el-button>
            <el-button link type="danger" @click="handleDelete(scope.row)" v-hasPermi="['custom:device:remove']">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList"/>

      <el-dialog v-model="formOpen" :title="formTitle" width="640px" append-to-body>
        <el-form ref="deviceFormRef" :model="form" :rules="rules" label-width="100px">
          <el-row :gutter="16">
            <el-col :span="12"><el-form-item label="设备名称" prop="deviceName"><el-input v-model="form.deviceName"/></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="设备ID" prop="deviceCode"><el-input v-model="form.deviceCode"/></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="设备类型" prop="deviceType"><el-select v-model="form.deviceType" clearable style="width:100%"><el-option v-for="type in deviceTypes" :key="type" :label="type" :value="type"/></el-select></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="状态" prop="status"><el-select v-model="form.status" style="width:100%"><el-option label="在线" value="ONLINE"/><el-option label="离线" value="OFFLINE"/><el-option label="未知" value="UNKNOWN"/></el-select></el-form-item></el-col>
            <el-col :span="24"><el-form-item label="视频流路径" prop="streamUrl"><el-input v-model="form.streamUrl" placeholder="rtsp://、rtmp:// 或 http(s)://"/></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="经度" prop="longitude"><el-input-number v-model="form.longitude" :precision="7" :min="-180" :max="180" style="width:100%"/></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="纬度" prop="latitude"><el-input-number v-model="form.latitude" :precision="7" :min="-90" :max="90" style="width:100%"/></el-form-item></el-col>
            <el-col :span="24"><el-form-item label="地址" prop="address"><el-input v-model="form.address"/></el-form-item></el-col>
            <el-col :span="24"><el-form-item label="备注" prop="remark"><el-input v-model="form.remark" type="textarea" :rows="3"/></el-form-item></el-col>
          </el-row>
        </el-form>
        <template #footer><el-button @click="formOpen=false">取消</el-button><el-button type="primary" :loading="submitting" @click="submitForm">保存</el-button></template>
      </el-dialog>

      <el-dialog v-model="previewOpen" :title="previewTitle" width="820px" append-to-body destroy-on-close @closed="cleanupPreviewPlayer">
        <div v-loading="previewLoading" class="player-box">
          <rtc-player v-if="rtcUrl" :video-url="rtcUrl" :hasaudio="true"/>
          <div v-else ref="oplayerContainer" class="oplayer-container"/>
        </div>
      </el-dialog>

      <el-dialog v-model="recordOpen" :title="`${recordDevice.deviceName || ''} - 录像管理`" width="560px" append-to-body>
        <el-alert title="录像由 WVP 的 ZLM 媒体服务器真实执行；计划跨午夜时按开始日归属。" type="info" :closable="false" class="mb16"/>
        <el-form :model="recordPlan" label-width="100px">
          <el-form-item label="当前状态"><el-tag :type="recording ? 'danger' : 'info'">{{ recording ? '录像中' : '未录像' }}</el-tag><el-button v-if="!recording" link type="primary" :disabled="!mediaAvailable" @click="startRecord">立即开始</el-button><el-button v-else link type="danger" @click="stopRecord">立即停止</el-button></el-form-item>
          <el-form-item label="启用计划"><el-switch v-model="recordPlan.enabled"/></el-form-item>
          <el-form-item label="录像星期"><el-checkbox-group v-model="selectedDays"><el-checkbox v-for="day in weekOptions" :key="day.value" :label="day.value">{{ day.label }}</el-checkbox></el-checkbox-group></el-form-item>
          <el-form-item label="录像时段"><el-time-picker v-model="timeRange" is-range value-format="HH:mm" format="HH:mm" start-placeholder="开始" end-placeholder="结束"/></el-form-item>
        </el-form>
        <template #footer><el-button @click="recordOpen=false">取消</el-button><el-button type="primary" @click="saveRecordPlanForm">保存计划</el-button></template>
      </el-dialog>
    </div>
  </DeviceClassificationLayout>
</template>

<script setup>
import { getCurrentInstance, nextTick, onMounted, reactive, ref, shallowRef } from 'vue'
import RtcPlayer from '@/components/rtcPlayer/index.vue'
import DeviceClassificationLayout from '@/components/DeviceClassificationLayout/index.vue'
import { addCustomDevice, deleteCustomDevices, getCustomDevice, getCustomMediaStatus, getCustomRecordPlan, getCustomRecordStatus, listCustomDevices, previewCustomDevice, saveCustomRecordPlan, startCustomRecord, stopCustomRecord, updateCustomDevice } from '@/api/custom/device'
import { createOPlayerOptions, ensureOPlayer, getCustomStreamType } from '@/utils/customPlayer'

const { proxy } = getCurrentInstance()
const loading=ref(false), showSearch=ref(true), deviceList=ref([]), total=ref(0), ids=ref([]), single=ref(true), multiple=ref(true)
const classificationDeviceKeys=ref([]), mediaAvailable=ref(false), formOpen=ref(false), submitting=ref(false), previewOpen=ref(false), previewLoading=ref(false), rtcUrl=ref('')
const oplayerContainer=ref(null), oplayerInstance=shallowRef(null)
const recordOpen=ref(false), recording=ref(false), selectedDays=ref(['1','2','3','4','5','6','7']), timeRange=ref(['00:00','23:59'])
const previewTitle=ref('视频预览'), formTitle=ref('新增设备'), recordDevice=ref({}), recordPlan=reactive({enabled:false,weekDays:'1,2,3,4,5,6,7',startTime:'00:00',endTime:'23:59'})
const queryParams=reactive({pageNum:1,pageSize:10,deviceName:'',deviceCode:'',status:undefined})
const form=reactive({id:undefined,deviceName:'',deviceCode:'',streamUrl:'',deviceType:'摄像头',status:'UNKNOWN',longitude:undefined,latitude:undefined,address:'',remark:''})
const rules={deviceName:[{required:true,message:'设备名称不能为空',trigger:'blur'}],deviceCode:[{required:true,message:'设备ID不能为空',trigger:'blur'}],streamUrl:[{required:true,message:'视频流路径不能为空',trigger:'blur'},{pattern:/^(rtsp|rtmp|https?):\/\//i,message:'请输入有效的视频流地址',trigger:'blur'}]}
const deviceTypes=['球机','云台','摄像头','枪机','半球','其他']
const weekOptions=[['1','周一'],['2','周二'],['3','周三'],['4','周四'],['5','周五'],['6','周六'],['7','周日']].map(([value,label])=>({value,label}))

async function getList(){loading.value=true;try{const [list,media]=await Promise.all([listCustomDevices(queryParams),getCustomMediaStatus()]);deviceList.value=list.rows||[];total.value=list.total||0;mediaAvailable.value=Boolean(media.data?.available)}finally{loading.value=false}}
function handleQuery(){queryParams.pageNum=1;getList()}
function resetQuery(){proxy.resetForm('queryRef');handleQuery()}
function handleClassificationFilter(filter){Object.assign(queryParams,filter,{pageNum:1});getList()}
function handleSelectionChange(selection){ids.value=selection.map(x=>String(x.id));classificationDeviceKeys.value=[...ids.value];single.value=selection.length!==1;multiple.value=!selection.length}
function resetForm(){Object.assign(form,{id:undefined,deviceName:'',deviceCode:'',streamUrl:'',deviceType:'摄像头',status:'UNKNOWN',longitude:undefined,latitude:undefined,address:'',remark:''});proxy.resetForm('deviceFormRef')}
function handleAdd(){resetForm();formTitle.value='新增设备';formOpen.value=true}
async function handleEdit(row){resetForm();const id=row?.id||ids.value[0];const res=await getCustomDevice(id);Object.assign(form,res.data||{});formTitle.value='修改设备';formOpen.value=true}
async function submitForm(){await proxy.$refs.deviceFormRef.validate();submitting.value=true;try{form.id?await updateCustomDevice(form):await addCustomDevice(form);proxy.$modal.msgSuccess(form.id?'修改成功':'新增成功');formOpen.value=false;getList()}finally{submitting.value=false}}
function handleDelete(row){const values=row?.id?[String(row.id)]:ids.value;proxy.$modal.confirm(`是否确认删除选中的 ${values.length} 台设备？`).then(()=>deleteCustomDevices(values.join(','))).then(()=>{proxy.$modal.msgSuccess('删除成功');getList()}).catch(()=>{})}
function handleExport(){proxy.download('/custom/device/export',{...queryParams},`自定义协议设备_${Date.now()}.xlsx`)}
function cleanupPreviewPlayer(){
  if(oplayerInstance.value?.compInstance?.$destroy)oplayerInstance.value.compInstance.$destroy()
  oplayerInstance.value=null
  if(oplayerContainer.value)oplayerContainer.value.innerHTML=''
  rtcUrl.value=''
}
async function handlePreview(row){
  if(!row.streamUrl)return proxy.$modal.msgWarning('设备未配置视频流地址')
  cleanupPreviewPlayer()
  previewTitle.value=`${row.deviceName} - 视频预览`
  previewOpen.value=true
  previewLoading.value=true
  try{
    if(['rtsp','rtmp'].includes(getCustomStreamType(row.streamUrl))){
      if(!mediaAvailable.value)throw new Error('RTSP 预览需要可用的 ZLM 媒体服务器')
      const res=await previewCustomDevice(row.id)
      const stream=res.data||{}
      rtcUrl.value=location.protocol==='https:'?stream.rtcs:stream.rtc
      if(!rtcUrl.value)throw new Error('ZLM 未返回 WebRTC 播放地址')
      return
    }

    await Promise.all([ensureOPlayer(),nextTick()])
    if(!oplayerContainer.value)throw new Error('播放器容器未准备好')
    const {playerConfig,playConfig}=createOPlayerOptions(row.streamUrl)
    const player=new window.OToolBox.OPlayer(oplayerContainer.value,playerConfig)
    oplayerInstance.value=player
    player.play({...playConfig,name:row.deviceName||''})
  }catch(error){
    proxy.$modal.msgError(error?.message||'视频预览失败')
    previewOpen.value=false
  }finally{previewLoading.value=false}
}
async function openRecord(row){recordDevice.value=row;const [plan,status]=await Promise.all([getCustomRecordPlan(row.id),getCustomRecordStatus(row.id)]);Object.assign(recordPlan,plan.data||{});selectedDays.value=(recordPlan.weekDays||'').split(',').filter(Boolean);timeRange.value=[recordPlan.startTime||'00:00',recordPlan.endTime||'23:59'];recording.value=Boolean(status.data);recordOpen.value=true}
async function startRecord(){await startCustomRecord(recordDevice.value.id);recording.value=true;proxy.$modal.msgSuccess('录像已启动')}
async function stopRecord(){await stopCustomRecord(recordDevice.value.id);recording.value=false;proxy.$modal.msgSuccess('录像已停止')}
async function saveRecordPlanForm(){if(!timeRange.value?.length)return proxy.$modal.msgWarning('请选择录像时段');Object.assign(recordPlan,{weekDays:selectedDays.value.join(','),startTime:timeRange.value[0],endTime:timeRange.value[1]});await saveCustomRecordPlan(recordDevice.value.id,recordPlan);proxy.$modal.msgSuccess('录像计划已保存');recordOpen.value=false}
function statusType(status){return status==='ONLINE'?'success':status==='OFFLINE'?'info':'warning'}
function statusText(status){return status==='ONLINE'?'在线':status==='OFFLINE'?'离线':'未知'}
onMounted(getList)
</script>

<style scoped>
.tag-item{margin-right:4px}.player-box{height:420px;background:#111;display:flex;align-items:center;justify-content:center}.oplayer-container{width:100%;height:100%}.player-box :deep(#rtcPlayer){width:100%}.mb16{margin-bottom:16px}
</style>
