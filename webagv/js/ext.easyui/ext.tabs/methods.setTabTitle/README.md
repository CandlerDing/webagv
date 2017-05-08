#扩展Tabs的setTabTitle方法

定义
```javascript
$.extend($.fn.tabs.methods, {
	setTabTitle:function(jq,opts){
		return jq.each(function(){
			var tab = opts.tab;
			var options = tab.panel("options");
			var tab = options.tab;
			options.title = opts.title;
			var title = tab.find("span.tabs-title");
			title.html(opts.title);
		});
	}
});
```

用法
```javascript
function setTitle(){
	var tab = $("#tabs").tabs("getTab",0);
	if(tab){
		$("#tabs").tabs("setTabTitle",{tab:tab,title:"newTabTitle"});
	}
}
```