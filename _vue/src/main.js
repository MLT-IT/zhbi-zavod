
import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import Collerovka from "./components/HelloWorld.vue"


const appCollerovka = createApp(Collerovka);
appCollerovka.mount('#collerovka')

