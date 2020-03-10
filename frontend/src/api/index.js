import axios from 'axios'

export default {
  request(method, uri, data = null) {
    if (!method) {
      console.error('API function call requires method argument')
      return
    }

    if (!uri) {
      console.error('API function call requires uri argument')
      return
    }

    var url = uri
    return axios({ method, url, data })
  },
  menu() {
    return this.request('GET', '/api/menu')
  },
  login(username, password) {
    return this.request('POST', '/api/session', {
      username: username,
      password: password
    })
  },
  logout() {
    return this.request('DELETE', '/api/session')
  },
  getSession() {
    return this.request('GET', '/api/session')
  }
}
