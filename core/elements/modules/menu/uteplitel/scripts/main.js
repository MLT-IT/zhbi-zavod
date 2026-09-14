import {initMegaMenu} from "./mega-menu";
import "./mobile-menu";

const ctx = body.getAttribute('data-ctx');

if(ctx != 'fibrofasad') {
  initMegaMenu();
}
