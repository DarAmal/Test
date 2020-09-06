{* Список записей блога *}
<!-- Хлебные крошки /-->
<div itemtype="http://data-vocabulary.org/Breadcrumb" itemscope="" class="breadcrumbs" id="path">
        <a itemprop="url" href="./">Главная</a>
        {foreach from=$category->path item=cat}
        → <a itemprop="url" href="catalog/{$cat->url}">{$cat->name|escape}</a>
        {/foreach}
        {if $brand}
        → <a itemprop="url" href="catalog/{$cat->url}/{$brand->url}">{$brand->name|escape}</a>
        {/if}
        →  {$page->name}               
</div>
<!-- Хлебные крошки #End /-->

<!-- Заголовок /-->
<h1>{$page->name}</h1>


<!-- Статьи /-->
<div class="actions">
	{foreach $posts as $post}
	
		<h3> {$post->date|date} <a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h3>
		<p>{$post->annotation}</p>
	
	{/foreach}


<!-- Статьи #End /-->    

{include file='pagination.tpl'}
</div>          
      <br />    <br />

<!-- Yandex.RTB R-A-140061-1 -->
<div id="yandex_rtb_R-A-140061-1"></div>
<script type="text/javascript">
    (function(w, d, n, s, t) {
        w[n] = w[n] || [];
        w[n].push(function() {
            Ya.Context.AdvManager.render({
                blockId: "R-A-140061-1",
                renderTo: "yandex_rtb_R-A-140061-1",
                async: true
            });
        });
        t = d.getElementsByTagName("script")[0];
        s = d.createElement("script");
        s.type = "text/javascript";
        s.src = "//an.yandex.ru/system/context.js";
        s.async = true;
        t.parentNode.insertBefore(s, t);
    })(this, this.document, "yandexContextAsyncCallbacks");
</script>

   