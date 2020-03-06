<template>
  <section class="content">
    <iframe id="window" :src="detail.url" v-if="detail"></iframe>
    <not-found v-else />
  </section>
</template>

<script>
import NotFound from './404'

export default {
  name: 'Dashboard',
  components: {
    NotFound
  },
  props: {
    site: {
      type: String,
      default: ''
    }
  },
  computed: {
    detail() {
      return this.$store.state.menu.items[this.site]
    }
  }
}
</script>

<style>
iframe {
  width: 100%;
  height: 100vmin;
  border: 0px none;
  margin: 0px;
}
</style>
