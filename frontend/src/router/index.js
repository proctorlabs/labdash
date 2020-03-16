import NotFoundView from '../components/views/404.vue'
import DashboardView from '../components/views/Overview.vue'
import FrameView from '../components/views/Frame.vue'

import store from '../store'
import VueRouter from 'vue-router'

const routes = [
  {
    path: '/dash/overview',
    alias: '',
    component: DashboardView,
    meta: {
      title: 'Overview'
    }
  },
  {
    path: '/:site',
    component: FrameView,
    name: 'Frame',
    props: true,
    meta: {
      titleProp: 'site'
    }
  },
  {
    path: '*',
    component: NotFoundView,
    meta: {
      title: 'Not Found'
    }
  }
]

var router = new VueRouter({
  routes: routes,
  mode: 'history',
  linkExactActiveClass: 'active'
})

router.beforeEach((to, from, next) => {
  if (to.meta.title) {
    document.title = to.meta.title + ' | Dashboard'
  } else if (to.meta.titleProp) {
    var key = to.params[to.meta.titleProp]
    var item = store.state.menu.items[key]
    if (item) {
      document.title = item.display + ' | Dashboard'
    } else {
      document.title = 'Dashboard'
    }
  } else {
    document.title = 'Dashboard'
  }
  next()
})

export default router
