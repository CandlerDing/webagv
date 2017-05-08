<%@ page language="java"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.main.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
	String flag = ParamUtils.getParameter(request, "flag", "");
%>
<html>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>AGV群控系统</title>
<link href="js/css.css" rel="stylesheet" type="text/css">
<!--[if lte IE 6]>
<script type="text/javascript" src="js/IMG_PNG.js"></script>
<![endif]-->
<script language="JavaScript">
	window.name = "bjmath_logon";
	ie4 = (document.all) ? true : false;
	ns4 = (document.layers) ? true : false;
	<!--
	//页面装载时,进行焦点定位
	//如果名字有内容同时选中了记住名字
	//则焦点转移到密码框
	function setFocus() {
		if (document.logon.txt_username.value != "") {
			document.logon.txt_password.focus();
		} else {
			document.logon.txt_username.focus();
		}
		return;
	}
	//检测到回车就提交
	function keyEnter(iKeyCode) {
		//仅对于IE有效
		if (ie4) {
			if (window.event.keyCode == 13) {
				checkuser();
			}
		}
	}

	//检查用户输入，无误后提交
	function checkuser() {
		if (document.logon.txt_username.value == "") {
			alert("请输入用户名字！");
			document.logon.txt_username.focus();
			return;
		}
		if (document.logon.txt_password.value == "") {
			alert("请输入用户密码！");
			document.logon.txt_password.focus();
			return;
		}
		if (document.getElementById("hasPwd").checked) {
			setLoginCookie();
		} else {
			deleteCookie();
		}
		document.logon.submit();
		document.logon.txt_password.value = ""

	}
//-->
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	//让index始终在最上层，不嵌入到别的frame中
	if (top != window) {
		top.location.href = "logon.jsp";
	}
	function clearform(form) {
		form.username.value = "";
		form.password.value = "";

	}
	function SetHome() {
		if (document.all) {
			document.body.style.behavior = 'url(#default#homepage)';
			document.body.setHomePage(window.location.href);
		} else if (window.sidebar) {
			if (window.netscape) {
				try {
					netscape.security.PrivilegeManager
							.enablePrivilege("UniversalXPConnect");
				} catch (e) {
					alert("该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config ,然后将项 signed.applets.codebase_principal_support 值该为true");
					history.go(-1);
				}
			}

			var prefs = Components.classes['@mozilla.org/preferences-service;1']
					.getService(Components.interfaces.nsIPrefBranch);
			prefs.setCharPref('browser.startup.homepage', window.location.href);
		}
	}

	//填充用户名称密码
	function getLoginCookie() {
		var username = getCookie("jnzyName");
		var password = getCookie("jnzyPwd");
		if (username != null && username != "" && password != null
				&& password != "") {
			document.getElementById("txt_username").value = username;
			document.getElementById("txt_password").value = password;
			document.getElementById("hasPwd").checked = true;
		}
	}

	function getCookie(c_name) //根据分隔符每个变量的值
	{
		if (document.cookie.length > 0) {
			c_start = document.cookie.indexOf(c_name + "=");
			if (c_start != -1) {
				c_start = c_start + c_name.length + 1;
				c_end = document.cookie.indexOf("@@@", c_start);
				if (c_end == -1)
					c_end = document.cookie.length;
				return unescape(document.cookie.substring(c_start, c_end));
			}
		}
		return "";
	}

	function deleteCookie() {

		var exdate = new Date();
		exdate.setDate(exdate.getDate() - 1000);
		document.cookie = "jnzyName=^;expires=" + exdate.toGMTString();
	}
	function setLoginCookie() {

		var username = document.getElementById("txt_username").value;
		var password = document.getElementById("txt_password").value;
		setCookie("jnzyName", username, "jnzyPwd", password, 30);
	}

	function setCookie(c_name, n_value, p_name, p_value, expiredays) //设置cookie
	{
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + expiredays);
		document.cookie = c_name
				+ "="
				+ escape(n_value)
				+ "@@@"
				+ p_name
				+ "="
				+ escape(p_value)
				+ ((expiredays == null) ? "" : "@@@;expires="
						+ exdate.toGMTString());

	}
	function topWin() {
		window.open("topwin.jsp", "", "width=1000px,height=600px");
	}
