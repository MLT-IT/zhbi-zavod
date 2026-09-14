
{switch $_modx->resource.context_key}
{case 'tagnerud'}
<table class="table__table table-delivery">
  <tbody>
    <tr class="table__row">
      <th class="table__cell">
        <span>Способ доставки</span>
      </th>
      <th class="table__cell">
        <span>Стоимость доставки по Санкт-Петербургу</span>
      </th>
    </tr>
    <tr class="table__row">
      <td class="table__cell"> Самосвал 12 кубов </td>
      <td class="table__cell"> от 1 200 руб </td>
    </tr>
    <tr class="table__row">
      <td class="table__cell"> Самосвал 20 кубов </td>
      <td class="table__cell"> от 1 700 руб </td>
    </tr>
    <tr class="table__row">
      <td class="table__cell"> Самосвал 25 кубов </td>
      <td class="table__cell"> от 1 900 руб </td>
    </tr>
    <tr class="table__row">
      <td class="table__cell"> Самосвал 30 кубов </td>
      <td class="table__cell"> от 2 000 руб </td>
    </tr>
  </tbody>
</table>
{case default}
  <table class="table__table table-delivery">
    <thead>
    <tr class="table__row">
      <td class="table__cell">Способ доставки</td>
      <td class="table__cell">MAX длина груза, м</td>
      <td class="table__cell">Стоимость доставки</td>
    </tr>
    </thead>
    <tbody>
    <tr class="table__row">
      <td class="table__cell">
        Машина до 1,5 тн до 18 м3
        <div class="mobile-block">макс. длина груза 4 м</div>
      </td>
      <td class="table__cell">4</td>
      <td class="table__cell">от 2 200 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Машина до 2,5 тн до 32 м3
        <div class="mobile-block">макс. длина груза 6 м</div>
      </td>
      <td class="table__cell">6</td>
      <td class="table__cell">от 3 000 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Машина до 5 тн до 35 м3
        <div class="mobile-block">макс. длина груза 6 м</div>
      </td>
      <td class="table__cell">6</td>
      <td class="table__cell">от 4 000 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Машина до 10 тн до 37 м3
        <div class="mobile-block">макс. длина груза 8 м</div>
      </td>
      <td class="table__cell">8</td>
      <td class="table__cell">от 6 000 руб</td>
    </tr>
    <tr class="table__row table__row_border_bold">
      <td class="table__cell">
        Машина до 20 тн до 80 м3
        <div class="mobile-block">макс. длина груза 13,5 м</div>
      </td>
      <td class="table__cell">13,5</td>
      <td class="table__cell">от 10 500 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Манипулятор до 5 тн
        <div class="mobile-block">макс. длина груза 6 м</div>
      </td>
      <td class="table__cell">6</td>
      <td class="table__cell">от 7 000 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Манипулятор до 10 тн
        <div class="mobile-block">макс. длина груза 8 м</div>
      </td>
      <td class="table__cell">8</td>
      <td class="table__cell">от 13 000 руб</td>
    </tr>
    <tr class="table__row">
      <td class="table__cell">
        Манипулятор до 20 тн
        <div class="mobile-block">макс. длина груза 13,5 м</div>
      </td>
      <td class="table__cell">14</td>
      <td class="table__cell">от 16 000 руб</td>
    </tr>
    </tbody>
  </table>
{/switch}
