<article class="promo section section_view_bg">
  <div class="promo__container">
    <div class="promo__top">
      <h2 class="section__title">Акции и скидки</h2><a class="link" href="/akcii/">Смотреть все</a>
    </div>

    {set $imageBaner1 = "assets/template/pictures/promo/promo-1.jpg"}
    {set $imageBanerMobile1 = "assets/template/pictures/promo/promo-1-mob.jpg"}
    {set $titleBaner1 = "Скидка 20% на доставку манипулятором"}
    {set $textBaner1 = "Скидка 20% на доставку газобетона манипулятором при заказе от 60 м3"}
    {set $linkBaner1 = "/akcii/"}
    {set $buttonLinkBaner1 = "Узнать подробности акции"}

    {set $imageBaner2 = "assets/template/pictures/promo/promo-2-mob.jpg"}
    {set $imageBanerMobile2 = "assets/template/pictures/promo/promo-2.jpg"}
    {set $titleBaner2 = "Газобетон D200 по 4 500 Ꝑ/м3"}
    {set $textBaner2 = "Скидка 20% на новый газобетон D200"}
    {set $linkBaner2 = "/gazobeton-lsr/?plotnost-ob=D200"}
    {set $buttonLinkBaner2 = "Узнать подробности акции"}

    {set $imageBaner3 = "assets/template/pictures/promo/promo-3.jpg"}
    {set $imageBanerMobile3 = "assets/template/pictures/promo/promo-3-mob.jpg"}
    {set $titleBaner3 = "Белорусский газобетон 3 000 Ꝑ/м3"}
    {set $textBaner3 = "Газобетон с доставкой Беларусии"}
    {set $linkBaner3 = $_modx->makeUrl(102335)}
    {set $buttonLinkBaner3 = "Узнать подробности акции"}

    {switch $_modx->resource.context_key}
      {case 'krovelnyjstroymarket'}
        {set $imageBaner1 = "assets/template/pictures/promo/1.jpg"}
        {set $imageBanerMobile1 = "assets/template/pictures/promo/1.jpg"}
        {set $titleBaner1 = "Бесплатный выезд замерщика"}
        {set $textBaner1 = ""}
        {set $linkBaner1 = "/akcii/"}
        {set $colorText1 = "#fff"}
        {set $buttonLinkBaner1 = "Вызвать замерщика"}

        {set $imageBaner2 = "assets/template/pictures/promo/2.jpg"}
        {set $imageBanerMobile2 = "assets/template/pictures/promo/2.jpg"}
        {set $titleBaner2 = "Металлочерепица Grand Line от 380 руб/м2"}
        {set $textBaner2 = ""}
        {set $colorText2 = "#fff"}
        {set $linkBaner2 = "/metallocherepitsya-grand-line/"}

        {set $imageBaner3 = "assets/template/pictures/promo/3.jpg"}
        {set $imageBanerMobile3 = "assets/template/pictures/promo/3.jpg"}
        {set $titleBaner3 = "Профлист от компании “Металл Профиль” от 280 руб/м2"}
        {set $textBaner3 = ""}
        {set $colorText3 = "#fff"}
        {set $linkBaner3 = '/profilirovannyj-list-dlya-zabora-metall-profil/'}

    {/switch}
    <div class="promo__items">
      <div class="promo__item promo-block promo-block_view_big promo-block_style_white">
        <picture class="promo-block__bg">
          <source srcset="{$imageBanerMobile1}" media="(max-width: 768px)"><img class="promo-block__bg-img" src="{$imageBaner1}">
        </picture>
        <h3 class="promo-block__title" {if $colorText1} style = "color:{$colorText1}" {/if}>{$titleBaner1}</h3>
        <p class="promo-block__text">{$textBaner1}</p><a class="promo-block__btn btn btn_style_base" href="{$linkBaner1}">{$buttonLinkBaner1}</a>
      </div>
      <div class="promo__item promo-block">
        <picture class="promo-block__bg">
          <source srcset="{$imageBanerMobile2}" media="(max-width: 768px)"><img class="promo-block__bg-img" src="{$imageBaner2}">
        </picture>
        <h3 class="promo-block__title" {if $colorText2} style = "color:{$colorText2}" {/if}>{$titleBaner2}</h3>
        <p class="promo-block__text">{$textBaner2}</p><a class="promo-block__btn btn btn_style_base" href="{$linkBaner2}">{$buttonLinkBaner2}</a>
      </div>
      <div class="promo__item promo-block">
        <picture class="promo-block__bg">
          <source srcset="{$imageBanerMobile3}" media="(max-width: 768px)"><img class="promo-block__bg-img" src="{$imageBaner3}">
        </picture>
        <h3 class="promo-block__title" {if $colorText3} style = "color:{$colorText3}" {/if}>{$titleBaner3}</h3>
        <p class="promo-block__text">{$textBaner3}</p><a class="promo-block__btn btn btn_style_trans" href="{$linkBaner3}">{$buttonLinkBaner2}</a>
      </div>
    </div>
  </div>
</article>
