<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,com.service.commucation.client.*"%>
<%@ page import="org.apache.commons.logging.*,com.software.util.*,com.software.main.*,com.service.command.*"%>
<%
String  code = ParamUtils.getParameter(request,"code","");
Car car = new Car(); 
car = car.getById(7);
SVCCommucationClient sCommucationClient = new SVCCommucationClient();

String directingSystemIP = "127.0.0.1";
String directingSystemPort = "9123";

sCommucationClient.setServerAddress(directingSystemIP, directingSystemPort);

sCommucationClient.open();
SVCBaseCmd cmd = null;
if(sCommucationClient != null) {

	System.out.println("==1==");

if(sCommucationClient.isCommunicatting())
{	System.out.println("==2==");
    String command = null;
   /*  if(code.equals("getDetailDebug"))
    {
    	 command = agv.protocol.ComCarState.getDetailDebug();	
    }else if(code.equals("getSearchControl"))
    {
    	 command = agv.protocol.ComCarState.getSearchControl();	
    }   
   */
    if(cmd != null) {
        sCommucationClient.sendSVCCommand(cmd);                    
    }
}  
}    
%>
