<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.main.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>

<HTML>
<HEAD>
<TITLE>AGV智能调度系统</TITLE>
<link href="<%=request.getContextPath()%>/images/logon/css.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
window.name="sdgzjy_logon";
ie4 = (document.all)?true:false;
ns4 = (document.layers)?true:false;
//<!--
//页面装载时,进行焦点定位
//如果名字有内容同时选中了记住名字
//则焦点转移到密码框
function setFocus()
{
    if (document.logon.txt_username.value != ""){
        document.logon.txt_password.focus();
    }
    else{
        document.logon.txt_username.focus();
    }
    return;
}
//检测到回车就提交
function keyEnter(iKeyCode)
{
	 //仅对于IE有效
    if (ie4){
        if(window.event.keyCode==13){
            checkuser();
        }
    }
}

//检查用户输入，无误后提交
function checkuser()
{
    if(document.logon.txt_username.value==""){
    	 alert("请输入用户名字！");
        document.logon.txt_username.focus();
        return;
    }
    if(document.logon.txt_password.value==""){
    	alert("请输入用户密码！");
        document.logon.txt_password.focus();
        return;
    }
   var username=document.getElementById("txt_username").value;
   var paw=document.getElementById("txt_password").value;
   document.logon.action="enter.jsp?txt_username="+username+"&txt_password="+paw;
    document.logon.submit();
}
//-->

</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
//让index始终在最上层，不嵌入到别的frame中
if(top!=window){
	top.location.href="logon.jsp";
}
function clearform(form){
	//form.reset();
	form.username.value="";
	form.password.value="";

}
//-->
</SCRIPT>
</head>

<body style="background-color: #4a8fc2" topmargin="0" onkeypress="javascript:keyEnter(event.keyCode);" onload="javascript:setFocus();">
<form name="logon" id="logon" action="enter.jsp" method="post">
			<input type="hidden" value="submit" name="hdn_submit_sign">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%">
	<tr>
		<td align="center">
		<table border="0" width="100%" cellspacing="0" cellpadding="0" height="600">
			<tr>
				<td align="center">
				<table border="0" cellspacing="0" cellpadding="0" height="118">
					<tr>
						<td>   </td>
					</tr>
				</table>
				<table border="0" width="650" cellspacing="0" cellpadding="0">
					<tr>
						<td width="16"><img border="0" src="<%=request.getContextPath()%>/images/logon/001.gif" width="16" height="16"></td>
						<td background="<%=request.getContextPath()%>/images/logon/005.gif"></td>
						<td width="16"><img border="0" src="<%=request.getContextPath()%>/images/logon/002.gif" width="16" height="16"></td>
					</tr>
					<tr>
						<td background="<%=request.getContextPath()%>/images/logon/006.gif"></td>
						<td bgcolor="#FFFFFF" align="center">
						<table border="0" width="100%">
							<tr>
								<td>
								<img border="0" src="<%=request.getContextPath()%>/images/logon/mingcheng.gif"  height="106"></td>
							</tr>
						</table>
						<table border="0" width="90%">
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td background="<%=request.getContextPath()%>/images/logon/line2.gif"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>

				<table border="0" cellpadding="6">
					<tr>
						<td>用户名</td>
						<td>
						<input type="text" id="txt_username" name="txt_username" size="29" style="border: 1px solid #C0C0C0" maxlength=20  onFocus="this.select(); " onMouseOver="this.style.background='#E1F4EE';"  onMouseOut="this.style.background='#FFFFFF'" title="请在此处输入登陆用户名称"></td>
					</tr>
					<tr>
						<td>密&nbsp; 码</td>
						<td>
						<input type="password" id="txt_password" name="txt_password" size="29" style="border: 1px solid #C0C0C0" maxlength=20  onFocus="this.select(); " onMouseOver="this.style.background='#E1F4EE';"  onMouseOut="this.style.background='#FFFFFF'" title="请在此处输入用户密码"></td>
					</tr>
					
				</table>
						<table border="0" width="90%">
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td background="<%=request.getContextPath()%>/images/logon/line2.gif"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>
				<table border="0">
					<tr>
						<td width="39"></td>
						<td width="90">
						<img border="0" src="<%=request.getContextPath()%>/images/logon/btn_login.gif" width="75" height="25" onclick="javascript:checkuser();" style="cursor:hand"></td>
						<td align="right"></td>
						<td>
						<!--img border="0" src="<%=request.getContextPath()%>/images/logon/btn_reg.gif" width="74" height="25"--></td>
					</tr>
				</table>
						</td>
						<td background="<%=request.getContextPath()%>/images/logon/007.gif"></td>
					</tr>
					<tr>
						<td width="16"><img border="0" src="<%=request.getContextPath()%>/images/logon/003.gif" width="16" height="16"></td>
						<td background="<%=request.getContextPath()%>/images/logon/008.gif"></td>
						<td width="16"><img border="0" src="<%=request.getContextPath()%>/images/logon/004.gif" width="16" height="16"></td>
					</tr>
				</table>
				<table border="0" width="650" cellspacing="0" cellpadding="0" background="<%=request.getContextPath()%>/images/logon/y002.gif">
					<tr>
						<td>
						<img border="0" src="<%=request.getContextPath()%>/images/logon/y001.gif" width="16" height="113"></td>
						<td align="center">技术支持：山东亚历山大智能科技有限公司</td>
						<td align="right">
						<img border="0" src="<%=request.getContextPath()%>/images/logon/y003.gif" width="16" height="113"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>

</html>
