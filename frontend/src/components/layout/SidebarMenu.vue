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
    <router-link tag="li" class="nav-item nav-link" to="/tables">
      <a>
        <i class="nav-icon fa fa-table"></i>
        <span class="page">Tables</span>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item nav-link" to="/tasks">
      <a>
        <i class="nav-icon fa fa-tasks"></i>
        <span class="page">Tasks</span>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item nav-link" to="/setting">
      <a>
        <i class="nav-icon fa fa-cog"></i>
        <span class="page">Settings</span>
      </a>
    </router-link>
    <li class="nav-item has-treeview menu-open">
      <a href="#" class="nav-link">
        <i class="nav-icon fas fa-tachometer-alt"></i>
        <span>Files</span>
        <i class="right fas fa-angle-left"></i>
      </a>
      <ul class="nav nav-treeview">
        <router-link tag="li" class="nav-item nav-link" to="/item1">
          <a>
            <i class="nav-icon fa fa-file-word-o"></i>
            <span class="page">Item 1</span>
          </a>
        </router-link>
        <router-link tag="li" class="nav-item nav-link" to="/item2">
          <a>
            <i class="nav-icon fa fa-file-picture-o"></i>
            <span class="page">Item 2</span>
          </a>
        </router-link>
        <router-link tag="li" class="nav-item nav-link" to="/item3">
          <a>
            <i class="nav-icon fa fa-file-pdf-o"></i>
            <span class="page">Item 3</span>
          </a>
        </router-link>
      </ul>
    </li>
    <router-link tag="li" class="nav-item nav-link" to="/access">
      <a>
        <i class="nav-icon fa fa-book"></i>
        <span class="page">Access</span>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item nav-link" to="/server">
      <a>
        <i class="nav-icon fa fa-hdd-o"></i>
        <span class="page">Server</span>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item nav-link" to="/repos">
      <a>
        <i class="nav-icon fa fa-heart"></i>
        <span class="page">Repos</span>
        <small class="label pull-right bg-green">AJAX</small>
      </a>
    </router-link>

    <router-link tag="li" class="nav-item nav-link" to="/login">
      <a>
        <i class="nav-icon fa fa-circle-o text-yellow"></i>
        <span class="page"> Login</span>
      </a>
    </router-link>
    <router-link tag="li" class="nav-item nav-link" to="/404">
      <a>
        <i class="nav-icon fa fa-circle-o text-red"></i>
        <span class="page"> 404</span>
      </a>
    </router-link>
  </ul>
</template>
<script>
export default {
  name: 'SidebarMenu'
}
</script>
