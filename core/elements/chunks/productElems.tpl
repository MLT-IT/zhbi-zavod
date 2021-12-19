<div class="product-item__ms2-elems">
    <form class="product-item__form-add ms2_form" method="post">
        <input name="options" value="[]">
        <input name="id" value="{$_modx->resource['id']}">
        <input name="count" value="1">
        <input name="ctx" value="{$_modx->resource.context_key}">
        <button type="submit" name="ms2_action" value="cart/add">Добавить</button>
    </form>
    <form class="product-item__form-change ms2_form" method="post">
        <input name="key" value="{$productKey}">
        <input name="count" value="1">
        <input name="ctx" value="{$_modx->resource.context_key}">
        <button type="submit" name="ms2_action" value="cart/change">Изменить кол-во</button>
    </form>
</div>
