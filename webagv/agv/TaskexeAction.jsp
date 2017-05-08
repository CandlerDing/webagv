<%@ page language="java" %>
<%--任务执行记录--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Taskexe.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[] DicKeys = {"Id", "Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"int", "序号", "-1", "text", ""}, {"int", "任务ID", "-1", "TaskName", ""}, {"int", "小车", "-1", "CarName", ""}, {"int", "路径ID", "-1", "PathsName", ""}, {"string", "命令代码", "500", "text", ""}, {"string", "开始时间", "50", "text", ""}, {"string", "结束时间", "50", "text", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[] ListFields = {"Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[] PrintFields = {"Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[] FormFields = {"Xh", "Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private String[] QueryFields = {"Taskid", "Carid", "Pathid", "ComandsCode", "Starttime", "Endtime"};
private Taskexe getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Taskexe v = new Taskexe();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramXh(request, "Xh");
        v.paramTaskid(request, "Taskid");
        v.paramCarid(request, "Carid");
        v.paramPathid(request, "Pathid");
        v.paramComandsCode(request, "ComandsCode");
        v.paramStarttime(request, "Starttime");
        v.paramEndtime(request, "Endtime");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setXh(ParamUtils.getIntParameter(request, "Xh", -1));
        v.setTaskid(ParamUtils.getIntParameter(request, "Taskid", -1));
        v.setCarid(ParamUtils.getIntParameter(request, "Carid", -1));
        v.setPathid(ParamUtils.getIntParameter(request, "Pathid", -1));
        v.setComandsCode(ParamUtils.getParameter(request, "ComandsCode", ""));
        v.setStarttime(ParamUtils.getParameter(request, "Starttime", ""));
        v.setEndtime(ParamUtils.getParameter(request, "Endtime", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Taskexe pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map PathsNamemap = CEditConst.getPathsNameMap(userInfo);
    Map TaskNamemap = CEditConst.getTaskNameMap(userInfo);
    Map CarNamemap = CEditConst.getCarNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Taskexe v = (Taskexe)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add("" + v.getXh());
        row.add((String)TaskNamemap.get("" + v.getTaskid()));
        row.add((String)CarNamemap.get("" + v.getCarid()));
        row.add((String)PathsNamemap.get("" + v.getPathid()));
        row.add(Tool.jsSpecialChars(v.getComandsCode()));
        row.add(Tool.jsSpecialChars(v.getStarttime()));
        row.add(Tool.jsSpecialChars(v.getEndtime()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Taskexe pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Taskexe pv, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    int shownum = ParamUtils.getIntParameter(request, "shownum", userInfo.getDispNum());
    int jqueryshownum = ParamUtils.getIntParameter(request,"rows",userInfo.getDispNum());
    if(jqueryshownum>0)
    {
        	shownum = jqueryshownum;
    }
    String orderfield = ParamUtils.getParameter(request, "orderfield", "Id");
    String ordertype = ParamUtils.getParameter(request, "ordertype", "desc");
    String sort = ParamUtils.getParameter(request, "sort", "");
    String order = ParamUtils.getParameter(request, "order", "");
    if(sort.length()>0)
    {
        	orderfield = sort;
    }
    if(order.length()>0)
    {
        	ordertype = order;
    }
    List cdt = new ArrayList();
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qvali = ParamUtils.getIntParameter(request, "_Taskid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Taskid=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Carid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Carid=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Pathid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Pathid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_ComandsCode_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("ComandsCode like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Starttime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Starttime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Endtime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Endtime like '%" + qval + "%'");
    }
    if (!isAll) {
        int currpage = ParamUtils.getIntParameter(request, "page", 1);
        com.software.common.PageControl pc = new com.software.common.PageControl(pv.getCount(cdt), currpage, shownum);
        cdt.add("limit " + pc.getOffset() + "," + pc.getShownum());
        request.setAttribute("PageControl", pc);
    }
    String cname = pv.getFieldByProperty(orderfield);
    if (cname.length() != 0) {
        cdt.add("order by " + cname + " " + ordertype);
        log.debug("order by " + cname + " " + ordertype);
    }
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo, "-1"));
    request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo, "-1"));
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("TaskNameoptions", CEditConst.getTaskNameOptions(userInfo, "-1"));
    request.setAttribute("TaskNameoptions", CEditConst.getTaskNameOptions(userInfo, "-1"));
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("CarNameoptions", CEditConst.getCarNameOptions(userInfo, "-1"));
    request.setAttribute("CarNameoptions", CEditConst.getCarNameOptions(userInfo, "-1"));
    request.setAttribute("queryfields", QueryFields);
    request.setAttribute("queryvalues", QueryValues);
    return cdt;
}
private void setList(javax.servlet.http.HttpServletRequest request)
{
    setList(request, false);
}
private void setList(javax.servlet.http.HttpServletRequest request, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Taskexe pv = new Taskexe();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Taskexe");
    request.setAttribute("describe", "任务执行记录");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Taskexe pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map PathsNamemap = CEditConst.getPathsNameMap(userInfo);
    Map TaskNamemap = CEditConst.getTaskNameMap(userInfo);
    Map CarNamemap = CEditConst.getCarNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Taskexe v = (Taskexe)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Xh","" + v.getXh());
        map.put("Taskid",(String)TaskNamemap.get("" + v.getTaskid()));
        map.put("Carid",(String)CarNamemap.get("" + v.getCarid()));
        map.put("Pathid",(String)PathsNamemap.get("" + v.getPathid()));
        map.put("ComandsCode",Tool.jsSpecialChars(v.getComandsCode()));
        map.put("Starttime",Tool.jsSpecialChars(v.getStarttime()));
        map.put("Endtime",Tool.jsSpecialChars(v.getEndtime()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Taskexe pv, List cdt)
{
    request.setAttribute("List", getListJsonRows(request, pv, cdt));
}
private void setJsonList(javax.servlet.http.HttpServletRequest request)
{
    setJsonList(request, false);
}
private void setJsonList(javax.servlet.http.HttpServletRequest request, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Taskexe pv = new Taskexe();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Taskexe");
    request.setAttribute("describe", "任务执行记录");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Taskexe pv = new Taskexe();
    try {
         List<Integer> cols = new ArrayList();
         WorkbookSettings ws = new WorkbookSettings();
         ws.setLocale(new Locale("zh", "CN"));
         WritableWorkbook workbook = Workbook.createWorkbook(new File(filename), ws);
         WritableSheet s1 = workbook.createSheet("Sheet1", 0);
         for (int k = 0; k < PrintFields.length; k ++) {
              for (int ii = 0; ii < DicKeys.length; ii ++) {
                   if(DicKeys[ii].equals(PrintFields[k])){
                       Label lr = new Label(k, 0, DicValues[ii][1]);
                       s1.addCell(lr);
                       cols.add(ii);
                   }
              }
        }
        int i = 1;
        List condition = getListCondition(request, pv, true);
        int num = pv.getCount(condition);
        for (int pos = 0; pos < num; pos += 100) {
            List cdt = new ArrayList(condition);
            for (Iterator it = condition.iterator(); it.hasNext();) {
                cdt.add(new String((String)it.next()));
            }
            cdt.add("limit " + pos + ",100");
            for (Iterator rit = getListRows(request, pv, cdt).iterator(); rit.hasNext(); i ++) {
                List row = (List)rit.next();
                int j = 0;
                for(int jj=0;jj<cols.size();jj++,j++){
                     if(cols.size()>=jj){
                        Label lr = new Label(j, i, (String)row.get(cols.get(jj)));
                        s1.addCell(lr);
                    }
                }
            }
        }
        workbook.write();
        workbook.close();
    }
    catch (IOException e) {
    }
    catch (WriteException e) {
    }
}
private void setForm(javax.servlet.http.HttpServletRequest request, Taskexe form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo));
    request.setAttribute("TaskNameoptions", CEditConst.getTaskNameOptions(userInfo));
    request.setAttribute("CarNameoptions", CEditConst.getCarNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Taskexe");
    request.setAttribute("describe", "任务执行记录");
    request.setAttribute("OperateField",OperateField);
}
private List mkRtn(String cmd, String forward, Taskexe form)
{
    List rtn = new ArrayList();
    rtn.add(cmd);
    rtn.add(forward);
    rtn.add(form);
    return rtn;
}
public List main(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    log.debug("cmd=" + cmd);
    Taskexe form = getByParameterDb(request);
    if (cmd.equals("list"))
    {
        setList(request);
        return mkRtn("list", "success", form);
    }
    if (cmd.equals("listall"))
    {
        setList(request, true);
        return mkRtn(cmd, "success", form);
    }
    if(cmd.equals("json"))
    {
        setJsonList(request,false);
        return mkRtn("listjson","listjson",form);
    }
    if(cmd.equals("listjquery"))
    {
        setJsonList(request,false);
        return mkRtn("listjson","listjson",form);
    }
    if (cmd.equals("excel"))
    {
        String filename = HeadConst.root_file_path + "/upload/temp/" + userInfo.getName() + "_export.xls";
        writeExcel(request, filename);
        return mkRtn(cmd, "excel", form);
    }
    if (cmd.equals("create"))
    {
        setForm(request, form);
        return mkRtn("save", "input", form);
    }
    if (cmd.equals("jqueryCreate"))
    {
        setForm(request, form);
        return mkRtn("jquerySave", "jqueryInput", form);
    }
    if (cmd.equals("modify"))
    {
        form = form.getById(form.getId());
        setForm(request, form);
        return mkRtn("update", "input", form);
    }
    if (cmd.equals("jquery"))
    {
        	request.setAttribute("dickeys", DicKeys);
        	request.setAttribute("dicvalues", DicValues);
        	request.setAttribute("keyfield", KeyField);
        	request.setAttribute("allfields", AllFields);
        	request.setAttribute("fields", ListFields);
        	request.setAttribute("classname", "Taskexe");
        	request.setAttribute("describe", "任务执行记录");
        	request.setAttribute("OperateField",OperateField);
        	setJsonList(request,false);
        	return mkRtn("listjquery", "listjquery", form);
    }
    if (cmd.equals("delete"))
    {
        form.delete(form.getId());
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("deletelist"))
    {
        String idlist = ParamUtils.getParameter(request, "idlist", "-1");
        List cdt = new ArrayList();
        cdt.add("id in (" + idlist + ")");
        form.deleteByCondition(cdt);
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
        form.insert();
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("update") )
    {
        form.update();
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("jqueryModify"))
    {
        	form = form.getById(form.getId());
        	setForm(request, form);
        	return mkRtn("jqueryUpdate", "jqueryInput", form);
    }
    if (cmd.equals("jqueryUpdate") )
    {
        	Map resultMap = new HashMap();
        	form.update();
        	resultMap.put("success", "true");
        	resultMap.put("msg", "成功");
        	request.setAttribute("jsonMap",resultMap);
        	return mkRtn("showjson", "showjson", form);
    }
    if (cmd.equals("jquerySave"))
    {
        Map resultMap = new HashMap();
        form.insert();
        	resultMap.put("success", "true");
        	resultMap.put("msg", "操作成功");
        	request.setAttribute("jsonMap",resultMap);
        return mkRtn("showjson", "showjson", form);
    }
    if (cmd.equals("jqueryDeletelist"))
    {
        	String idlist = ParamUtils.getParameter(request, "idlist", "-1");
        	List cdt = new ArrayList();
        	cdt.add("id in (" + idlist + ")");
        	form.deleteByCondition(cdt);
        	Map resultMap = new HashMap();
        	resultMap.put("success", "true");
        	resultMap.put("msg", "成功");
        	request.setAttribute("jsonMap",resultMap);
        	return mkRtn("showjson", "showjson", form);
    }
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("list", "failure", form);
}
%>
<%
response.setHeader("Cache-Control", "no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
log.debug("TaskexeAction");
int currpage = ParamUtils.getIntParameter(request, "page", 1);
List rtn = null;
UserInfo userInfo = Tool.getUserInfo(request);
if (userInfo==null) {
    rtn = mkRtn("login", "login", null);
}
else {
    rtn = main(request);
}
String cmd = (String)rtn.get(0);
String forwardKey = (String)rtn.get(1);
request.setAttribute("fromBean", rtn.get(2));
Map forwardMap = new HashMap();
forwardMap.put("login", "/logon");
forwardMap.put("list", "TaskexeAction.jsp");
forwardMap.put("failure", "TaskexeForm.jsp");
forwardMap.put("success", "TaskexeList.jsp");
forwardMap.put("listjquery", "TaskexeListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "TaskexeForm.jsp");
forwardMap.put("jqueryInput", "TaskexeFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='TaskexeAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
}else if(forwardKey.equals("listjson"))
{
    out.clear();
    List l  =  (List)request.getAttribute("List");
    PageControl pc = (PageControl)request.getAttribute("PageControl");
    out.print("{\"total\":"+  pc.getTotal_recorder()  +",\"rows\":["+Tool.join(",",l)+"]}");
}else if(forwardKey.equals("showjson"))
{
    	out.clear();
    	Map map  =  (Map)request.getAttribute("jsonMap");
    	out.clear();
    	out.print(JSON.toJSONString(map));
}else if(forwardKey.equals("login"))
{
      out.println("<script type=\"text/JavaScript\">alert('登陆已超时！');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
