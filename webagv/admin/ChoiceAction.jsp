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
      
      
       
      if (cmd.equals("ChannelCode"))
        {
            makeChannelTree(request);
            return mkRtn(cmd, cmd, null);
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
forwardMap.put("msg", "ChoiceForm.jsp");
forwardMap.put("RoleCode", "ChoiceForm.jsp");
forwardMap.put("DeptCode", "ChoiceTreeForm.jsp");
forwardMap.put("ExpCode", "ChoiceTreeForm.jsp");
forwardMap.put("special_code", "ChoiceTreeForm.jsp");
forwardMap.put("area_code", "ChoiceTreeForm.jsp");
forwardMap.put("ChannelCode", "ChoiceTreeForm.jsp");
forwardMap.put("TeacherCode", "RadioForm.jsp");
forwardMap.put("KeChengCode", "ChoiceTreeForm.jsp");

forwardMap.put("PeiXunBanCode", "ChoiceForm.jsp");
HttpTool.saveParameters(request, "OptionsExt");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ",forward=" + forwardKey);
pageContext.forward((String)forwardMap.get(forwardKey) + "?DbName="+DbName+"&cmd=" + cmd);
%>

