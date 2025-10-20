<div class="mm_block_main">
    {foreach $data as $item index=$index}
        <span class="mm_block_main_item" data-category="mm_v2_{$index}">
                {if $item.image}
                    <img class="mm_block_main_item-img" src="{$item.image}">
                {/if}

            {$item.title}
              </span>
    {/foreach}
</div>
<div class="mm_block_cat_blocks_wrapper">
    {foreach $data as $item index=$index}
        <div class="mm_block_inner" id="mm_v2_{$index}">
            <div class="mm_block-inner_groups">
                <div class="mm_block-inner_group">
                    <a href="{$item.link}" class="mm_block-inner_group-title">{$item.title}</a>
                    <div class="mm_block-inner_group-linkwrapper {if empty($item.customClass)}type_1 {else} {$item.customClass}{/if} ">
                        {foreach $item.children as $itemChild}

                                {if empty($item.customClass)}
                                    <a class="mm_block-inner_group-linkitem" href="{$itemChild.link}">
                                    <div class="img_wrapper"><img src="{$itemChild.image}"></div>
                                    <div class="txt_wrapper">
                                        {$itemChild.title}
                                    </div>
                                    </a>
                                    {elseif $item.customClass == "type_3"}
                                    <a href="{$itemChild.link}">
                                        <div class="txt_wrapper">
                                            {$itemChild.title}
                                        </div>
                                    </a>
                                {/if}



                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
    {*<div class="mm_block_inner" id="mm_v2_1">
        <div class="mm_block-inner_groups">
            <div class="mm_block-inner_group">
                <a href="/kollekcziya-texas/" class="mm_block-inner_group-title">Коллекция Texas</a>
                <div class="mm_block-inner_group-linkwrapper type_1">
                    <a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/sostavnaya-krepezhnaya-planka/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/sostavnaya-krepezhnaya-planka.jpg"></div>
                        <div class="txt_wrapper">Составная крепежная планка</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/kryishki/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/kryishki.jpg"></div>
                        <div class="txt_wrapper">Крышки</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/lameli-liczevyie/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/lameli-liczevyie.jpg">
                        </div>
                        <div class="txt_wrapper">Ламели лицевые</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/lameli-obratnyie/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/lameli-obratnyie.jpg">
                        </div>
                        <div class="txt_wrapper">Ламели обратные</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/nashhelniki-dlya-kalitok-i-vorot/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/nashhelniki-dlya-kalitok-i-vorot.jpg"></div>
                        <div class="txt_wrapper">Нащельники для калиток и ворот</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/stojki-dlya-kalitok/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/stojki-dlya-kalitok.jpg"></div>
                        <div class="txt_wrapper">Стойки для калиток</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/stojki/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/stojki.jpg"></div>
                        <div class="txt_wrapper">Стойки</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/krepezhnyij-vkladyish/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/krepezhnyij-vkladyish.jpg"></div>
                        <div class="txt_wrapper">Крепежный вкладыш</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-texas/kalitki-i-vorota/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/kalitki-i-vorota.jpg">
                        </div>
                        <div class="txt_wrapper">Калитки и ворота</div>
                    </a></div>
            </div>
        </div>
    </div>
    <div class="mm_block_inner" id="mm_v2_2">
        <div class="mm_block-inner_groups">
            <div class="mm_block-inner_group">
                <a href="/kollekcziya-tokyo/" class="mm_block-inner_group-title">Коллекция Tokyo</a>
                <div class="mm_block-inner_group-linkwrapper type_1">
                    <a class="mm_block-inner_group-linkitem" href="/kollekcziya-tokyo/krepezhnyij-vkladyish/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/krepezhnyij-vkladyish.jpg"></div>
                        <div class="txt_wrapper">Крепежный вкладыш</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-tokyo/lameli/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/lameli-tokyo.jpg"></div>
                        <div class="txt_wrapper">Ламели</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-tokyo/shablonyi-dlya-montazha/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/shablonyi-dlya-montazha.jpg"></div>
                        <div class="txt_wrapper">Шаблоны для монтажа</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-tokyo/dekorativnaya-nakladka-na-stolb-uglovaya/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/dekorativnaya-nakladka-na-stolb-uglovaya-tokyo.jpg">
                        </div>
                        <div class="txt_wrapper">Декоративная накладка на столб угловая</div>
                    </a></div>
            </div>
        </div>
    </div>
    <div class="mm_block_inner" id="mm_v2_3">
        <div class="mm_block-inner_groups">
            <div class="mm_block-inner_group">
                <a href="/kollekcziya-palermo/" class="mm_block-inner_group-title">Коллекция Palermo</a>
                <div class="mm_block-inner_group-linkwrapper type_1">
                    <a class="mm_block-inner_group-linkitem" href="/kollekcziya-palermo/lameli/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/lameli-palermo.jpg">
                        </div>
                        <div class="txt_wrapper">Ламели</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-palermo/planka-opornaya-sostavnaya-vneshnyaya/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/planka-opornaya-sostavnaya-vneshnyaya.jpg">
                        </div>
                        <div class="txt_wrapper">Планка опорная составная внешняя</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/kollekcziya-palermo/kalitki-i-vorota/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/kalitki-i-vorota-palermo.jpg"></div>
                        <div class="txt_wrapper">Калитки и ворота</div>
                    </a></div>
            </div>
        </div>
    </div>
    <div class="mm_block_inner" id="mm_v2_4">
        <div class="mm_block-inner_groups">
            <div class="mm_block-inner_group">
                <a href="/zapolnenie-shtaketnikom/" class="mm_block-inner_group-title">Заполнение штакетником</a>
                <div class="mm_block-inner_group-linkwrapper type_1">
                    <a class="mm_block-inner_group-linkitem" href="/zapolnenie-shtaketnikom/dekorativnyie-nakladki/">
                        <div class="img_wrapper">
                            <img src="/assets/template/img/menu-images/dekorativnyie-nakladki.jpg"></div>
                        <div class="txt_wrapper">Декоративная накладка</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/zapolnenie-shtaketnikom/kryishki/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/kryishki.jpg"></div>
                        <div class="txt_wrapper">Крышки</div>
                    </a><a class="mm_block-inner_group-linkitem" href="/zapolnenie-shtaketnikom/planki/">
                        <div class="img_wrapper"><img src="/assets/template/img/menu-images/planki.jpg"></div>
                        <div class="txt_wrapper">Планки</div>
                    </a></div>
            </div>
        </div>
    </div>
    <div class="mm_block_inner active" id="mm_v2_5">
        <div class="mm_block-inner_groups">
            <div class="mm_block-inner_group"><a href="/stolbyi/" class="mm_block-inner_group-title">Столбы</a>
                <div class="mm_block-inner_group-linkwrapper type_3">
                    <a href="/stolbyi/stolb-62h55h1-4h1500-ral-3005/">
                        <div class="txt_wrapper">62х55х1,4х1500
                            <span data-val="RAL 3005" class="color-label">RAL 3005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h1700-ral-3005/">
                        <div class="txt_wrapper">62х55х1,4х1700
                            <span data-val="RAL 3005" class="color-label">RAL 3005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h2000-ral-3005/">
                        <div class="txt_wrapper">62х55х1,4х2000
                            <span data-val="RAL 3005" class="color-label">RAL 3005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h1700-ral-8017/">
                        <div class="txt_wrapper">62х55х1,4х1700
                            <span data-val="RAL 8017" class="color-label">RAL 8017</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h2000-ral-8017/">
                        <div class="txt_wrapper">62х55х1,4х2000
                            <span data-val="RAL 8017" class="color-label">RAL 8017</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h4000-ral-8017/">
                        <div class="txt_wrapper">62х55х1,4х4000
                            <span data-val="RAL 8017" class="color-label">RAL 8017</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h4000-ral-6005/">
                        <div class="txt_wrapper">62х55х1,4х4000
                            <span data-val="RAL 6005" class="color-label">RAL 6005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h4500-ral-6005/">
                        <div class="txt_wrapper">62х55х1,4х4500
                            <span data-val="RAL 6005" class="color-label">RAL 6005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h1700-ral-6005/">
                        <div class="txt_wrapper">62х55х1,4х1700
                            <span data-val="RAL 6005" class="color-label">RAL 6005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h3500-rr-32/">
                        <div class="txt_wrapper">62х55х1,4х3500
                            <span data-val="RR 32" class="color-label">RR 32</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h4500-zn/">
                        <div class="txt_wrapper">62х55х1,4х4500 Zn</div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h1680-treugolnyy-flanec-ral-8017-mo-001-12-50-0/">
                        <div class="txt_wrapper">62х55х1,4х1680 треугольный фланец
                            <span data-val="RAL 8017" class="color-label">RAL 8017</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h1680-usilennyy-pryamougolnyy-flanec-230h230-ral-6005-mo-003-12-10-0/">
                        <div class="txt_wrapper">62х55х1,4х1680 усиленный прямоугольный фланец 230х230
                            <span data-val="RAL 6005" class="color-label">RAL 6005</span></div>
                    </a><a href="/stolbyi/stolb-62h55h1-4h2465-usilennyy-pryamougolnyy-flanec-160h180-ral-8017-mo-004-12-10-0-01/">
                        <div class="txt_wrapper">62х55х1,4х2465 усиленный прямоугольный фланец 160х180
                            <span data-val="RAL 8017" class="color-label">RAL 8017</span></div>
                    </a></div>
            </div>
        </div>
    </div>*}
</div>
