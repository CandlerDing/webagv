<%@ page language="java" %>
<%--预算单位编码表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(Tool.class); 
private UserInfo userInfo = null;
private static  String[] allFormNames = {"cmd","page","filter_ids","checked_ids","choice_type","type","item","items","userType"};
//private static final String[] allFormNames = {"cmd","page","Id","SetYear","Content","DeptId","Type"};
private String[] DicKeys = {"Id", "SetYear", "Content", "DeptId", "Type"};
private String[][] DicValues = {{"int", "id", "-1"}, {"string", "业务年度", "4"}, {"string", "字号内容", "40"}, {"int", "部门Id", "-1"}, {"int", "编码类型", "-1"}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "SetYear", "Content", "DeptId", "Type"};
private String[] Fields = {"SetYear", "Content", "Type"};
public Map initDeptParentMap(List cdt) {
   cdt.add("order by ordernum*1");
   System.out.println("==="+Tool.join(" and ",cdt));
   Office dc = new Office();
        List vs = dc.query(cdt);
        Map code2idmap = new HashMap();
        for (Iterator it = vs.iterator(); it.hasNext(); ) {
        	Office v = (Office)it.next();
            String id =""+ v.getId();
            code2idmap.put(id, "" + v.getId());
        }
        CodeUtils codeutils = new CodeUtils(HeadConst.splitType);
        Map map = new HashMap();
        for (Iterator it = vs.iterator(); it.hasNext(); ) {
        	Office v = (Office)it.next();
            String pid ="0";// (String)code2idmap.get(codeutils.getPcode(v.getCode()));
            if (pid == null) {
                pid = "0";
            }
            List child = (List)map.get(pid);
            if (child == null) {
                child = new ArrayList();
            }
            child.add(v);
            map.put(pid, child);
        }
        return map;
    }

//显示部门、用户的treebox ti是部门的tree
public static String getDeptUserCheckBoxTree(TreeItem ti, String treeName, String parent, int level, String checkedIds) {

StringBuffer rtnBack = new StringBuffer();
StringBuffer rtn = new StringBuffer();
String currlvl = "lvl" + level;
//部门都是不显示checkbox

//rtn.append(parent + ".add(" + currlvl + " = new WebFXTreeItem('" + ti.getName() + "'));\n");
String officeSelected = "0";

List cdt = new ArrayList();
String deptCode = ti.getCode();
Office dc = new Office();

cdt.add("ID="+ deptCode );//部门Code ，找到ID
List<Office> dcs = dc.query(cdt);
StringBuffer officeStr = new StringBuffer();
if(dcs!=null && dcs.size()>0)
{
 dc = dcs.get(0);
 officeStr.append("[{type:'office',");
 officeStr.append("id:'" + dc.getId() + "',");
 officeStr.append("pid:'0',");
 officeStr.append("code:'" + dc.getCode() + "',");
 officeStr.append("pcode:'',");
 officeStr.append("name:'" + dc.getName() + "',");
 officeStr.append("url:'',");
 officeStr.append("checked:'0'}]");
}
User ucuc = new User();
cdt.clear();
cdt.add("OFFICEID="+ dc.getId() );
cdt.add("order by ordernum");
List<User> ucucs = ucuc.query(cdt);
for(int i=0;i<ucucs.size();i++)
{
 ucuc = ucucs.get(i);
 int checked = 0;
 if(StrTool.inList(checkedIds, "" + ucuc.getId(), ","))
 {
   checked = 1;
   officeSelected = "1";
 }
  StringBuffer str = new StringBuffer();
 str.append("[{type:'user',");
 str.append("id:'" + ucuc.getId() + "',");
 str.append("pid:'0',");
 str.append("code:'" + ucuc.getCode() + "',");
 str.append("pcode:'',");
 str.append("name:'" + ucuc.getName() + "',");
 str.append("url:'',");
 str.append("checked:'" + checked + "'}]");


 rtn.append(currlvl+".add(lvl" + (level + 1) + " = new WebFXTreeItem('"+ ucuc.getName() + "' ,\"javascript:treeClick(tree.getSelected());\", \"" + str.toString() + "\", 1 , " + checked + "));\n");
}
String thisDept = parent+".add(" + currlvl + " = new WebFXTreeItem('"+ ti.getName() + "' ,\"javascript:treeClick(tree.getSelected());\", \"" + officeStr.toString() + "\", 1 , "+ officeSelected +"));\n";
thisDept = thisDept + rtn.toString();

rtnBack.append(thisDept);

Collection sublist = ti.values();
Iterator it = sublist.iterator();
while (it.hasNext()) {
   TreeItem pt = (TreeItem)(it.next());
   rtnBack.append(getDeptUserCheckBoxTree(pt, treeName, currlvl, level + 1, checkedIds));
}
return rtnBack.toString();
}


