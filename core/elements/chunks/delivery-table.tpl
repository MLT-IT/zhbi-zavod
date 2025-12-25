{set $trs = [
    ['Машина - до 1,5 тн до 18 м3','4','от 2 200 ₽'],
    ['Машина - до 2,5 тн до 32 м3','6','от 3 000 ₽'],
    ['Машина - до 5 тн до 35 м3','6','от 4 000 ₽'],
    ['Машина - до 10 тн до 37 м3','8','от 6 000 ₽'],
    ['Машина - до 20 тн до 80 м3','13,5','от 10 500 ₽'],
    ['Манипулятор до 5 тн','6','от 7 000 ₽'],
    ['Манипулятор до 10 тн','8','от 13 000 ₽'],
    ['Манипулятор до 20 тн','14','от 16 000 ₽']
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
    <tr>
      <td>{$tr[0]}</td>
      <td>{$tr[1]}</td>
      <td>{$tr[2]}</td>
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