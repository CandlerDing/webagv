<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.software.util.*,com.software.common.*,com.software.main.*"%>
<%@page import="java.io.*,java.util.*"%>
<%
String code1 = ParamUtils.getParameter(request,"code1","");
String code2 = ParamUtils.getParameter(request,"code2","");
String code3 = ParamUtils.getParameter(request,"code3","");
String ml = Commucation.ControlCar(code1,code2,code3);
out.println(ml);
/* byte[] aaa=Utils.hexStringToBytes2(ml.replace(",", ""));
int crc8 = CRC8.calcCrc8(aaa);
out.println(crc8);
int a = crc8 & 0xff; */
//out.println(a);
//将byte转换成int，然后利用Integer.toHexString(int)来转换成16进制字符串
out.clear();  
//out.print(ml+","+Integer.toHexString(a).toUpperCase());
out.print(ml);
%>
