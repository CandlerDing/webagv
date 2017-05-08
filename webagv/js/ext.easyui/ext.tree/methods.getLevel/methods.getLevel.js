//获取节点层级
$.extend($.fn.tree.methods, {
	getLevel:function(jq,target){
		var l = $(target).parentsUntil("ul.tree","ul");
		return l.length+1;
	}
});