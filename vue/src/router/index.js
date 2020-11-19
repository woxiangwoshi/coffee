import Vue from 'vue'
import Router from 'vue-router'
import selectAllCoffee from '@/components/Coffee/selectAllCoffee'
import index from '@/components/index'
import deleteCoffee from '@/components/Coffee/deleteCoffee'
import insertCoffee from '@/components/Coffee/insertCoffee'
import updateCoffee from '@/components/Coffee/updateCoffee'
import muban from '@/components/muban' 
import login from '@/components/login'
import selectAllMachine from '@/components/Machine/selectAllMachine'
import deleteMachine from '@/components/Machine/deleteMachine'
import MachineMessage from '@/components/Machine/MachineMessage'
import MachineCoffee from '@/components/Machine/MachineCoffee'
import selectAllMenu from '@/components/CoffeeMenu/selectAllMenu'
import maintenance from '@/components/Machine/maintenance'


Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: login
    },
    {
      path:'/muban',
      name:'muban',
      component:muban,
      children:[
        {
          path: '/index',
          name: 'index',
          component: index
        },
        {
          path: '/selectAllCoffee',
          name: 'selectAllCoffee',
          component: selectAllCoffee
        },
        {
          path: '/deleteCoffee',
          name: 'deleteCoffee',
          component: deleteCoffee
        },
        {
          path: '/insertCoffee',
          name: 'insertCoffee',
          component: insertCoffee
        },
        {
          path: '/updateCoffee',
          name: 'updateCoffee',
          component: updateCoffee
        },
        {
          path: '/selectAllMachine',
          name: 'selectAllMachine',
          component: selectAllMachine
        },
        {
          path: '/MachineMessage',
          name: 'MachineMessage',
          component: MachineMessage
        },
        {
          path: '/MachineCoffee',
          name: 'MachineCoffee',
          component: MachineCoffee
        },
        {
          path: '/deleteMachine',
          name: 'deleteMachine',
          component: deleteMachine
        },
        {
          path: '/selectAllMenu',
          name: 'selectAllMenu',
          component: selectAllMenu
        },
        {
          path: '/maintenance',
          name: 'maintenance',
          component: maintenance
        }
      ]        
    }
  ]
})
