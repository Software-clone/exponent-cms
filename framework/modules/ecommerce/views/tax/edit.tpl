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

{form action=update}
    {control type="hidden" name="id" value=$record->id}
    {control type="text" name="name" label="Class Name"|gettext value=$record->classname}
    {control type="text" name="rate" label="Percentage Rate"|gettext value=$record->rate}
    {control type="dropdown" name="zone" label="Zone"|gettext items=$zones value=$record->zone}
    {*{control type=state name=state label="State/Province"|gettext value=$record->state}*}
    {*{control type=country name=country label="Country"|gettext value=$record->country}*}
    {control type=regioncountry name=address label="Country/State"|gettext country_default=$record->country|default:223 region_default=$record->state includeblank="-- Choose a State --"|gettext}
    {control type="buttongroup" submit="Submit"|gettext cancel="Cancel"|gettext}
{/form}
