<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
UserInfo ui = Tool.getUserInfo(request);
if (ui == null) {
    out.print("<meta http-equiv='refresh' content='0;url=logon.jsp'>");
    return;
  } 
%>
<!DOCTYPE html>
<html>
<head>
<title>AGV���ܵ���ϵͳ</title>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<jsp:include page="jqueryinc.jsp"></jsp:include>
<script type="text/javascript">
	var index_tabs;
	var index_tabsMenu;
	var index_layout;
	$(function() {
		index_layout = $('#index_layout').layout({
			fit : true
		});
		/*index_layout.layout('collapse', 'east');*/

		index_tabs = $('#index_tabs').tabs({
			fit : true,
			border : false,
			onContextMenu : function(e, title) {
				e.preventDefault();
				index_tabsMenu.menu('show', {
					left : e.pageX,
					top : e.pageY
				}).data('tabTitle', title);
			},
			tools : [ {
				iconCls : 'database_refresh',
				handler : function() {
					var href = index_tabs.tabs('getSelected').panel('options').href;
					if (href) {/*˵��tab����href��ʽ�����Ŀ��ҳ��*/
						var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
						index_tabs.tabs('getTab', index).panel('refresh');
					} else {/*˵��tab����content��ʽ�����Ŀ��ҳ��*/
						var panel = index_tabs.tabs('getSelected').panel('panel');
						var frame = panel.find('iframe');
						try {
							if (frame.length > 0) {
								for ( var i = 0; i < frame.length; i++) {
									frame[i].contentWindow.document.write('');
									frame[i].contentWindow.close();
									frame[i].src = frame[i].src;
								}
								if (navigator.userAgent.indexOf("MSIE") > 0) {// IE���л����ڴ淽��
									try {
										CollectGarbage();
									} catch (e) {
									}
								}
							}
						} catch (e) {
						}
					}
				}
			}, {
				iconCls : 'delete',
				handler : function() {
					var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
					var tab = index_tabs.tabs('getTab', index);
					if (tab.panel('options').closable) {
						index_tabs.tabs('close', index);
					} else {
						$.messager.alert('��ʾ', '[' + tab.panel('options').title + ']�����Ա��رգ�', 'error');
					}
				}
			} ]
		});

		index_tabsMenu = $('#index_tabsMenu').menu({
			onClick : function(item) {
				var curTabTitle = $(this).data('tabTitle');
				var type = $(item.target).attr('title');

				if (type === 'refresh') {
					index_tabs.tabs('getTab', curTabTitle).panel('refresh');
					return;
				}

				if (type === 'close') {
					var t = index_tabs.tabs('getTab', curTabTitle);
					if (t.panel('options').closable) {
						index_tabs.tabs('close', curTabTitle);
					}
					return;
				}

				var allTabs = index_tabs.tabs('tabs');
				var closeTabsTitle = [];

				$.each(allTabs, function() {
					var opt = $(this).panel('options');
					if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
						closeTabsTitle.push(opt.title);
					} else if (opt.closable && type === 'closeAll') {
						closeTabsTitle.push(opt.title);
					}
				});

				for ( var i = 0; i < closeTabsTitle.length; i++) {
					index_tabs.tabs('close', closeTabsTitle[i]);
				}
			}
		});
	});
	
	
</script>
</head>
<body>
	<div id="index_layout">
		<div data-options="region:'north'" style="height: 100px; overflow: hidden;" >
		<iframe src="<%=request.getContextPath()%>/lay/north1.jsp" frameborder="0" border="0" style="border: 0; width: 100%; height: 100%;"  scrolling="no"></iframe>
		</div>
		<div data-options="region:'west',href:'<%=request.getContextPath()%>/lay/west.jsp?moduletype=��������',split:true" title="�˵�" style="width: 200px; overflow: hidden;"></div>
		<div data-options="region:'center'" title="" style="overflow: hidden;fit: true;">
			<div id="index_tabs" style="overflow: hidden;">
				<div title="��ҳ" data-options="border:false" style="overflow: hidden;">
				    <iframe src="<%=request.getContextPath()%>/contents.jsp" frameborder="0" style="border: 0; width: 100%; height: 98%;"></iframe>	
				</div>
			</div>
		</div>
		 <div data-options="region:'east',href:'<%=request.getContextPath()%>/lay/east.jsp',collapsed:true" title="����" style="width: 230px; overflow: hidden;"></div>
		 <div data-options="region:'south',href:'<%=request.getContextPath()%>/lay/south.jsp',border:false,collapsed:false" style="height: 30px; overflow: "></div>  
	</div>
	<div id="index_tabsMenu" style="width: 120px; display: none;">
		<div title="refresh" data-options="iconCls:'transmit'">ˢ��</div>
		<div class="menu-sep"></div>
		<div title="close" data-options="iconCls:'delete'">�ر�</div>
		<div title="closeOther" data-options="iconCls:'delete'">�ر�����</div>
		<div title="closeAll" data-options="iconCls:'delete'">�ر�����</div>
	</div>
<div id="dialogwin"></div>
<iframe src="" style="width:0;height:0" id="formsaveFrm" name="formsaveFrm"></iframe>	
</body>
</html>