<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" charset="utf-8">
	$(function() {

		$('#layout_east_calendar').calendar({
			fit : true,
			current : new Date(),
			border : false,
			onSelect : function(date) {
				$(this).calendar('moveTo', new Date());
			}
		});

		$('#layout_east_onlinePanel').panel({
			tools : [ {
				iconCls : 'database_refresh',
				handler : function() {
				}
			} ]
		});

	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="height: 180px; overflow: hidden;">
		<div id="layout_east_calendar"></div>
	</div>
	
</div>