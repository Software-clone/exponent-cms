{*
 * Copyright (c) 2004-2015 OIC Group, Inc.
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

 <div id="discountconfig" class="module discountconfig configure">
    <h1>{'Edit Discount'|gettext}</h1>
    <div id="mainform">
        {form action=update_discount}
            {control type="hidden" name="id" value=$discount->id}
            <div id="discounttabs" class="">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#tab1" role="tab" data-toggle="tab"><em>{"General"|gettext}</em></a></li>
                    <li role="presentation"><a href="#tab2" role="tab" data-toggle="tab"><em>{"Usage"|gettext}</em></a></li>
                    <li role="presentation"><a href="#tab3" role="tab" data-toggle="tab"><em>{"Conditions"|gettext}</em></a></li>
                    <li role="presentation"><a href="#tab4" role="tab" data-toggle="tab"><em>{"Actions"|gettext}</em></a></li>
                </ul>
                <div class="tab-content">
                    <div id="tab1" role="tabpanel" class="tab-pane fade in active">
                        <h2>{"General Configuration"|gettext}</h2>
                        {control type="text" name="title" label="Name"|gettext value=$discount->title focus=1}
                        {control type="text" name="coupon_code" label="Coupon Code"|gettext value=$discount->coupon_code}
                        {control type="editor" name="body" label="Description"|gettext height=250 value=$discount->body}
                        {*control type="text" name="priority" label="Priority"|gettext value=$discount->priority*}
                    </div>
                     <div id="tab2" role="tabpanel" class="tab-pane fade">
                        <h2>{"Usage Rules"|gettext}</h2>
                        {* control type="text" name="uses_per_coupon" label="Uses Per Coupon"|gettext value=$discount->uses_per_coupon}
                        {control type="text" name="uses_per_user" label="Uses Per Customer"|gettext value=$discount->uses_per_user *}
                        {control type="checkbox" name="never_expires" label="Offer Never Expires"|gettext value=1 checked=$discount->never_expires}
                        {control type="datetimecontrol" name="startdate" label="Valid From"|gettext value=$discount->startdate showtime=false}
                        {control type="datetimecontrol" name="startdate_time" label=" " value=$discount->startdate_time showdate=false}
                        {control type="datetimecontrol" name="enddate" label="Valid To"|gettext value=$discount->enddate showtime=false}
                        {control type="datetimecontrol" name="enddate_time" label=" " value=$discount->enddate_time showdate=false}
                        {* control type="checkbox" name="allow_other_coupons" label="All Use of Other Coupons"|gettext value=$discount->allow_other_coupons *}
                        {* control type="radiogroup?" name="apply_before_after_tax" label="All Use of Other Coupons"|gettext value=$discount->allow_other_coupons *}
                        {'If the discount is related to free or discounted shipping, or you simply want to force the shipping method used when this discount is applied, you may force the shipping method used here:'|gettext}
                        {control type="dropdown" name="required_shipping_calculator_id" id="required_shipping_calculator_id" label="Required Shipping Service" includeblank="-- Select a shipping service --"|gettext items=$shipping_services value=$discount->required_shipping_calculator_id}
                        {foreach from=$shipping_methods key=calcid item=methods name=sm}
                            <div id="dd-{$calcid}" class="methods" style="display:none;">
                                {control type="dropdown" name="required_shipping_methods[`$calcid`]" label="Required Shipping Method" items=$methods value=$discount->required_shippng_method}
                            </div>
                        {/foreach}
                    </div>
                    <div id="tab3" role="tabpanel" class="tab-pane fade">
                        <h2>{"Conditions"|gettext}</h2>
                        {* control type="dropdown" name="group_ids[]" label="Groups"|gettext items=$groups default=$selected_groups multiple=true size=10 *}
                        {control type="text" name="minimum_order_amount" label="Minimum Order Amount"|gettext filter=money value=$discount->minimum_order_amount}
                    </div>
                    <div id="tab4" role="tabpanel" class="tab-pane fade">
                        <h2>{"Actions and Amounts"|gettext}</h2>
                        {control type="dropdown" name="action_type" label="Discount Action"|gettext items=$discount->actions default=$discount->action_type}
                        {'If you selected \'Percentage off entire cart\', enter the percentage discount you would like applied with this coupon code here.'|gettext}
                        {control type="text" name="discount_percent" label="Discount Percent"|gettext filter=percent value=$discount->discount_percent}
                        {'If you selected \'Fixed amount off entire cart\', enter dollar amount discount you would like applied with this coupon code here.'|gettext}
                        {control type="text" name="discount_amount" label="Discount Amount"|gettext filter=money value=$discount->discount_amount}
                        {'If you selected \'Fixed amount off shipping\', enter dollar amount you would like discounted off the shipping.'|gettext}
                        {control type="text" name="shipping_discount_amount" label="Shipping Discount Amount"|gettext filter=money value=$discount->shipping_discount_amount}
                    </div>
                </div>
            </div>
            <div class="loadingdiv">{'Loading'|gettext}</div>
            {control type=buttongroup submit="Save Discount"|gettext cancel="Cancel"|gettext}
        {/form}
    </div>
</div>

{script unique="discountedit" yui3mods=1}
{literal}
    YUI(EXPONENT.YUI3_CONFIG).use('node', function(Y) {
        var switchMethods = function () {
            var dd = Y.one('#required_shipping_calculator_id');
            var ddval = dd.get('value');
            if (ddval != '') {
                var methdd = Y.one('#dd-'+ddval);
            }
            var otherdds = Y.all('.methods');

            otherdds.each(function (odds) {
                if (odds.get('id') == 'dd-'+ddval) {
                    odds.setStyle('display', 'block');
                } else {
                    odds.setStyle('display', 'none');
                }
            });
        }
        switchMethods();
        Y.one('#required_shipping_calculator_id').on('change', switchMethods);
    });
{/literal}
{/script}

{*{script unique="authtabs" yui3mods=1}*}
{*{literal}*}
    {*EXPONENT.YUI3_CONFIG.modules.exptabs = {*}
        {*fullpath: EXPONENT.JS_RELATIVE+'exp-tabs.js',*}
        {*requires: ['history','tabview','event-custom']*}
    {*};*}

	 {*YUI(EXPONENT.YUI3_CONFIG).use("get", "exptabs", "node-load","event-simulate", function(Y) {*}
        {*Y.expTabs({srcNode: '#discounttabs'});*}
		{*Y.one('#discounttabs').removeClass('hide');*}
        {*Y.one('.loadingdiv').remove();*}
    {*});*}
{*{/literal}*}
{*{/script}*}

{script unique="tabload" jquery=1 bootstrap="tab,transition"}
{literal}
    $('.loadingdiv').remove();
{/literal}
{/script}