{set $data = "@FILE snippets/getJsonData.php" | snippet : [
    "path" => "/assets/template/json/faqs/"~$_modx->context.key~".json"
]}



<div class="faqs bg-light-gray-2 section-margin">
    <div class="container">
        <h2 class="section-title">Ответы на популярные вопросы</h2>
        <div class="faqs__row">
            {if $data['status'] == 'success'}
                {foreach $data['data'] as $index => $item}
                <div class="faqs__item" data-opened-element="question-{$index}">
                    <div class="faqs__item-question fw-700" data-opened-btn="question-{$index}">{$item['question']} <div class="faqs__item-question--btn"></div></div>
                    <div class="faqs__item-answer">{$item['answer']}</div>
                </div>
                {/foreach}
            {/if}
        </div>
    </div>
</div>