{extends "file:layouts/base.tpl"}

{block 'page-content'}
{include "file:sections/breadcrumbs/wrapper.tpl"}

<div class="section-margin">
  <div class="container">
    <h1 class="section-title">{$_modx->resource.pagetitle}</h1>

    <div class="free-measurement page-content">
      {if $_modx->resource.introtext}
      <div class="free-measurement__intro">
        {$_modx->resource.introtext}
      </div>
      {/if}

      <div class="free-measurement__actions">
        <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Заказать замер</button>
      </div>

      <blockquote class="free-measurement__quote">
        Замер кровли проводится по стропильной системе. Мы создаем эскиз на каждый сегмент крыши, учитывая
        все скаты. После чего мы предоставляем полный и наглядный план Вашей кровли.
      </blockquote>

      <section class="free-measurement__section">
        <h2>Какие измерения необходимы?</h2>
        <ol class="free-measurement__list">
          <li>Длина ската по коньку и по карнизу, высота от низшей точки карниза до высшей точки конька. Для исключения
            возможных отклонений измеряется диагональ ската.</li>
          <li>Размеры печной трубы, расстояние от ее левого нижнего угла до левой боковой стороны и карниза ската.</li>
          <li>Длина карниза по фронтону, расстояние между карнизами.</li>
          <li>Длина карнизных свесов от стены до края карниза.</li>
          <li>Длина фронтонных свесов от стены до края фронтона.</li>
          <li>Длина примыканий кровли к стенам и элементам крыши.</li>
          <li>Высота дома от земли до высшей точки конька.</li>
          <li>Высота стены от земли до карниза.</li>
        </ol>
      </section>

      <div class="free-measurement__image">
        <img src="/assets/template/images/sections/free-measurement/zamer-1.png" alt="Схема замера кровли"
          width="400" />
      </div>

      <section class="free-measurement__section">
        <h2>Почему важен замер?</h2>
        <ul class="free-measurement__list">
          <li>Ремонт кровли, фасада, фундамента и т.д. не может обойтись без сметы. Для правильного комплектования
            вашего
            объекта необходимыми строительными материалами наш специалист должен обладать всей информацией о размерах
            кровли или
            фасада, особенностях их конструкции и другими важными техническими параметрами.</li>
          <li>Отлично если у вас есть готовый проект с чертежами и размерами, но за частую мы сталкиваемся с иной
            ситуацией!
          </li>
          <li>Самостоятельное составление эскиза подходящего для точного расчета, зачастую не под силу даже людям с
            техническим
            образованием. И это абсолютно нормально, так как вы не сталкиваетесь с данной задачей ежедневно. Как
            следствие не
            точные и не полные измерения приводят к ошибочному расчету.</li>
          <li>Итог - материала не хватает, либо остается слишком много! В первом случае приходится его довозить и
            тратить
            дополнительные средства на доставку, во втором ломать голову, куда деть лишнее. Нередки случаи, когда,
            например, при
            ремонте кровли не задумались о необходимости установки вентиляции или водостоков и проект приходится
            пересматривать.
          </li>
        </ul>
      </section>

      <section class="free-measurement__section">
        <h2>Преимущества профессионального замера от СтройКомплект</h2>
        <ul class="free-measurement__list">
          <li>Бесплатный выезд специалиста;</li>
          <li>Точные и полные измерения объекта, правильно занесенные в технический эскиз;</li>
          <li>Своевременное выявление дефектов объекта, которые нужно учитывать при расчетах;</li>
          <li>Информация о необходимости каких либо дополнительных работ и использования нестандартных аксессуаров;</li>
          <li>Помощь в подборе материала и его презентация;</li>
          <li>Индивидуальная консультация с ответами на ваши вопросы;</li>
        </ul>
      </section>

      <div class="free-measurement__grid">
        <div class="free-measurement__grid-image">
          <img src="/assets/template/images/sections/free-measurement/zamer-2.png" alt="Профессиональный замер"
            width="400" />
        </div>
        <div class="free-measurement__grid-actions">
          <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Заказать замер кровли</button>
          <button class="btn btn-primary" onclick="modals.events.open('modal-callback')">Заказать замер забора</button>
        </div>
      </div>
    </div>
  </div>
</div>

{/block}