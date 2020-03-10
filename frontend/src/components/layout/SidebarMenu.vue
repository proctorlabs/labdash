<template>
  <ul
    class="nav nav-pills nav-sidebar flex-column"
    data-widget="treeview"
    role="menu"
    data-accordion="false"
  >
    <router-link tag="li" class="nav-item" to="/">
      <a class="nav-link">
        <i class="nav-icon fa fa-desktop"></i>
        <p class="page">Overview</p>
      </a>
    </router-link>
    <router-link
      tag="li"
      class="nav-item"
      :to="'/' + k"
      v-for="(i, k) in menu.items"
      v-bind:key="k"
    >
      <a class="nav-link">
        <i :class="['nav-icon', 'fa', i.icon]"></i>
        <p class="page">{{ k }}</p>
      </a>
    </router-link>
  </ul>
</template>

<script>
export default {
  name: 'SidebarMenu',
  computed: {
    menu() {
      return this.$store.state.menu
    }
  },
  mounted() {
    this.$store.dispatch('loadMenu')
  }
}
</script>

<style scoped>
.method {
  cursor: pointer;
}
</style>
