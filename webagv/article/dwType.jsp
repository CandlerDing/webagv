<%@page language="java"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.software.main.*,com.software.main.db.*"%>
<%@page import="com.software.util.*,com.software.common.*,com.software.system.*"%>
<%@page import="java.io.*,java.util.*" %>
<%@page import="org.apache.commons.logging.*"%>
<%@ page import="org.json.JSONArray,org.json.JSONObject" %>
<%
int id = ParamUtils.getIntParameter(request,"id",0);
Article jnwj = new Article(); 
List cdt = new ArrayList();
cdt.add("ischeck=1");
cdt.add("order by id ");
List<Article>jnwjs = jnwj.query(cdt);
String result = "";	

	if (jnwjs.size() > 0) {
		
		List row = new ArrayList();
		List rows = new ArrayList();
		for (int i = 0; i < jnwjs.size(); i++) {
			jnwj = jnwjs.get(i);
			row = new ArrayList();
			
			row.add("\"id\":\"" + jnwj.getId() + "\"");
			row.add("\"text\":\"" + jnwj.getTitle() + "\"");
			row.add("\"state\":\"open\"");
			row.add("\"attributes\":{\"url\":\"" + jnwj.getSiteurl() + "\"}");
			rows.add("{" + Tool.join(",", row) + "}");
		}
		result = result + "[" + Tool.join(",", rows) + "]";
	}	
   
	out.clear();
	out.print(result);
%>