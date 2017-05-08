<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(Tool.class);
private UserInfo userInfo = null;
private static final String[] allFormNames = {};
private String Name;
private String Id;
private String Code;


 private void setDictCode(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String deptid=ParamUtils.getParameter(request,"deptid","0001");
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                DictCode um=new DictCode();
		List cdt = new ArrayList();
       
		cdt.add("order by id");
		Map imap = um.initParentMap(cdt);
		String treeRootKey = um.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"参数管理\", \"javascript:tree0Click();\", \"[{type:'DictCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"参数管理\", \"javascript:tree0Click();\", \"[{type:'DictCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else
			{
			 int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			DictCode pv = (DictCode)it.next();
					 if(j==0)
		             {
		               Id = String.valueOf(pv.getId());
		               Name = pv.getName();
		             }
		             j++;
                      TreeItem ti = um.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
	}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
} 

private void setArticleTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                Channel v = new Channel();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by id");
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    Channel pv = (Channel)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
		}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}

private void setArticleCheckBoxTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                Channel v = new Channel();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by id");
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    Channel pv = (Channel)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
//                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
strTree.append(TreeTool.getCheckBoxTree(ti,"",1,"",""));
//                      strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1));
                    }
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setCarCodeTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String deptid=ParamUtils.getParameter(request,"Classid","0001");
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
     Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
     String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
     Car v = new Car();
     List cdt = new ArrayList();
     cdt.add("order by id");
		Map imap = v.initParentMap(cdt);		
		String treeRootKey = v.findRootKey(imap);		
		String treeStr = "var tree = new WebFXTree(\"车辆管理\", \"javascript:tree0Click();\", \"[{type:'CarCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"车辆管理\", \"javascript:tree0Click();\", \"[{type:'CarCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else
			{
			 int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			Car pv = (Car)it.next();		
                      if(j==0)
                      {
                        Id = String.valueOf(pv.getId());
                        Name = pv.getName();
                      }
                      j++;
                     // System.out.print("Name==="+Name);
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListDESC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"Classid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
	}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
} 
private void setTaskTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String deptid=ParamUtils.getParameter(request,"Classid","0001");
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
     Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
     String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
     Task v = new Task();
     List cdt = new ArrayList();
     cdt.add("order by id");
		Map imap = v.initParentMap(cdt);		
		String treeRootKey = v.findRootKey(imap);		
		String treeStr = "var tree = new WebFXTree(\"任务管理\", \"javascript:tree0Click();\", \"[{type:'TaskTree',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"任务管理\", \"javascript:tree0Click();\", \"[{type:'TaskTree',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else
			{
			 int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			Task pv = (Task)it.next();		
                      if(j==0)
                      {
                        Id = String.valueOf(pv.getId());
                        Name = pv.getName();
                      }
                      j++;
                     // System.out.print("Name==="+Name);
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListDESC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"Classid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
	}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
} 
private List mkRtn(String cmd, String forward)
{
    List rtn = new ArrayList();
    rtn.add(cmd);
    rtn.add(forward);
    return rtn;
}
public List main(javax.servlet.http.HttpServletRequest request)
{
    String cmd = ParamUtils.getParameter(request,"cmd","DeptCode");
    log.debug("cmd=" + cmd);

    
    if (cmd.equals("DictCode")) {
        setDictCode(request);
        return mkRtn(cmd, cmd);
    }
   
    if (cmd.equals("CarCode")) {
        setCarCodeTree(request);
        return mkRtn(cmd, cmd);
    }
    if (cmd.equals("TaskTree")) {
        setTaskTree(request);
        return mkRtn(cmd, cmd);
    }
    
    if ( cmd.equals("ArticleCode") || cmd.equals("ArticleCodeModi") || cmd.equals("ChannelCode")) {
        setArticleTree(request);
        return mkRtn(cmd, cmd);
    }
    if ( cmd.equals("ChannelSelect")) {
      setArticleCheckBoxTree(request);
       return mkRtn(cmd, cmd);
    }
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("", "failure");
}
%>
<%
log.debug("list.jsp");
List rtn = null;
synchronized(this) {
    userInfo = Tool.getUserInfo(request);
    if (userInfo==null) {
        rtn = mkRtn("login", "login");
    }
    else {
        rtn = main(request);
    }
}
String cmd = (String)rtn.get(0);
String forwardKey = (String)rtn.get(1);
Map forwardMap = new HashMap();
forwardMap.put("login", "/logon");
forwardMap.put("failure", "Tree.jsp");
forwardMap.put("DeptCode", "Tree.jsp");
forwardMap.put("DeptUserCode", "Tree.jsp");
forwardMap.put("DeptUser", "Tree.jsp");
forwardMap.put("Daibiao", "Tree1.jsp");
forwardMap.put("Daibiaozy", "Tree1.jsp");
forwardMap.put("DictCode", "Tree.jsp");
forwardMap.put("DaTree", "Tree.jsp");
forwardMap.put("DaTreet", "Tree.jsp");
forwardMap.put("CarCode", "Tree.jsp");
forwardMap.put("TaskTree", "Tree.jsp");
forwardMap.put("SxTree", "Tree.jsp");
forwardMap.put("DzTree", "Tree.jsp");
forwardMap.put("JjTree", "Tree.jsp");
forwardMap.put("SwTree", "Tree.jsp");
forwardMap.put("TjTree", "Tree.jsp");
forwardMap.put("KjTree", "Tree.jsp");
forwardMap.put("AjTree", "Tree.jsp");
forwardMap.put("Qyml", "Tree.jsp");
forwardMap.put("Whsy", "Tree.jsp");
forwardMap.put("Zrzsy", "Tree.jsp");
forwardMap.put("Rmsy", "Tree.jsp");
forwardMap.put("Cfwzsy", "Tree.jsp");
forwardMap.put("Rmtree", "Tree.jsp");
forwardMap.put("Cfwztree", "Tree.jsp");
forwardMap.put("Jnwjmb", "Tree.jsp");
forwardMap.put("Daibiaojc", "Tree1.jsp");
forwardMap.put("ArticleCode", "TreeNode.jsp");
forwardMap.put("ChannelCode", "Tree.jsp");
forwardMap.put("ArticleCodeModi", "TreeNode.jsp");
forwardMap.put("ChannelSelect", "TreeCheckbox.jsp");

HttpTool.saveParameters(request, "TreeExt", allFormNames);
log.debug("cmd=" + cmd + ",forward=" + forwardKey);
pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&Id=" + Id + "&Name=" + Name+"&Code="+Code);
%>

