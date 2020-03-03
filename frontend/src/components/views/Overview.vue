<template>
  <section class="content">
    <iframe
      src="https://vuejs.org/v2/guide/list.html"
      style="height: 500px; border: 0px none; width: 500px; margin-bottom: 0px; margin-left: 24px;"
    ></iframe>
  </section>
</template>

<script>
import api from '../../api'

export default {
  name: 'Dashboard',
  mounted() {
    api.menu()
  }
}
</script>
