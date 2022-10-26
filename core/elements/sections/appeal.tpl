<section class="appeal">

  <div class="wrapper">
    <h2 class="title-2">Видеообращение директора</h2>
      {switch '!utm' | snippet : ['val' => 'phone']}
        {case '+7 (812) 200-48-39'}
          {set $src = '4cUbAlC22RM'}
        {case '+7 (812) 209-52-89'}
          {set $src = 'g575KnnENJs'}
        {case '+7 (812) 209-52-92'}
          {set $src = 'DvH4AFbTaxs'}
        {default}
          {set $src = '0MzAXoe3D2E'}
      {/switch}

    <div class="lazy-video">
      <a class="lazy-video__link" href="https://youtu.be/{$src}">
        <img src="/assets/images/placeholder.png"
             data-src="https://i.ytimg.com/vi/{$src}/maxresdefault.jpg"
             class="lazy lazy-video__media" alt="">
      </a>
      <button class="lazy-video__button" type="button" aria-label="Запустить видео">
        <svg width="68" height="48" viewBox="0 0 68 48">
          <path class="lazy-video__button-shape"
                d="M66.52,7.74c-0.78-2.93-2.49-5.41-5.42-6.19C55.79,.13,34,0,34,0S12.21,.13,6.9,1.55 C3.97,2.33,2.27,4.81,1.48,7.74C0.06,13.05,0,24,0,24s0.06,10.95,1.48,16.26c0.78,2.93,2.49,5.41,5.42,6.19 C12.21,47.87,34,48,34,48s21.79-0.13,27.1-1.55c2.93-0.78,4.64-3.26,5.42-6.19C67.94,34.95,68,24,68,24S67.94,13.05,66.52,7.74z"></path>
          <path class="lazy-video__button-icon" d="M 45,24 27,14 27,34"></path>
        </svg>
      </button>
    </div>

  </div>
</section>
