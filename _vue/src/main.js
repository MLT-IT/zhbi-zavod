
import { createApp } from 'vue'
import './style.css'
import Collerovka from "./plugin/collerovka/Collerovka.vue"
import VueCookies from 'vue-cookies'

const appCollerovka = createApp(Collerovka);
appCollerovka.use(VueCookies, { expires: '7d'})
appCollerovka.mount('#collerovka')

