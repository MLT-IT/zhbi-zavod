<section class="appeal">
    <div class="wrapper">
        <h2 class="title-2">Видеообращение директора</h2>
        {switch '!utm' | snippet : ['val' => 'phone']}
            {case '+7 (812) 200-48-39'}
                {set $src = 'https://www.youtube.com/embed/4cUbAlC22RM'}
            {case '+7 (812) 209-52-89'}
                {set $src = 'https://www.youtube.com/embed/g575KnnENJs'}
            {case '+7 (812) 209-52-92'}
                {set $src = 'https://www.youtube.com/embed/DvH4AFbTaxs'}
            {default}
                {set $src = 'https://www.youtube.com/embed/0MzAXoe3D2E'}
        {/switch}

        <iframe class="appeal__iframe" src="{$src}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
</section>
