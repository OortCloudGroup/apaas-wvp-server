<template>
  <div class="app-container">
    <el-alert title="通道号要填写正确，用户名/密码就是后台登陆的用户名/密码" type="success"
              style="margin-bottom: 10px;"/>

    <div class="toolbar-with-search">
      <div class="toolbar-left">
        <button type="button" class="exportBtn newBtn flexRowAC" @click="handleAdd" v-hasPermi="['rtsp:RtspDevice:add']">
          <el-icon class="BtnImg"><Plus /></el-icon>新增
        </button>
        <button-group :button-list="toolbarButtons" />
      </div>
      <div class="searchHeight_out flexRowAC">
        <search-height-box
          keyword="name"
          placeholder="请输入摄像头名称等关键词"
          :data="searchData"
          @handle="searchResetFn"
        />
        <export-excel-pdf :item="{ isDisabledExcel: false }" @handle="handleExportType" />
      </div>
    </div>
    <table-self
      class="new_table"
      header-cell-class-name="header_tenant_cell"
      stripe
      v-loading="loading"
      :data="RtspDeviceList"
      current-row-key="id"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" :width="clacPXToVW(55)" align="center"/>
      <el-table-column label="所属部门" align="center" prop="deptName" show-overflow-tooltip/>
      <el-table-column label="ip" align="center" prop="ip" show-overflow-tooltip/>
      <el-table-column label="摄像头名称" align="center" prop="name" show-overflow-tooltip/>
      <el-table-column label="地址" align="center" prop="addressMap" show-overflow-tooltip/>
      <el-table-column label="用户名" align="center" prop="userName"/>
      <el-table-column label="密码" align="center" prop="password">
        <template #default="scope">
          <div class="password-container">
            <span v-if="!passwordVisibility[scope.row.id]">******</span>
            <span v-else>{{ scope.row.password }}</span>
            <el-icon class="eye-icon" @click.stop="togglePasswordVisibility(scope.row.id)">
              <component :is="passwordVisibility[scope.row.id] ? 'Hide' : 'View'"/>
            </el-icon>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="通道号" align="center" prop="channel"/>
      <el-table-column label="设备厂商" align="center" prop="firm">
        <template #default="scope">
          <dict-tag :options="rtsp_manufacturer" :value="scope.row.firm"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="right" fixed="right" :width="clacPXToVW(220)">
        <template #default="scope">
          <div class="operateAppBox flexRowAC" style="justify-content: flex-end;">
            <div
              v-hasPermi="['rtsp:RtspDevice:view']"
              class="new_table_svg_group"
              @click.stop="handleView(scope.row)"
            >
              <el-icon><View /></el-icon>
              <span>播放</span>
            </div>
            <div
              v-hasPermi="['rtsp:RtspDevice:edit']"
              class="new_table_svg_group"
              @click.stop="handleUpdate(scope.row)"
            >
              <el-icon><Edit /></el-icon>
              <span>修改</span>
            </div>
            <el-dropdown
              @command="(command)=>{moreClick(command, scope.row)}"
              v-if="checkPermi(['rtsp:RtspDevice:remove', 'rtsp:RtspDevice:edit', 'rtsp:RtspDevice:Avatar', 'rtsp:RtspDevice:AlarmClock'])"
            >
              <div class="new_table_svg_group" @click.stop>
                <span>更多</span>
                <el-icon><ArrowDown /></el-icon>
              </div>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="handleDelete" v-if="checkPermi(['rtsp:RtspDevice:remove'])">删除</el-dropdown-item>
                  <el-dropdown-item command="handleMap" v-if="checkPermi(['rtsp:RtspDevice:edit'])">修改位置</el-dropdown-item>
                  <el-dropdown-item command="handleAI" v-if="checkPermi(['rtsp:RtspDevice:Avatar'])">AI播放</el-dropdown-item>
                  <el-dropdown-item command="handleAlarmClock" v-if="checkPermi(['rtsp:RtspDevice:AlarmClock'])">历史播放</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </template>
      </el-table-column>
    </table-self>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改rtsp设备对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="RtspDeviceRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="所属部门" prop="deptId">
          <el-tree-select v-model="form.deptId" :data="enabledDeptOptions" :props="{ value: 'id', label: 'label', children: 'children' }" value-key="id" placeholder="请选择归属部门" check-strictly />
        </el-form-item>
        <el-form-item label="ip" prop="ip">
          <el-input v-model="form.ip" placeholder="请输入ip"/>
        </el-form-item>
        <el-form-item label="摄像头名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入摄像头名称"/>
        </el-form-item>
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入用户名"/>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" placeholder="请输入密码"/>
        </el-form-item>
        <el-form-item label="通道号" prop="channel">
          <el-input v-model="form.channel" placeholder="请输入通道号"/>
        </el-form-item>
        <el-form-item label="设备厂商" prop="firm">
          <el-select v-model="form.firm" placeholder="请选择设备厂商">
            <el-option
                v-for="dict in rtsp_manufacturer"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 播放弹窗 对话框 -->
    <el-dialog :title="title" v-model="showPaly" width="835px">
      <div>
        <Hikvision :rtsp="rtspURL" v-if="showPaly"/>
      </div>
    </el-dialog>

    <el-dialog title="选择时间" v-model="showAlarmClock" width="505px" append-to-body>
      <el-form :model="alarmClockOptions" :rules="rulesAlarm" ref="alarmClockFormRef" label-width="100px">
        <el-form-item label="开始时间" prop="startTime">
          <el-date-picker
              v-model="alarmClockOptions.startTime"
              type="datetime"
              value-format="YYYY-MM-DD HH:mm:ss"
              placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="结束时间" prop="endTime">
          <el-date-picker
              v-model="alarmClockOptions.endTime"
              type="datetime"
              value-format="YYYY-MM-DD HH:mm:ss"
              placeholder="选择日期时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitFormAlarmClock">确 定</el-button>
          <el-button @click="showAlarmClock = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="选择ai模式" v-model="showAI" width="505px">
      <div>
        <el-button type="primary" style="width: 100%;" @click="handlDetection('detection')">目标检测</el-button>
      </div>
      <div style="margin-top: 10px;">
        <el-button type="primary" style="width: 100%;">车牌检测</el-button>
      </div>
    </el-dialog>

    <el-dialog title="目标检测算法" v-model="showAIPaly" width="835px" @close="closeAI">
      <div style="width: 800px; height: 600px;">
        <el-row>
          <el-col :span="24">
            <div class="selectVideo">
              <CusPlayer ref="cusPlayer" v-if="cusPlayerShow"></CusPlayer>
            </div>
          </el-col>
        </el-row>
      </div>
    </el-dialog>

    <el-dialog title="修改地址" v-model="showMap" width="800px" append-to-body>
      <MapGaoDe ref="MapContainer" @update-value="updateDialogMap" :position="position" :toponym="form.address"/>
    </el-dialog>

  </div>
