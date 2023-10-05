import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/pages',
      component: () => import('@/views/pages/Index'),
      children: [

        {
          name: 'Login',
          path: 'login',
          component: () => import('@/views/pages/Login')
        },

        {
          name: 'Register',
          path: 'register',
          component: () => import('@/views/pages/Register')
        }
      ]
    },
    {
      path: '/',
      component: () => import('@/views/dashboard/Index'),
      children: [
        // Dashboard
        {
          name: 'Dashboard',
          path: '',
          component: () => import('@/views/dashboard/Dashboard')
        },
        // Maps
        // Root level
        // {
        //   name: 'Widgets',
        //   path: 'widgets',
        //   component: () => import('@/views/dashboard/Widgets')
        // },
        // {
        //   name: 'Charts',
        //   path: 'charts',
        //   component: () => import('@/views/dashboard/Charts')
        // },
        {
          name: 'Calendar',
          path: 'calendar',
          component: () => import('@/views/dashboard/Calendar')
        },
        {
          name: 'Train List',
          path: 'trainList',
          component: () => import('@/views/dashboard/TrainList'),
        },
        {
          name: 'Train Detail',
          path: 'trainDetail',
          component: () => import('@/views/dashboard/TrainDetail'),
        },
        {
          name: 'Rake List',
          path: 'rakeList',
          component: () => import('@/views/dashboard/RakeList'),
        },
        {
          name: 'Rake Detail',
          path: 'rakeDetail',
          component: () => import('@/views/dashboard/RakeDetail'),
        },
        {
          name: 'Coach List',
          path: 'coachList',
          component: () => import('@/views/dashboard/CoachList'),
        },
        {
          name: 'Coach Detail',
          path: 'coachDetail',
          component: () => import('@/views/dashboard/CoachDetail'),
        },
        {
          name: 'Coach Fault History',
          path: 'coachFaultHistory',
          component: () => import('@/views/dashboard/CoachFaultHistory'),
        },
      ]
    },
    {
      path: '*',
      component: () => import('@/views/pages/Index'),
      children: [
        {
          name: '404 Error',
          path: '',
          component: () => import('@/views/pages/Error')
        }
      ]
    },
  ]
})
