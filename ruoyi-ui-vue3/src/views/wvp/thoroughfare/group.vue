<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="4">
        <div class="head-container">
          <el-input v-model="groupName" placeholder="请输入分组名称" clearable prefix-icon="Search"
                    style="margin-bottom: 20px"/>
        </div>
        <div class="head-container">
          <el-tree :data="groupOptions"
                   :props="{label: 'name', children: 'children'}"
                   :expand-on-click-node="false"
                   :filter-node-method="filterNode"
                   ref="groupTreeRef"
                   node-key="id"
                   highlight-current
                   default-expand-all
                   @node-click="handleNodeClick"/>
        </div>
      </el-col>
      <el-col :span="20">
        <div class="toolbar-with-search">
          <div class="toolbar-left">
            <button type="button" class="exportBtn newBtn flexRowAC" @click="handleAdd" v-hasPermi="['wvp:channel:addGroupChannel']">
              <el-icon class="BtnImg"><Plus /></el-icon>新增
            </button>
            <button-group :button-list="toolbarButtons" />
          </div>
          <div class="searchHeight_out flexRowAC">
            <search-height-box
              keyword="query"
              placeholder="请输入关键字"
              :data="searchData"
              @handle="searchResetFn"
            />
            <export-excel-pdf />
          </div>
        </div>

        <el-table v-loading="loading" :data="channelList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center"/>
          <el-table-column prop="gbName" label="名称" align="center"/>
          <el-table-column prop="gbDeviceId" label="编号" align="center"/>
          <el-table-column prop="gbManufacturer" label="厂家" align="center"/>
          <el-table-column label="类型" align="center">
            <template #default="scope">
              <div slot="reference" class="name-wrapper">
                <el-tag effect="plain" v-if="scope.row.dataType === 1">国标设备</el-tag>
                <el-tag effect="plain" type="success" v-else-if="scope.row.dataType === 2">推流设备</el-tag>
                <el-tag effect="plain" type="warning" v-else-if="scope.row.dataType === 3">拉流代理</el-tag>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center">
            <template #default="scope">
              <div slot="reference" class="name-wrapper">
                <el-tag v-if="scope.row.gbStatus === 'ON'">在线</el-tag>
                <el-tag type="info" v-if="scope.row.gbStatus !== 'ON'">离线</el-tag>
              </div>
            </template>
          </el-table-column>
        </el-table>

        <pagination
            v-show="total > 0"
            :total="total"
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="getList"
        />

        <el-dialog :title="title" v-model="open" width="1100px" append-to-body>
          <div class="searchHeight_out flexRowAC" style="margin-bottom: 12px; justify-content: flex-end;">
            <search-height-box keyword="query" placeholder="请输入关键字" :data="selectSearchData" @handle="selectSearchResetFn" />
            <export-excel-pdf />
          </div>
          <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
              <el-button type="primary" plain icon="Select" :disabled="multipleSelect" @click="handleSelect">选择</el-button>
            </el-col>
          </el-row>

          <el-table v-loading="loadingSelect" :data="channelSelectList" @selection-change="handleSelectionSelectChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column prop="gbName" label="名称" align="center"/>
            <el-table-column prop="gbDeviceId" label="编号" align="center"/>
            <el-table-column prop="gbManufacturer" label="厂家" align="center"/>
            <el-table-column label="类型" align="center">
              <template #default="scope">
                <div slot="reference" class="name-wrapper">
                  <el-tag effect="plain" v-if="scope.row.dataType === 1">国标设备</el-tag>
                  <el-tag effect="plain" type="success" v-else-if="scope.row.dataType === 2">推流设备</el-tag>
                  <el-tag effect="plain" type="warning" v-else-if="scope.row.dataType === 3">拉流代理</el-tag>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="状态" align="center">
              <template #default="scope">
                <div slot="reference" class="name-wrapper">
                  <el-tag v-if="scope.row.gbStatus === 'ON'">在线</el-tag>
                  <el-tag type="info" v-if="scope.row.gbStatus !== 'ON'">离线</el-tag>
                </div>
              </template>
            </el-table-column>
          </el-table>

          <pagination
              v-show="totalSelect > 0"
              :total="totalSelect"
              v-model:page="queryParamsSelect.pageNum"
              v-model:limit="queryParamsSelect.pageSize"
              @pagination="getChannelList"
          />
        </el-dialog>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Group">
import {queryForTree} from "../../../api/wvp/group.js";
import {
  addChannelToGroup,
  deleteChannelToGroup,
  queryListByCivilCode,
  queryListByParentId
} from "../../../api/wvp/channel.js";

const {proxy} = getCurrentInstance();

const groupName = ref('')
const groupOptions = ref([]);
const channelList = ref([]);
const loading = ref(true);
const total = ref(0);
const showSearch = ref(true);
const searchData = ref([
  {
    label: '类型',
    value: 'channelType',
    type: 'select',
    option: [
      { label: '国标设备', value: 1 },
      { label: '推流设备', value: 2 },
      { label: '拉流代理', value: 3 }
    ],
    default: undefined
  },
  {
    label: '在线状态',
    value: 'online',
    type: 'select',
    option: [
      { label: '在线', value: 'true' },
      { label: '离线', value: 'false' }
    ],
    default: undefined
  }
]);
const groupDeviceId = ref('');
const businessGroup = ref('');
const selectionList = ref([]);
const multiple = ref(true);

