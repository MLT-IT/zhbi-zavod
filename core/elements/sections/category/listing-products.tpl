<div class="listing__products">
    {include "file:sections/category/listing-tags.tpl"}
    <div class="listing__sort">
        <div class="listing__sort-list"><span>Сортировать: </span>
            <div class="listing__sort-item min">по цене</div>
            <div class="listing__sort-item max">по популярности</div>
            <div class="listing__sort-item">по алфавиту</div>
        </div>
        <div class="listing__sort-select-container"> <span>Сортировать: </span>
            <div class="listing__sort-select">
                <select name="sort">
                    <option value="1">по цене ↑</option>
                    <option value="2">по цене ↓</option>
                    <option value="3">по популярности</option>
                    <option value="4">по алфавиту</option>
                </select>
            </div>
        </div>
        <div class="listing__sort-grid">
            <svg class="svg icon-lines active" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-lines"></use>
            </svg>
            <svg class="svg icon-grid" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-grid"></use>
            </svg>
        </div>
    </div>
    <div class="listing__products-list rows" id="mse2_results">
        {$results}
        {*'!pdoPage' | snippet : [
            'tpl' => "@FILE sections/category/listing-products-item.tpl",


            'limit' => 20,
            'element' => "msProducts",
            'ajaxMode' => 'default',
            'ajaxElemWrapper' => ".listing__products",
            'ajaxElemRows' => ".listing__products-list",
            'ajaxElemPagination' => ".listing__products .pagination",
            'ajaxElemLink' => ".listing__products .pagination a",
            'ajaxMode' => 'scroll',
            'ajaxTplMore' => '@INLINE <button class="white-btn btn-more">[[%pdopage_more]]</button>',
            'ajaxElemMore' => ".listing__products .btn-more",
        ]*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/beton/beton1.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn">В корзину</div>*}
{*            </div>*}
{*        </div>*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/not-exist.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn added">В корзину</div>*}
{*            </div>*}
{*        </div>*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/beton/beton1.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn">В корзину</div>*}
{*            </div>*}
{*        </div>*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/beton/beton1.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn">В корзину</div>*}
{*            </div>*}
{*        </div>*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/beton/beton1.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn">В корзину</div>*}
{*            </div>*}
{*        </div>*}
{*        <div class="listing__products-item">*}
{*            <div class="listing__products-item-left"><a class="listing__products-item-photo" href="#"><img src="{$_modx->config['template_path']}img/beton/beton1.png" alt=""></a>*}
{*                <div class="listing__products-item-title"><a href="#">Бетон товарный</a></div>*}
{*                <div class="listing__products-item-avail">*}
{*                    <svg class="svg icon-available" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-available"></use>*}
{*                    </svg>В наличии*}
{*                </div>*}
{*                <div class="listing__products-item-rate two">*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                    <svg class="svg icon-star" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">*}
{*                        <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-star"></use>*}
{*                    </svg>*}
{*                </div>*}
{*                <div class="listing__products-item-art">Арт. 998393</div>*}
{*            </div>*}
{*            <div class="listing__products-item-right">*}
{*                <div class="listing__products-item-price">3 000 руб.</div>*}
{*                <div class="listing__products-item-button yellow-btn">В корзину</div>*}
{*            </div>*}
{*        </div>*}
    </div>
    <div class="mse2_pagination">
        {$pagenav}
    </div>
</div>