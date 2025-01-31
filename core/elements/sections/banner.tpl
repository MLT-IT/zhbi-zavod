<div class="main-screen__banners">
  <div class="main-screen__slider">
    <div class="swiper-container">
      <div class="swiper-wrapper">
        <div class="swiper-slide banner">
          <picture class="banner__bg">
            {set $file = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen-mob.webp'}
            {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
            <source srcset="{$file}" media="(max-width: 480px)" type="image/webp">
            {/if}
            <source srcset="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen-mob.jpg" media="(max-width: 480px)">
            {set $file = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen.webp'}
            {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
            <source srcset="{$file}" type="image/webp" >
            {/if}
            <img class="banner__bg-img" src="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen.jpg">
          </picture>
          <div class="banner__title">
            {set $text = 'Закажите товар сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}

            {switch $_modx->resource.context_key}
              {case 'web'}
                {set $text = 'Закажите утеплитель сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'plitnye'}
                {set $text = 'Закажите плитные материалы сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'stenovye'}
                {set $text = 'Закажите плиты сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'gazosilikatstroy'}
                {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
              {case 'kraska'}
                {set $text = 'Закажите краску сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'suhiesmesi'}
                {set $text = 'Закажите сухие смеси сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'fibrofasad'}
                {set $text = 'Закажите фиброцементный фасад сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'fibrofasad2'}
                {set $text = 'Закажите фиброцементный фасад сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'beltermo'}
                {set $text = 'Закажите плиты Белтермо сейчас <br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
              {case 'krovelnyjstroymarket'}
                {set $text = 'Скидка 15% на изготовление металлочерепицы Grand line в размер'}
              {case 'tagnerud'}
                {set $text = 'Закажите керамзит сейчас<br>и получите <span class="text-highlighter">скидку 20%</span><br>на доставку'}
              {case 'profnastil'}
                {set $text = 'Профнастил МП20<br> со скидкой 20%'}
              {case 'gibkaya-cherepiza'}
                {set $text = 'Гибкая черепица Технониколь<br> со скидкой 15%'}
              {case 'falcevaya-krovlya'}
                {set $text = 'Фальцевая кровля с бесплатной<br> доставкой от 200 тыс руб'}
              {case 'metallocherepica'}
                {set $text = 'Металлочерепица в размер<br> со скидкой 25%'}
              {case 'kirpich-m5'}
                {set $text = 'Распродажа облицовочного<br> кирпича!'}
                {set $caption = 'Керамический кирпич ЛСР от 29 руб./шт!'}
                {set $btn = 'Перейти'}
                {set $link = '/oblicovochnye/'}
              {case 'zbi500'}
                {set $text = 'Закажите ЖБИ сейчас<br>и получите <span class="text-highlighter">скидку 20%</span><br>на доставку манипулятором'}
            {/switch}
            {$text}
          </div>
          <p class="banner__text">{$caption ?: 'Акция до конца месяца'}</p>
          <div class="banner__action">
            {if $link}
              <a href="{$link}" class="banner__btn btn btn_style_yellow">{$btn ?: 'Заказать со скидкой'}</a>
            {else}
              <span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">{$btn ?: 'Заказать со скидкой'}</span>
            {/if}
          </div>
        </div>

      </div>
      <div class="swiper-pagination"></div>
    </div>

  </div>
  <div class="main-screen__sub-slider">
    <div class="swiper-slide banner banner_sm">
      <picture class="banner__bg">
        {set $file = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen-sm.webp'}
        {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
        <source srcset="{$file}" type="image/webp" >
        {/if}
       <img class="banner__bg-img" src="assets/template/pictures/main-screen/{$_modx->resource.context_key}/main-screen-sm.jpg">
      </picture>
      {if $_modx->resource.context_key == 'krovelnyjstroymarket'}
        <span class="banner__title">Выберите товар вживую в нашем шоу-руме!</span>
      {else}
        <span class="banner__title">Ликвидация склада успей забрать!</span>
      {/if}
      {switch $_modx->resource.context_key}
        {case 'web'}
          {set $link = '/akcii/likvidacziya-sklada-uspej-zabrat/'}
        {case 'plitnye'}
          {set $link = '/likvidaciya-sklada/'}
        {case 'stenovye'}
          {set $link = '#'}
        {case 'gazosilikatstroy'}
          {set $link = '/rasprodazha-so-sklada/'}
        {case 'kraska'}
          {set $link = '#'}
        {case 'suhiesmesi'}
          {set $link = '#'}
        {case 'krovelnyjstroymarket'}
          {set $link = '/shourum/'}
        {case 'trotuarnaya-plitka'}
          {set $link = '/rasprodazha-so-sklada/'}
        {case 'zbi500'}
          {set $link = '#'}
        {default}
          {set $link = '/akcii/'}
      {/switch}
      <div class="banner__action"><a class="banner__btn btn btn_style_yellow" href="{$link}">подробнее</a></div>
    </div>
  </div>
</div>