</template>

<script setup name="RtspDevice">
import {
  listRtspDevice,
  getRtspDevice,
  delRtspDevice,
  addRtspDevice,
  updateRtspDevice,
  addDetection,
  stopDetection,
  alarmClockRtspDevice
} from "@/api/rtsp/RtspDevice";
import Hikvision from "@/components/Hikvision/index.vue";
import CusPlayer from "@/components/flv/CusPlayer.vue";
import {ElLoading} from "element-plus";
import {deptTreeSelect} from "@/api/system/user";
import MapGaoDe from "@/components/MapGaoDe/index.vue";
import {checkPermi} from "@/utils/permission";
import { clacPXToVW } from "@/utils/index";

const {proxy} = getCurrentInstance();
const {rtsp_manufacturer} = proxy.useDict('rtsp_manufacturer');

const RtspDeviceList = ref([]);
const open = ref(false);
const loading = ref(true);
const cusPlayerShow = ref(false);
const ids = ref([]);
const searchData = ref([]);
const single = ref(true);
const multiple = ref(true);

const toolbarButtons = computed(() => [
  { name: '修改', svg: 'edit', disabled: single.value, permi: ['rtsp:RtspDevice:edit'], clickFn: () => handleUpdate() },
  { name: '删除', svg: 'delete', disabled: multiple.value, permi: ['rtsp:RtspDevice:remove'], clickFn: () => handleDelete() }
]);
const total = ref(0);
const title = ref("");
const rtspURL = ref("");
const showPaly = ref(false);
const showAIPaly = ref(false);
const showAI = ref(false);
const showMap = ref(false);
const showAlarmClock = ref(false);
const streamInfo = ref(null);
const cusPlayer = ref(null);
const alarmClockFormRef = ref(null);
const position = ref(null);
const MapContainer = ref(null);
const toponym = ref('');

