<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,agv.communication.client.*"%>
<%@ page import="org.apache.commons.logging.*,com.software.util.*,com.software.main.*"%>
<%
String  code = ParamUtils.getParameter(request,"code","");
Car car = new Car(); 
car = car.getById(7);
System.out.println("code=="+code);
CommucationClient  commucationClient = new CommucationClient(car);
System.out.println(car.getName()+"Á¬½Ó£º"+commucationClient.isCommunicatting());
if(commucationClient.isCommunicatting())
{
    String command = null;
    if(code.equals("getDetailDebug"))
    {
    	 command = agv.protocol.ComCarState.getDetailDebug();	
    }else if(code.equals("getSearchControl"))
    {
    	 command = agv.protocol.ComCarState.getSearchControl();	
    }   
    commucationClient.sendCarCommand(command);
    
}              

%>
