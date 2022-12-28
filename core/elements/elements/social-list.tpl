{switch $_modx->resource.context_key}
    {case 'pro-fanera'}
        {set $vk = 'https://vk.com/profanera'}
    {case 'krovlya'}
        {set $vk = 'https://vk.com/krovlyasp'}
    {case 'fasady-pro'}
        {set $vk = 'https://vk.com/fasady_pro'}
    {case 'fasad'}
        {set $vk = 'https://vk.com/mirfasad'}
    {case 'rockwool'}
        {set $vk = 'https://vk.com/minvata_termo'}
    {case 'paroc'}
        {set $vk = 'https://vk.com/minvatapro'}
    {case 'tn'}
        {set $vk = 'https://vk.com/prominvata'}
    {case 'ursa'}
        {set $vk = 'https://vk.com/minvataspb'}
    {case 'penoplex'}
        {set $vk = 'https://vk.com/plityepps'}
    {case 'isover'}
        {set $vk = 'https://vk.com/minvata178'}
    {case 'web'}
        {set $vk = 'https://vk.com/minvata_78'}
    {case 'pilomat'}
        {set $vk = 'https://vk.com/pilomatpro'}
    {case 'plitaosb'}
        {set $vk = 'https://vk.com/plitaosb'}
    {case 'kirpich-m'}
        {set $vk = 'https://vk.com/kirpichm_pro'}
{/switch}

{if ($insta is not empty) || ($vk is not empty) || ($yt is not empty) || ($fb is not empty)}
  <div class="footer__social">
      <div class="footer__nav-block-title">Мы в соц. сетях</div>
      <div class="footer__social-list">
          {if $insta ?}
              <a href="{$insta}" target="_blank">
                  <svg class="svg icon-inst" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-inst"></use>
                  </svg>
              </a>
          {/if}
          {if $vk ?}
              <a href="{$vk}" target="_blank">
                  <svg class="svg icon-vk" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-vk"></use>
                  </svg>
              </a>
          {/if}
          {if $yt ?}
              <a href="{$yt}" target="_blank">
                  <svg class="svg icon-yt" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-yt"></use>
                  </svg>
              </a>
          {/if}
          {if $fb ?}
              <a href="{$fb}" target="_blank">
                  <svg class="svg icon-face" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
                      <use xlink:href="{$_modx->config['template_path']}img/svg-sprite.svg#icon-face"></use>
                  </svg>
              </a>
          {/if}
      </div>
  </div>
{/if}