const deptOptions = ref(undefined);
const enabledDeptOptions = ref(undefined);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    deptId: null,
    ip: null,
    name: null,
    firm: null,
  },
  rules: {
    deptId: [{ required: true, message: "请选择所属部门", trigger: 'blur' }],
    ip: [
      {required: true, message: "ip不能为空", trigger: "blur"}
    ],
    name: [
      {required: true, message: "摄像头名称不能为空", trigger: "blur"}
    ],
    userName: [
      {required: true, message: "用户名不能为空", trigger: "blur"}
    ],
    password: [
      {required: true, message: "密码不能为空", trigger: "blur"}
    ],
    channel: [
      {required: true, message: "通道号不能为空", trigger: "blur"}
    ],
    firm: [
      {required: true, message: "设备厂商不能为空", trigger: "change"}
    ],
  }
});

const {queryParams, form, rules} = toRefs(data);

function moreClick(command, itemData) {
  if (command === "handleDelete") {
    handleDelete(itemData)
  } else if (command === "handleMap") {
    handleMap(itemData)
  } else if (command === "handleAI") {
    handleAI(itemData)
  } else if (command === "handleAlarmClock") {
    handleAlarmClock(itemData)
  }
}

const updateDialogMap = (value) => {
  form.value.addressMap = value.address + value.detailedStreet;
  form.value.lng = value.lng;
  form.value.lat = value.lat;
  position.value = [form.value.lng, form.value.lat];
  toponym.value = form.value.addressMap;
  updateRtspDevice(form.value).then(res => {
    showMap.value = false;
    Destruction();
    proxy.$modal.msgSuccess("操作成功");
  }).catch(() => {
    proxy.$modal.msgError("操作失败");
  })
}

const Destruction = () => {
  MapContainer.value?.Destruction();
};

const passwordVisibility = ref({});


const rulesAlarm = ref({
  startTime: [
    { required: true, message: '请选择开始时间', trigger: 'change' }
  ],
  endTime: [
    { required: true, message: '请选择结束时间', trigger: 'change' }
  ]
});

const alarmClockOptions = ref({
  id: undefined,
  startTime: undefined,
  endTime: undefined,
});

const handleMap = (row) => {
  form.value = row;
  position.value = [form.value.lng, form.value.lat];
  toponym.value = form.value.addressMap;
  showMap.value = true;
  Create();
};

const Create = () => {
  MapContainer.value?.inGaDeMap();
};


const submitFormAlarmClock = () => {
  proxy.$refs["alarmClockFormRef"].validate(valid => {
    if (valid) {
      alarmClockRtspDevice(alarmClockOptions.value).then(res => {
        rtspURL.value = res.msg;
        showPaly.value = true;
      }).finally(() => {
        showAlarmClock.value = false;
      });
    }
  });
}

const handleAlarmClock = (row) => {
  resetAlarmClock();
  alarmClockOptions.value.id = row.id;
  showAlarmClock.value = true;
}

const closeAI = () => {
  const params = {
    type: "detection",
    url: streamInfo.value.url,
    mediaId: null,
  }
  stopDetection(params);
}

