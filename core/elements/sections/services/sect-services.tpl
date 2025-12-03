{set $servicesBlocks = ($_modx->resource.servicesBlocks ?: $_modx->resource.services_blocks) | fromJSON}
{if $servicesBlocks && $servicesBlocks[0]}
  {set $block = $servicesBlocks[0]}
{/if}

{if $block}
  {set $info_list = $block.info_list | fromJSON}
  {if !$info_list && $block.info_list}
    {set $info_list = $block.info_list | split : '||'}
  {/if}

{set $table_columns = $block.table_columns | fromJSON}
{if !$table_columns && $block.table_columns}
  {set $table_columns = $block.table_columns | split : '||'}
{/if}

{set $table_rows = $block.table_rows | fromJSON}

{set $reviews_gallery = $block.reviews_images | fromJSON}
{if $reviews_gallery is not array}
  {set $reviews_gallery = []}
{/if}

{set $works_gallery = ($_modx->resource.works_gallery ?: $block.works_gallery) | fromJSON}
{if $works_gallery is not array}
  {set $works_gallery = []}
{/if}

{set $works_title = $_modx->resource.works_title ?: $block.works_title ?: 'Наши работы'}

{set $showroom_cards = ($_modx->resource.showroom_cards ?: $block.showroom_cards) | fromJSON}
{if $showroom_cards is not array}
  {set $showroom_cards = []}
{/if}

{set $showroom_title = $_modx->resource.showroom_title ?: $block.showroom_title}
{set $showroom_subtitle = $_modx->resource.showroom_subtitle ?: $block.showroom_subtitle}
{set $showroom_image_raw = $_modx->resource.showroom_image ?: $block.showroom_image}
{set $showroom_btn_text = $_modx->resource.showroom_button_text ?: $block.showroom_button_text}
{set $showroom_btn_link = $_modx->resource.showroom_button_link ?: $block.showroom_button_link}

{set $showroom_image = $showroom_image_raw ? (($showroom_image_raw | substr : 0 : 4) == 'http' ? $showroom_image_raw : ((($showroom_image_raw | substr : 0 : 1) == '/') ? $showroom_image_raw : '/' ~ $showroom_image_raw)) : ''}
{if $showroom_image && (($showroom_image | substr : 0 : 4) != 'http') && !('@FILE snippets/fileExists.php' | snippet : ['input' => $showroom_image])}
  {set $showroom_trimmed = ($showroom_image | substr : 0 : 1) == '/' ? ($showroom_image | substr : 1) : $showroom_image}
  {set $showroom_image = '/assets/' ~ $showroom_trimmed}
{/if}
{set $showroom_img = $showroom_image && (($showroom_image | substr : 0 : 4) != 'http') ? ('phpthumbon' | snippet : ['input' => $showroom_image, 'options' => '&w=520&h=360&zc=1']) : $showroom_image}
{if $showroom_img && ($showroom_img | contains : 'noimage_')}
  {set $showroom_img = $showroom_image}
{/if}

{set $banner_original = $block.banner_bg ? (($block.banner_bg | substr : 0 : 1) == '/' ? $block.banner_bg : '/' ~ $block.banner_bg) : ''}
{set $banner_path = $banner_original}
{if $banner_path && !('@FILE snippets/fileExists.php' | snippet : ['input' => $banner_path]) && ($banner_path | substr : 0 : 4) != 'http'}
  {set $banner_trimmed = ($banner_path | substr : 0 : 1) == '/' ? ($banner_path | substr : 1) : $banner_path}
  {set $banner_path = '/assets/' ~ $banner_trimmed}
{/if}
{set $banner_bg = $banner_path ? ('phpthumbon' | snippet : ['input' => $banner_path, 'options' => '&w=1440&h=460&zc=1']) : ''}
{set $banner_src = $banner_bg}
{if !$banner_src || !('@FILE snippets/fileExists.php' | snippet : ['input' => $banner_bg])}
  {set $banner_src = $banner_path}
{/if}
{if $banner_src && ($banner_src | contains : 'noimage_')}
  {set $banner_src = $banner_path}
{/if}

