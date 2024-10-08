{set $params = [
  "href" => "/servisyi-rascheta/raschet-krovli-iz-profnastila/",
  "text" => "Рассчитать в калькуляторе кровли"
]}

{if $isMetalloCherepica}
  {set $params["href"] = "/servisyi-rascheta/raschet-krovli-iz-metallocherepiczyi/"}
{elseif $isShtaketnik}
  {set $params["href"] = "/servisyi-rascheta/raschet-shtaketnika-dlya-zabora/"}
  {set $params["text"] = "Рассчитать в калькуляторе заборов"}
{/if}


<div class="product-info__link-calculator">
    <a href="{$params['href']}" class="btn btn_style_trans btn_calc">
      {$params['text']}
    </a>
</div>
