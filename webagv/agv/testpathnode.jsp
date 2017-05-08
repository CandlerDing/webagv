<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.agvmap.model.AGVMap,com.agvmap.model.PathNode,com.software.main.db.PathBs"%>
<%@ page import="org.apache.commons.logging.*,com.agvdirecting.DirectingSystem"%>
<%
DirectingSystem directingSystem = DirectingSystem.GetInstance();

// ¼ÓÔØµØÍ¼
directingSystem.loadMap("C:\\test\\simple.agvcad");

AGVMap  agvMap= directingSystem.getMap();
out.println("agvMap="+agvMap.toString());
List<PathNode>pnodes = agvMap.getPathNodes();
out.println("size="+pnodes.size());
if(pnodes.size()>0){
for(int i=0;i<pnodes.size();i++)
{
	PathBs pb = new PathBs();
	out.println("ID="+pnodes.get(i).getID());
	out.println("Name="+pnodes.get(i).getName());
	pb.setOnlyId(pnodes.get(i).getID());
	pb.setName(pnodes.get(i).getName());
	pb.insert();
}
}
%>
