import DashView from './components/Dash.vue'
import LoginView from './components/Login.vue'
import NotFoundView from './components/404.vue'

// Import Views - Dash
import DashboardView from './components/views/Overview.vue'
import TablesView from './components/views/Tables.vue'
import SettingView from './components/views/Setting.vue'
import ReposView from './components/views/Repos.vue'

// Routes
const routes = [
  {
    path: '/login',
    component: LoginView
  },
  {
    path: '/',
    component: DashView,
    children: [
      {
        path: 'dashboard',
        alias: '',
        component: DashboardView,
        name: 'Dashboard',
        meta: { description: 'Overview of environment' }
      },
      {
        path: 'tables',
        component: TablesView,
        name: 'Tables',
        meta: { description: 'Simple and advance table in CoPilot' }
      },
      {
        path: 'setting',
        component: SettingView,
        name: 'Settings',
        meta: { description: 'User settings page' }
      },
      {
        path: 'repos',
        component: ReposView,
        name: 'Repository',
        meta: { description: 'List of popular javascript repos' }
      }
    ]
  },
  {
    // not found handler
    path: '*',
    component: NotFoundView
  }
]

export default routes
