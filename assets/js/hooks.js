let Hooks = {}
Hooks.FocusInput = {
  mounted() {
    window.addEventListener('keydown', (e) => {
      if (e.key === '/' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
        e.preventDefault()
        this.el.focus()
        this.el.select()
      }
    })
  }
}

export default Hooks
