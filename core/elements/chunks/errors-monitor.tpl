<div class="errors-monitor">
  <br><br><br><b>logs</b><br><br>
  {$_modx->getInfo('', true, '@INLINE {$key} => {$value} <br>')}</code>

  {if $_modx->getPlaceholder("config.errors")}
    <br>
    <ul>
      <li><b>Пустые конфиги core/config/placeholders/</b></li>
      {foreach $_modx->getPlaceholder("config.errors") as $error}
        <li>{$error}</li>
      {/foreach}
    </ul>
  {/if}
</div>