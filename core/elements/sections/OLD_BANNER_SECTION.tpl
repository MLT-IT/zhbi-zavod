{* Старый вывод банеров до внедрения API *}

      {if $_modx->context.key == 'trotuarnaya-plitka'}
        {include "file:sections/banners/trotuarnaya-plitka.tpl" small_banner_hide=true}
      {else}
            {switch $_modx->resource.context_key}
            {case 'web'}
                {set $text = 'Закажите утеплитель сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'gazosilikatstroy'}
                {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
            {case 'gazoclone'}
                {set $text = 'Закажите газобетон сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на манипулятор'}
            {case 'kraska'}
                {set $text = 'Закажите краску сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'suhiesmesi'}
                {set $text = 'Закажите сухие смеси сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'krovelnyjstroymarket'}
                {set $text = 'Скидка 15% на изготовление металлочерепицы Grand line в размер'}
            {case 'tagnerud'}
                {set $text = 'Закажите керамзит сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {case 'gbi-zavod78'}
                {set $text = 'Закажите дорожные плиты сейчас<br>и получите <span class="text-highlighter">скидку 20%</span><br>на доставку'}
            {case 'kirpich-m5'}
                {set $text = 'Закажите кирпич сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
                {set $img = 'assets/template/pictures/catalog/'~$_modx->resource.context_key~'/delivery.jpg'}
                {set $img_mob = 'assets/template/pictures/catalog/'~$_modx->resource.context_key~'/delivery.jpg'}
            {case default}
                {set $text = 'Закажите продукцию сейчас<br>и получите <span class="text-highlighter">скидку 30%</span><br>на доставку'}
            {/switch}
            {if !$img}
            {set $img = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen.jpg'}
            {/if}
            {if !$img_mob}
            {set $img_mob = 'assets/template/pictures/main-screen/'~$_modx->resource.context_key~'/main-screen-mob.jpg'}        
            {/if}
        <div class="banner">
            <picture class="banner__bg">
            {set $file = $img_mob | replace : '.jpg': '.webp'}
            {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
                <source srcset="{$file}" media="(max-width: 768px)">
            {/if}
            <source srcset="{$img_mob}" media="(max-width: 480px)">
            {set $file = $img | replace : '.jpg': '.webp'}
            {if ('@FILE snippets/fileExists.php' | snippet : ['input' => $file])}
                <source srcset="{$file}">
            {/if}
            <img class="banner__bg-img" src="{$img}">
            </picture>
            <div class="banner__title">
            {$text}
            </div>
            <p class="banner__text">Акция до конца месяца</p>
            <div class="banner__action"><span data-fancybox data-src="#callback" class="banner__btn btn btn_style_yellow">Заказать со скидкой</span></div>
        </div>
      {/if}
