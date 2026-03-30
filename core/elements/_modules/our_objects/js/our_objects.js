import Swiper from "swiper";
import { Navigation, EffectFade, Pagination, Autoplay, Thumbs } from "swiper/modules";

class OurObjects{
    constructor(){

    }
    bind(){
        try{
            // Слайдер на странице шоу-рума
            if(body.querySelector('.showroom-swiper')){
                new Swiper(".showroom-swiper", {
                    modules: [Navigation, EffectFade, Pagination, Autoplay, Thumbs],
                    loop: false,
                    slidesPerView: 1, 
                    spaceBetween: 10, 
                    lazy: {loadPrevNext: true},
                    observer: true,
                    observeParents: true,
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev"
                    },
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true
                    },
                    scrollbar: {draggable: true, el: ".swiper-scrollbar"},
                    breakpoints: { 
                        1201: {
                            slidesPerView: 4,
                        },
                        768: {
                            slidesPerView: 3,
                        }, 
                        500: {
                            slidesPerView: 2,
                        },
                        400: {
                            slidesPerView: 2,
                        }
                    }
                });
            }
        }catch(t){
            console.error("Module our_objects failed");
            console.error(t);
        }
        
    }
}

export {
    OurObjects
}
