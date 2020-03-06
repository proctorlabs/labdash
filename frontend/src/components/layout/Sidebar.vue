<template>
  <div class="sidebar-wrapper">
    <aside class="main-sidebar sidebar-dark-primary">
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

<style>
.sidebar-mini.sidebar-collapse .main-sidebar,
.sidebar-mini.sidebar-collapse .main-sidebar::before {
  width: 0.3rem;
}

.sidebar-mini.sidebar-collapse .content-wrapper,
.sidebar-mini.sidebar-collapse .main-footer,
.sidebar-mini.sidebar-collapse .main-header {
  margin-left: 0.3rem !important;
}

.sidebar-mini.sidebar-collapse .main-sidebar:hover .brand-link {
  border-bottom: 1px solid #4b545c;
}

.sidebar-mini.sidebar-collapse .main-sidebar .brand-link {
  border-bottom: 0;
}
</style>
