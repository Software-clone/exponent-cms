/*
YUI 3.14.1 (build 63049cb)
Copyright 2013 Yahoo! Inc. All rights reserved.
Licensed under the BSD License.
http://yuilibrary.com/license/
*/

YUI.add("datatable-head",function(e,t){var n=e.Lang,r=n.sub,i=n.isArray,s=e.Array;e.namespace("DataTable").HeaderView=e.Base.create("tableHeader",e.View,[],{CELL_TEMPLATE:'<th id="{id}" colspan="{_colspan}" rowspan="{_rowspan}" class="{className}" scope="col" {_id}{abbr}{title}>{content}</th>',ROW_TEMPLATE:"<tr>{content}</tr>",THEAD_TEMPLATE:'<thead class="{className}"></thead>',getClassName:function(){var t=this.host,n=t&&t.constructor.NAME||this.constructor.NAME;return t&&t.getClassName?t.getClassName.apply(t,arguments):e.ClassNameManager.getClassName.apply(e.ClassNameManager,[n].concat(s(arguments,0,!0)))},render:function(){var t=this.get("container"),n=this.theadNode||(this.theadNode=this._createTHeadNode()),i=this.columns,s={_colspan:1,_rowspan:1,abbr:"",title:""},o,u,a,f,l,c,h,p;if(n&&i){c="";if(i.length)for(o=0,u=i.length;o<u;++o){h="";for(a=0,f=i[o].length;a<f;++a)l=i[o][a],p=e.merge(s,l,{className:this.getClassName("header"),content:l.label||l.key||"Column "+(a+1)}),p._id=l._id?' data-yui3-col-id="'+l._id+'"':"",l.abbr&&(p.abbr=' abbr="'+l.abbr+'"'),l.title&&(p.title=' title="'+l.title+'"'),l.className&&(p.className+=" "+l.className),l._first&&(p.className+=" "+this.getClassName("first","header")),l._id&&(p.className+=" "+this.getClassName("col",l._id)),h+=r(l.headerTemplate||this.CELL_TEMPLATE,p);c+=r(this.ROW_TEMPLATE,{content:h})}n.setHTML(c),n.get("parentNode")!==t&&t.insertBefore(n,t.one("tfoot, tbody"))}return this.bindUI(),this},_afterColumnsChange:function(e){this.columns=this._parseColumns(e.newVal),this.render()},bindUI:function(){this._eventHandles.columnsChange||(this._eventHandles.columnsChange=this.after("columnsChange",e.bind("_afterColumnsChange",this)))},_createTHeadNode:function(){return e.Node.create(r(this.THEAD_TEMPLATE,{className:this.getClassName("columns")}))},destructor:function(){(new e.EventHandle(e.Object.values(this._eventHandles))).detach()},initializer:function(e){this.host=e.host,this.columns=this._parseColumns(e.columns),this._eventHandles=[]},_parseColumns:function(t){var n=[],r=[],s=1,o,u,a,f,l,c,h,p;if(i(t)&&t.length){t=t.slice(),r.push([t,-1]);while(r.length){o=r[r.length-1],u=o[0],c=o[1]+1;for(h=u.length;c<h;++c){u[c]=a=e.merge(u[c]),f=a.children,e.stamp(a),a.id||(a.id=e.guid());if(i(f)&&f.length){r.push([f,-1]),o[1]=c,s=Math.max(s,r.length);break}a._colspan=1}if(c>=h){if(r.length>1){o=r[r.length-2],l=o[0][o[1]],l._colspan=0;for(c=0,h=u.length;c<h;++c)u[c]._parent=l,l._colspan+=u[c]._colspan}r.pop()}}for(c=0;c<s;++c)n.push([]);r.push([t,-1]);while(r.length){o=r[r.length-1],u=o[0],c=o[1]+1;for(h=u.length;c<h;++c){a=u[c],f=a.children,n[r.length-1].push(a),o[1]=c,a._headers=[a.id];for(p=r.length-2;p>=0;--p)l=r[p][0][r[p][1]],a._headers.unshift(l.id);if(f&&f.length){r.push([f,-1]);break}a._rowspan=s-r.length+1}c>=h&&r.pop()}}for(c=0,h=n.length;c<h;c+=a._rowspan)a=n[c][0],a._first=!0;return n}})},"3.14.1",{requires:["datatable-core","view","classnamemanager"]});
