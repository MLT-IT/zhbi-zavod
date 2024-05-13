
class VisualFilter
{
    constructor(selectorFilterElement, selectorItemFilter, selectorAfterOption, strongContext = false)
    {
        this.selectorItemFilter = selectorItemFilter;
        this.selectorFilterElement = selectorFilterElement;
        // элемент после которого предстоит вставить визуальное представление
        this.selectorAfterOption = selectorAfterOption;
        this.strongContext = strongContext

        this.getJson("ottenok");
        this.getJson("cvet");
        this.getJson("proizvoditel");
        this.addStyle()
    }

    addStyle(){
        var style = document.createElement('style');
        style.type = 'text/css';

        // добавляем CSS-правила
        style.innerText = '.filter-brand { background-position: 50%; background-repeat: no-repeat; background-size: contain; height: 20px; width: 30px; }';
        style.innerText += 'svg.filter-color {-webkit-box-ordinal-group: 3;margin-right: 10px; order: 1;}';
        // добавляем новый элемент 'style' в 'head'
        document.head.appendChild(style);
    }

    getColor(item){
        let color = "rgb(255,255,255)";
        if(item !== undefined)
        {
            color = item.value;
        }

        return color;
    }

    getHandlerColor(item, elementOption)
    {
        let self = this
        let $label = $(elementOption).find(self.selectorAfterOption);
        let color = self.getColor(item);
        let svg = $(`<svg width="30" height="20" class="filter-color"><rect width="30" height="20" style="fill:${color};stroke-width:3;" /></svg>`)
        $label.before(svg);
    }

    getHandlerImage(item, elementOption)
    {
        let self = this
        let $label = $(elementOption).find(self.selectorAfterOption);

        let image = $(`<div class="filter-brand"  style='background-image:url("${item.value}")'>`)
        $label.after(image);
    }


    getHandler(element, json, context){
        console.log(element);
        console.log(json);
        let name = $(element).data("value");
        // сначала изем по названию и контексту
        let item = json.find(item => item.name === name && (item.key == context || item.key == ""));

        if(item !== undefined){
            // запуск функции для роутинга обработчиков
            this.routeHandler(item, element)
        }else if(this.strongContext != true){
            // если по названию и контексту ничего не найдено ищем по названию
            item = json.find(item => item.name === name);
            if(item !== undefined) {
                // запуск функции для роутинга обработчиков
                this.routeHandler(item, element)
            }else{
                // обработчик если ничего не найдено
                this.getHandlerColor(undefined, element);
            }
        }else{
            this.getHandlerColor(undefined, element);
        }
    }

    routeHandler(item, element)
    {
        switch (item.type){
            case "color":
                this.getHandlerColor(item, element);
                break;
            case "image":
                this.getHandlerImage(item, element);
                break;
        }
    }

    getJson(optionName)
    {
        var self = this
        fetch(`/assets/template/json/visual-filter/${optionName}.json`)
            .then((response) => response.json())
            .then((json) => {

                $(`[data-key="msoption|${optionName}"] ${this.selectorItemFilter}`).each(function (){
                    self.getHandler($(this), json, $("body").attr("data-ctx"));
                });
            });
    }

}

export default VisualFilter;