private List getTreeParameters(javax.servlet.http.HttpServletRequest request)
{
    String filter_ids = ParamUtils.getParameter(request,"filter_ids","0");
    int choice_type = ParamUtils.getIntParameter(request, "choice_type", -1);
    List cdt = new ArrayList();
    if (!filter_ids.equals("0")) {
        String[] ids = Tool.split(",", filter_ids);
        if (choice_type == 1) { //in查询
            for (int i = 0; i < ids.length; i ++) {
                ids[i] = "'" + ids[i] + "'";
            }
            cdt.add("code in(" + Tool.join(",", ids) + ")");
        } else {  //like查询
            List subcdt = new ArrayList();
            for (int i = 0; i < ids.length; i ++) {
                subcdt.add("code like '" + ids[i] + "%'");
            }
            cdt.add("(" + Tool.join(" or ", subcdt) + ")");
        }
    }
    cdt.add("order by code");
    return cdt;
}


private void makeDeptUserCodeTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    CDataCenterOffice cv = new CDataCenterOffice();
    List cdt = getTreeParameters(request);
    cdt = new ArrayList();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = cv.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}


private void makeJiaoSeDeptUserCodeTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    int classid = ParamUtils.getIntParameter(request,"Classid",0); //角色id
    int moduleid = ParamUtils.getIntParameter(request,"moduleid",0); //角色id
    
    String officeId =  ParamUtils.getParameter(request, "officeId", "");
    
    List row = new ArrayList();
    User_JiaoSeList userlist = new User_JiaoSeList();
    List cdt = new ArrayList();
    if(classid>0)
    {
      cdt.add("jiaoseid='"+ classid +"'");
      List<User_JiaoSeList> uselists = userlist.query(cdt);
      for(int i=0;i<uselists.size();i++)
      {
        row.add(uselists.get(i).getUserId());
      }
      checked_ids = Tool.join(",",row);
    }
    if(moduleid>0)
    {
      row.clear();
      User_ModuleList m = new User_ModuleList();
      cdt.clear();
      cdt.add("moduleid='"+ moduleid +"'");
      List<User_ModuleList> ms = m.query(cdt);
      for(int i=0;i<ms.size();i++)
      {
        row.add(ms.get(i).getUserId());
      }
      checked_ids = Tool.join(",",row);
    }
    
    cdt.clear();
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    
    cdt = getTreeParameters(request);
    cdt = new ArrayList();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}
//获取部门  考勤人员
private void makeDeptKaoQinJiaoSeDeptUserCodeTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    int classid = ParamUtils.getIntParameter(request,"Classid",0); //角色id
    int jiaoseid = 0;
    
    String officeId =  ParamUtils.getParameter(request, "officeId", "");//部门名称
    List row = new ArrayList();
    User_JiaoSeList userlist = new User_JiaoSeList();
    List cdt = new ArrayList();
    //得到考勤角色的id
    User_JiaoSe jiaose = new User_JiaoSe();
    cdt.clear();
    cdt.add("name='部门考勤人员'");
    List<User_JiaoSe> jiaoses = jiaose.query(cdt);
    
    if(jiaoses!=null && jiaoses.size()>0)
    {
    	jiaose = jiaoses.get(0);
    	jiaoseid = jiaose.getId();
    }
    
    if(jiaoseid > 0)
    {
      row.clear();
      User_JiaoSeList m = new User_JiaoSeList();
      cdt.clear();
      cdt.add("jiaoseid='"+ jiaoseid +"'");
  	  cdt.add("deptid='"+ officeId +"'");

  	  
      List<User_JiaoSeList> ms = m.query(cdt);
      for(int i=0;i<ms.size();i++)
      {
        row.add(ms.get(i).getUserId());
      }
      checked_ids = Tool.join(",",row);
    }
    
    cdt.clear();
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
   // CDataCenterOffice cv = new CDataCenterOffice();
    cdt = getTreeParameters(request);
    cdt = new ArrayList();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}

