import api from '../api'

export default {
  loadMenu({ commit }) {
    api
      .menu()
      .then(result => {
        commit('UPDATE_MENU', result.data)
        console.log(result)
      })
      .catch(error => {
        throw new Error(`API ${error}`)
      })
  }
}
