<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%String flag = ParamUtils.getParameter(request,"flag",""); 
String sn = ParamUtils.getParameter(request,"sn","0"); 
UserInfo userInfo = Tool.getUserInfo(request);
%>
<script type="text/javascript">
	var layout_west_tree;
	var layout_west_tree_url = '/lay/submenu.jsp?id=1';		
	$(function() {
		$('.easyui-accordion li div').click(function() {
			$('.easyui-accordion li div').removeClass("selected");
			$(this).parent().addClass("selected");
		}).hover(function() {
			$(this).parent().addClass("hover");
		}, function() {
			$(this).parent().removeClass("hover");
		});
		
	});

	function addTab(params) {
		var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';
		var t = $('#index_tabs');
		var opts = {
			title : params.title,
			closable : true,
			iconCls : params.iconCls,
			content : iframe,
			border : false,
			fit : true
		};
		if (t.tabs('exists', opts.title)) {
			//t.tabs('select', opts.title);
			t.tabs('close', opts.title);
			t.tabs('add', opts);
			parent.$.messager.progress('close');
		} else {
			t.tabs('add', opts);
		}
	}
</script>
<!-- <div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="管理后台" style="padding: 5px;" data-options="border:false,isonCls:'anchor',tools : [ {
				iconCls : 'database_refresh',
				handler : function() {
					$('#layout_west_tree').tree('reload');
				}
			} ]">
			<div id=nav class ="panel">
	     
			<ul class="easyui-tree">
			<li>
			<div class="tree-node">
			<span class="nav"></span>
			</div>
			</li>
			</ul>
		</div> 		
	</div>
</div> -->
<div class="easyui-accordion" style="border:left" data-options="fit:true,border:false">
<%
List cdt = new ArrayList();
User_ModuleList um = new User_ModuleList();
User_Module module = new User_Module();
cdt.add("pid=0");
//cdt.add("moduletype='档案管理'");
cdt.add("order by remark");
List<User_Module> modules = module.query(cdt);	
for(int i=0;i<modules.size();i++)
{
	module = modules.get(i);
	cdt.clear();
	 boolean allPow = false;
	 if(module.getCanShu().equals("*"))
     {
    	 allPow = true;                	 
     }
	 cdt.clear();
	 cdt.add("userid='"+userInfo.getId()+"'");
     cdt.add("moduleId='"+ module.getId()  +"'");
        
    // List<User_ModuleListCode> userModules1 = userModule.query(cdt);
     if(allPow || (um.getCount(cdt)>0))
     {
 		
%>
	
			<div title="<%=module.getName() %>" iconCls="folder">
			<ul class="easyui-tree tree" data-options="url:'<%=request.getContextPath() %>/lay/submenu.jsp?pid=<%=module.getId() %>',parentField : 'pid',onClick : function(node) {			
					var url;
					if (node.attributes.url.indexOf('/') == 0) {
						url =  node.attributes.url;
						
					} else {/*打开跨域资源*/
						url = node.attributes.url;
					}
					addTab({
						url : url,
						title : node.text,
						iconCls : node.iconCls
					});
			
			},
			onDblClick:function(node)
			{//双击打开
				if(node.state == 'closed')
					{
					 $(this).tree('expand',node.target);
					}else
						{
						$(this).tree('collapse',node.target);
						}
			},
			onBeforeLoad : function(node, param) {
				if (layout_west_tree_url) {//只有刷新页面才会执行这个方法
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
				}
			},
			onLoadSuccess : function(node, data) {
				parent.$.messager.progress('close');
			}">  
    		</ul> 
			</div>
<%}}%>
<%-- if(userInfo.isAdmin()){%>
	<div title="权限管理" iconCls="folder">
	<ul class="easyui-tree tree" data-options="url:'<%=request.getContextPath() %>/lay/amenu.jsp?id=00',parentField : 'pid',onClick : function(node) {			
					var url;
					if (node.attributes.url.indexOf('/') == 0) {
						url =  node.attributes.url;
						
					} else {/*打开跨域资源*/
						url = node.attributes.url;
					}
					addTab({
						url : url,
						title : node.text,
						iconCls : node.iconCls
					});
			
			},
			onDblClick:function(node)
			{//双击打开
				if(node.state == 'closed')
					{
					 $(this).tree('expand',node.target);
					}else
						{
						$(this).tree('collapse',node.target);
						}
			},
			onBeforeLoad : function(node, param) {
				if (layout_west_tree_url) {//只有刷新页面才会执行这个方法
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
				}
			},
			onLoadSuccess : function(node, data) {
				parent.$.messager.progress('close');
			}">  
    		</ul> 
	</div>

<%} %> --%>

</div>