<template>
  <div class="app-container">
    <div class="toolbar-with-search">
      <div class="toolbar-left">
        <button type="button" class="exportBtn newBtn flexRowAC" :disabled="multiple" @click="handleGenTable" v-hasPermi="['tool:gen:code']">
          <el-icon class="BtnImg"><Download /></el-icon>生成
        </button>
        <button-group :button-list="toolbarButtons" />
      </div>
      <div class="searchHeight_out flexRowAC">
        <search-height-box keyword="tableName" placeholder="请输入表名称等关键词" :data="searchData" @handle="searchResetFn" />
        <export-excel-pdf />
      </div>
    </div>

    <table-self
      ref="genRef"
      class="new_table"
      header-cell-class-name="header_tenant_cell"
      stripe
      v-loading="loading"
      :data="tableList"
      @selection-change="handleSelectionChange"
      :default-sort="defaultSort"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" align="center" :width="clacPXToVW(55)"></el-table-column>
      <el-table-column label="序号" type="index" :width="clacPXToVW(55)" align="center">
        <template #default="scope">
          <span>{{(queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1}}</span>
        </template>
      </el-table-column>
      <el-table-column label="表名称" align="center" prop="tableName" :show-overflow-tooltip="true" />
      <el-table-column label="表描述" align="center" prop="tableComment" :show-overflow-tooltip="true" />
      <el-table-column label="实体" align="center" prop="className" :show-overflow-tooltip="true" />
      <el-table-column label="创建时间" align="center" prop="createTime" :width="clacPXToVW(160)" sortable="custom" :sort-orders="['descending', 'ascending']" />
      <el-table-column label="更新时间" align="center" prop="updateTime" :width="clacPXToVW(160)" sortable="custom" :sort-orders="['descending', 'ascending']" />
      <el-table-column label="操作" align="right" fixed="right" :width="clacPXToVW(220)">
        <template #default="scope">
          <div class="operateAppBox flexRowAC" style="justify-content: flex-end;">
            <div class="new_table_svg_group" @click.stop="handlePreview(scope.row)" v-hasPermi="['tool:gen:preview']">
              <el-icon><View /></el-icon>
              <span>预览</span>
            </div>
            <div class="new_table_svg_group" @click.stop="handleEditTable(scope.row)" v-hasPermi="['tool:gen:edit']">
              <el-icon><Edit /></el-icon>
              <span>编辑</span>
            </div>
            <el-dropdown @command="(command)=>{genMoreClick(command, scope.row)}">
              <div class="new_table_svg_group" @click.stop>
                <span>更多</span>
                <el-icon><ArrowDown /></el-icon>
              </div>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="handleDelete" v-if="checkPermi(['tool:gen:remove'])">删除</el-dropdown-item>
                  <el-dropdown-item command="handleSynchDb" v-if="checkPermi(['tool:gen:edit'])">同步</el-dropdown-item>
                  <el-dropdown-item command="handleGenTable" v-if="checkPermi(['tool:gen:code'])">生成代码</el-dropdown-item>
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
    <!-- 预览界面 -->
    <el-dialog :title="preview.title" v-model="preview.open" width="80%" top="5vh" append-to-body class="scrollbar">
      <el-tabs v-model="preview.activeName">
        <el-tab-pane
          v-for="(value, key) in preview.data"
          :label="key.substring(key.lastIndexOf('/')+1,key.indexOf('.vm'))"
          :name="key.substring(key.lastIndexOf('/')+1,key.indexOf('.vm'))"
          :key="value"
        >
          <el-link :underline="false" icon="DocumentCopy" v-copyText="value" v-copyText:callback="copyTextSuccess" style="float:right">&nbsp;复制</el-link>
          <pre>{{ value }}</pre>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>
    <import-table ref="importRef" @ok="handleQuery" />
    <create-table ref="createRef" @ok="handleQuery" />
  </div>
</template>

<script setup name="Gen">
import { listTable, previewTable, delTable, genCode, synchDb } from "@/api/tool/gen";
import router from "@/router";
import importTable from "./importTable";
import createTable from "./createTable";
import { checkRole, checkPermi } from "@/utils/permission";
import { clacPXToVW } from "@/utils/index";

const route = useRoute();
const { proxy } = getCurrentInstance();

const tableList = ref([]);
const loading = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);

