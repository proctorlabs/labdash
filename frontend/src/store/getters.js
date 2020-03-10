export default {
  loggedIn: state => {
    return state.user !== null && state.user.length > 0
  }
}
