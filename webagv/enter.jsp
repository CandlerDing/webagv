<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.main.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%!
private static Log log = LogFactory.getLog(com.software.common.PageControl.class);
%>
<%
CUserPower userPower = new CUserPower();
String userName=ParamUtils.getParameter(request,"txt_username","-1");
String passWord=ParamUtils.getParameter(request,"txt_password","-1");
String userType=ParamUtils.getParameter(request,"txt_usertype","-1");//用户类型
String hasPwd=ParamUtils.getParameter(request,"hasPwd","");//是否记住用户名、密码

Vector condition = new Vector();

	condition.add("LOGID='" + userName + "'");
	User v = new User();       
	User[] uc = v.queryByCondition(condition);
	 Asso ola = new Asso();
     List cdt = new ArrayList();
     /*   SysSet sysset = new SysSet();
     sysset = sysset.getById(1);
     int num = sysset.getOnlinenum();
     if(ola.getCount(cdt)>=num){
    	 out.print(HtmlTool.msgBox("管理员只允许"+num+"人在线,请稍后再试或联系管理员", request.getContextPath()+"/logon",""));
 	    return;	 
     } */
	if(uc.length < 1) {out.print(userName);
	    out.print(HtmlTool.msgBox("请输入正确的用户名和密码! ", request.getContextPath()+"/logon",""));
	    return;
	   }
	/* if(uc[0].getErrorNum()==3){
		out.print(HtmlTool.msgBox("密码输错3次,请联系管理员重置密码! ", request.getContextPath()+"/logon",""));
	    return;
	} */
       // String pwd = userPower.getPwd(uc[0].getLOGPASS());
        passWord=Tool.getDigest(passWord.trim());
        String pwd = uc[0].getLOGPASS();
        out.print("pwd=="+pwd+"--passWord=="+passWord);
        if(!pwd.trim().equals(passWord))
        {  /*  uc[0].setErrorNum(uc[0].getErrorNum()+1); */
            uc[0].update();
            out.print(HtmlTool.msgBox("请输入正确的用户名和密码1! ", request.getContextPath()+"/logon",""));
	    return;
        }       
        uc[0].setIp(IPFilter.getIpAddr(request));
          UserInfo ui = new UserInfo(uc[0]);
          ui.setJsId(session.getId());
       //   log.error("===jsid===="+ui.getJsId());
          Cookie cookie = new Cookie(HeadConst.MainCookieName,  ui.getId()+"" );
          response.addCookie(cookie);
          ui.addCookie(response);
          session.setAttribute("UserInfo", ui);
          request.setAttribute("UserInfo",ui);      
       
          CUserPower kaoqin = new CUserPower();        
                 
          String jsId = session.getId();
          kaoqin.login(request,jsId);
          Cookie jnzyCookiejsid = new Cookie(HeadConst.MainCookieName+"jsID", jsId);
        
          jnzyCookiejsid.setMaxAge(60000);
          jnzyCookiejsid.setValue(session.getId());
          jnzyCookiejsid.setPath("/");
          response.addCookie(jnzyCookiejsid);
          response.sendRedirect(request.getContextPath() + "/indexnew.jsp");
        
        %>