<div class="sidebar-banner">
  {* Баннер для заборов *}
  
  {if $_modx->resource.parent in list
    [98281,89532,89533,89534,89535,89825,90130,90470,90471,90664,90889,90890,91057,91430,91431,91537,91645,91693,91772,91829,91846,91866,91881,91982,92097,92113,92214,92305,92430,92522,92600,92682,92773,92853,92854,92855,92992,93173,93337,93412,93413,93570,93709,93737,93785,93786,93791,94073,94630,94901,95069,95140,95152,95463,95808,96081,96082,96107,96135,96157,96178,96203,96216,96239,96255,96257,96306,96308,96311,96374,96410,96444,96453,96463,96533,96627,96641,96650,96712,96721,98282,98283,98420,98554,98706,98880,99057,99219,99393,99590,99725,99865,100016,100167,100168,100409,100642]}
    <a class="btn btn-dark" href="/servisyi-rascheta/raschet-shtaketnika-dlya-zabora/">
        Рассчитать забор
    </a>
    <img
        src="/assets/template/images/sections/sidebar-banner/sidebar-zabor.png"
    />
  {else}
    <a class="btn btn-dark" href="/servisyi-rascheta/raschet-krovli-iz-metallocherepiczyi/">
        Рассчитать кровлю
    </a>
    <img
        src="/assets/template/images/sections/sidebar-banner/sidebar-krovlya.png"
    />
  {/if}
</div>
