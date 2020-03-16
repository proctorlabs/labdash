<template>
  <section
    class="container-fluid h-100 d-flex justify-content-center align-items-center"
  >
    <div class="col-sm-4 card bg-gradient-dark">
      <div class="card-header">
        <h1 class="card-title text-center text-xl col-sm-12">
          Not Found
        </h1>
      </div>
      <div class="card-body text-center col-sm-12">
        <h4>
          This page doesn't exist.
        </h4>
      </div>
      <div class="card-footer text-right col-sm-12">
        <router-link to="/" tag="a" class="btn btn-secondary">
          Take me home.
        </router-link>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'NotFound'
}
</script>
