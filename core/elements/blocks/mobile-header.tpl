<div class="mobile-header">
    <div class="mobile-header__phone">
        <svg class="svg icon-phone" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" viewBox="0 0 17 17" width="17" height="17">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-phone"></use>
        </svg><a href="tel:{'phone' | option}">{'phone' | option}</a>
    </div>
    <div class="mobile-header__city">
        <svg class="svg icon-place" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
            <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-place"></use>
        </svg>
        <div class="mobile-header__city-select">
            <select name="city">
                <option value="1">Санкт-Петербург</option>
            </select>
        </div>
    </div>
</div>
