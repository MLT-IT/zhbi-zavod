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
  {if !$reviews_gallery && $block.reviews_images}
    {set $reviews_gallery = $block.reviews_images | split : '||'}
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
            {if $block.reviews_button_text}
              {if $block.reviews_button_link}
                <a class="btn btn_style_trans services-feedback__submit" data-fancybox="" href="{$block.reviews_button_link}" {if $block.reviews_comment}data-comment="{$block.reviews_comment}"{/if}>{$block.reviews_button_text}</a>
              {else}
                <a class="btn btn_style_trans services-feedback__submit" data-fancybox="" href="#callback" data-fancybox {if $block.reviews_comment}data-comment="{$block.reviews_comment}"{/if}>{$block.reviews_button_text}</a>
              {/if}
            {/if}
          </div>
          {if $reviews_gallery}
            <div class="services-feedback__gallery">
              {foreach $reviews_gallery as $img}
                {if $img | trim}
                  {set $thumb = 'phpthumbon' | snippet : ['input' => $img, 'options' => '&w=270&h=180&zc=1']}
                  <a class="services-feedback__gallery-item" data-fancybox="" href="{$img}" data-fancybox="services-reviews">
                    <img src="{$thumb ?: $img}" alt="">
                  </a>
                {/if}
              {/foreach}
            </div>
          {/if}
        </div>
      </div>
    {/if}
  </section>
{/if}
