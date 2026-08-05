/**
 * 左右拖拽调整宽度（竖线分隔）
 * 用法：<div v-yResize class="police_aside">...</div>
 */
export default {
  mounted(el) {
    const state = {
      isResizing: false,
      resizer: null,
      initResize: (e) => {
        e.preventDefault()
        state.isResizing = true
        document.addEventListener('mousemove', state.resize)
        document.addEventListener('mouseup', state.stopResize)
      },
      resize: (e) => {
        if (!state.isResizing) return
        const containerRect = el.getBoundingClientRect()
        const newWidth = e.clientX - containerRect.left
        el.style.width = `${newWidth}px`
      },
      stopResize: () => {
        state.isResizing = false
        document.removeEventListener('mousemove', state.resize)
        document.removeEventListener('mouseup', state.stopResize)
      }
    }

    el.__resizeState__ = state

    el.style.position = 'relative'
    el.style.overflow = 'hidden'

    const resizer = document.createElement('div')
    Object.assign(resizer.style, {
      position: 'absolute',
      right: '0',
      top: '0',
      bottom: '0',
      width: '2px',
      backgroundColor: '#66666610',
      cursor: 'ew-resize',
      zIndex: '100',
      transition: 'background-color 0.2s'
    })

    resizer.addEventListener('mouseenter', () => {
      resizer.style.backgroundColor = '#3a8ee6'
      resizer.style.width = '4px'
    })
    resizer.addEventListener('mouseleave', () => {
      resizer.style.backgroundColor = '#66666610'
      resizer.style.width = '2px'
    })

    resizer.addEventListener('mousedown', state.initResize)
    el.appendChild(resizer)
    state.resizer = resizer
  },

  unmounted(el) {
    const state = el.__resizeState__
    if (!state) return

    document.removeEventListener('mousemove', state.resize)
    document.removeEventListener('mouseup', state.stopResize)

    if (state.resizer && state.resizer.parentNode === el) {
      el.removeChild(state.resizer)
    }

    delete el.__resizeState__
  }
}
