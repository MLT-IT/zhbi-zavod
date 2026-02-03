{set $trs = [
    ['title'=>'Машина до 1,5 тн до 18 м3', 'max'=>'4',  'cost'=>'от 2 200 ₽', 'style'=>''],
    ['title'=>'Машина до 2,5 тн до 32 м3', 'max'=>'6',  'cost'=>'от 3 000 ₽', 'style'=>''],
    ['title'=>'Машина до 5 тн до 35 м3',   'max'=>'6',  'cost'=>'от 4 000 ₽', 'style'=>''],
    ['title'=>'Машина до 10 тн до 37 м3',  'max'=>'8',  'cost'=>'от 6 000 ₽', 'style'=>''],
    ['title'=>'Машина до 20 тн до 80 м3',  'max'=>'13,5','cost'=>'от 10 500 ₽','style'=>'border-bottom:3px solid #c9c9c9'],
    ['title'=>'Манипулятор до 5 тн',       'max'=>'6',  'cost'=>'от 7 000 ₽', 'style'=>''],
    ['title'=>'Манипулятор до 10 тн',      'max'=>'8',  'cost'=>'от 13 000 ₽','style'=>''],
    ['title'=>'Манипулятор до 20 тн',      'max'=>'14', 'cost'=>'от 16 000 ₽','style'=>'']
]}


<table class="table-simple {if $is_shadow}base-box-shadow{/if}">
  <thead>
    <tr>
      <th>Способ доставки</th>
      <th>MAX длина груза, м</th>
      <th>Стоимость доставки</th>
    </tr>
  </thead>
  <tbody>
    {foreach $trs as $tr}
    <tr style="{$tr.style}">
      <td>{$tr.title}</td>
      <td>{$tr.max}</td>
      <td>{$tr.cost}</td>
    </tr>
    {/foreach}
  </tbody>
</table>

{if $is_callback_btn}
<div class="d-flex justify-center mt-24">
  <button
    class="btn btn-primary"
    onclick="modals.events.open('modal-callback')"
  >
    Заказать с доставкой
  </button>
</div>
{/if}