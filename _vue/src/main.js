
import { createApp } from 'vue'
import './styles/style.sass'
import Collerovka from "./plugin/collerovka/Collerovka.vue"
import VueCookies from 'vue-cookies'

const appCollerovka = createApp(Collerovka);
appCollerovka.use(VueCookies, { expires: '7d'})
appCollerovka.mount('#collerovka')

