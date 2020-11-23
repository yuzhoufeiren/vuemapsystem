import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from 'axios'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import '@/assets/scss/common.scss'
import '@/assets/scss/reset.scss'
import '@/assets/font/iconfont.css'
import setAxios from './setAxios'
import Cookie from 'js-cookie'
import echarts from "echarts";
import moment from 'moment'//导入文件 





Vue.prototype.$moment = moment;//赋值使用
Vue.prototype.$echarts = echarts;
Vue.filter('dateformat', function(dataStr, pattern = 'YYYY-MM-DD HH:mm:ss') {
  return moment(dataStr).format(pattern)
})

setAxios()
Vue.config.productionTip = false;
Vue.prototype.$axios = axios
Vue.use(ElementUI);
// Vue.use(mavonEditor);

router.beforeEach((to,from,next)=>{
  store.commit('setToken',Cookie.get('token'))
  if(store.state.token){
    store.commit('chanIsSignIn',1)
    next()
  }
  if(to.meta.requireAuth){
    if(store.state.token){
      next()
    }else{
      next({path:'/login'})
    }
  }else{
    next()
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");



import VueAMap from 'vue-amap';
Vue.use(VueAMap);
VueAMap.initAMapApiLoader({
  key: '1fcd67e41be8c3c533f4bb1768e472cc',
  plugin: ['AMap.Autocomplete', 'AMap.PlaceSearch', 'AMap.Scale', 'AMap.OverView', 'AMap.ToolBar', 'AMap.MapType', 'AMap.PolyEditor', 'AMap.CircleEditor'],
  // 默认高德 sdk 版本为 1.4.4
  v: '1.4.4'
});

// new Vue({
//   el: '#app',
//   render: h => h(App)
// })