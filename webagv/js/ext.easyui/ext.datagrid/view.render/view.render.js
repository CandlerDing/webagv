/**
 * 重写datagrid默认view的render
 * @author ____′↘夏悸
 * 本js使用方法，只需要在easyui.min.js之后导入便可。基于1.3.3的版本修改。没有测试向前的兼容性。
 */
$.extend($.fn.datagrid.defaults.view, {
	render : function (target, container, frozen) {
		var state = $.data(target, "datagrid");
		var opts = state.options;
		var rows = state.data.rows;
		var fields = $(target).datagrid("getColumnFields", frozen);
		if (frozen) {
			if (!(opts.rownumbers || (opts.frozenColumns && opts.frozenColumns.length))) {
				return;
			}
		}
		var table = ["<table class=\"datagrid-btable\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"];
		for (var i = 0; i < rows.length; i++) {
			var cls = (i % 2 && opts.striped) ? "class=\"datagrid-row datagrid-row-alt\"" : "class=\"datagrid-row\"";
			var styleValue = opts.rowStyler ? opts.rowStyler.call(target, i, rows[i]) : "";
			var style = styleValue ? "style=\"" + styleValue + "\"" : "";
			var rowId = state.rowIdPrefix + "-" + (frozen ? 1 : 2) + "-" + i;
			table.push("<tr id=\"" + rowId + "\" datagrid-row-index=\"" + i + "\" " + cls + " " + style + ">");
			table.push(this.renderRow.call(this, target, fields, frozen, i, rows[i]));
			table.push("</tr>");
		}
		table.push("</tbody></table>");
		$(container).html(table.join(""));
		//增加此句以实现,formatter里面可以返回easyui的组件，以便实例化。例如：formatter:function(){ return "<a href='javascript:void(0)' class='easyui-linkbutton'>按钮</a>" }}
		$.parser.parse(container);
	},
	renderRow : function (target, fields, frozen, rowIndex, rowData) {
		var opts = $.data(target, "datagrid").options;
		var cc = [];
		if (frozen && opts.rownumbers) {
			var rownumber = rowIndex + 1;
			if (opts.pagination) {
				rownumber += (opts.pageNumber - 1) * opts.pageSize;
			}
			cc.push("<td class=\"datagrid-td-rownumber\"><div class=\"datagrid-cell-rownumber\">" + rownumber + "</div></td>");
		}
		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var col = $(target).datagrid("getColumnOption", field);
			if (col) {
				//修改默认的value取值，改了此句之后field就可以用关联对象了。如：people.name
				var value = jQuery.proxy(function(){try{return eval('this.'+field);}catch(e){return "";}},rowData)();
				var styleValue = col.styler ? (col.styler(value, rowData, rowIndex) || "") : "";
				var style = col.hidden ? "style=\"display:none;" + styleValue + "\"" : (styleValue ? "style=\"" + styleValue + "\"" : "");
				cc.push("<td field=\"" + field + "\" " + style + ">");
				if (col.checkbox) {
					var style = "";
				} else {
					var style = styleValue;
					if (col.align) {
						style += ";text-align:" + col.align + ";";
					}
					if (!opts.nowrap) {
						style += ";white-space:normal;height:auto;";
					} else {
						if (opts.autoRowHeight) {
							style += ";height:auto;";
						}
					}
				}
				cc.push("<div style=\"" + style + "\" ");
				if (col.checkbox) {
					cc.push("class=\"datagrid-cell-check ");
				} else {
					cc.push("class=\"datagrid-cell " + col.cellClass);
				}
				cc.push("\">");
				if (col.checkbox) {
					cc.push("<input type=\"checkbox\" name=\"" + field + "\" value=\"" + (value != undefined ? value : "") + "\"/>");
				} else {
					if (col.formatter) {
						cc.push(col.formatter(value, rowData, rowIndex));
					} else {
						cc.push(value);
					}
				}
				cc.push("</div>");
				cc.push("</td>");
			}
		}
		return cc.join("");
	}
});
