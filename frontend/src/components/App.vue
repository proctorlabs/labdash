<template>
  <div id="app" class="wrapper">
    <sidebar v-if="$store.getters.loggedIn" />
    <div class="content-wrapper" v-if="$store.getters.loggedIn">
      <div
        class="container-fluid parent-view"
        style="background-image: url('/api/image');background-size: cover;"
      >
        <router-view></router-view>
      </div>
    </div>
    <div
      class="content-wrapper"
      style="margin-left: 0 !important;"
      v-else-if="$store.state.initialized"
    >
      <div class="container-fluid parent-view">
        <login />
      </div>
    </div>
  </div>
</template>

<script>
import Sidebar from './layout/Sidebar'
import Login from './views/Login'

export default {
  name: 'App',
  components: {
    Sidebar,
    Login
  },
  computed: {
    menu() {
      return this.$store.state.menu
    }
  },
  created() {
    this.$store.dispatch('initialize')
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
