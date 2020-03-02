<template>
  <div id="login">
    <img src="/static/img/logo.png" class="center-block logo" />

    <div class="text-center col-sm-12">
      <!-- login form -->
      <form @submit.prevent="checkCreds">
        <div class="input-group">
          <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
          <input
            class="form-control"
            name="username"
            placeholder="Username"
            type="text"
            v-model="username"
          />
        </div>

        <div class="input-group">
          <span class="input-group-addon"><i class="fa fa-lock"></i></span>
          <input
            class="form-control"
            name="password"
            placeholder="Password"
            type="password"
            v-model="password"
          />
        </div>
        <button
          type="submit"
          v-bind:class="'btn btn-primary btn-lg ' + loading"
        >
          Submit
        </button>
      </form>

      <!-- errors -->
      <div v-if="response" class="text-red">
        <p class="vertical-5p lead">{{ response }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import api from '../api'

export default {
  name: 'Login',
  data(router) {
    return {
      section: 'Login',
      loading: '',
      username: '',
      password: '',
      response: ''
    }
  },
  methods: {
    checkCreds() {
      const { username, password } = this

      this.toggleLoading()
      this.resetResponse()
      this.$store.commit('TOGGLE_LOADING')

      /* Making API call to authenticate a user */
      api
        .request('post', '/login', { username, password })
        .then(response => {
          this.toggleLoading()

          var data = response.data
          /* Checking if error object was returned from the server */
          if (data.error) {
            var errorName = data.error.name
            if (errorName) {
              this.response =
                errorName === 'InvalidCredentialsError'
                  ? 'Username/Password incorrect. Please try again.'
                  : errorName
            } else {
              this.response = data.error
            }

            return
          }

          /* Setting user in the state and caching record to the localStorage */
          if (data.user) {
            var token = 'Bearer ' + data.token

            this.$store.commit('SET_USER', data.user)
            this.$store.commit('SET_TOKEN', token)

            if (window.localStorage) {
              window.localStorage.setItem('user', JSON.stringify(data.user))
              window.localStorage.setItem('token', token)
            }

            this.$router.push(data.redirect ? data.redirect : '/')
          }
        })
        .catch(error => {
          this.$store.commit('TOGGLE_LOADING')
          console.log(error)

          this.response = 'Server appears to be offline'
          this.toggleLoading()
        })
    },
    toggleLoading() {
      this.loading = this.loading === '' ? 'loading' : ''
    },
    resetResponse() {
      this.response = ''
    }
  }
}
</script>
