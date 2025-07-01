<article class="promo section section_view_bg">
  <div class="promo__container">
    <div class="promo__top">
      
      <h2 class="section__title">Акции и скидки</h2>
      {if !$show_more_hide}
      <a class="link" href="/akcii/">Смотреть все</a>
      {/if}
    </div>

    {set $imageBaner1 = "assets/template/pictures/promo/promo-1.jpg"}
    {set $imageBanerMobile1 = "assets/template/pictures/promo/promo-1-mob.jpg"}
    {set $titleBaner1 = "Скидка 20% на доставку манипулятором"}
    {set $textBaner1 = "Скидка 20% на доставку газобетона манипулятором при заказе от 60 м3"}
    {set $linkBaner1 = "/akcii/"}
    {set $customCssTitle1 = ""}
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
        {set $imageBaner1 = "assets/template/pictures/promo/v1/krovlya-1.png"}
        {set $imageBanerMobile1 = "assets/template/pictures/promo/v1/krovlya-1-mobile.png"}
        {set $titleBaner1 = "Точный расчет <br> кровли <span style='color:var(--color-red)'>в подарок!</span>"}
        {set $textBaner1 = "Специалисты<br> произведут точный расчет<br> всех материалов <br>под Ваш заказ <br>бесплатно"}
        {set $linkBaner1 = ""}
        {set $colorText1 = "#3C3C3B"}
        {set $customCssTitle1 = "background:transparent;padding:0;"}
        
        {set $buttonLinkBaner1 = "получить расчет"}

        {set $imageBaner2 = "assets/template/pictures/promo/v1/krovlya-2.png"}
        {set $imageBanerMobile2 = "assets/template/pictures/promo/v1/krovlya-2-mobile.png"}
        {set $titleBaner2 = "Скидка на металлочерепицу<br><span style='color:#B61E13'>Grand Line</span>"}
        {set $textBaner2 = ""}
        {set $colorText2 = "#3C3C3B"}
        {set $linkBaner2 = "/metallocherepitsya-grand-line/"}
        {set $buttonLinkBaner2 = "перейти в каталог"}
        {set $btn_2_style = "background: #B61E13; box-shadow: 0px 2px 0px 0px #944434;"}
        {set $label2 = [
          'text'=>'от 310 ₽ за м2'
          'style' => 'background:#B61E13;'   
        ]}
          {set $logo_2="assets/template/pictures/promo/v1/grand-logo.png"}

        {set $pzdc_tut_css_file="min-width: 66%;box-shadow: 0 0 3px #00000073;"}

        {set $imageBaner3 = "assets/template/pictures/promo/v1/krovlya-3.png"}
        {set $imageBanerMobile3 = "assets/template/pictures/promo/v1/krovlya-3-mobile.png"}
        {set $titleBaner3 = "Скидка на профлист<br><span style='color:#0275A8'>Металл-Профиль</span>"}
        {set $textBaner3 = ""}
        {set $colorText3 = "#3C3C3B"}
        {set $linkBaner3 = '/profilirovannyj-list-dlya-zabora-metall-profil/'}
        {set $buttonLinkBaner3 = "перейти в каталог"}
        {set $label3 = [
          'text'=>'от 250 ₽ за м2 '
          'style' => 'background:#0275A8;'   
        ]}
        {set $btn_3_style = "background: #0275A8; box-shadow: 0px 2px 0px 0px #0275A8;border:none"}
        {set $btn_3_base = true}  
        {set $logo_3="assets/template/pictures/promo/v1/mp-logo.png"}

      {case 'tagnerud'}
        {set $imageBaner1 = "assets/template/pictures/promo/tagnerud/banner_1.jpg"}
        {set $imageBanerMobile1 = "assets/template/pictures/promo/tagnerud/banner_1.jpg"}
        {set $titleBaner1 = "Скидка 20% на доставку керамзита"}
        {set $textBaner1 = ""}
        {set $linkBaner1 = ""}
        {set $colorText1 = "#fff"}

        {set $imageBaner2 = "assets/template/pictures/promo/tagnerud/banner_2.jpg"}
        {set $imageBanerMobile2 = "assets/template/pictures/promo/tagnerud/banner_2.jpg"}
        {set $titleBaner2 = "Керамзит в мешках от 80 Ꝑ/мешок"}
        {set $textBaner2 = ""}
        {set $colorText2 = "#fff"}
        {set $linkBaner2 = "/catalog/v-meshkax/"}
        {set $buttonLinkBaner2 = "КЕРАМЗИТ В МЕШКАХ"}

        {set $imageBaner3 = "assets/template/pictures/promo/tagnerud/banner_3.jpg"}
        {set $imageBanerMobile3 = "assets/template/pictures/promo/tagnerud/banner_3.jpg"}
        {set $titleBaner3 = "Керамзит фракции 20-40 мм от 1 490 Ꝑ/м3"}
        {set $textBaner3 = ""}
        {set $colorText3 = "#fff"}
        {set $linkBaner3 = '/catalog/frakczii-20-40/'}
        {set $buttonLinkBaner3 = "КЕРАМЗИТ 20-40"}
      {case 'kirpich-m5'}
        {set $imageBaner1 = "assets/template/pictures/promo/kirpich-m5/banner_1.jpg"}
        {set $imageBanerMobile1 = "assets/template/pictures/promo/kirpich-m5/banner_1.jpg"}
        {set $titleBaner1 = "Кирпич ЛСР со скидкой 20%"}
        {set $textBaner1 = "Только до конца месяца &mdash; скидка на облицовочный кирпич ЛСР<br> Количество ограничено!"}
        {set $linkBaner1 = "/catalog/"}
        {set $buttonLinkBaner1 = "Перейти в каталог"}
        {set $colorText1 = "#fff"}

        {set $imageBaner2 = "assets/template/pictures/promo/kirpich-m5/banner_2.jpg"}
        {set $imageBanerMobile2 = "assets/template/pictures/promo/kirpich-m5/banner_2.jpg"}
        {set $titleBaner2 = "Кладочный раствор ОСНОВИТ 25 кг &mdash; 360 Ꝑ!"}
        {set $textBaner2 = ""}
        {set $colorText2 = "#fff"}
        {set $linkBaner2 = ""}
        {set $buttonLinkBaner2 = ""}

        {set $imageBaner3 = "assets/template/pictures/promo/kirpich-m5/banner_3.jpg"}
        {set $imageBanerMobile3 = "assets/template/pictures/promo/kirpich-m5/banner_3.jpg"}
        {set $titleBaner3 = "Скидки до 30% на оптовые заказы"}
        {set $textBaner3 = ""}
        {set $colorText3 = "#fff"}
        {set $linkBaner3 = ''}
        {set $buttonLinkBaner3 = ""}
  {case 'gbi-zavod78'}
        {set $imageBaner2 = "assets/template/pictures/promo/zhbi500/promo-mob.png"}
        {set $imageBanerMobile2 = "assets/template/pictures/promo/zhbi500/promo-mob.png"}
        {set $imageBaner3 = "assets/template/pictures/promo/zhbi500/ptomo-2-mob.jpg"}
        {set $imageBanerMobile3 = "assets/template/pictures/promo/zhbi500/ptomo-2-mob.jpg"}

        {set $titleBaner1 = "Скидка 20% на доставку манипулятором"}
        {set $textBaner1 = "Скидка 20% на доставку ЖБИ манипулятором при заказе от 60 м3"}

        {set $titleBaner2 = "Плита дорожная 2П 30-18-30 ГОСТ 8 800 руб/шт"}
        {set $textBaner2 = "Самые низкие цены на ЖБИ"}

        {set $titleBaner3 = "Железобетонный Лоток ЛК 300.60.60 3760 руб/шт"}
        {set $textBaner3 = "Доставка уже завтра"}
    {/switch}
    <div class="promo__items">
      <div class="promo__item promo-block promo-block_view_big promo-block_style_white">
        <picture class="promo-block__bg">
          {set $file = $imageBanerMobile1 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$file}" media="(max-width: 768px)">
          {/if}
          <source srcset="{$imageBanerMobile1}" media="(max-width: 768px)">
          {set $file = $imageBaner1 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$file}" type="image/webp" >
          {/if}
          <img class="promo-block__bg-img" src="{$imageBaner1}">
        </picture>
        <h3 class="promo-block__title" 
          {if $colorText1}style = "color:{$colorText1}{if $customCssTitle1};{$customCssTitle1}{/if}"{/if}
        >{$titleBaner1}</h3>
        <p class="promo-block__text" {if $colorText1} style = "color:{$colorText1}"{/if}>{$textBaner1}</p>
          <a class="promo-block__btn btn btn_style_base" 
          {if $pzdc_tut_css_file}
            style="{$pzdc_tut_css_file}"
          {/if}
          {if $linkBaner1 is empty}
            href="#callback"
            data-fancybox 
          {else}
            href="{$linkBaner1}"
          {/if}
          >{$buttonLinkBaner1}</a>
      </div>
      <div class="promo__item promo-block promo-block">
        {if $logo_2}
          <img class="promo-logo" src="{$logo_2}" />
        {/if}
        <picture class="promo-block__bg">
          {set $file = $imageBanerMobile2 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$file}" media="(max-width: 768px)">
          {/if}
          <source srcset="{$imageBanerMobile2}" media="(max-width: 768px)">
          {set $file = $imageBaner2 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$imageBaner2 | replace : '.jpg': '.webp'}" type="image/webp" >
          {/if}
          <img class="promo-block__bg-img" src="{$imageBaner2}">
        </picture>
        <h3 class="promo-block__title small" {if $colorText2} style = "color:{$colorText2}" {/if}>
          {$titleBaner2}
          {if $label2}
            <span class="promo-label" {if $label2['style']}style="{$label2['style']}"{/if}>{$label2['text']}</span>
          {/if}
        </h3>
        <p class="promo-block__text">
          {$textBaner2}
        </p>
        {if $buttonLinkBaner2}
        <a class="promo-block__btn btn btn_style_base opacity" {if $btn_2_style}style="{$btn_2_style}"{/if}  href="{$linkBaner2}">{$buttonLinkBaner2}</a>
        {/if}
      </div>
      <div class="promo__item promo-block">
        {if $logo_3}
          <img class="promo-logo" src="{$logo_3}" />
        {/if}
        <picture class="promo-block__bg">
          {set $file = $imageBanerMobile3 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$file}" media="(max-width: 768px)">
          {/if}
          <source srcset="{$imageBanerMobile3}" media="(max-width: 768px)">
          {set $file = $imageBaner3 | replace : '.jpg': '.webp'}
          {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
          <source srcset="{$file}" type="image/webp" >
          {/if}
          <img class="promo-block__bg-img" src="{$imageBaner3}">
        </picture>
        <h3 class="promo-block__title small" {if $colorText3} style = "color:{$colorText3}" {/if}>
          {$titleBaner3}
          {if $label3}
            <span class="promo-label" {if $label3['style']}style="{$label3['style']}"{/if}>{$label3['text']}</span>
          {/if}
        </h3>
        <p class="promo-block__text">
          {$textBaner3}
        </p>
        {if $buttonLinkBaner3}
        <a class="promo-block__btn btn {if $btn_3_base}btn_style_base{else}btn_style_trans{/if} opacity"  {if $btn_3_style}style="{$btn_3_style}"{/if} href="{$linkBaner3}">{$buttonLinkBaner3}</a>
        {/if}
      </div>
    </div>
  </div>
</article>
