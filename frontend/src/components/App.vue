<template>
  <div id="app" class="wrapper">
    <sidebar />
    <div class="content-wrapper">
      <div class="container-fluid parent-view">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import Sidebar from './layout/Sidebar'

export default {
  name: 'App',
  components: {
    Sidebar
  },
  computed: {
    menu() {
      return this.$store.state.menu
    }
  },
  created() {
    this.$store.dispatch('loadMenu')
  }
}
</script>

<style scoped>
.content-wrapper {
  background: #181a1b;
  color: #e8e6e3;
}

.content {
  padding: 0 0 0 0;
}

.parent-view {
  padding: 0 0 0 0;
  height: 100vmin;
}
</style>
