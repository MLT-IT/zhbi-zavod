<template>
  <div class="colors-item" :class="{active: color == currentColor}" :style="color.background" >
    <span>{{color.title}}</span>
    <span class="colors-remove-favorite" @click.stop @click="removeColorCookie(color)">x</span>
  </div>
</template>

<script>
export default {
  props: ['color', 'currentColor', 'callbackRemoveFavorite'],

  methods: {
    removeColorCookie(color){
      let cookieColor = [];
      // добавление в куки
      if(this.$cookies.get('favoriteColors'))
      {
        cookieColor = this.$cookies.get('favoriteColors``');
      }else{
        cookieColor = [];
      }
      cookieColor = cookieColor.filter(e => e.title != color.title);

      this.$cookies.set('favoriteColors``', cookieColor);
      this.callbackRemoveFavorite(color);
    },

  },

}
</script>
<style>
.colors-remove-favorite
{
  position: absolute;
  font-size: 10px;
  color: #eee;
  visibility: hidden;
  right: 5px;
  top: 5px;
  padding: 3px 3px;
  display: none;

}
.colors-favorite .colors-item:hover .colors-remove-favorite
{
  transition: 0.3s;
  visibility: visible;
  display: block;
  z-index: 2;
}
</style>
