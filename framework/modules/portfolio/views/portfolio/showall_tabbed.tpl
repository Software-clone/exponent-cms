{*
 * Copyright (c) 2004-2012 OIC Group, Inc.
 *
 * This file is part of Exponent
 *
 * Exponent is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * GPL: http://www.gnu.org/licenses/gpl.txt
 *
 *}

{uniqueid assign="id"}

{css unique="portfolio" link="`$asset_path`css/portfolio.css"}

{/css}

<div class="module portfolio showall-tabbed">
    {if $moduletitle && !$config.hidemoduletitle}<h1>{$moduletitle}</h1>{/if}
    {permissions}
        <div class="module-actions">
			{if $permissions.create == 1}
				{icon class=add action=edit rank=1 title="Add to the top"|gettext text="Add a Portfolio Piece"|gettext}
			{/if}
            {if $permissions.manage == 1}
                {icon class="manage" controller=expTag action=manage text="Manage Tags"|gettext}
            {/if}
			{if $permissions.manage == 1 && $rank == 1}
				{ddrerank items=$page->records model="portfolio" label="Portfolio Pieces"|gettext}
			{/if}
        </div>
    {/permissions}
    {if $config.moduledescription != ""}
   		{$config.moduledescription}
   	{/if}
    <div id="{$id}" class="yui-navset exp-skin-tabview hide">
        <ul>
            {foreach name=tabs from=$page->cats key=catid item=cat}
                <li><a href="#tab{$smarty.foreach.items.iteration}">{$cat->name}</a></li>
            {/foreach}
        </ul>
        <div>
            {foreach name=items from=$page->cats key=catid item=cat}
                <div id="tab{$smarty.foreach.items.iteration}">
                     {foreach from=$cat->records item=record}
                        {include 'portfolioitem.tpl'}
                    {/foreach}
                </div>
            {/foreach}
        </div>
    </div>
    <div class="loadingdiv">{'Loading'|gettext}</div>
</div>

{script unique="`$id`" yui3mods="1"}
{literal}
	YUI(EXPONENT.YUI3_CONFIG).use('tabview', function(Y) {
	    var tabview = new Y.TabView({srcNode:'#{/literal}{$id}{literal}'});
	    tabview.render();
		Y.one('#{/literal}{$id}{literal}').removeClass('hide');
		Y.one('.loadingdiv').remove();
	});
{/literal}
{/script}