const toolbarButtons = computed(() => [
  { name: '创建', svg: 'edit', show: checkRole(['admin']), clickFn: () => openCreateTable() },
  { name: '导入', svg: 'upload', permi: ['tool:gen:import'], clickFn: () => openImportTable() },
  { name: '修改', svg: 'edit', disabled: single.value, permi: ['tool:gen:edit'], clickFn: () => handleEditTable() },
  { name: '删除', svg: 'delete', disabled: multiple.value, permi: ['tool:gen:remove'], clickFn: () => handleDelete() }
]);
const total = ref(0);
const tableNames = ref([]);
const dateRange = ref([]);
const uniqueId = ref("");
const defaultSort = ref({ prop: "createTime", order: "descending" });

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    tableName: undefined,
    tableComment: undefined,
    orderByColumn: defaultSort.value.prop,
    isAsc: defaultSort.value.order
  },
  preview: {
    open: false,
    title: "代码预览",
    data: {},
    activeName: "domain.java"
  }
});

const { queryParams, preview } = toRefs(data);

const searchData = [
  { label: '表描述', value: 'tableComment', type: 'text', default: '' },
  {
    label: '创建时间',
    value: 'dateRange',
    type: 'daterange',
    startP: '开始日期',
    endP: '结束日期',
    format: 'YYYY-MM-DD',
    default: []
  }
];

onActivated(() => {
  const time = route.query.t;
  if (time != null && time != uniqueId.value) {
    uniqueId.value = time;
    queryParams.value.pageNum = Number(route.query.pageNum);
    dateRange.value = [];
    getList();
  }
})

/** 查询表集合 */
function getList() {
  loading.value = true;
  listTable(proxy.addDateRange(queryParams.value, dateRange.value)).then(response => {
    tableList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

function searchResetFn(val) {
  queryParams.value.pageNum = 1;
  queryParams.value.tableName = val.tableName || undefined;
  queryParams.value.tableComment = val.tableComment || undefined;
  dateRange.value = val.dateRange && val.dateRange.length ? val.dateRange : [];
  getList();
}

/** 生成代码操作 */
function handleGenTable(row) {
  const tbNames = row?.tableName || tableNames.value;
  if (tbNames == "") {
    proxy.$modal.msgError("请选择要生成的数据");
    return;
  }
  if (row?.genType === "1") {
    genCode(row.tableName).then(response => {
      proxy.$modal.msgSuccess("成功生成到自定义路径：" + row.genPath);
    });
  } else {
    proxy.$download.zip("/tool/gen/batchGenCode?tables=" + tbNames, "ruoyi.zip");
  }
}

/** 同步数据库操作 */
function handleSynchDb(row) {
  const tableName = row.tableName;
  proxy.$modal.confirm('确认要强制同步"' + tableName + '"表结构吗？').then(function () {
    return synchDb(tableName);
  }).then(() => {
    proxy.$modal.msgSuccess("同步成功");
  }).catch(() => {});
}

/** 打开导入表弹窗 */
function openImportTable() {
  proxy.$refs["importRef"].show();
}

/** 打开创建表弹窗 */
function openCreateTable() {
  proxy.$refs["createRef"].show();
}

/** 预览按钮 */
function handlePreview(row) {
  previewTable(row.tableId).then(response => {
    preview.value.data = response.data;
    preview.value.open = true;
    preview.value.activeName = "domain.java";
  });
}

/** 复制代码成功 */
function copyTextSuccess() {
  proxy.$modal.msgSuccess("复制成功");
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.tableId);
  tableNames.value = selection.map(item => item.tableName);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 排序触发事件 */
function handleSortChange(column, prop, order) {
  queryParams.value.orderByColumn = column.prop;
  queryParams.value.isAsc = column.order;
  getList();
}

/** 修改按钮操作 */
function handleEditTable(row) {
  const tableId = row?.tableId || ids.value[0];
  router.push({ path: "/tool/gen-edit/index/" + tableId, query: { pageNum: queryParams.value.pageNum } });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const tableIds = row?.tableId || ids.value;
  proxy.$modal.confirm('是否确认删除表编号为"' + tableIds + '"的数据项？').then(function () {
    return delTable(tableIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

function genMoreClick(command, row) {
  if (command === "handleDelete") {
    handleDelete(row);
  } else if (command === "handleSynchDb") {
    handleSynchDb(row);
  } else if (command === "handleGenTable") {
    handleGenTable(row);
  }
}

getList();
</script>
