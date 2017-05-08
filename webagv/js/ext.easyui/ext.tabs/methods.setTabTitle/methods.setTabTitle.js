//设置tabs的tab的标题
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