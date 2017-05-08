<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<meta http-equiv="x-ua-compatible" content="IE=edge" >
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/demo/demo.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/syUtil.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/extEasyUIIcon.css?v=201305232126" type="text/css">
	<style type="text/css"> 
.jqueryform{ width:100%;}
.jqueryform td{border:solid #add9c0; border-width:0px 1px 1px 0px;height:25px}
.jqueryform table{border:solid #6193b8; border-width:0px 0px 0px 0px;}
.jqueryform table td p{ padding:2px 0;}
#jqueryform .td_label {
  background : #E1E8FF;
  color:#00080;
}
#jqueryform .td_value
{
	background : #ffffff;
    color:#00080;
    }
.title_bgcolor{
	background:#BDDFFF;
	color:#00080;
	font-size:12pt;
	height:35px;
	font-weight:bold;
	}
.title_color{color : #BDDFFF;font-size:9pt}
	</style>
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true;}
			if ($('#dadagrid').datagrid('validateRow', editIndex)){
				var ed = $('#dadagrid').datagrid('getEditor', {index:editIndex,field:'productid'});
				var productname = $(ed.target).combobox('getText');
				$('#dadagrid').datagrid('getRows')[editIndex]['productname'] = productname;
				$('#dadagrid').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickRow(index){
			if (editIndex != index){
				if (endEditing()){
					$('#dadagrid').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					editIndex = index;
				} else {
					$('#dadagrid').datagrid('selectRow', editIndex);
				}
			}
		}
		function accept(){
			if (endEditing()){
				$('#dadagrid').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dadagrid').datagrid('rejectChanges');
			editIndex = undefined;
		}
		function getChanges(){
			var rows = $('#dadagrid').datagrid('getChanges');
			alert(rows.length+' rows are changed!');
		}
		
	</script>