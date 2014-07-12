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

{css unique="showlogin" link="`$asset_path`css/login.css" corecss="button"}

{/css}

{messagequeue}
<div class="login default row">
    {if $loggedin == false || $smarty.const.PREVIEW_READONLY == 1}
        <div{if $smarty.const.SITE_ALLOW_REGISTRATION || $smarty.const.ECOM} class="box login-form one col-sm-9"{/if}>
            {if $smarty.const.USER_REGISTRATION_USE_EMAIL || $smarty.const.ECOM}
                {$usertype="Customers"|gettext}
                {$label="Email Address"|gettext|cat:":"}
            {else}
                {$usertype="Users"|gettext}
                {$label="Username"|gettext|cat:":"}
            {/if}
            <h2>{"Existing"|gettext} {$usertype}</h2>
            <!--p>If you are an existing customer please log-in below to continue in the checkout process.</p-->
            {form action=login}
                {control type="text" name="username" label=$label size=25 required=1 prepend="user" focus=1}
                {control type="password" name="password" label="Password"|gettext|cat:":" size=25 required=1 prepend="key"}
                {*<a href="{link controller=users action=reset_password}">{'Forgot Your Password?'|gettext}</a>*}
                {br}
                {control type="buttongroup" wide=true submit="Log In"|gettext}
                {br}
                {icon wide=true controller=users action=reset_password text='Forgot Your Password?'|gettext}
            {/form}
        </div>
        {if $smarty.const.SITE_ALLOW_REGISTRATION || $smarty.const.ECOM}
            <div class="box new-user two col-sm-9">
                <h2>{"New"|gettext} {$usertype}</h2>
                <p>
                    {if $smarty.const.ECOM}
                        {if $oicount>0}
                            {"If you are a new customer, select this option to continue with the checkout process."|gettext}{br}{br}
                            {"We will gather billing and shipping information, and you will have the option to create an account so can track your order status."|gettext}{br}{br}
                            {*<a class="btn btn-default {$btn_size}" href="{link module=cart action=customerSignup}">{"Continue Checking Out"|gettext}</a>*}
                            {icon button=true wide=true module=cart action=customerSignup text="Continue Checking Out"|gettext}
                        {else}
                            {"If you are a new customer, add an item to your cart to continue with the checkout process."|gettext}{br}{br}
                            {*<a class="btn btn-default {$btn_size}" href="{backlink}">{"Keep Shopping"|gettext}</a>*}
                            {$backlink = makeLink(expHistory::getBack(1))}
                            {icon button=true wide=true link=$backlink text="Keep Shopping"|gettext}
                        {/if}
                    {else}
                        {"Create a new account here."|gettext}{br}{br}
                        {*<a class="btn btn-default {$btn_size}" href="{link controller=users action=create}">{"Create an Account"|gettext}</a>*}
                        {icon button=true wide=true controller=users action=create text="Create an Account"|gettext}
                    {/if}
                </p>
            </div>
        {/if}
    {else}
        {if !$smarty.const.ECOM}
            <div class=" logout">
                {*<a class="btn btn-default {$btn_size}" href="{link action=logout}">{'Logout'|gettext}</a>*}
                {icon button=true wide=true action=logout text='Logout'|gettext}
            </div>
        {/if}
    {/if}
</div>
