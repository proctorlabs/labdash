import api from '../api'

export default {
  async loadMenu({ commit }) {
    return await api.menu().then(result => {
      commit('UPDATE_MENU', result.data)
    })
  },

  async login({ commit }, { username: username, password: password }) {
    return await api.login(username, password).then(() => {
      return commit('SET_USER', username)
    })
  },

  async logout({ commit }) {
    return await api.logout().then(() => {
      commit('SET_USER', null)
    })
  },

  async initialize({ commit, state }) {
    return await api
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
