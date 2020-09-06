{* Шаблон корзины *}

{$meta_title = "Корзина" scope=parent}
<!-- Хлебные крошки /-->
<div itemtype="http://data-vocabulary.org/Breadcrumb" itemscope="" class="breadcrumbs" id="path">
        <a itemprop="url" href="./">Главная</a>
        {foreach from=$category->path item=cat}
        → <a itemprop="url" href="catalog/{$cat->url}">{$cat->name|escape}</a>
        {/foreach}
        {if $brand}
        → <a itemprop="url" href="catalog/{$cat->url}/{$brand->url}">{$brand->name|escape}</a>
        {/if}
        →  {$product->name|escape}    
        Корзина
                   
</div>
<!-- Хлебные крошки #End /-->

<h1>
{if $cart->purchases}В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}
{else}</h1>
<div style="margin:0 auto; text-align:center; font-size: 18px; line-height:25px;">
<h1 style="font-size:25px;">Корзина пуста!</h1><br />
<img src="design/{$settings->theme|escape}/images/cart-empty.png" title="" alt=""/>
<h3>Вы очистили корзину, в ней пусто<br />— нам от этого очень грустно :-( </h3>
Чтобы добавить товары в корзину, воспользуйтесь<br />
<a href="/products">каталогом нашего магазина</a>. </div>

<br />
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

{/if}


{if $cart->purchases}
<form method="post" name="cart">

{* Список покупок *}
<table id="purchases">

{foreach from=$cart->purchases item=purchase}
<tr>
	{* Изображение товара *}
	<td class="image">
		{$image = $purchase->product->images|first}
		{if $image}
		<a href="products/{$purchase->product->url}"><img src="{$image->filename|resize:50:50}" alt="{$product->name|escape}"></a>
		{/if}
	</td>
	
	{* Название товара *}
	<td class="name">
		<a href="products/{$purchase->product->url}">{$purchase->product->name|escape}</a>
		{$purchase->variant->name|escape}			
	</td>

	{* Цена за единицу *}
	<td class="price">
		{($purchase->variant->price)|convert} {$currency->sign}
	</td>

	{* Количество *}
	<td class="amount">
		<select name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
			{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
			<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index}selected{/if}>{$smarty.section.amounts.index} {$settings->units}</option>
			{/section}
		</select>
	</td>

	{* Цена *}
	<td class="price">
		{($purchase->variant->price*$purchase->amount)|convert}&nbsp;{$currency->sign}
	</td>
	
	{* Удалить из корзины *}
	<td class="remove">
		<a href="cart/remove/{$purchase->variant->id}">
		<img src="design/{$settings->theme}/images/delete.png" title="Удалить из корзины" alt="Удалить из корзины">
		</a>
	</td>
			
</tr>
{/foreach}
{if $user->discount}
<tr>
	<th class="image"></th>
	<th class="name">скидка</th>
	<th class="price"></th>
	<th class="amount"></th>
	<th class="price">
		{$user->discount}&nbsp;%
	</th>
	<th class="remove"></th>
</tr>
{/if}


<tr>
	<th class="image"></th>
	<th class="name"></th>
	<th class="price" colspan="4">
		Итого:
		{$cart->total_price|convert}&nbsp;{$currency->sign}
	</th>
</tr>
</table>


{* Доставка *}
{if $deliveries}
<h2>Выберите способ доставки:</h2>
<ul id="deliveries">
	{foreach $deliveries as $delivery}
	<li>
		<div class="checkbox">
			<input type="radio" name="delivery_id" value="{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if} id="deliveries_{$delivery->id}">
		</div>
		
			<h3>
			<label for="deliveries_{$delivery->id}">
			{$delivery->name}
			{if $cart->total_price < $delivery->free_from && $delivery->price>0}
				({$delivery->price|convert}&nbsp;{$currency->sign})
			{elseif $cart->total_price >= $delivery->free_from}
				(бесплатно)
			{/if}
			</label>
			</h3>
			<div class="description">
			{$delivery->description}
			</div>
	</li>
	{/foreach}
</ul>
{/if}
    
<h2>Адрес получателя</h2>
	
<div class="form cart_form">         
	{if $error}
	<div class="message_error">
		{if $error == 'empty_name'}Введите имя{/if}
		{if $error == 'empty_email'}Введите email{/if}
		{if $error == 'captcha'}Капча введена неверно{/if}
	</div>
	{/if}
	<label>Имя, фамилия</label>
	<input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя"/>
	
	<label>Email</label>
	<input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" />

	<label>Телефон</label>
	<input name="phone" type="text" value="{$phone|escape}" />
	
	<label>Адрес доставки</label> <input id="searchTextField" name="address" type="text" value="{$address|escape}" />

	<label>Комментарий к&nbsp;заказу</label>
	<textarea name="comment" id="order_comment">{$comment|escape}</textarea>
	
	<div class="captcha"><img src="captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/></div> 
	<input class="input_captcha" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
	
	<input type="submit" name="checkout" class="button" value="Оформить заказ">
	</div>
   
</form>
{else}
  <br />
{/if}

{literal}
<script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
<script>
function initialize() {
var input = document.getElementById('searchTextField');
var autocomplete = new google.maps.places.Autocomplete(input);

autocomplete.bindTo('bounds', map);

var infowindow = new google.maps.InfoWindow();
var marker = new google.maps.Marker({
map: map
});
}
google.maps.event.addDomListener(window, 'load', initialize);
</script>
{/literal}