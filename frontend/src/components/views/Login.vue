<template>
  <section
    class="container-fluid h-100 d-flex justify-content-center align-items-center"
  >
    <div class="card bg-gradient-dark text-center w-25 p-3">
      <div class="overlay dark" v-if="loading">
        <i class="fas fa-2x fa-sync-alt fa-spin"></i>
      </div>
      <div class="card-header">
        <span class="font-weight-bold">System Login</span>
      </div>
      <div class="card-body">
        <div class="alert alert-danger" role="alert" v-if="error">
          <i class="fas fa-exclamation-triangle"></i>
          {{ error }}
        </div>
        <form @submit.prevent="checkCreds">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">
                <i class="fa fa-user"></i>
              </span>
            </div>
            <input
              class="form-control"
              name="username"
              placeholder="Username"
              type="text"
              v-model="username"
            />
          </div>

          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fa fa-lock"></i></span>
            </div>
            <input
              class="form-control"
              name="password"
              placeholder="Password"
              type="password"
              v-model="password"
            />
          </div>
          <button type="submit" class="btn btn-primary">
            Submit
          </button>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Login',
  data: function() {
    return {
      username: '',
      password: '',
      loading: false,
      error: ''
    }
  },
  methods: {
    async checkCreds() {
      const { username, password } = this
      try {
        this.loading = true
        await this.$store.dispatch('login', { username, password })
      } catch (e) {
        this.error = e.message
      }
      this.loading = false
    }
  }
}
</script>
