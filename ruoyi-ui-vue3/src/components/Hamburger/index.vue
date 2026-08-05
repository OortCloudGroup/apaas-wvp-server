<template>
  <div class="hamburger-wrap" @click="toggleClick">
    <img
      :src="collapseIcon"
      class="hamburger"
      :class="{ 'is-active': isActive }"
      alt="collapse"
    />
  </div>
</template>

<script setup>
import collapseIcon from '@/assets/images/collapse.png'

defineProps({
  isActive: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits()
const toggleClick = () => {
  emit('toggleClick');
}
</script>

<style scoped>
.hamburger-wrap {
  padding: 0 15px;
  display: inline-flex;
  align-items: center;
  cursor: pointer;
}

.hamburger {
  display: inline-block;
  vertical-align: middle;
  width: 24px;
  height: 24px;
  object-fit: contain;
}

.hamburger.is-active {
  transform: rotate(180deg);
}
</style>
