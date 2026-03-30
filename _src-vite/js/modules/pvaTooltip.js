export default class PvaTooltip{
    // @param qTooltip - селектор для всплывашки
    // @param duration - время показа
    // Класс генерирует исключения
    constructor(qTooltip, duration = 7000){ 
        this.activeClass = 'tooltip--active';
        this.btnCloseClass = 'tooltip__close';
        this.popup = document.querySelector(qTooltip);
        this.duration = Number(duration);
        this.timeout = null;

        if(!this.popup)throw `${qTooltip} not found`;
        
    }

    //Этот метод нужно вызвать чтобы все начало работать
    bind(){
        const host = this;
        this.popup.classList.add(this.activeClass);
        this.timeout = setTimeout(function () {
            host.popup.classList.remove(host.activeClass);
        }, host.duration);    
        const btnClose = this.popup.querySelector('.' + this.btnCloseClass);
        if(!btnClose)throw `${this.btnCloseClass} not found`;

        if(this.btnCloseAttached)return;
        btnClose.addEventListener('click', function(e){
            e.preventDefault();
            e.stopPropagation();
            host.close();
        });
        this.btnCloseAttached = true;
    }

    close(){
        this.popup.classList.remove(this.activeClass);
        clearTimeout(this.timeout);
    }
}
