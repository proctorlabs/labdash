import 'expose-loader?$!expose-loader?jQuery!jquery'
import 'es6-promise/auto'
import 'admin-lte/dist/css/adminlte.min.css'
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.js'
import 'admin-lte/dist/js/adminlte.min.js'
import '@popperjs/core'

import Vue from 'vue'
import VueRouter from 'vue-router'
import { sync } from 'vuex-router-sync'
import routes from './routes'
import store from './store'
import AppView from './components/App.vue'

Vue.use(VueRouter)

var router = new VueRouter({
  routes: routes,
  mode: 'history',
  linkExactActiveClass: 'active'
})

sync(store, router)

// eslint-disable-next-line no-new
new Vue({
  el: '#app',
  router: router,
  store: store,
  render: h => h(AppView)
})
