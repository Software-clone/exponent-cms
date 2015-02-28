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

<div class="module billing configure">
    <h1>{'Configure'|gettext} {$calculator->title}</h1>
    <blockquote>{'Use this form to configure'|gettext} {$calculator->title} {'billing'|gettext}</blockquote>
    
    {form action=saveconfig}
        {control type="hidden" name="id" value=$calculator->id}
        {include file=$calculator->calculator->configForm()}
        {control type="buttongroup" submit="Save Config"|gettext cancel="Cancel"|gettext}
    {/form}
</div>
