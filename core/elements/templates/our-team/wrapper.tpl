{extends "file:layouts/default.layout.tpl"} 
{block "page"} 
  <main class="layout__main"> 
  {include "file:chunks/breadcrumbs/breadcrumbs.tpl"} 
  <section class="section section_view_bg">
    <div class="our-team__container">
      <h2 class="margin-bottom-md section__title">{$_modx->resource.pagetitle}</h2>
      <div class="content"> {$_modx->resource.content} </div>
      <div class="our-team">
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <img src="/assets/images/zbi500/team/gendir.jpg" alt="">
            <div class="team-card__title">
              <h3>Генеральный директор</h3>
              <p>Козырев Александр Дмитриевич</p>
            </div>
          </div>
          <div class="team-card__details">
            <p> Александр Дмитриевич готов помочь Вам в нестандартной ситуации, готов проконсультировать по товару и его
              наличию, приехать на переговоры, оперативно подписать договоры и спецификации. </p>
          </div>
        </div>
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <div class="team-card__title">
              <h3>Отдел продаж Краснодар</h3>
              <p>Руководитель отдела: Надежда Спецова</p>
            </div>
          </div>
          <div class="team-card__details">
            <p> Мы подробно консультируем клиентов, помогаем подобрать оптимальные решения и оформить заказ. Наша
              команда гибко подходит к ценообразованию и условиям оплаты, чтобы сделать сотрудничество максимально
              выгодным для заказчика. Мы также контролируем исполнение договоров и оперативно решаем возникающие
              вопросы. </p>
          </div>
        </div>
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <img src="/assets/images/zbi500/team/dolly.png" alt="">
            <div class="team-card__title">
              <h3>Отдел закупок</h3>
              <p>Руководитель отдела: Глеб Кузьмичев</p>
            </div>
          </div>
          <div class="team-card__details">
            <p>Отдел закупок отвечает за планирование и обеспечение производственных нужд. Мы заключаем выгодные договоры с надежными поставщиками, организуем логистику и управляем складскими запасами, чтобы завод работал непрерывно и эффективно.</p>
          </div>
        </div>
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <img src="/assets/images/zbi500/team/calculate.png" alt="">
            <div class="team-card__title">
              <h3>Отдел бухгалтерии</h3>
              <p>Главный бухгалтер: Нина Петровна Жилина</p>
            </div>
          </div>
          <div class="team-card__details">
            <p>Сотрудники бухгалтерии обеспечивают правильность и своевременность всех расчетов, начислений и платежей, необходимых для бесперебойной работы предприятия. </p>
          </div>
        </div>
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <img src="/assets/images/zbi500/team/factory.png" alt="">
            <div class="team-card__title">
              <h3>Производство</h3>
              <p>Начальник производства: Олег Юрьевич Семашко</p>
            </div>
          </div>
          <div class="team-card__details">
            <p>Олег Юрьевич обеспечивает бесперебойную работу наших производств. Являясь специалистом в своем деле и обладая многолетним опытом руководства производством ЖБИ и бетонными заводами, он стал опорой и гарантом успеха компании на строительном рынке Санкт-Петербурга и Ленинградской области.</p>
          </div>
        </div>
        <div class="our-team__card team-card">
          <div class="team-card__head">
            <img src="/assets/images/zbi500/team/logistic.png" alt="">
            <div class="team-card__title">
              <h3>Отдел логистики</h3>
              <p>Начальник отдела: Дмитрий Кармазин</p>
            </div>
          </div>
          <div class="team-card__details">
            <p>Осуществляет руководство и контроль за выполнением работ по приему, хранению и отпуску сырья и готовой продукции на складах компании с учетом наиболее рационального использования складских площадей, облегчения и ускорения поиска необходимых расходных материалов, оборудования.</p>
          </div>
        </div>
      </div>
    </div>
  </section>
  <section class="section inner">
    <div class="section__container"> 
      {include 'file:sections/our-partners/wrapper.tpl'} 
      {include 'file:sections/benefits/wrapper.tpl'}
    </div>
  </section>
</main> 
{/block}
