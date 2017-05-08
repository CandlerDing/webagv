/**
 * 基于dialog插件的扩展.(适用于Easyui 1.3.3+版本)
 * @author ____′↘夏悸
 **/
(function ($) {
	function S4() {
		return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
	}
	function CreateIndentityWindowId() {
		return "UUID-" + (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
	}
	function destroy(target) {
		$(target).dialog("destroy");
	}
	function getWindow(target) {
		if (typeof target == "string") {
			return document.getElementById(target);
		} else {
			return $(target).closest(".window-body");
		}
	}

	function getFrameWindow(frame) {
		return frame && typeof(frame) == 'object' && frame.tagName == 'IFRAME' && frame.contentWindow;
	}

	function getTpl(id, ctxjq) {
		try {
			var tpl = ctxjq("#" + id);
			if (tpl.length > 0) {
				var TEMPLATE = $.trim(tpl.html()).replace(/[\r\n]/g, "").replace(/\s+/g, " ");
				var reg = new RegExp("^(<!--)(.*)(-->)$");
				var match = TEMPLATE.match(reg);
				return match[2];
			}
		} catch (e) {
			throw new Error("获取模板错误！");
		}
	}

	function ajaxSuccess(dialog, options, rsp) {
		var dgContent = dialog.find("div.dialog-content");
		if (options.isIframe && !rsp) {
			dgContent.css("overflow", "hidden");
			var iframe = document.createElement("iframe");
			iframe.src = options.url;
			iframe.style.width = "100%";
			iframe.style.height = "100%";
			iframe.style.border = "none";
			if (iframe.attachEvent) {
				iframe.attachEvent("onload", function () {
					options.onComplete.call(dialog, window.top.jQuery, iframe);
				});
			} else {
				iframe.onload = function () {
					options.onComplete.call(dialog, window.top.jQuery, iframe);
				};
			}
			dgContent[0].appendChild(iframe);
		} else {
			dgContent.html(rsp);
			$.parser.parse(dialog);
			options.onComplete.call(dialog, window.top.jQuery);
		}

		if (!options.height) {
			dialog.dialog("center");
		}
	}

	$.window = function (options,jq) {
		if(window.top != self){
			if(window.top.jQuery && window.top.jQuery.window){
				return window.top.jQuery.window(options,window.jQuery);
			}
			throw "父窗口没有导入jQuery或定义window插件！";
		}
		
		if (!options.url && !options.contents && !options.tplRef) {
			top.$.messager.alert("提示", "缺少必要参数!(url or contents or tplRef)");
			return false;
		}
		//获取模板内容
		if (options.tplRef) {
			options.contents = getTpl(options.tplRef,jq||window.jQuery);
		}

		var windowId = CreateIndentityWindowId();
		if (options.winId) {
			windowId = options.winId;
		} else {
			options.winId = windowId;
		}
		options = $.extend({}, $.window.defaults, options || {});
		if (options.isMax) {
			options.draggable = false;
			options.closed = true;
		}
		var dialog = $('<div/>');
		if (options.target != 'body') {
			options.inline = true;
		}
		dialog.appendTo($(options.target));
		dialog.dialog($.extend({}, options, {
				onClose : function () {
					if (typeof options.onClose == "function") {
						options.onClose.call(dialog, $);
					}
					destroy(this);
				}
			}));
		if (options.align) {
			var w = dialog.closest(".window");
			switch (options.align) {
			case "right":
				dialog.dialog("move", {
					left : w.parent().width() - w.width() - 10
				});
				break;
			case "tright":
				dialog.dialog("move", {
					left : w.parent().width() - w.width() - 10,
					top : 0
				});
				break;
			case "bright":
				dialog.dialog("move", {
					left : w.parent().width() - w.width() - 10,
					top : w.parent().height() - w.height() - 10
				});
				break;
			case "left":
				dialog.dialog("move", {
					left : 0
				});
				break;
			case "tleft":
				dialog.dialog("move", {
					left : 0,
					top : 0
				});
				break;
			case "bleft":
				dialog.dialog("move", {
					left : 0,
					top : w.parent().height() - w.height() - 10
				});
				break;
			case "top":
				dialog.dialog("move", {
					top : 0
				});
				break;
			case "bottom":
				dialog.dialog("move", {
					top : w.parent().height() - w.height() - 10
				});
				break;
			}
		}

		if (options.isMax) {
			dialog.dialog("maximize");
			dialog.dialog("open");
		}

		if (options.contents) {
			ajaxSuccess(dialog, options, options.contents);
		} else {
			if (!options.isIframe) {
				$.ajax({
					url : options.url,
					type : options.ajaxType || "POST",
					data : options.data == null ? "" : options.data,
					success : function (rsp) {
						ajaxSuccess(dialog, options, rsp);
					}
				});
			} else {
				ajaxSuccess(dialog, options);
			}
		}

		dialog.attr("id", windowId);

		dialog.destroy = function () {
			destroy(this);
		};

		return dialog;
	};

	//一些工具方法
	$.window.util = {
		getTpl : getTpl, //获取模板内容
		getFrameWindow : getFrameWindow //根据iframe的dom对象获取iframe的window对象
	};

	$.window.defaults = $.extend({}, $.fn.dialog.defaults, {
			url : '',
			data : '',
			contents : '',
			isIframe:false,
			tplRef : '',
			ajaxType : "POST",
			target : 'body',
			width : 400,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			closable : true,
			modal : true,
			shadow : false,
			onComplete : function (topjQuery) {}
		});
})(jQuery);
