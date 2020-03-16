<template>
  <section class="container-fluid h-100 d-flex ">
    <div class="row w-100 m-4 justify-content-center align-items-start">
      <div class="card bg-gradient-dark">
        <div class="card-header">
          <h4 class="card-title display-4">Welcome {{ $store.state.user }}!</h4>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Overview'
}
</script>