const handleAI = (row) => {
  streamInfo.value = row;
  showAI.value = true;
}

function resetAlarmClock() {
  alarmClockOptions.value.id = undefined;
  alarmClockOptions.value.startTime = undefined;
  alarmClockOptions.value.endTime = undefined;
}

const handlDetection = async (str) => {
  const loadingService = ElLoading.service({
    lock: true,
    fullscreen: true,
    text: '正在发送指令',
    spinner: 'el-icon-loading',
    background: 'rgba(0, 0, 0, 0.7)',
  });
  cusPlayerShow.value = false;
  let mediaId = Math.floor(Math.random() * 900) + 100;
  const params = {
    type: str,
    url: streamInfo.value.url,
    mediaId: mediaId,
  }
  await addDetection(params).then(res => {
    showAI.value = false;
    cusPlayerShow.value = true;
    showAIPaly.value = true;
    setTimeout(() => {
      cusPlayer.value.createPlayer("http://127.0.0.1:7080/live/livestream/" + mediaId + ".flv", true, 0);
      loadingService.close();
    }, 3000);
  }).finally(() => {
    loadingService.close();
  });
}

/** 查询部门下拉树结构 */
function getDeptTree() {
  deptTreeSelect().then(response => {
    deptOptions.value = response.data;
    enabledDeptOptions.value = filterDisabledDept(JSON.parse(JSON.stringify(response.data)));
    initSearchData();
  });
};

function initSearchData() {
  searchData.value = [
    {
      label: '所属部门',
      value: 'deptId',
      type: 'tree-select',
      option: enabledDeptOptions.value || [],
      default: undefined
    },
    { label: 'ip', value: 'ip', type: 'text', default: '' },
    {
      label: '设备厂商',
      value: 'firm',
      type: 'select',
      option: (rtsp_manufacturer.value || []).map(d => ({ label: d.label, value: d.value })),
      default: undefined
    }
  ];
}

/** 过滤禁用的部门 */
function filterDisabledDept(deptList) {
  return deptList.filter(dept => {
    if (dept.disabled) {
      return false;
    }
    if (dept.children && dept.children.length) {
      dept.children = filterDisabledDept(dept.children);
    }
    return true;
  });
};

const togglePasswordVisibility = (id) => {
  passwordVisibility.value[id] = !passwordVisibility.value[id];
};

const handleView = (row) => {
  rtspURL.value = row.url;
  title.value = row.name;
  showPaly.value = true;
}

/** 查询rtsp设备列表 */
function getList() {
  loading.value = true;
  listRtspDevice(queryParams.value).then(response => {
    RtspDeviceList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    deptId: null,
    ip: null,
    name: null,
    userName: null,
    password: null,
    channel: null,
    url: null,
    firm: null,
    lat: null,
    lng: null,
    addressMap: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  };
  proxy.resetForm("RtspDeviceRef");
}

/** 搜索按钮操作 */
function searchResetFn(val) {
  queryParams.value.pageNum = 1;
  queryParams.value.name = val.name || null;
  queryParams.value.deptId = val.deptId || null;
  queryParams.value.ip = val.ip || null;
  queryParams.value.firm = val.firm || null;
  getList();
}

function handleExport() {
  proxy.download('rtsp/RtspDevice/export', {
    ...queryParams.value
  }, `RtspDevice_${new Date().getTime()}.xlsx`)
}

function handleExportType(type) {
  if (type === 'Excel') {
    handleExport();
  }
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加rtsp设备";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row?.id || ids.value
  getRtspDevice(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改rtsp设备";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["RtspDeviceRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateRtspDevice(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addRtspDevice(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row?.id || ids.value;
  proxy.$modal.confirm('是否确认删除rtsp设备编号为"' + _ids + '"的数据项？').then(function () {
    return delRtspDevice(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

getDeptTree();
getList();
</script>

<style scoped>
.selectVideo {
  height: 600px;
  width: 800px;
}
</style>
