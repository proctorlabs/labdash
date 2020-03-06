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
    <router-link tag="li" class="nav-item" to="/dddd">
      <a class="nav-link">
        <i class="nav-icon fa fa-question"></i>
        <p>Notfound</p>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item" to="/dash/login">
      <a class="nav-link">
        <i class="nav-icon fa fa-user"></i>
        <p>Login</p>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item" to="/dash/settings">
      <a class="nav-link">
        <i class="nav-icon fa fa-tools"></i>
        <p>Settings</p>
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
  }
}
</script>
