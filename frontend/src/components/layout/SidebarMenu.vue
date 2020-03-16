<template>
  <ul
    class="nav nav-pills nav-sidebar flex-column"
    data-widget="treeview"
    role="menu"
    data-accordion="false"
  >
    <li class="nav-item" to="/">
      <router-link class="nav-link" to="/">
        <i class="nav-icon fa fa-desktop"></i>
        <p class="page">Overview</p>
      </router-link>
    </li>
    <li class="nav-item" v-for="(i, k) in menu.items" v-bind:key="k">
      <router-link
        class="nav-link"
        :to="'/' + k"
        v-bind:key="k"
        v-if="i.open_in != 'new'"
      >
        <i :class="['nav-icon', 'fa', i.icon]"></i>
        <p>{{ i.display }}</p>
      </router-link>
      <a
        class="nav-link"
        :href="'/site/' + k + '/'"
        target="_blank"
        v-bind:key="k"
        v-else
      >
        <i :class="['nav-icon', 'fa', i.icon]"></i>

        <p>
          {{ i.display }}
          <span class="right badge badge-success">
            <i class="fa fa-external-link-alt"></i>
          </span>
        </p>
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
