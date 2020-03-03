<template>
  <div class="wrapper">
    <dash-header />
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
import DashHeader from './layout/DashHeader'
import Sidebar from './layout/Sidebar'

export default {
  name: 'Dash',
  components: {
    DashHeader,
    Sidebar
  }
}
</script>

<style scoped>
.content-wrapper {
  background: #181a1b;
  color: #e8e6e3;
}
</style>
