<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>��¼ҳ��</title>
<link href="<%=request.getContextPath() %>/css/stylelogon.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script language="JavaScript">
$(document).ready(function(){
    //��ȡCookie������û���
      getLoginCookie();
      });
//ҳ��װ��ʱ,���н��㶨λ
//�������������ͬʱѡ���˼�ס����
//�򽹵�ת�Ƶ������
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
//��⵽�س����ύ
function keyEnter(iKeyCode) 
{
	//������IE��Ч
	ie = (document.all)? true:false;
	if (ie){
		if(window.event.keyCode==13){
			checkuser();
		}
	}
	
}
function set_flag(flag)
{
	document.getElementById("flag").value=flag;
}
//��ⴰ�ڹر�
var timer;
function IfWindowClosed()
{
 if(openwin.closed == true)
  {
    //alert("��ȷ����Ҫ�˳���ϵͳ��");
    window.open("logoff.jsp","","width=100,height=100,left=100,top=100");
    window.clearInterval(timer);
  }
}
//����û����룬������ύ
function checkuser()
{
   if(document.getElementById("txt_username").value==""){
      alert("�������û����֣�");
      document.getElementById("txt_username").focus();
      return;
      //return false;
   }
   if(document.getElementById("txt_password").value==""){
      alert("�������û����룡");
      document.getElementById("txt_password").focus();
      return;
      //return false;
   }
   if(document.getElementById("chk_memoryme").checked)
	{
   	setLoginCookie();
	}else{
	 deleteCookie();
	}
   	  openwin=window.open("","beelink_web_oa_main","scrollbars=yes");
        openwin.moveTo(0,0);
	openwin.resizeTo(screen.width,screen.height-25);
	document.getElementById("logon").target="beelink_web_oa_main";
	document.getElementById("logon").method="post";
	document.getElementById("logon").action="enter.jsp";
	document.getElementById("logon").submit();
	document.getElementById("txt_password").value="";
	/* //��ⴰ�ڹر�
	timer=window.setInterval("IfWindowClosed()",500); */
   //return true;
}
//����û���������
function getLoginCookie(){
		var username= getCookie("jnzyName") ; 
		
		if(username!=null && username!=""){ 
		 	document.getElementById("txt_username").value=username;
		 	//document.getElementById("txt_password").value=password;
		 	document.getElementById("chk_memoryme").checked = true;
		  } 
	}

 function getCookie(c_name)      //���ݷָ���ÿ��������ֵ
 {
     if (document.cookie.length > 0) {
         c_start = document.cookie.indexOf(c_name + "=");
         if (c_start != -1) { 
             c_start = c_start + c_name.length + 1;
             c_end = document.cookie.indexOf("@@@",c_start);
             if (c_end==-1)
                 c_end=document.cookie.length;
             return unescape(document.cookie.substring(c_start,c_end));
     } 
   }
     return "";
 }
 
 function deleteCookie(){
	 
	 var exdate = new Date();
     exdate.setDate(exdate.getDate() - 1000);
     document.cookie = "jnzyName=^;expires=" + exdate.toGMTString();
 }
 function setLoginCookie(){
		
		var username=document.getElementById("txt_username").value;
        setCookie("jnzyName", username,  30);
	}
 
 function setCookie(c_name, n_value, expiredays)        //����cookie
 {
     var exdate = new Date();
     exdate.setDate(exdate.getDate() + expiredays);
     document.cookie = c_name + "=" + escape(n_value) + ((expiredays == null) ? "" : "@@@;expires=" + exdate.toGMTString());
 }
</script>
</head>
<body class="bj">
<!--[if IE 6]>
<script src="js/png.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('.header_m img');
DD_belatedPNG.fix('.biaozhi img');
</script>
<![endif]-->
<div class="header">
	<div class="header_m"><img src="<%=request.getContextPath() %>/images/logog.png" width="704" height="85" /></div>
</div>
<div class="content">
 <form name="logon" id="logon" action="enter.jsp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%">�û�����</td>
    <td width="82%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="62%"><input type="text" name="txt_username" id="txt_username" size="32" value=""  onfocus="this.select()" onmouseover="this.focus()" title="���ڴ˴������û���¼��"/></td>
        <td width="6%"><input type="checkbox" name="chk_memoryme" id="chk_memoryme" value="on" checked="checked" /></td>
        <td width="32%">��ס����</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>���룺</td>
    <td><input type="password" name="txt_password" id="txt_password" size="32"  onfocus="this.select()" onmouseover="this.focus()" title="���ڴ˴������û�����"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="button" name="button" id="confirm" onclick='checkuser();' value="�ύ" />
    </label></td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="14%">&nbsp;</td>
        <td width="6%"><input type="hidden" id="flag" name="flag" value="1"/> <input name="rad_gotourl" id="rad_gotourl" type="radio" value="2" checked="checked"  onclick='set_flag(1);'/></td>
        <td width="30%">��¼���칫ϵͳ</td>
        <td width="6%"><input name="rad_gotourl" id="rad_gotourl" type="radio" value="2" onclick='set_flag(2);'/></td>
        <td width="30%">��¼��ϵͳά�� </td>
        <td width="14%">&nbsp;</td>
      </tr>
    </table></td>
    </tr>
</table></form>
<div class="biaozhi"><img src="<%=request.getContextPath() %>/images/guow.png"  /></div>
</div>
<div class="footer">�����������Web_OAϵͳ �汾��2.0 </div>
</body>
</html>