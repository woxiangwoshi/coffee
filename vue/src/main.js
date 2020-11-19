import Vue from 'vue'
import App from './App'
import router from './router'
import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import qs from 'qs'
// 导入共用组件
import global from './components/global.vue'
import QRCode from 'qrcodejs2';

Vue.prototype.COMMON = global
Vue.config.productionTip = false
Vue.use(Element)
Vue.prototype.$axios=axios
Vue.prototype.$qs=qs
Vue.prototype.qrCode=QRCode

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  render: h => h(App)
})


