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

{css unique="invoice" link="`$smarty.const.PATH_RELATIVE`framework/modules/ecommerce/assets/css/invoice.css"}

{/css}
    
<div>
    <h1>{'Create A New Order'|gettext}</h1>
    <div id="create_new_order">
        {form id=order_item_form name=order_item_form action=save_new_order}
            {'Select the order type, order status, and customer.'|gettext}{br}{br}
            {control type="dropdown" name="order_type_id" label="Order Type:"|gettext frommodel='order_type' focus=1}
            {control type="dropdown" name="order_status_id" label="Order Status:"|gettext frommodel='order_status' orderby='rank'}
            {control type="hidden" id="addresses_id" name="addresses_id"}
            {br}
            <div id="customer_type">
                <input type="radio" id="customer_type1" name="customer_type" value="1" checked=""> {'New Customer'|gettext}{br}
                <input type="radio" id="customer_type2" name="customer_type"  value="2"> {'Existing Customer - Internal'|gettext}{br}
                <input type="radio" id="customer_type3" name="customer_type"  value="3"> {'Existing Customer - External'|gettext}{br}
            {capture assign="callbacks"}
                {literal}

                // the text box for the title
                var tagInput = Y.one('#search_internal');
                var theAddressesId = Y.one('#addresses_id');
                var existingRadio = Y.one('#customer_type2');

                var onRequestData = function( oSelf , sQuery , oRequest) {
                    existingRadio.set('checked',true);
                    tagInput.setStyles({'border':'1px solid green','background':'#fff url('+EXPONENT.PATH_RELATIVE+'framework/core/forms/controls/assets/autocomplete/loader.gif) no-repeat 100% 50%'});
                }

                var onRGetDataBack = function( oSelf , sQuery , oRequest) {
                    tagInput.setStyles({'border':'1px solid #000','backgroundImage':'none'});
                }

                var setProduct = function(e,args) {
                    theAddressesId.set('value',args[2].id);
                    tagInput.set('value',args[2].firstname + ' ' + args[2].middlename + ' ' + args[2].lastname + ' - ' + args[2].email);
                    return true;
                }

                // makes formatResult work mo betta
                oAC.resultTypeList = false;

                oAC.maxResultsDisplayed  = 12;

                // when we start typing...?
                oAC.dataRequestEvent.subscribe(onRequestData);
                oAC.dataReturnEvent.subscribe(onRGetDataBack);

                // format the results coming back in from the query
                oAC.formatResult = function(oResultData, sQuery, sResultMatch) {
                    return oResultData.firstname + ' ' + oResultData.middlename + ' ' + oResultData.lastname + ' - ' + oResultData.email;
                }

                // what should happen when the user selects an item?
                oAC.itemSelectEvent.subscribe(setProduct);

                {/literal}
            {/capture}
            {control type="autocomplete" controller="order" action="search" name="search_internal" value="Search customer name or email" schema="id,firstname,middlename,lastname,organization,email" searchmodel="addresses" searchoncol="firstname,lastnamename,organization,email" jsinject=$callbacks}

            {capture assign="callbacks2"}
                {literal}

                // the text box for the title
                var tagInput = Y.one('#related_items2');
                var theAddressesId = Y.one('#addresses_id');
                var existingRadio = Y.one('#customer_type3');

                var onRequestData = function( oSelf , sQuery , oRequest) {
                    existingRadio.set('checked',true);
                    tagInput.setStyles({'border':'1px solid green','background':'#fff url('+EXPONENT.PATH_RELATIVE+'framework/core/forms/controls/assets/autocomplete/loader.gif) no-repeat 100% 50%'});
                }

                var onRGetDataBack = function( oSelf , sQuery , oRequest) {
                    tagInput.setStyles({'border':'1px solid #000','backgroundImage':'none'});
                }

                var setProduct = function(e,args) {
                    theAddressesId.set('value',args[2].id);
                    tagInput.set('value',args[2].firstname + ' ' + args[2].middlename + ' ' + args[2].lastname + ' - ' + args[2].email);
                    return true;
                }

                // makes formatResult work mo betta
                oAC.resultTypeList = false;

                oAC.maxResultsDisplayed  = 12;

                // when we start typing...?
                oAC.dataRequestEvent.subscribe(onRequestData);
                oAC.dataReturnEvent.subscribe(onRGetDataBack);

                // format the results coming back in from the query
                oAC.formatResult = function(oResultData, sQuery, sResultMatch) {
                    if (oResultData.source == 1) $src = "[SMC]";
                    if (oResultData.source == 2) $src = "[MCP]";
                    if (oResultData.source == 3) $src = "[Amazon]";
                    return oResultData.firstname + ' ' + oResultData.middlename + ' ' + oResultData.lastname + ' - ' + oResultData.email + $src;
                }

                // what should happen when the user selects an item?
                oAC.itemSelectEvent.subscribe(setProduct);

                {/literal}
            {/capture}
            {control type="autocomplete" controller="order" action="search_external" name="related_items2" value="Search other customer name or email" schema="id,source,firstname,middlename,lastname,organization,email" searchmodel="addresses" searchoncol="firstname,lastname,organization,email" jsinject=$callbacks2}
            {br}
            </div>
            <div id="submit_order_item_formControl" class="control buttongroup">
                <input id="submit_order_item_form" class="submit button {button_style}" type="submit" value="Create New Order" />
                <input class="cancel button {button_style}" type="button" value="Cancel" onclick="history.back(1);" />
            </div>
        {/form}
    </div>
</div>

{script unique="neworder" yui3mods="node,node-event-simulate"}
{literal}
YUI(EXPONENT.YUI3_CONFIG).use('node','node-event-simulate', function(Y) {
    var radioSwitchers = Y.all('#customer_type input[type="radio"]');
    radioSwitchers.on('click',function(e){
        var curval = e.target.get('value');
        var intcust = Y.one("#search_internal").get('parentNode').get('parentNode');
        var extcust = Y.one("#related_items2").get('parentNode').get('parentNode');
        if (curval ==  1) {
            intcust.setStyle('display','none');
            extcust.setStyle('display','none');
        } else if (curval ==  2) {
            intcust.setStyle('display','block');
            extcust.setStyle('display','none');
        } else if (curval ==  3) {
            intcust.setStyle('display','none');
            extcust.setStyle('display','block');
        }
    });

    radioSwitchers.each(function(node,k){
        if(node.get('checked')==true){
            node.simulate('click');
        }
    });
});
{/literal}
{/script}
