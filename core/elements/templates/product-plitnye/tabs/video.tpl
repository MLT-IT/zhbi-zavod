          <div class="infoblocks__block" data-tab-page="Видео">
            <button class="infoblocks__block-title" data-tab="Видео">Видео</button>
            <div class="infoblocks__block-dropdown">
              {set $srcs = $video | split}
              {foreach $srcs as $src}
                  <iframe width="100%" height="450" class="lazy" data-src="{$src}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
              {/foreach}
            </div>
          </div>
