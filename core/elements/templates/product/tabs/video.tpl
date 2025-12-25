{set $srcs = $video | split}
{foreach $srcs as $src}
    <iframe width="100%" height="450" src="{$src}" loading="lazy" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
{/foreach}