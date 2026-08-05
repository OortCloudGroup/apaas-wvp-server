<template>
  <el-table
    ref="tableRef"
    v-bind="mergedAttrs"
    :class="[customClass, attrs.class]"
    :style="attrs.style"
    highlight-current-row
    @row-click="handleRowClick"
    @select="handleSelect"
  >
    <template v-for="(_, slotName) in slots" #[slotName]="slotProps">
      <slot :name="slotName" v-bind="slotProps || {}" />
    </template>
    <slot />
  </el-table>
</template>

<script setup>
import { ref, useAttrs, useSlots, computed, watch } from 'vue'

defineOptions({
  name: 'TableSelf',
  inheritAttrs: false
})

defineProps({
  customClass: {
    type: String,
    default: ''
  }
})

const selectedRows = ref([])
const currentRows = ref(null)
const tableRef = ref(null)
const attrs = useAttrs()
const slots = useSlots()

const mergedAttrs = computed(() => {
  const {
    class: _c,
    style: _s,
    onRowClick: _rc,
    onSelect: _s2,
    ...rest
  } = attrs
  return rest
})

const handleRowClick = (row, column, event) => {
  currentRows.value = row
  if (tableRef.value) {
    tableRef.value.toggleRowSelection(row)
  }
  if (typeof attrs.onRowClick === 'function') {
    attrs.onRowClick(row, column, event)
  }
}

const handleSelect = (selection, row) => {
  selectedRows.value = selection.slice()
  if (typeof attrs.onSelect === 'function') {
    attrs.onSelect(selection, row)
  }
}

defineExpose({
  tableRef,
  toggleRowSelection: (...args) => tableRef.value?.toggleRowSelection?.(...args),
  clearSelection: (...args) => tableRef.value?.clearSelection?.(...args),
  setCurrentRow: (...args) => tableRef.value?.setCurrentRow?.(...args),
  doLayout: (...args) => tableRef.value?.doLayout?.(...args),
  getSelectionRows: (...args) => tableRef.value?.getSelectionRows?.(...args)
})

watch(
  () => attrs.data,
  (newData) => {
    if (!Array.isArray(newData)) return
    if (tableRef.value && currentRows.value) {
      let findRow = null
      const key = attrs['current-row-key'] || attrs.currentRowKey
      if (key) {
        findRow = newData.find(
          (item) => item[key] === currentRows.value[key]
        )
      } else if (newData.length > 0 && newData[0].id !== undefined) {
        findRow = newData.find((item) => item.id === currentRows.value.id)
      }
      setTimeout(() => {
        if (findRow && tableRef.value) {
          tableRef.value.setCurrentRow(findRow)
          tableRef.value.toggleRowSelection(findRow)
        }
      }, 0)
    }
  }
)
</script>
