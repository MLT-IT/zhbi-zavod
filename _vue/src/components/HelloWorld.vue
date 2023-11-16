
<template>
  <button class="btm-collerovka btn" @click="openModal = !openModal">Коллеровка</button>
  <div class="collerovka-container collerovka" v-if="openModal">
    <div class="collerovka-header">
      <h2>Выбор коллеровки</h2>
    </div>
    <div class="collerovka-body">
      <div class="collerovka-body_interior" :style="currentColor.background">

      </div>
      <div class="collerovka-body_colors colors">
        <input type="text" class="search-collerovka" placeholder="Поиск ">
        <div>
          <div class="colors-tabs">
            <div v-for="group in groupColors" class="color-tab" :class="{ active: group == selectGroup }" @click="selectedGroup(group)">
              {{group.group_name}}
            </div>
          </div>
          <div class="colors-items" v-if="currentColor">
            <div v-for="color in currentColors" class="colors-item" :class="{active: color == currentColor}" :style="color.background" @click="selectedColor(color)">
              <span>{{color.title}}</span>
            </div>
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
  height: 90vh;
  padding: 30px;
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
  grid-template-columns: 1fr 2fr;
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
export default {
  data(){
    return{
      openModal: true,
      groupColors:[

      ],
      currentColors: [],
      currentColor: {},
      selectGroup: {}
    }
  },
  mounted(){
    $.getJSON('/assets/template/json/collerovka.json', (json) => {
      console.log(json);
      this.groupColors = json;

    }).then(() => {

      this.selectGroup =  this.groupColors[0];
      this.currentColors = this.groupColors[0].items;
      console.log( this.groupColors);
    })

  },
  methods:{
    selectedGroup(group){
      this.selectGroup = group;
      this.currentColors = group.items;
    },
    selectedColor(color){
      this.currentColor = color;
    }
  }
}
</script>


