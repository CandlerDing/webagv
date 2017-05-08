<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%
UserInfo userInfo = Tool.getUserInfo(request);
if(userInfo==null)
{
	out.clear();
	out.print("[]");
	return 	;
}
String depid = "a";//审核单位depid
String id = ParamUtils.getParameter(request,"id","");
String text = ParamUtils.getParameter(request,"text","");

String flag = ParamUtils.getParameter(request,"flag","");
String depname = ParamUtils.getParameter(request,"depname","");

List row = new ArrayList();
List rows = new ArrayList();
if(id.equals(""))
{
	List cdt = new ArrayList();
	User_ModuleList um = new User_ModuleList();
	User_Module module = new User_Module();
    cdt.add("pid=0");
   cdt.add("moduletype='档案管理'");
    cdt.add("order by remark");
	List<User_Module> modules = module.query(cdt);	
	for(int i=0;i<modules.size();i++)
	{
		module = modules.get(i);
		cdt.clear();
		 boolean allPow = false;
		 if(module.getCanShu().equals("*"))
         {
        	 allPow = true;                	 
         }
		 cdt.clear();
		 cdt.add("userid='"+userInfo.getId()+"'");
         cdt.add("moduleId='"+ module.getId()  +"'");
            
        // List<User_ModuleListCode> userModules1 = userModule.query(cdt);
         if(allPow || (um.getCount(cdt)>0))
         {
     		row.add("\"id\":\""+ module.getId() +"\"");
    		row.add("\"text\":\""+module.getName()+"\"");
    		//看有没有下级权限
    		cdt.clear();
    		cdt.add("pid='"+ module.getId()+"'");
    		List<User_Module> tempums = module.query(cdt);
    		boolean hasNext = false;
    		for(int j=0;j<tempums.size();j++)
    		{
    			User_Module tum = tempums.get(j);
    			  cdt.clear();
    			 cdt.add("userid='"+userInfo.getId()+"'");
    	         cdt.add("moduleId='"+ module.getId()  +"'");
    	        if(tum.getCanShu().equals("*") || um.getCount(cdt)>0)
    	        {
    	        	hasNext = true;
    	    		    	        	
    	        }
    		}
    		if(hasNext)
    		{
    			row.add("\"state\":\"closed\"");
    		}else
    		{
    			row.add("\"state\":\"open\"");
    		}
    		row.add("\"attributes\":{\"url\":\""+ module.getFileName() +"\"}");
    		
    		rows.add("{" + Tool.join(",", row) + "}");
        	 
         }
	}
	if(userInfo.isAdmin())
	{
		row.add("\"id\":\"00\"");
		row.add("\"text\":\"权限设置\"");
		row.add("\"state\":\"closed\"");
		row.add("\"attributes\":{\"url\":\"\"}");
		
		rows.add("{" + Tool.join(",", row) + "}");
		}
} else if(id.length()>0 && !id.equals("00"))
{
	
	List cdt = new ArrayList();
	User_ModuleList um = new User_ModuleList();
	User_Module module = new User_Module();
    cdt.add("pid='"+ id +"'");
    cdt.add("order by remark");
	List<User_Module> modules = module.query(cdt);
	for(int i=0;i<modules.size();i++)
	{
		module = modules.get(i);
		cdt.clear();
		 boolean allPow = false;
		 if(module.getCanShu().equals("*"))
         {
        	 allPow = true;                	 
         }
		 cdt.clear();
		 cdt.add("userid='"+userInfo.getId()+"'");
         cdt.add("moduleId='"+ module.getId()  +"'");
       
         if(allPow || (um.getCount(cdt)>0))
         {
     		row.add("\"id\":\""+ module.getId() +"\"");
    		row.add("\"text\":\""+module.getName()+"\"");
    		//看有没有下级权限
    		cdt.clear();
    		cdt.add("pid='"+ module.getId()+"'");
    		List<User_Module> tempums = module.query(cdt);
    		boolean hasNext = false;
    		for(int j=0;j<tempums.size();j++)
    		{
    			User_Module tum = tempums.get(j);
    			  cdt.clear();
    			 cdt.add("userid='"+userInfo.getId()+"'");
    	         cdt.add("moduleId='"+ module.getId()  +"'");
    	        if(tum.getCanShu().equals("*") || um.getCount(cdt)>0)
    	        {
    	        	hasNext = true;
    	    		    	        	
    	        }
    		}
    		if(hasNext)
    		{
    			row.add("\"state\":\"closed\"");
    		}else
    		{
    			row.add("\"state\":\"open\"");
    		}
    		row.add("\"attributes\":{\"url\":\""+ module.getFileName() +"\"}");
    		
    		rows.add("{" + Tool.join(",", row) + "}");
        	 
         }
	}
	
}else if(id.length()>0 && id.equals("00"))
{
	row.add("\"id\":\"0001\"");
	row.add("\"text\":\"模块设置\"");
	row.add("\"state\":\"open\"");
	row.add("\"attributes\":{\"url\":\""+request.getContextPath()+"/admin/role_index_treenew.jsp?cmd=UserModule&ModuleType=touchservice\"}");
	rows.add("{" + Tool.join(",", row) + "}");
	
	row.add("\"id\":\"0002\"");
	row.add("\"text\":\"权限设置\"");
	row.add("\"state\":\"open\"");
	row.add("\"attributes\":{\"url\":\""+request.getContextPath()+"/admin/role_index_treenew.jsp?cmd=QuanXian&ModuleType=touchservice\"}");
	rows.add("{" + Tool.join(",", row) + "}");
} //admin/role_index_tree.jsp?cmd=UserModule
	String result = "[" + Tool.join(",", rows) + "]";
			out.clear();
			out.print(result);
		%>