<template>
  <div class="sidebar-wrapper">
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <a href="#/" class="brand-link">
        <img
          src="static/img/AdminLTELogo.png"
          alt="AdminLTE Logo"
          class="brand-image img-circle elevation-3"
          style="opacity: .8"
        />
        <span class="brand-text font-weight-light">Home Dashboard</span>
      </a>

      <div class="sidebar">
        <nav class="mt-2">
          <sidebar-menu></sidebar-menu>
        </nav>
      </div>
    </aside>
  </div>
</template>
<script>
import SidebarMenu from './SidebarMenu'

export default {
  name: 'Sidebar',
  components: { SidebarMenu }
}
</script>