//获取部门  正职人员
private void makeDeptZhengZhiDeptUserCodeTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    int classid = ParamUtils.getIntParameter(request,"Classid",0); //角色id
    String zhengzhiid = "";
    
    String officeId =  ParamUtils.getParameter(request, "officeId", "");//部门名称
    List row = new ArrayList();
    User_JiaoSeList userlist = new User_JiaoSeList();
    List cdt = new ArrayList();
    //得到部门正职人员
    Office jiaose = new Office();
    cdt.clear();
    cdt.add("OfficeId='"+officeId+"'");
    
    List<Office> jiaoses = jiaose.query(cdt);
    
    if(jiaoses!=null && jiaoses.size()>0)
    {
    	jiaose = jiaoses.get(0);
    	checked_ids = jiaose.getZhengZhiId();
    }
    
    cdt.clear();
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    CDataCenterOffice cv = new CDataCenterOffice();
    cdt = getTreeParameters(request);
    cdt = new ArrayList();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = cv.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}

private void makeDeptUserCodeTree(javax.servlet.http.HttpServletRequest request,String checkIds)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = checkIds;
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    CDataCenterOffice cv = new CDataCenterOffice();
    List cdt = getTreeParameters(request);
    cdt = new ArrayList();

    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = cv.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}
/////////
private void makeQuanXianUserTree(javax.servlet.http.HttpServletRequest request,String checkIds)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = checkIds;
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    CDataCenterOffice cv = new CDataCenterOffice();
    List cdt = getTreeParameters(request);
    cdt = new ArrayList();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = cv.initTree(pv, imap);
             strTree.append(getDeptUserCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    request.setAttribute("TreeName", "部门人员");
    request.setAttribute("Tree", strTree.toString());
}


