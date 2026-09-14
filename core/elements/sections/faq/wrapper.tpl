{set $faq = 'getFaqValue' | snippet}
{set $faqCount = $faq | count}
{set $faqCountHalf = ($faqCount / 2) | ceil}

<article class="faq section section_view_bg">
  <div class="faq__container">
    {if $ispage}
      <h1 class="faq__title section__title">Ответы на популярные вопросы</h1>
    {else}
      <h2 class="faq__title section__title">Ответы на популярные вопросы</h2>
    {/if}
    <div class="faq__list">
      {set $iterator = 1}
        {foreach $faq as $item}
          {if $iterator == 1}
            <div class="faq__column">
          {/if}
          {if $iterator == $faqCountHalf+1}
            </div>
            <div class="faq__column">
          {/if}
          <div class="faq-item" data-dropdown="responsive" data-disable-close>
            <div class="faq-item__top">
              <p class="faq-item__title">{$item['question']}</p>
              <button class="faq-item__toggler"></button>
            </div>
            <div class="faq-item__dropdown">
              <div class="faq-item__content">
                <p class="faq-item__text">
                    {$item['answer']}
                </p>
              </div>
            </div>
          </div>

          {if $iterator == $faqCount}
            </div>
          {/if}

          {set $iterator = $iterator + 1}
        {/foreach}
    </div>
    {*
    <button class="faq__more btn btn_style_trans">Показать ещё вопросы</button>
    *}
  </div>
</article>
