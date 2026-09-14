{set $data = '@FILE snippets/fromJSON.php' | snippet: ['input' => 'raspil/plitnye/raspil-delivery.json']}
{*$data | print_r*}
<article class="infoblocks section{$styleClass ? ' ' ~ $styleClass : ''}">
  <div class="infoblocks__container">
    <div class="infoblocks__content">
      <span class="infoblocks__title section__title">{$data.title}</span>
      <p class="infoblocks__subtitle">{$data.text}</p>
      <div class="table">

        <table class="table__table table-delivery">
          <thead>
          <tr class="table__row">
            {foreach $data.pricelist.header as $h}
              <td class="table__cell">{$h}</td>
            {/foreach}
          </tr>
          </thead>
          <tbody>
          {foreach $data.pricelist.body as $row}
            <tr class="table__row">{foreach $row as $cell}<td class="table__cell">
              {$cell}<div class="mobile-block"></div></td>{/foreach}
            </tr>
          {/foreach}
          </tbody>
        </table>
      </div>
      <div class="infoblocks__bottom"><a class="btn btn_style_shadow" data-fancybox="" href="#callback">{$data.button}</a></div>
    </div>

    <div class="infoblocks__advantages">
      {foreach $data.tiles as $item}
        <div class="infoblocks__advantage">
          <div class="advantage__image-wrap">
            <img class="advantage__image" src="{$item.img}"/>
          </div>
          <p class="advantage__title">{$item.title}</p>
          <p class="advantage__text">{$item.text}</p>
        </div>
      {/foreach}
    </div>
    
  </div>
</article>
