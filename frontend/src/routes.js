import NotFoundView from './components/views/404.vue'
import DashboardView from './components/views/Overview.vue'
import SettingView from './components/views/Setting.vue'
import FrameView from './components/views/Frame.vue'

const routes = [
  {
    path: '/dash/overview',
    alias: '',
    component: DashboardView,
    name: 'Dashboard'
  },
  {
    path: '/dash/settings',
    component: SettingView,
    name: 'Settings'
  },
  {
    path: '/:site',
    component: FrameView,
    name: 'Frame',
    props: true
  },
  {
    path: '*',
    component: NotFoundView
  }
]

export default routes