const toolbarButtons = computed(() => [
  { name: '删除', svg: 'delete', disabled: multiple.value, permi: ['wvp:channel:deleteGroupChannel'], clickFn: () => handleDelete() }
]);
const open = ref(false);
const title = ref("");
const dataType = ref('group');

const channelSelectList = ref([]);
const loadingSelect = ref(true);
const totalSelect = ref(0);
const showSearchSelect = ref(true);
const multipleSelect = ref(true);
const selectionSelectList = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
    online: undefined,
    channelType: undefined,
    groupDeviceId: ' '
  },
  rules: {},

  queryParamsSelect: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
    online: undefined,
    channelType: undefined,
    groupDeviceId: undefined,
  }
});

const {queryParams, form, rules, queryParamsSelect} = toRefs(data);

const selectSearchData = [
  {
    label: '类型',
    value: 'channelType',
    type: 'select',
    option: [
      { label: '国标设备', value: 1 },
      { label: '推流设备', value: 2 },
      { label: '拉流代理', value: 3 }
    ],
    default: undefined
  },
  {
    label: '在线状态',
    value: 'online',
    type: 'select',
    option: [
      { label: '在线', value: 'true' },
      { label: '离线', value: 'false' }
    ],
    default: undefined
  }
];

function getList() {
  loading.value = true
  queryListByParentId(queryParams.value).then((res) => {
    channelList.value = res.rows
    total.value = res.total
    loading.value = false
  })
}

/** 根据名称筛选树 */
watch(groupName, val => {
  proxy.$refs["groupTreeRef"].filter(val);
});

/** 搜索按钮操作 */
function searchResetFn(val) {
  queryParams.value.pageNum = 1;
  queryParams.value.query = val.query || undefined;
  queryParams.value.channelType = val.channelType || undefined;
  queryParams.value.online = val.online || undefined;
  getList();
}

/** 选择条数  */
function handleSelectionChange(selection) {
  selectionList.value = selection
  multiple.value = !selection.length;
}

function handleDelete() {
  let channels = []
  for (let i = 0; i < selectionList.value.length; i++) {
    channels.push(selectionList.value[i].gbId)
  }
  proxy.$modal.confirm('是否删除选择的数据？').then(function () {
    return deleteChannelToGroup({channelIds: channels});
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 通过条件过滤节点  */
const filterNode = (value, data) => {
  if (!value) return true;
  return data.name.indexOf(value) !== -1;
};

/** 节点单击事件 */
function handleNodeClick(data) {
  if (data.deviceId) {
    queryParams.value.groupDeviceId = data.deviceId;
  } else {
    queryParams.value.groupDeviceId = ' ';
  }

  groupDeviceId.value = queryParams.value.groupDeviceId;
  businessGroup.value = data.businessGroup;
  getList();
}

/** 新增按钮操作 */
function handleAdd() {
  if (groupDeviceId.value === "" || groupDeviceId.value === ' ') {
    proxy.$modal.msgError("请选择左侧业务分组");
    return;
  }

  title.value = "添加国标通道";
  open.value = true;

  getChannelList()
}

function getChannelList() {
  if (dataType.value === "civilCode") {
    loadingSelect.value = true
    queryListByCivilCode(queryParamsSelect.value).then((res) => {
      channelSelectList.value = res.rows
      totalSelect.value = res.total
      loadingSelect.value = false
    })
  } else {
    loadingSelect.value = true
    queryListByParentId(queryParamsSelect.value).then((res) => {
      channelSelectList.value = res.rows
      totalSelect.value = res.total
      loadingSelect.value = false
    })
  }
}

/** 弹窗搜索 */
function selectSearchResetFn(val) {
  queryParamsSelect.value.pageNum = 1;
  queryParamsSelect.value.query = val.query || undefined;
  queryParamsSelect.value.channelType = val.channelType || undefined;
  queryParamsSelect.value.online = val.online || undefined;
  getChannelList();
}

function handleSelectionSelectChange(selection) {
  selectionSelectList.value = selection;
  multipleSelect.value = !selection.length;
}

function handleSelect() {
  proxy.$modal.msgSuccess("选择成功");
  open.value = false;
  addChannelToCivilCode(groupDeviceId.value, businessGroup.value, selectionSelectList.value)
}

function addChannelToCivilCode(groupDeviceId, businessGroup, data) {
  let channels = []
  for (let i = 0; i < data.length; i++) {
    channels.push(data[i].gbId)
  }
  addChannelToGroup({
    parentId: groupDeviceId,
    businessGroup: businessGroup,
    channelIds: channels
  }).then(() => {
    getList()
  })
}

onMounted(() => {
  queryForTree({}).then((res) => {
    let data = [
      {
        name: "根资源组",
        children: []
      }
    ]
    data[0].children = proxy.handleTree(res.data, "id")
    groupOptions.value = data
  })

  getList()
})
</script>

<style scoped>

</style>
