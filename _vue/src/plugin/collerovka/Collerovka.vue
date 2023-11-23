
<template>
  <div>
    <ButtonCollerovka @click="openModal = !openModal"></ButtonCollerovka>
    <div class="select-colors product-form">
      <div  v-for="color in selectedColors" class="select-colors_item">
        <ColorItem :color="color"></ColorItem>
        <button class="btn-select-color-remove" @click="selectedColors = selectedColors.filter(el => el.title != color.title); refreshFormProduct()">x</button>
      </div>
    </div>

  </div>
  <div class="collerovka-container collerovka" v-if="openModal">
    <div class="collerovka-header-control control" @click="openModal = false">
      <div class="control-close">x</div>
    </div>
    <div class="collerovka-header">
      <h2>Выбор коллеровки</h2>
    </div>
    <div class="collerovka-body">
      <Interiors :color="currentColor"></Interiors>
      <div class="collerovka-body_colors colors">
        <input type="text" class="search-collerovka" v-model="searchColorText" placeholder="Поиск ">
        <div>
          <div class="colors-tabs">
            <div v-for="group in groupColors" class="color-tab" :class="{ active: group == selectGroup }" @click="selectedGroup(group)">
              {{group.group_name}}
            </div>
            <Favorite @click="favorite = !favorite" :class="{active: favorite}"></Favorite>
          </div>

          <div class="colors-items" v-if="currentColors && !searchColorText && !favorite">
            <ColorItem  v-for="color in currentColors" :color="color" :currentColor="currentColor" @click.self="selectedColor(color)" ></ColorItem>
          </div>
          <div class="colors-items search-modal" v-if="searchColorText">
            <ColorItem  v-for="color in searchColorResult" :color="color" :currentColor="currentColor" @click="selectedColor(color)" ></ColorItem>
          </div>
          <div class="colors-items colors-favorite" v-if="favorite && !searchColorText">
            <ColorItem  v-for="color in favoriteColors" :color="color" :currentColor="currentColor" @click="selectedColor(color)" :callbackRemoveFavorite="removeFavorite" ></ColorItem>
          </div>
        </div>
      </div>
    </div>
    <div class="collerovka-bottom-control">
      <button class="btn_style_shadow btn-select-collerovka" @click="pickColor">Выбрать</button>
    </div>
  </div>
</template>


<script>
import ColorItem from "./blocks/ColorItem.vue";
import Favorite from "./blocks/Favorite.vue";
import Interiors from "./blocks/Interiors.vue";
import ButtonCollerovka from "./blocks/ButtonCollerovka.vue";
export default {
  components: {ButtonCollerovka, Interiors, Favorite, ColorItem},
  data(){
    return{
      openModal: false,
      // массив где хранятся все цвета
      groupColors:[],
      selectedColors: [],
      // текущие цвета которые отоббражаются
      currentColors: [],
      // выбранный цвет
      currentColor: {},
      // выбранная группа цветов
      selectGroup: {},
      // поисковая строка цвета
      searchColorText: "",
      // найденные в поиске цвета
      searchColorResult: [],
      // избранные цвета
      favoriteColors: [],
      // отображение избранного
      favorite: false
    }
  },
  watch: {
    searchColorText(val) {
      this.searchColor(val);
    }
  },
  mounted(){
    /* получение основных данных цветов */
    $.getJSON('/assets/template/json/collerovka.json', (json) => {
      this.groupColors = json;

    }).then(() => {
      // назначаем выбранные группы и отображаемые цвета на модальной форме
      this.selectGroup =  this.groupColors[0];
      this.currentColors = this.groupColors[0].items;
      // избранныые товары достаем из cookie
      this.favoriteColors = this.$cookies.get('favoriteColors');
    })

  },
  methods:{
    // выбор группы
    selectedGroup(group){
      this.selectGroup = group;
      this.currentColors = group.items;
      this.searchColorText = "";
      this.favorite = false;
    },
    // колбэкк удаление из избранного
    removeFavorite(color){
      this.favoriteColors =  this.$cookies.get('favoriteColors');
    },
    // выбор цвета на форме для смены фона интерьера
    selectedColor(color){
      this.currentColor = color;
      // добавление в избранное
      this.favoriteColors = this.addColorCookie(color);
    },
    // выбор цвета коллеровки в карточке товара
    pickColor(){
      if(this.currentColor.title){
        if(this.selectedColors.indexOf(this.currentColor) == -1){
          this.selectedColors.push(this.currentColor)
          this.refreshFormProduct();
        }
      }
      this.currentColor = {};
      this.openModal = false
    },
    refreshFormProduct(){
      // форма
      let form = document.getElementsByClassName('js-product__form-add')[0];

      // если не существует
      if(!document.getElementById('selected-collerovka-form')){
        var optionsInput = document.createElement("div");
        optionsInput.setAttribute("id", "selected-collerovka-form");
        form.append(optionsInput);
      }else{
        optionsInput = document.getElementById('selected-collerovka-form');
      }

      let optionsHTML = '';
      this.selectedColors.forEach(selectColor => {
        optionsHTML +='<input  class="form-check-input" type="hidden" name="options[collerovka][]" value="' +selectColor.title + '">';
      })
      optionsInput.innerHTML  = optionsHTML;

    },
    // добавление товаров в избранное cookie
    addColorCookie(color){
      let cookieColor = [];

      // добавление в куки
      if(this.$cookies.get('favoriteColors'))
      {
        cookieColor = this.$cookies.get('favoriteColors');
      }else{
        cookieColor = [];
      }

      if (!cookieColor.some(e => e.title === color.title)) {
        cookieColor.push(color);
      }
      this.$cookies.set('favoriteColors', cookieColor);
      return cookieColor;
    },
    // поиск по цвету
    searchColor(search){
      this.searchColorResult = []
      this.groupColors.map(groupColor => {
        groupColor.items.forEach( itemColor => {
          if (itemColor.title.toLowerCase().indexOf(search.toLowerCase()) != -1) {
            this.searchColorResult.push(itemColor)
          }
        });
      });
    }
  }
}
</script>


