<template>
  <div class="collerovka-body_interior" :style="color.background + ';background-image: url(' + currentInterior.image + ')'">

    <div class="collerovka-body_interior-active">
      <div class="btn-interior-action prev" @click="prev" v-if="indexInterior != 0">
        <svg xmlns="http://www.w3.org/2000/svg" width="30px" height="30px" viewBox="0 0 1024 1024" class="icon" version="1.1"><path d="M768 903.232l-50.432 56.768L256 512l461.568-448 50.432 56.768L364.928 512z" fill="#000000"/></svg>
      </div>
      <div class="btn-interior-action next" @click="next" v-if="indexInterior + 1 != interiors.length">
        <svg xmlns="http://www.w3.org/2000/svg" width="30px" height="30px" viewBox="0 0 1024 1024" class="icon" version="1.1"><path d="M256 120.768L306.432 64 768 512l-461.568 448L256 903.232 659.072 512z" fill="#000000"/></svg>
      </div>

      <div class="interior-alert">
         <span class="icon-alert">
          <svg width="40px" height="40px" viewBox="0 0 36 36" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">
            <g id="SVGRepo_bgCarrier" stroke-width="0"/>
            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>
            <g id="SVGRepo_iconCarrier"> <title>attention</title> <desc>Created with Sketch.</desc> <defs> <linearGradient x1="50%" y1="0%" x2="50%" y2="100%" id="linearGradient-1"> <stop stop-color="#FFF200" offset="0%"> </stop> <stop stop-color="#FFE100" offset="100%"> </stop> </linearGradient> </defs> <g id="icons" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="ui-gambling-website-lined-icnos-casinoshunter" transform="translate(-2422.000000, -1903.000000)" fill-rule="nonzero"> <g id="4" transform="translate(50.000000, 1871.000000)"> <g id="attention" transform="translate(2372.000000, 32.000000)"> <path d="M18,0 C27.9411255,0 36,8.0588745 36,18 C36,27.9411255 27.9411255,36 18,36 C8.0588745,36 0,27.9411255 0,18 C0,8.0588745 8.0588745,0 18,0 Z" fill="url(#linearGradient-1)"> </path> <path d="M18,10 C18.5522847,10 19,10.4477153 19,11 L19,21 C19,21.5522847 18.5522847,22 18,22 C17.4477153,22 17,21.5522847 17,21 L17,11 C17,10.4477153 17.4477153,10 18,10 Z" id="Rectangle" fill="#ff0000"> </path> <path d="M18,24 C18.5522847,24 19,24.4477153 19,25 C19,25.5522847 18.5522847,26 18,26 C17.4477153,26 17,25.5522847 17,25 C17,24.4477153 17.4477153,24 18,24 Z" id="Rectangle-Copy-24" fill="#ff0000"> </path> </g> </g> </g> </g> </g>
            </svg>
        </span>
        <p>
          Цвета на экране монитора могут отличаться от реальных, так как на восприятие цвета влияет отделка материала, блеск, условия освещения и другие факторы. Мы рекомендуем делать свой выбор с помощью карт цветов, доступных у продавцов.
        </p>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: ['color'],
  data(){
    return{
      indexInterior: 0,
      currentInterior: {},
      interiors: [],
    }
  },
  methods:{
    next(){
      if(this.indexInterior + 1 <= this.interiors.length - 1)
      {
        this.indexInterior++;
      }
      this.currentInterior = this.interiors[this.indexInterior];
    },
    prev(){
      if(this.indexInterior != 0)
      {
        this.indexInterior--;
      }
      this.currentInterior = this.interiors[this.indexInterior];
    }
  },
  mounted() {
    $.getJSON('/assets/template/json/interior.json', (json) => {
      this.interiors = json;
    }).then(() => {
      // выбор первого интерьера
      this.indexInterior = 0;
      this.currentInterior =  this.interiors[0];
    })
  }
}
</script>

<style>
.collerovka-body_interior
{
  background-size:cover;
  background-repeat: no-repeat;
  background-position:bottom;
}
.collerovka-body_interior-active
{
  width: 100%;
  height: 100%;
  position: relative;
}
.btn-interior-action
{
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  height: 100%;
}
.btn-interior-action.next{
  right: 0;
}
.btn-interior-action.prev{
  left: 0;
}
.interior-alert{
  display: flex;
  align-items: center;
  position: absolute;
  bottom: -90px;
  margin: 0 40px;
  font-size: 12px;
  background: #eeeeee69;
  padding: 10px;
  border-radius: 5px;
}
.icon-alert
{
  margin-right: 10px;
}

</style>