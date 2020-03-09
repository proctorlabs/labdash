<template>
  <section
    class="container-fluid h-100 d-flex justify-content-center align-items-center"
  >
    <div class="col-sm-4 card bg-gradient-dark">
      <div class="card-header">
        <h3 class="card-title">Default Card Example</h3>
      </div>
      <div class="card-body">
        The body of the card
      </div>
      <div class="card-footer">
        The footer of the card
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Dashboard',
  props: ['site']
}
</script>
