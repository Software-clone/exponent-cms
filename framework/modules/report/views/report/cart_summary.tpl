{include file='menu.inc'}

<div class="rightcol">

        <div id="dashboard-tabs" class="hide exp-skin-tabview">
            {script unique="dashboard-tabs" yuimodules="tabview, element"}
            {literal}
                var tabView = new YAHOO.widget.TabView('dashboard-tabview');     
                YAHOO.util.Dom.removeClass("dashboard-tabs", 'hide');
                var loading = YAHOO.util.Dom.getElementsByClassName('loadingdiv', 'div');
                YAHOO.util.Dom.setStyle(loading, 'display', 'none');
            {/literal}
            {/script}

            <div id="dashboard-tabview" class="yui-navset">
                <ul class="yui-nav">
                    <li class="selected"><a href="#tab1"><em>New Orders</em></a></li>
                    <!--li><a href="#tab2"><em>Top Selling Items</em></a></li>
                    <li><a href="#tab3"><em>Most Viewed</em></a></li>
                    <li><a href="#tab4"><em>Customers</em></a></li-->
                </ul>            
                <div class="yui-content">      
                    <div id="tab1" class="exp-ecom-table">
                        {control type="dropdown" name="filter" label="Range: " items="Last 24 hours, Last 48 hours, Jurassic Period and prior"}      
                        <table border="0" cellspacing="0" cellpadding="0">                             
                            <tbody>
                                <tr class="even">
                                    <td>Carts Started (visits)
                                    </td>
                                    <td>Sessions Started (visits)
                                    </td>
                                </tr> 
                            </tbody>
                        </table>
                        <div class="dashboard-totals">
                            <strong>107 Items</strong>
                            <strong>$1,208.22</strong>
                        </div>
                    </div>
                    <div id="tab2">
                    </div>          
                    <div id="tab3">
                    </div>
                    <div id="tab4">
                    </div>
                    <div id="tab5">
                    </div>
                </div>
            </div>
        </div>
        <div class="loadingdiv">Loading Dashboard</div>
        
    </div>
    <div style="clear:both"></div>
</div>