//-->
</SCRIPT>
<style>
.bg {
	background: #3c86c7 url('../images/bg2012.jpg') repeat-x left top;
}
</style>
</head>
<body oncontextmenu="return false" onselectstart="return false;"
	topmargin="0" leftmargin="0" class="bg"
	onkeypress="javascript:keyEnter(event.keyCode);"
	onLoad="getLoginCookie();">
	<div align="center">
		<table border="0" width="100%" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td align="center">
					<table border="0" width="1000" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table>
									<tr>
										<!-- <td valign="middle"> <img src="images/logo.png" border="0"
											 style="height: 50;"></td> -->
										<td valign="middle"><img src="images/company.png"
											border="0" align="left" /> <!-- images/logo.png  -旧--></td>
									</tr>
								</table>
							</td>
							<td valign="bottom"></td>
						</tr>
					</table>
					<table border="0" width="1000" cellspacing="0" cellpadding="0"
						background="images/c002.jpg">
						<tr>
							<td width="20"><img border="0" src="images/c001.jpg"
								width="20" height="400"></td>
							<td width="960">
								<table border="0" width="100%">
									<tr>
										<td width="20"></td>
										<td>
											<table border="0" bgcolor="#fffffff">
												<tr>
													<td><iframe src="flash/index.jsp" frameborder="0"
															SCROLLING="no" width=600px height=340px></iframe></td>
												</tr>
											</table>
										</td>
										<td>
											<table border="0" width="100%" cellpadding="0">
												<tr>
													<td><img border="0" src="images/login.gif" width="120"
														height="57"></td>
												</tr>
												<tr>
													<td height="20"></td>
												</tr>
											</table>
											<form name="logon" id="logon" action="enter.jsp"
												method="post">
												<input type="hidden" value="submit" name="hdn_submit_sign">
												<table border="0" width="100%" cellpadding="6">
													<tr>
														<td align="right">用户名</td>
														<td><input type="text" size="31"
															style="border: 1px solid #C0C0C0" id=txt_username
															name="txt_username" onFocus="this.select(); "
															onMouseOver="this.style.background='#E1F4EE';"
															onMouseOut="this.style.background='#FFFFFF'"></td>
													</tr>
													<tr>
														<td align="right">密&nbsp; 码</td>
														<td><input size="34"
															style="border: 1px solid #C0C0C0" id=txt_password
															type=password name=txt_password onFocus="this.select(); "
															onMouseOver="this.style.background='#E1F4EE';"
															onMouseOut="this.style.background='#FFFFFF'"></td>
													</tr>
													<tr>
														<td align="right"></td>
														<td><input type="checkbox" name="hasPwd" id="hasPwd"
															value="1" />记住密码</td>
													</tr>
													<tr>
														<td></td>
														<td>
															<table border="0">
																<tr>
																	<td onClick="checkuser();" style="cursor: pointer">
																		<table border="0" width="60" cellspacing="0"
																			cellpadding="0" background="images/anniu.gif"
																			height="26">
																			<tr>
																				<td align="center"><b class="ald">登录</b></td>
																			</tr>
																		</table>

																	</td>
																	<td></td>
																	<td onClick="self.close();" style="cursor: pointer">
																		<table border="0" width="60" cellspacing="0"
																			cellpadding="0" background="images/anniu.gif"
																			height="26">
																			<tr>
																				<td align="center"><b class="ald">退出</b></td>
																			</tr>
																		</table>
																	</td>
																	<td></td>
																	<td></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</form>
										</td>
										<td width="20"></td>
									</tr>
								</table>
							</td>
							<td width="20"><img border="0" src="images/c003.jpg"
								width="20" height="400"></td>
						</tr>
					</table>
					<table border="0" width="1000" cellspacing="0" cellpadding="0">
						<tr>
							<td height="20"></td>
						</tr>
						<tr>
							<td align="center" style="height: 80px; line-height: 35px"><span
								style="font-size: 14px; font-weight: bold; color: #ffffff">————
									技术支持：158114330@qq.com ————</span> <br></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
