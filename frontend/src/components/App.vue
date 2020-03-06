<template>
  <div id="app" class="wrapper">
    <sidebar />
    <div class="content-wrapper">
      <div class="content">
        <div class="container-fluid">
          <router-view></router-view>
        </div>
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
  padding: 0 0;
}

.container-fluid {
  padding-left: 0;
  padding-right: 0;
}
</style>
