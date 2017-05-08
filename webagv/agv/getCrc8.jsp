<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.software.util.*,com.software.common.*"%>
<%@page import="java.io.*,java.util.*"%>
<%
String send1 = ParamUtils.getParameter(request,"send1","");
//send1 ="A0B0000009A100";
byte[] aaa = new byte[100];
 String[] cmds = send1.split("_");


aaa=Utils.hexStringToBytes2(send1.replace("_", ""));
int crc8 = CRC8.calcCrc8(aaa);
//out.println(crc8);
int a = crc8 & 0xff;
//out.println(a);
//将byte转换成int，然后利用Integer.toHexString(int)来转换成16进制字符串
//out.clear();  
out.print(send1.replace("_", ",")+",00,"+Integer.toHexString(a).toUpperCase());%>
