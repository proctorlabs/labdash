import api from '../api'

export default {
  loadMenu({ commit }) {
    api
      .menu()
      .then(result => {
        commit('UPDATE_MENU', result.data)
      })
      .catch(error => {
        throw new Error(`API ${error}`)
      })
  },

  login({ commit }, { username: username, password: password }) {
    api
      .login(username, password)
      .then(() => {
        commit('SET_USER', username)
      })
      .catch(error => {
        throw new Error(`API ${error}`)
      })
  },

  logout({ commit }) {
    api
      .logout()
      .then(() => {
        commit('SET_USER', null)
      })
      .catch(error => {
        throw new Error(`API ${error}`)
      })
  },

  initialize({ commit, state }) {
    api
      .getSession()
      .then(result => {
        state.initialized = true
        commit('SET_USER', result.data.user)
      })
      .catch(() => {
        state.initialized = true
      })
  }
}
