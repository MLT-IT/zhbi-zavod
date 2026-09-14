        <div class="infoblocks__block" data-tab-page="Отзывы">
            <button class="infoblocks__block-title" data-tab="Отзывы">Отзывы</button>
            <div class="infoblocks__block-dropdown">
              {if $_modx->context.key in ['krovelnyjstroymarket', 'kirpich-m5', 'fibrofasad','trotuarnaya-plitka', 'web']}
                {insert 'file:modules/mltreviews/chunks/product-page.tpl'}
              {else}
              <div class="reviews">
                {foreach $reviews as $idx => $row}
                    {if $row.status == 1}
                        {set $statusPublishedReviews = true}
                    {/if}
                {/foreach}

               {if $_modx->context.key == 'gazosilikatstroy'}
                  {include "file:chunks/all_reviews.tpl" classnames="cols-2"}
               {else}
                  {if $reviewsCount > 0 && $statusPublishedReviews}
                    <div class="reviews__slider">
                      <div class="swiper-container swiper-container-fade swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                        <div class="swiper-wrapper">

                          {foreach $reviews as $idx => $row}
                              {if $row.status == 1}
                                <div class="swiper-slide reviews__item" style="width: 802px; opacity: 1; transform: translate3d(0px, 0px, 0px);"><span class="reviews__name">{$row.author}</span>
                                  <p class="reviews__text">{$row.text}</p>
                                </div>
                              {/if}
                          {/foreach}

                        </div>
                      </div>

                        <div class="swiper-buttons">
                        <div class="swiper-button swiper-button-prev swiper-button-disabled"></div>
                        <div class="swiper-button swiper-button-next"></div>
                      </div>
                    </div>
                  {else}
                      <h3 class="py-5">Еще нет отзывов</h3>
                  {/if}
                {/if}

                <a class="btn btn_style_shadow reviews__btn"  data-fancybox href="#review">Оставить отзыв</a>
              </div> 
              {/if}
            </div>
          </div>
