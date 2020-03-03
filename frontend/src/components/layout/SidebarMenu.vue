<template>
  <ul
    class="nav nav-pills nav-sidebar flex-column"
    data-widget="treeview"
    role="menu"
    data-accordion="false"
  >
    <router-link tag="li" class="nav-item nav-link" to="/">
      <a>
        <i class="nav-icon fa fa-desktop"></i>
        <span class="page">Dashboard</span>
      </a>
    </router-link>
    <li
      class="nav-item nav-link"
      to="/"
      v-for="i in menu.items"
      v-bind:key="i.url"
    >
      <a :href="i.url">
        <i :class="['nav-icon', 'fa', i.icon]"></i>
        <span class="page">{{ i.name }}</span>
      </a>
    </li>
  </ul>
</template>
<script>
export default {
  name: 'SidebarMenu',
  computed: {
    menu() {
      return this.$store.state.menu
    }
  }
}
</script>
