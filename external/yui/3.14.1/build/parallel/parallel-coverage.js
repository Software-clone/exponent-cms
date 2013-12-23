/*
YUI 3.14.1 (build 63049cb)
Copyright 2013 Yahoo! Inc. All rights reserved.
Licensed under the BSD License.
http://yuilibrary.com/license/
*/

if (typeof __coverage__ === 'undefined') { __coverage__ = {}; }
if (!__coverage__['build/parallel/parallel.js']) {
   __coverage__['build/parallel/parallel.js'] = {"path":"build/parallel/parallel.js","s":{"1":0,"2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"11":0,"12":0,"13":0,"14":0,"15":0,"16":0,"17":0,"18":0,"19":0,"20":0},"b":{"1":[0,0],"2":[0,0],"3":[0,0,0],"4":[0,0],"5":[0,0],"6":[0,0]},"f":{"1":0,"2":0,"3":0,"4":0,"5":0,"6":0},"fnMap":{"1":{"name":"(anonymous_1)","line":1,"loc":{"start":{"line":1,"column":20},"end":{"line":1,"column":39}}},"2":{"name":"(anonymous_2)","line":34,"loc":{"start":{"line":34,"column":13},"end":{"line":34,"column":25}}},"3":{"name":"(anonymous_3)","line":67,"loc":{"start":{"line":67,"column":9},"end":{"line":67,"column":23}}},"4":{"name":"(anonymous_4)","line":73,"loc":{"start":{"line":73,"column":15},"end":{"line":73,"column":27}}},"5":{"name":"(anonymous_5)","line":85,"loc":{"start":{"line":85,"column":10},"end":{"line":85,"column":22}}},"6":{"name":"(anonymous_6)","line":99,"loc":{"start":{"line":99,"column":10},"end":{"line":99,"column":36}}}},"statementMap":{"1":{"start":{"line":1,"column":0},"end":{"line":107,"column":41}},"2":{"start":{"line":34,"column":0},"end":{"line":40,"column":2}},"3":{"start":{"line":35,"column":4},"end":{"line":35,"column":26}},"4":{"start":{"line":36,"column":4},"end":{"line":36,"column":22}},"5":{"start":{"line":37,"column":4},"end":{"line":37,"column":44}},"6":{"start":{"line":38,"column":4},"end":{"line":38,"column":19}},"7":{"start":{"line":39,"column":4},"end":{"line":39,"column":22}},"8":{"start":{"line":42,"column":0},"end":{"line":104,"column":2}},"9":{"start":{"line":68,"column":8},"end":{"line":69,"column":31}},"10":{"start":{"line":71,"column":8},"end":{"line":71,"column":24}},"11":{"start":{"line":73,"column":8},"end":{"line":79,"column":10}},"12":{"start":{"line":74,"column":12},"end":{"line":74,"column":28}},"13":{"start":{"line":75,"column":12},"end":{"line":76,"column":77}},"14":{"start":{"line":78,"column":12},"end":{"line":78,"column":24}},"15":{"start":{"line":86,"column":8},"end":{"line":86,"column":24}},"16":{"start":{"line":87,"column":8},"end":{"line":89,"column":9}},"17":{"start":{"line":88,"column":12},"end":{"line":88,"column":70}},"18":{"start":{"line":100,"column":8},"end":{"line":100,"column":33}},"19":{"start":{"line":101,"column":8},"end":{"line":101,"column":25}},"20":{"start":{"line":102,"column":8},"end":{"line":102,"column":20}}},"branchMap":{"1":{"line":35,"type":"binary-expr","locations":[{"start":{"line":35,"column":18},"end":{"line":35,"column":19}},{"start":{"line":35,"column":23},"end":{"line":35,"column":25}}]},"2":{"line":37,"type":"binary-expr","locations":[{"start":{"line":37,"column":19},"end":{"line":37,"column":38}},{"start":{"line":37,"column":42},"end":{"line":37,"column":43}}]},"3":{"line":75,"type":"binary-expr","locations":[{"start":{"line":75,"column":35},"end":{"line":75,"column":37}},{"start":{"line":75,"column":41},"end":{"line":75,"column":74}},{"start":{"line":76,"column":17},"end":{"line":76,"column":75}}]},"4":{"line":76,"type":"cond-expr","locations":[{"start":{"line":76,"column":42},"end":{"line":76,"column":54}},{"start":{"line":76,"column":57},"end":{"line":76,"column":75}}]},"5":{"line":87,"type":"if","locations":[{"start":{"line":87,"column":8},"end":{"line":87,"column":8}},{"start":{"line":87,"column":8},"end":{"line":87,"column":8}}]},"6":{"line":87,"type":"binary-expr","locations":[{"start":{"line":87,"column":12},"end":{"line":87,"column":39}},{"start":{"line":87,"column":43},"end":{"line":87,"column":56}}]}},"code":["(function () { YUI.add('parallel', function (Y, NAME) {","","","/**","* A concurrent parallel processor to help in running several async functions.","* @module parallel","* @main parallel","*/","","/**","A concurrent parallel processor to help in running several async functions.","","    var stack = new Y.Parallel();","","    for (var i = 0; i < 15; i++) {","        Y.io('./api/json/' + i, {","            on: {","                success: stack.add(function() {","                })","            }","        });","    }","","    stack.done(function() {","    });","","@class Parallel","@param {Object} o A config object","@param {Object} [o.context=Y] The execution context of the callback to done","","","*/","","Y.Parallel = function(o) {","    this.config = o || {};","    this.results = [];","    this.context = this.config.context || Y;","    this.total = 0;","    this.finished = 0;","};","","Y.Parallel.prototype = {","    /**","    * An Array of results from all the callbacks in the stack","    * @property results","    * @type Array","    */","","    results: null,","    /**","    * The total items in the stack","    * @property total","    * @type Number","    */","    total: null,","    /**","    * The number of stacked callbacks executed","    * @property finished","    * @type Number","    */","    finished: null,","    /**","    * Add a callback to the stack","    * @method add","    * @param {Function} fn The function callback we are waiting for","    */","    add: function (fn) {","        var self = this,","            index = self.total;","","        self.total += 1;","","        return function () {","            self.finished++;","            self.results[index] = (fn && fn.apply(self.context, arguments)) ||","                (arguments.length === 1 ? arguments[0] : Y.Array(arguments));","","            self.test();","        };","    },","    /**","    * Test to see if all registered items in the stack have completed, if so call the callback to `done`","    * @method test","    */","    test: function () {","        var self = this;","        if (self.finished >= self.total && self.callback) {","            self.callback.call(self.context, self.results, self.data);","        }","    },","    /**","    * The method to call when all the items in the stack are complete.","    * @method done","    * @param {Function} callback The callback to execute on complete","    * @param {Mixed} callback.results The results of all the callbacks in the stack","    * @param {Mixed} [callback.data] The data given to the `done` method","    * @param {Mixed} data Mixed data to pass to the success callback","    */","    done: function (callback, data) {","        this.callback = callback;","        this.data = data;","        this.test();","    }","};","","","}, '3.14.1', {\"requires\": [\"yui-base\"]});","","}());"]};
}
var __cov_L5sDHvOirn0TVIbpXpofuA = __coverage__['build/parallel/parallel.js'];
__cov_L5sDHvOirn0TVIbpXpofuA.s['1']++;YUI.add('parallel',function(Y,NAME){__cov_L5sDHvOirn0TVIbpXpofuA.f['1']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['2']++;Y.Parallel=function(o){__cov_L5sDHvOirn0TVIbpXpofuA.f['2']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['3']++;this.config=(__cov_L5sDHvOirn0TVIbpXpofuA.b['1'][0]++,o)||(__cov_L5sDHvOirn0TVIbpXpofuA.b['1'][1]++,{});__cov_L5sDHvOirn0TVIbpXpofuA.s['4']++;this.results=[];__cov_L5sDHvOirn0TVIbpXpofuA.s['5']++;this.context=(__cov_L5sDHvOirn0TVIbpXpofuA.b['2'][0]++,this.config.context)||(__cov_L5sDHvOirn0TVIbpXpofuA.b['2'][1]++,Y);__cov_L5sDHvOirn0TVIbpXpofuA.s['6']++;this.total=0;__cov_L5sDHvOirn0TVIbpXpofuA.s['7']++;this.finished=0;};__cov_L5sDHvOirn0TVIbpXpofuA.s['8']++;Y.Parallel.prototype={results:null,total:null,finished:null,add:function(fn){__cov_L5sDHvOirn0TVIbpXpofuA.f['3']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['9']++;var self=this,index=self.total;__cov_L5sDHvOirn0TVIbpXpofuA.s['10']++;self.total+=1;__cov_L5sDHvOirn0TVIbpXpofuA.s['11']++;return function(){__cov_L5sDHvOirn0TVIbpXpofuA.f['4']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['12']++;self.finished++;__cov_L5sDHvOirn0TVIbpXpofuA.s['13']++;self.results[index]=(__cov_L5sDHvOirn0TVIbpXpofuA.b['3'][0]++,fn)&&(__cov_L5sDHvOirn0TVIbpXpofuA.b['3'][1]++,fn.apply(self.context,arguments))||(__cov_L5sDHvOirn0TVIbpXpofuA.b['3'][2]++,arguments.length===1?(__cov_L5sDHvOirn0TVIbpXpofuA.b['4'][0]++,arguments[0]):(__cov_L5sDHvOirn0TVIbpXpofuA.b['4'][1]++,Y.Array(arguments)));__cov_L5sDHvOirn0TVIbpXpofuA.s['14']++;self.test();};},test:function(){__cov_L5sDHvOirn0TVIbpXpofuA.f['5']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['15']++;var self=this;__cov_L5sDHvOirn0TVIbpXpofuA.s['16']++;if((__cov_L5sDHvOirn0TVIbpXpofuA.b['6'][0]++,self.finished>=self.total)&&(__cov_L5sDHvOirn0TVIbpXpofuA.b['6'][1]++,self.callback)){__cov_L5sDHvOirn0TVIbpXpofuA.b['5'][0]++;__cov_L5sDHvOirn0TVIbpXpofuA.s['17']++;self.callback.call(self.context,self.results,self.data);}else{__cov_L5sDHvOirn0TVIbpXpofuA.b['5'][1]++;}},done:function(callback,data){__cov_L5sDHvOirn0TVIbpXpofuA.f['6']++;__cov_L5sDHvOirn0TVIbpXpofuA.s['18']++;this.callback=callback;__cov_L5sDHvOirn0TVIbpXpofuA.s['19']++;this.data=data;__cov_L5sDHvOirn0TVIbpXpofuA.s['20']++;this.test();}};},'3.14.1',{'requires':['yui-base']});