private void makeChannelTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    StringBuffer strTree = new StringBuffer();
    Channel v = new Channel();
    List cdt = getTreeParameters(request);
    Map<String, List<Channel>> imap = v.initParentMap(cdt);
    if (imap.get("0") != null) {
        for (Channel pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
            if (type == 0) {
                strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
            } else {
                strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    }
    request.setAttribute("TreeName", "网站栏目");
    request.setAttribute("Tree", strTree.toString());
}
private void makeUserModuleTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = ParamUtils.getParameter(request, "checked_ids", "");
    StringBuffer strTree = new StringBuffer();
    User_Module v = new User_Module();
    List cdt = getTreeParameters(request);
    Map<String, List<User_Module>> imap = v.initParentMap(cdt);
    if (imap.get("0") != null) {
        for (User_Module pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
            if (type == 0) {
                strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
            } else {
                strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    }
    request.setAttribute("checked_ids",checked_ids);
    request.setAttribute("TreeName", "系统功能模块");
    request.setAttribute("Tree", strTree.toString());
}



private List mkRtn(String cmd, String forward, List<OptionBean> form)
{
    List rtn = new ArrayList();
    rtn.add(cmd);
    rtn.add(forward);
    rtn.add(form);
    return rtn;
}

public List main(javax.servlet.http.HttpServletRequest request)
{
    String cmd = ParamUtils.getParameter(request,"cmd","");
    int complex = ParamUtils.getIntParameter(request,"complex",0);
    request.setAttribute("complex",complex+"");
    log.debug("cmd=" + cmd);

      
         if (cmd.equals("UserModuleList"))
        {
          String check_ids = "";
          String moduleId = ParamUtils.getParameter(request,"moduleId","");
          List cdt = new ArrayList();
          cdt.add("moduleId="+moduleId);
          User_ModuleList userModuleList = new User_ModuleList();
          List<User_ModuleList> users = userModuleList.query(cdt);
          List row = new ArrayList();
          for(int i=0;i<users.size();i++)
          {
            userModuleList = users.get(i);
            row.add(userModuleList.getUserId()+"");
          }
          if(row.size()>0)
          {
            check_ids = Tool.join(",",row);
          }
           this.makeDeptUserCodeTree(request,check_ids);
            return mkRtn(cmd, cmd, null);
        }
        if(cmd.equals("Module"))
        {
        makeUserModuleTree(request);
        return mkRtn(cmd, cmd, null);
        }
       
      if (cmd.equals("ChannelCode"))
        {
            makeChannelTree(request);
            return mkRtn(cmd, cmd, null);
        }
        if(cmd.equals("JiaoSeUserList") ||  cmd.equals("WhiteUser") )
        {
           this.makeJiaoSeDeptUserCodeTree(request);
            return mkRtn(cmd, cmd, null);
        }
        if(cmd.equals("KaoQinId"))
        {
        	this.makeDeptKaoQinJiaoSeDeptUserCodeTree(request);
            return mkRtn(cmd, cmd, null);
        }
        
        if(cmd.equals("FlowUsers"))
        {
			String check_ids = ParamUtils.getParameter(request,"check_ids","");
        	this.makeDeptUserCodeTree(request,check_ids);
            return mkRtn(cmd, cmd, null);
        }
        
        if(cmd.equals("ZhengZhiId"))
        {
        	makeDeptZhengZhiDeptUserCodeTree(request);
        	return mkRtn(cmd, cmd, null);
        }
        if(cmd.equals("QuanXian"))
        {
            makeQuanXianUserTree(request,"");
            return mkRtn(cmd, cmd, null);
        }
        if(cmd.equals("YuanZhangId"))
        {
        	//分管院长
        	 String userType = ParamUtils.getParameter(request,"userType","0");
             String roleType = ParamUtils.getParameter(request,"roleType","0");
             List<OptionBean> options = new ArrayList<OptionBean>();

             options.add(new OptionBean("", "-1"));
             List cdt = new ArrayList();
             User v = new User();
             //找到所有的院长和副院长
             cdt.add("( FIND_IN_SET('2',zhiwucode)>0 or  FIND_IN_SET('4',zhiwucode)>0 )");
             List<User> vs = v.query(cdt);
             for (User item : vs)
             {
               options.add(new OptionBean(item.getName(), ""+item.getId()));
             }
             return mkRtn(cmd, cmd, options);
        }
        
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("msg", "msg", null);
}

%>
<%
log.debug("ChoiceAction");
String DbName="";
List rtn = null;
synchronized(this) {
    userInfo = Tool.getUserInfo(request);
    if (userInfo==null) {
        rtn = mkRtn("login", "login", null);
    }
    else {
        rtn = main(request);
    }
}
String cmd = (String)rtn.get(0);
String forwardKey = (String)rtn.get(1);
request.setAttribute("Options", rtn.get(2));
Map forwardMap = new HashMap();
forwardMap.put("login", "/logon");
forwardMap.put("msg", "role_ChoiceForm.jsp");

forwardMap.put("RoleCode", "role_ChoiceForm.jsp");
forwardMap.put("DeptCode", "role_ChoiceTreeForm.jsp");
forwardMap.put("ExpCode", "role_ChoiceTreeForm.jsp");
forwardMap.put("special_code", "role_ChoiceTreeForm.jsp");
forwardMap.put("area_code", "role_ChoiceTreeForm.jsp");
forwardMap.put("ChannelCode", "role_ChoiceTreeForm.jsp");
forwardMap.put("Module", "role_ChoiceTreeForm.jsp");

forwardMap.put("UserModuleList", "role_ChoiceTreeForm.jsp");
forwardMap.put("JiaoSeUserList", "role_ChoiceTreeForm.jsp");
forwardMap.put("QuanXian", "role_ChoiceTreeForm.jsp");
forwardMap.put("YuanZhangId", "RadioForm.jsp");
forwardMap.put("ZhengZhiId", "role_ChoiceTreeForm.jsp");
forwardMap.put("KaoQinId", "role_ChoiceTreeForm.jsp");
forwardMap.put("WhiteUser", "role_ChoiceTreeForm.jsp");
forwardMap.put("FlowUsers", "role_ChoiceTreeForm.jsp");


HttpTool.saveParameters(request, "OptionsExt");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ",forward=" + forwardKey);
pageContext.forward((String)forwardMap.get(forwardKey) + "?DbName="+DbName+"&cmd=" + cmd);
%>

