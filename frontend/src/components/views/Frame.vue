<template>
  <section class="content">
    <iframe id="window" :src="detail.url"></iframe>
  </section>
</template>

<script>
export default {
  name: 'Dashboard',
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
