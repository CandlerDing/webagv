<%@ page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,com.service.command.*"%>
<%@ page import="org.apache.commons.logging.*,com.service.commucation.client.*"%>
<%@ page import="com.software.util.*,com.software.main.*"%>
<%@ page import="com.agvdirecting.*"%>
<%
	DirectingSystem directingSystem = DirectingSystem.GetInstance();
   directingSystem.loadMap("C:\\test\\simple.agvcad");
   directingSystem.setPort("9123");
   directingSystem.getSvcCommucationServer().open();
   directingSystem.execute();
%>
