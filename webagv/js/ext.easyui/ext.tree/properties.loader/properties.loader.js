//重写tree的loader
$.extend($.fn.tree.defaults, {
	loader : function (param, success, error) {
		var opts = $(this).tree("options");
		if (!opts.url) {
			return false;
		}
		if(opts.queryParams){
			param = $.extend({},opts.queryParams,param);
		}
		$.ajax({
			type : opts.method,
			url : opts.url,
			data : param,
			dataType : "json",
			success : function (data) {
				success(data);
			},
			error : function () {
				error.apply(this, arguments);
			}
		});
	},
	queryParams:{}
});
//设置参数
$.extend($.fn.tree.methods, {
	setQueryParams : function (jq, params) {
		return jq.each(function () {
			$(this).tree("options").queryParams = params;
		});
	}
});
