<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%
List cdt = new ArrayList();
cdt.clear();

Opeorder ope = new Opeorder();
List<Opeorder>opes = ope.query(cdt);
for(int i=0;i<opes.size();i++)
{
	ope = opes.get(i);
	if(ope.getRetvalue().length()>0){
	ope.setRemark(ope.getRetvalue().replace(",", "."));
	ope.update();
	}
	
}

%>
