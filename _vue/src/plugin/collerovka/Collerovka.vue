
<template>
  <button class="btm-collerovka btn" @click="openModal = !openModal">Коллеровка</button>
  <input class="form-check-input" type="checkbox" name="options['collerovka']" :value="currentColor.title" checked>
  <div class="collerovka-container collerovka" v-if="openModal">
    <div class="collerovka-header-control control" @click="openModal = false">
      <div class="control-close">x</div>
    </div>
    <div class="collerovka-header">
      <h2>Выбор коллеровки</h2>
    </div>
    <div class="collerovka-body">
      <div class="collerovka-body_interior" :style="currentColor.background"
           style="background-image: url('/assets/template/img/interior/first-sweet-room.png');background-size:cover;background-repeat: no-repeat;background-position:bottom;">
      </div>
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
          <div class="colors-items colors-favorite" v-if="favorite">
            <ColorItem  v-for="color in favoriteColors" :color="color" :currentColor="currentColor" @click="selectedColor(color)" :callbackRemoveFavorite="removeFavorite" ></ColorItem>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.collerovka-container
{
  left: 0;
  right: 0;
  top:0;
  margin: 2% auto;
  background: #fff;
  position: fixed;
  width: 90%;
  z-index: 9999;
  padding: 30px;
}
.collerovka-header-control {
  position: relative;
}
.control-close{
  position: absolute;
  right: 0;
  top: 0;
  font-size: 16px;
  color: #6d6c6c;
  cursor: pointer;
}
.collerovka-header h2 {
  font-size: 24px;
  border-bottom: 3px solid #d3553c;
  padding-bottom: 4px;
  margin-bottom: 15px;
}
.collerovka-body
{
  display: grid;
  grid-template-columns: 2fr 3fr;
}
.collerovka-body_interior
{
  margin: 20px;
}
.search-collerovka
{
  padding: 10px 15px;
  border: none;
  background: #eee;
  width: 100%;
}
.colors-tabs{
  position: relative;
  margin-top: 10px;
  margin-bottom: 15px;
  display: flex;
  flex-direction: row;
  justify-content: start;
}
.color-tab{
  color: #898989;
  padding: 10px 15px;
  border-bottom: 2px solid #eee;
}
.color-tab:hover{
  cursor: pointer;
}
.color-tab.active{
  border-bottom: 2px solid #717171;
}

.colors-items
{
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  height: 450px;
  overflow-x: hidden;
  overflow-y: auto;
  padding: 20px;
  grid-auto-rows: 55px;
}
.colors-item
{
  margin: 1px 2px;
  color: #fff;
  padding: 15px 20px;
  transition: 0.3s;
  z-index: 1;
  cursor: pointer;
  border: 2px solid transparent;
  border-radius: 4px;
  height: 50px;
  position: relative;
}
.colors-item.active{
  border: 2px solid #b2b2b2;
}
.colors-item:hover
{
  transform: scale(1.3);
  transition: 0.3s;
  z-index: 2;
}

.colors-item span{
  background: inherit;
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
  filter: invert(1) grayscale(1);
  -webkit-filter: invert(1) grayscale(1);
}

</style>
<script>
import ColorItem from "./blocks/ColorItem.vue";
import Favorite from "./blocks/Favorite.vue";
export default {
  components: {Favorite, ColorItem},
  data(){
    return{
      openModal: false,
      // массив где хранятся все цвета
      groupColors:[],
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
      favoriteColors: [],
      favorite: false
    }
  },
  watch: {
    searchColorText(val) {
      this.searchColor(val);
    }
  },
  mounted(){
    $.getJSON('/assets/template/json/collerovka.json', (json) => {
      console.log(json);
      this.groupColors = json;

    }).then(() => {

      this.selectGroup =  this.groupColors[0];
      this.currentColors = this.groupColors[0].items;
      this.favoriteColors = this.$cookies.get('selectColors');
    })

  },
  methods:{
    selectedGroup(group){
      this.selectGroup = group;
      this.currentColors = group.items;
      this.searchColorText = "";
      this.favorite = false;
    },
    removeFavorite(color){
      this.favoriteColors =  this.$cookies.get('selectColors');
    },
    selectedColor(color){
      this.currentColor = color;
      this.favoriteColors = this.addColorCookie(color);
    },
    addColorCookie(color){
      let cookieColor = [];

      // добавление в куки
      if(this.$cookies.get('selectColors'))
      {
        cookieColor = this.$cookies.get('selectColors');
      }else{
        cookieColor = [];
      }

      if (!cookieColor.some(e => e.title === color.title)) {
        cookieColor.push(color);
      }
      this.$cookies.set('selectColors', cookieColor);
      return cookieColor;
    },
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


