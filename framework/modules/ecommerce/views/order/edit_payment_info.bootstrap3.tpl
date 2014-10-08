{*
 * Copyright (c) 2004-2014 OIC Group, Inc.
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

<div class="module order edit">
    <div id="editpayment">
        {form action=save_payment_info}
            {control type="hidden" name="id" value=$orderid}
            <div id="editpayment-tabs" class="">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab1" data-toggle="tab"><em>{'Edit Payment Info'|gettext}</em></a></li>
                </ul>
                <div class="tab-content">
                    <div id="tab1" class="tab-pane fade in active">
                        {control type="text" name="result[transId]" label="Payment Reference #"|gettext value=$opts->transId focus=1}
                        {group label="Payment Statuses"|gettext}
                        {foreach from=$opts item=field key=key}
                            {if $key != 'transId'}
                                {control type="text" name="result[`$key`]" label=$key|replace:"_":" "|ucwords value=$field}
                            {/if}
                        {/foreach}
                        {/group}
                        {control type="buttongroup" submit="Save Payment Info"|gettext cancel="Cancel"|gettext}
                    </div>
                </div>
            </div>
            <div class="loadingdiv">{'Loading'|gettext}</div>
        {/form}
    </div>
</div>

{*{script unique="editform" yui3mods=1}*}
{*{literal}*}
    {*EXPONENT.YUI3_CONFIG.modules.exptabs = {*}
        {*fullpath: EXPONENT.JS_RELATIVE+'exp-tabs.js',*}
        {*requires: ['history','tabview','event-custom']*}
    {*};*}

	{*YUI(EXPONENT.YUI3_CONFIG).use('exptabs', function(Y) {*}
        {*Y.expTabs({srcNode: '#editpayment-tabs'});*}
		{*Y.one('#editpayment-tabs').removeClass('hide');*}
		{*Y.one('.loadingdiv').remove();*}
    {*});*}
{*{/literal}*}
{*{/script}*}

{script unique="tabload" jquery=1 bootstrap="tab,transition"}
{literal}
    $('.loadingdiv').remove();
{/literal}
{/script}