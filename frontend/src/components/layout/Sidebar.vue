<template>
  <div class="sidebar-wrapper">
    <aside class="main-sidebar sidebar-dark-primary h-100">
      <router-link to="/" class="brand-link">
        <span class="brand-text font-weight-light">
          <i class="fa fa-home"></i>
          Home Dashboard
        </span>
      </router-link>

      <div class="sidebar flex-column">
        <nav class="mt-2">
          <sidebar-menu></sidebar-menu>
        </nav>

        <div class="sidebar-bottom-rel">
          <ul
            class="nav nav-pills nav-sidebar flex-column"
            data-widget="treeview"
            role="menu"
            data-accordion="false"
          >
            <li class="nav-item">
              <a class="nav-link method" @click="logout">
                <i class="nav-icon fa fa-door-open"></i>
                <p>Sign Out</p>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </aside>
  </div>
</template>

<script>
import SidebarMenu from './SidebarMenu'

export default {
  name: 'Sidebar',
  components: { SidebarMenu },
  methods: {
    logout() {
      this.$store.dispatch('logout')
    }
  }
}
</script>

<style scoped>
.brand-link {
  text-align: center;
}

.method {
  cursor: pointer;
}

.sidebar-bottom-rel {
  position: absolute;
  bottom: 0.3rem;
  left: 0.3rem;
  width: 15rem;
}
</style>

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
