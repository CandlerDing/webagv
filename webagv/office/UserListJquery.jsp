<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Tool.class);
%>
<%
log.debug("ListJquery");
StringBuffer str = new StringBuffer();
String keyfield = (String)request.getAttribute("keyfield");
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
//默认值定义
List YesNooptions = (List)request.getAttribute("YesNooptions");
List TechPostCodeoptions = (List)request.getAttribute("TechPostCodeoptions");
List Degree1Codeoptions = (List)request.getAttribute("Degree1Codeoptions");
List ZhiWeioptions = (List)request.getAttribute("ZhiWeioptions");
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<title> <%=request.getAttribute("describe")%> </title>
<%@ include file="../jqueryinc.jsp"%>
<script type="text/javascript">
var keyfield = "<%=keyfield%>";
$(function () {
    var datagrid;
    var editRow = undefined;
    datagrid = $("#dd").datagrid({
            url: 'UserAction.jsp?cmd=json',
            iconCls: 'icon-save',
            pagination: true,
            pageSize: 10,
            pageList: [10, 20, 30, 40],
            fit: true,
            fitColumn: false,
            striped: true,
            nowap: true, 
            border: false,
            idField: keyfield,
            columns: [[ 
        <%
        List rows = new ArrayList();
        for(int i=0;i<dickeys.length;i++){
            Map map = new HashMap();
            map.put("field",dickeys[i]+"");
            map.put("title",dicvalues[i][1]+"");
            map.put("sortable","true");
            if(dickeys[i].equals(keyfield))
            {
                map.put("checkbox","true");
            }
            rows.add(JSON.toJSONString(map));
        }
        out.print(Tool.join(",\r\n",rows));%>
        ]],
        queryParams : {		action : 'query'
        	},
        	toolbar : [
        			{
            				text : '添加',
            				iconCls : 'icon-add',
            				handler : function() {
                					if (editRow != undefined) {
                    						datagrid.datagrid("endEdit",editRow);
                					}	
                					if (editRow == undefined) {						datagrid.datagrid("insertRow",								{
                    									index : 0, 
                    									row : {
                    									}
                								});
                						datagrid.datagrid("beginEdit",0);
                						editRow = 0;
            					}
        				}
    			},
    			'-',
    			{				text : '删除',
        				iconCls : 'icon-remove',
        				handler : function() {
            					var rows = datagrid.datagrid("getSelections");
            					if (rows.length > 0) {
                						$.messager.confirm("提示","你确定要删除吗?",function(r) {
                    											if (r) {
                        												var ids = [];
                        												for (var i = 0; i < rows.length; i++) {
                            													ids.push(rows[i].ID);
                        												}
                        												$.ajax({
                            															url : "",
                            															data : {
                                																ids : ids.join(',')
                            															},
                            															dataType : json,
                            															success : function(r) {
                                																datagrid.datagrid("load");
                                																datagrid.datagrid("unselectAll");
                                																$.messager.show({
                                    																			msg : '',
                                    																			title : 'chenggong'
                                																		});
                            															}
                        														});
                        												alert(ids.join(','));
                    											}
                										});
                					} else {
                						$.messager.alert("提示","请选择要删除的行", "error");
            					}
        				}
    			},
    			'-',
    			{
        				text : '修改',
        				iconCls : 'icon-edit',
        				handler : function() {
            					var rows = datagrid.datagrid("getSelections");
            					if (rows.length == 1) {												
                						if (editRow != undefined) {
                    							datagrid.datagrid("endEdit", editRow);
                						}												
                						if (editRow == undefined) {
                    							var index = datagrid.datagrid("getRowIndex",rows[0]);
                    							datagrid.datagrid("beginEdit", index);
                    							editRow = index;
                    							datagrid.datagrid("unselectAll");
                						}
                					}else{
                					 $.messager.show({
                    						msg : '请选择一行',
                    						title : '错误'
                					  });
            					}
        				}
    			},
    			'-',
    			{
        				text : '保存',
        				iconCls : 'icon-save',
        				handler : function() {
            					datagrid.datagrid("endEdit",editRow);
        				}
        			}, '-', {
        				text : '取消编辑',
        				iconCls : 'icon-redo',
        				handler : function() {
            					editRow = undefined;
            					datagrid.datagrid("rejectChanges");
            					datagrid.datagrid("unselectAll");
        				}
    			}, '-' ],
    	onAfterEdit : function(rowIndex, rowData, changes) {
        		var inserted = datagrid.datagrid("getChanges","inserted");
        		var updated = datagrid.datagrid("getChanges","updated");
        		var url = "";
        		if (inserted.length > 0) {
            			url = "fygksave.jsp";
        		}
        		if (updated.length > 0) {
            			url = "UserAction.jsp?cmd=xxx";
        		}
        		$.ajax({
            			url : url,
            			data : rowData,
            			dataType : 'json',
            			success : function(r) {
                				if (r) {
                    					datagrid.datagrid("acceptChanges");
                    					$.messager.show({
                        						msg : '操作成功',
                        						title : '提示'
                    					});
                    				} else {
                    					datagrid.datagrid("rejectChanges");
                    					$.messager.alert("提示", "操作失败","error");
                				}
                				/* editRow = undefined;
                				datagrid.datagrid("unselectAll"); */
            			}
        		});
        		editRow = undefined;
        		datagrid.datagrid("unselectAll");
    	},
      onRowContextMenu : function(e,rowIndex, rowData) {	
        	   e.preventDefault(),
        	   $(this).datagrid("unselectAll");
        	   $(this).datagrid("selectRow", rowIndex);
        	   $('menu').menu('show', {    
                                  left: e.pageX,
                                  top: e.pageY
                          }); 
    	},
    	onDblClickRow : function(rowIndex, rowData) {
        		if (editRow != undefined) {
            			datagrid.datagrid("endEdit", editRow);
        		}
        		if (editRow == undefined) {
            			datagrid.datagrid("beginEdit", rowIndex);
            			editRow = rowIndex;
        		}
    	}
})
//$('.datagrid-header div').css("textAlign","center");
})
</script>
</head>
<script type="text/JavaScript">
</script>
<body>
<table id="dd">
</table>
<div id="menu" class="easyui-menu" style="width:120px;display:none;">
<div onClick="" iconCls="icon-add">增加</div>
<div onClick="" iconCls="icon-remove">删除</div>
<div onClick="" iconCls="icon-edit">修改</div>
</div>
</body>
</html>