{* banner image thumb *}
{set $banner_img_path = $block.banner_image ? (($block.banner_image | substr : 0 : 4) == 'http' ? $block.banner_image : ((($block.banner_image | substr : 0 : 1) == '/') ? $block.banner_image : '/' ~ $block.banner_image)) : ''}
{if $banner_img_path && (($banner_img_path | substr : 0 : 4) != 'http') && !('@FILE snippets/fileExists.php' | snippet : ['input' => $banner_img_path])}
  {set $banner_trimmed = ($banner_img_path | substr : 0 : 1) == '/' ? ($banner_img_path | substr : 1) : $banner_img_path}
  {set $banner_img_path = '/assets/' ~ $banner_trimmed}
{/if}
{set $banner_image = $banner_img_path && (($banner_img_path | substr : 0 : 4) != 'http') ? ('phpthumbon' | snippet : ['input' => $banner_img_path, 'options' => '&w=520&h=260&zc=1']) : $banner_img_path}
{if $banner_image && ($banner_image | contains : 'noimage_')}
  {set $banner_image = $banner_img_path}
{/if}

{* info image thumb with fallback *}
{set $info_path = $block.info_image ? (($block.info_image | substr : 0 : 4) == 'http' ? $block.info_image : ((($block.info_image | substr : 0 : 1) == '/') ? $block.info_image : '/' ~ $block.info_image)) : ''}
{if $info_path && (($info_path | substr : 0 : 4) != 'http') && !('@FILE snippets/fileExists.php' | snippet : ['input' => $info_path])}
  {set $info_trimmed = ($info_path | substr : 0 : 1) == '/' ? ($info_path | substr : 1) : $info_path}
  {set $info_path = '/assets/' ~ $info_trimmed}
{/if}
{set $info_img = $info_path && (($info_path | substr : 0 : 4) != 'http') ? ('phpthumbon' | snippet : ['input' => $info_path, 'options' => '&w=620&h=420&zc=1']) : $info_path}
{if $info_img && ($info_img | contains : 'noimage_')}
  {set $info_img = $info_path}
{/if}

{* table image thumb with fallback *}
{set $table_path = $block.table_image ? (($block.table_image | substr : 0 : 4) == 'http' ? $block.table_image : ((($block.table_image | substr : 0 : 1) == '/') ? $block.table_image : '/' ~ $block.table_image)) : ''}
{if $table_path && (($table_path | substr : 0 : 4) != 'http') && !('@FILE snippets/fileExists.php' | snippet : ['input' => $table_path])}
  {set $table_trimmed = ($table_path | substr : 0 : 1) == '/' ? ($table_path | substr : 1) : $table_path}
  {set $table_path = '/assets/' ~ $table_trimmed}
{/if}
{set $table_img = $table_path && (($table_path | substr : 0 : 4) != 'http') ? ('phpthumbon' | snippet : ['input' => $table_path, 'options' => '&w=540&h=480&zc=1']) : $table_path}
{if $table_img && ($table_img | contains : 'noimage_')}
  {set $table_img = $table_path}
{/if}

  <section class="services">
    {if $block.banner_bg || $block.banner_image || $block.banner_button_text}
      <div class="services-banner section">
        {set $banner_bg_style = $banner_src ? "background-image:url('{$banner_src}');" : ''}
        <div class="services-banner__container" style="{$banner_bg_style}">
          <div class="services-banner__content">
            {if $block.banner_button_text}
              {if $block.banner_button_link}
                <a class="btn btn_style_base services-banner__btn" data-fancybox="" href="{$block.banner_button_link}">{$block.banner_button_text}</a>
              {else}
                <a class="btn btn_style_base services-banner__btn" data-fancybox="" href="#callback" data-fancybox>{$block.banner_button_text}</a>
              {/if}
            {/if}
          </div>
          {if $block.banner_image}
            <div class="services-banner__media">
              <div class="services-banner__bg">
                <img src="{$banner_image ?: $block.banner_image}" alt="">
              </div>
              <div class="services-banner__picture">
                <img src="{$banner_image ?: $block.banner_image}" alt="">
              </div>
            </div>
          {/if}
        </div>
      </div>
    {/if}

    {if $block.info_title || $block.info_text || $info_list || $block.info_image}
      <div class="services-info section">
        <div class="services-info__container">
          <div class="services-info__content">
            {if $block.info_title || $block.info_text}
              <div class="services-info__lead">
                {if $block.info_title}
                  <div class="services-info__title">{$block.info_title}</div>
                {/if}
                {if $block.info_text}
                  <div class="services-info__text">{$block.info_text}</div>
                {/if}
              </div>
            {/if}
            {if $block.info_list_title || $info_list}
              <div class="services-info__list-block">
                {if $block.info_list_title}
                  <div class="services-info__list-title">{$block.info_list_title}</div>
                {/if}
                {if $info_list}
                  <ul class="services-info__list">
                    {foreach $info_list as $item}
                      {if $item | trim}
                        <li>{$item}</li>
                      {/if}
                    {/foreach}
                  </ul>
                {/if}
              </div>
            {/if}
            {if $block.info_button_text}
              {if $block.info_button_link}
                <a class="btn btn_style_trans services-info__btn" data-fancybox="" href="{$block.info_button_link}">{$block.info_button_text}</a>
              {else}
                <a class="btn btn_style_trans services-info__btn" data-fancybox="" href="#callback" data-fancybox>{$block.info_button_text}</a>
              {/if}
            {/if}
          </div>
          {if $block.info_image}
            <div class="services-info__media">
              <img src="{$info_img ?: $block.info_image}" alt="">
            </div>
          {/if}
        </div>
      </div>
    {/if}

    {if $block.table_title || $block.table_raw || $table_rows || $table_columns}
      <div class="services-table section">
        <div class="services-table__container">
          {if $block.table_image}
            <div class="services-table__media">
              <img src="{$table_img ?: $block.table_image}" alt="">
            </div>
          {/if}
          <div class="services-table__content">
            {if $block.table_title}
              <div class="services-table__title">{$block.table_title}</div>
            {/if}
            {if $block.table_note}
              <div class="services-table__note">{$block.table_note}</div>
            {/if}
            <div class="services-table__wrapper">
              {if $block.table_raw}
                {$block.table_raw}
              {elseif $table_columns || $table_rows}
                <table class="services-table__table">
                  {if $table_columns}
                    <thead>
                      <tr>
                        {foreach $table_columns as $col}
                          {if $col | trim}
                            <th>{$col}</th>
                          {/if}
                        {/foreach}
                      </tr>
                    </thead>
                  {/if}
                  {if $table_rows}
                    <tbody>
                      {foreach $table_rows as $row}
                        {if $row}
                          <tr>
                            {foreach $row as $cell}
                              <td>{$cell}</td>
                            {/foreach}
                          </tr>
                        {/if}
                      {/foreach}
                    </tbody>
                  {/if}
                </table>
              {/if}
            </div>
          </div>
        </div>
      </div>
    {/if}

    {if $works_gallery}
      <div class="services-works section">
        <div class="services-works__container">
          <div class="services-works__head">
            <div class="services-works__title">{$works_title}</div>
            <div class="services-works__nav">
              <div class="swiper-button-prev services-works__arrow services-works-button-prev"></div>
              <div class="swiper-button-next services-works__arrow services-works-button-next"></div>
            </div>
          </div>
          <div class="services-works__slider">
            <div class="swiper">
              <div class="swiper-wrapper">
                {foreach $works_gallery as $work}
                  {if $work}
                    {set $work_raw = $work.image | trim}
                    {set $work_image = ''}
                    {if $work_raw}
                      {if (($work_raw | substr : 0 : 4) == 'http')}
                        {set $work_image = $work_raw}
                      {elseif ($work_raw | substr : 0 : 1) == '/'}
                        {set $work_image = $work_raw}
                      {else}
                        {set $work_image = '/' ~ $work_raw}
                      {/if}
                    {/if}
                    {if $work_image && (($work_image | substr : 0 : 4) != 'http')}
                      {set $work_trimmed = ($work_image | substr : 0 : 1) == '/' ? ($work_image | substr : 1) : $work_image}
                      {if !('@FILE snippets/fileExists.php' | snippet : ['input' => $work_image]) && ('@FILE snippets/fileExists.php' | snippet : ['input' => '/assets/' ~ $work_trimmed])}
                        {set $work_image = '/assets/' ~ $work_trimmed}
                      {/if}
                    {/if}
                    {set $work_src = $work_image}
                    {if $work_image && (($work_image | substr : 0 : 4) != 'http')}
                      {set $tmp_thumb = 'phpthumbon' | snippet : ['input' => $work_image, 'options' => '&w=360&h=220&zc=1']}
                      {if $tmp_thumb && !($tmp_thumb | contains : 'noimage_')}
                        {if (($tmp_thumb | substr : 0 : 4) == 'http') || ($tmp_thumb | contains : '/')}
                          {set $work_src = $tmp_thumb}
                        {/if}
                      {/if}
                    {/if}
                    {if $work_src && (($work_src | trim) == '1')}
                      {set $work_src = $work_image}
                    {/if}
                    {if $work_src && (($work_src | substr : 0 : 4) != 'http') && !($work_src | contains : '/')}
                      {set $work_src = $work_image}
                    {/if}
                    {if $work_src && (($work_src | trim) == '1')}
                      {set $work_src = ''}
                    {/if}
                    {if $work_image || $work.title}
                      <div class="swiper-slide">
                        {if $work.link}
                          <a class="services-works__card" href="{$work.link}">
                        {else}
                          <div class="services-works__card">
                        {/if}
                            {if $work_src}
                              <div class="services-works__image">
                                <img src="{$work_src}" alt="{$work.title ?: 'Работа'}">
                              </div>
                            {/if}
                            {if $work.title}
                              <div class="services-works__caption">{$work.title}</div>
                            {/if}
                        {if $work.link}
                          </a>
                        {else}
                          </div>
                        {/if}
                      </div>
                    {/if}
                  {/if}
                {/foreach}
              </div>
            </div>
          </div>
        </div>
      </div>
    {/if}

    {if $block.reviews_title || $block.reviews_text || $reviews_gallery}
      <div class="services-feedback section">
        <div class="services-feedback__container">
          <div class="services-feedback__content">
            {if $block.reviews_title}
              <div class="services-feedback__title">{$block.reviews_title}</div>
            {/if}
            {if $block.reviews_text}
              <div class="services-feedback__text">{$block.reviews_text}</div>
            {/if}
            {set $form_btn_text = $block.reviews_button_text ?: 'Отправить заявку'}
            {'!AjaxForm' | snippet : [
              'snippet' => 'FormIt',
              'form' => '@FILE chunks/services/feedback-form.tpl',
              'hooks' => 'check_words_and_links,create_request,create_bitrix_lead',
              'customValidators' => 'checkPhone,check_request',
              'validate' => 'PHONE:required:checkPhone:check_request,NAME:required',
              'validationErrorMessage' => 'В форме содержатся ошибки!',
              'successMessage' => 'Сообщение успешно отправлено',
              'placeholderPrefix' => '',
              'form_btn_text' => $form_btn_text
            ]}
          </div>
          {if $reviews_gallery}
            <div class="services-feedback__gallery">
              {foreach $reviews_gallery as $img}
                {if $img | trim}
                  {set $thumb = 'phpthumbon' | snippet : ['input' => $img, 'options' => '&w=270&h=180&zc=1']}
                  <div class="services-feedback__gallery-item">
                    <img src="{$img}" alt="">
                  </div>
                {/if}
              {/foreach}
            </div>
          {/if}
        </div>
      </div>
    {/if}

    {if $showroom_title || $showroom_subtitle || $showroom_cards || $showroom_image || $showroom_btn_text}
      <section class="services-showroom section">
        <div class="services-showroom__container">
          <div class="services-showroom__content">
            {if $showroom_title}
              <div class="services-showroom__title">{$showroom_title}</div>
            {/if}
            {if $showroom_subtitle}
              <div class="services-showroom__subtitle">{$showroom_subtitle}</div>
            {/if}
            {if $showroom_cards}
              <div class="services-showroom__cards">
                {foreach $showroom_cards as $card}
                  {if $card}
                    {set $card_icon_raw = $card.icon | trim}
                    {set $card_icon = ''}
                    {if $card_icon_raw}
                      {if (($card_icon_raw | substr : 0 : 4) == 'http')}
                        {set $card_icon = $card_icon_raw}
                      {elseif ($card_icon_raw | substr : 0 : 1) == '/'}
                        {set $card_icon = $card_icon_raw}
                      {else}
                        {set $card_icon = '/' ~ $card_icon_raw}
                      {/if}
                    {/if}
                    {if $card_icon && (($card_icon | substr : 0 : 4) != 'http')}
                      {set $card_trimmed = ($card_icon | substr : 0 : 1) == '/' ? ($card_icon | substr : 1) : $card_icon}
                      {if !('@FILE snippets/fileExists.php' | snippet : ['input' => $card_icon]) && ('@FILE snippets/fileExists.php' | snippet : ['input' => '/assets/' ~ $card_trimmed])}
                        {set $card_icon = '/assets/' ~ $card_trimmed}
                      {/if}
                    {/if}
                    {set $card_icon_src = $card_icon}
                    {if $card_icon && (($card_icon | substr : 0 : 4) != 'http')}
                      {set $tmp_card_thumb = 'phpthumbon' | snippet : ['input' => $card_icon, 'options' => '&w=64&h=64&zc=1']}
                      {if $tmp_card_thumb && !($tmp_card_thumb | contains : 'noimage_')}
                        {if (($tmp_card_thumb | substr : 0 : 4) == 'http') || ($tmp_card_thumb | contains : '/')}
                          {set $card_icon_src = $tmp_card_thumb}
                        {/if}
                      {/if}
                    {/if}
                    {if $card_icon_src && (($card_icon_src | trim) == '1')}
                      {set $card_icon_src = $card_icon}
                    {/if}
                    {if $card_icon_src && (($card_icon_src | substr : 0 : 4) != 'http') && !($card_icon_src | contains : '/')}
                      {set $card_icon_src = $card_icon}
                    {/if}
                    {if $card_icon_src && (($card_icon_src | trim) == '1')}
                      {set $card_icon_src = ''}
                    {/if}
                    {set $card_icon_render = $card_icon_src ?: $card_icon}
                    <div class="services-showroom__card">
                      {if $card_icon_render}
                        <div class="services-showroom__card-icon">
                          <img src="{$card_icon_render}" alt="{$card.title ?: 'Иконка'}">
                        </div>
                      {/if}
                      {if $card.title}
                        <div class="services-showroom__card-title">{$card.title}</div>
                      {/if}
                      {if $card.text}
                        <div class="services-showroom__card-text">{$card.text}</div>
                      {/if}
                    </div>
                  {/if}
                {/foreach}
              </div>
            {/if}
            
          </div>
          {if $showroom_image}
            <div class="services-showroom__media">
              <img src="{$showroom_img ?: $showroom_image}" alt="">
              {if $showroom_btn_text}
                {if $showroom_btn_link}
                  <a class="btn btn_style_trans services-showroom__btn" href="{$showroom_btn_link}">{$showroom_btn_text}</a>
                {else}
                  <a class="btn btn_style_trans services-showroom__btn" data-fancybox href="#callback">{$showroom_btn_text}</a>
                {/if}
              {/if}
            </div>
          {/if}
        </div>
      </section>
    {/if}
  </section>
{/if}
