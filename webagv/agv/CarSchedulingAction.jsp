<%@ page language="java" %>
<%--车辆运行记录--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(CarScheduling.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime", "TaskRemark"};
private String[] DicKeys = {"Id", "Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime", "TaskRemark"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"int", "小车", "-1", "CarName", ""}, {"int", "任务ID", "-1", "TaskName", ""}, {"string", "运行速度", "50", "text", ""}, {"string", "电池电压", "50", "text", ""}, {"int", "负载状态", "-1", "YesNo", ""}, {"int", "运行状态", "-1", "YesNo", ""}, {"string", "起点", "50", "text", ""}, {"string", "终点", "50", "text", ""}, {"string", "运行时间", "50", "text", ""}, {"int", "任务描述", "-1", "hidden", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime", "TaskRemark"};
private String[] ListFields = {"Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime"};
private String[] PrintFields = {"Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime"};
private String[] FormFields = {"Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime"};
private String[] QueryFields = {"Carid", "Taskid", "Dqsd", "Dqdy", "Fzzt", "Yxzt", "Qd", "Zd", "Yxtime", "TaskRemark"};
private CarScheduling getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    CarScheduling v = new CarScheduling();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCarid(request, "Carid");
        v.paramTaskid(request, "Taskid");
        v.paramDqsd(request, "Dqsd");
        v.paramDqdy(request, "Dqdy");
        v.paramFzzt(request, "Fzzt");
        v.paramYxzt(request, "Yxzt");
        v.paramQd(request, "Qd");
        v.paramZd(request, "Zd");
        v.paramYxtime(request, "Yxtime");
        v.paramTaskRemark(request, "TaskRemark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCarid(ParamUtils.getIntParameter(request, "Carid", -1));
        v.setTaskid(ParamUtils.getIntParameter(request, "Taskid", -1));
        v.setDqsd(ParamUtils.getParameter(request, "Dqsd", ""));
        v.setDqdy(ParamUtils.getParameter(request, "Dqdy", ""));
        v.setFzzt(ParamUtils.getIntParameter(request, "Fzzt", -1));
        v.setYxzt(ParamUtils.getIntParameter(request, "Yxzt", -1));
        v.setQd(ParamUtils.getParameter(request, "Qd", ""));
        v.setZd(ParamUtils.getParameter(request, "Zd", ""));
        v.setYxtime(ParamUtils.getParameter(request, "Yxtime", ""));
        v.setTaskRemark(ParamUtils.getIntParameter(request, "TaskRemark", -1));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, CarScheduling pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map TaskNamemap = CEditConst.getTaskNameMap(userInfo);
    Map CarNamemap = CEditConst.getCarNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        CarScheduling v = (CarScheduling)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add((String)CarNamemap.get("" + v.getCarid()));
        row.add((String)TaskNamemap.get("" + v.getTaskid()));
        row.add(Tool.jsSpecialChars(v.getDqsd()));
        row.add(Tool.jsSpecialChars(v.getDqdy()));
        row.add((String)YesNomap.get("" + v.getFzzt()));
        row.add((String)YesNomap.get("" + v.getYxzt()));
        row.add(Tool.jsSpecialChars(v.getQd()));
        row.add(Tool.jsSpecialChars(v.getZd()));
        row.add(Tool.jsSpecialChars(v.getYxtime()));
        row.add("" + v.getTaskRemark());
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, CarScheduling pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, CarScheduling pv, boolean isAll)
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
    qvali = ParamUtils.getIntParameter(request, "_Carid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Carid=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Taskid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Taskid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Dqsd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Dqsd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Dqdy_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Dqdy like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Fzzt_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Fzzt=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Yxzt_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Yxzt=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Qd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Qd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Yxtime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Yxtime like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_TaskRemark_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("TaskRemark=" + qvali);
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
    //request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo, "-1"));
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo, "-1"));
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
    CarScheduling pv = new CarScheduling();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "CarScheduling");
    request.setAttribute("describe", "车辆运行记录");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, CarScheduling pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map TaskNamemap = CEditConst.getTaskNameMap(userInfo);
    Map CarNamemap = CEditConst.getCarNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        CarScheduling v = (CarScheduling)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Carid",(String)CarNamemap.get("" + v.getCarid()));
        map.put("Taskid",(String)TaskNamemap.get("" + v.getTaskid()));
        map.put("Dqsd",Tool.jsSpecialChars(v.getDqsd()));
        map.put("Dqdy",Tool.jsSpecialChars(v.getDqdy()));
        map.put("Fzzt",(String)YesNomap.get("" + v.getFzzt()));
        map.put("Yxzt",(String)YesNomap.get("" + v.getYxzt()));
        map.put("Qd",Tool.jsSpecialChars(v.getQd()));
        map.put("Zd",Tool.jsSpecialChars(v.getZd()));
        map.put("Yxtime",Tool.jsSpecialChars(v.getYxtime()));
        map.put("TaskRemark","" + v.getTaskRemark());
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, CarScheduling pv, List cdt)
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
    CarScheduling pv = new CarScheduling();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "CarScheduling");
    request.setAttribute("describe", "车辆运行记录");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    CarScheduling pv = new CarScheduling();
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
private void setForm(javax.servlet.http.HttpServletRequest request, CarScheduling form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("TaskNameoptions", CEditConst.getTaskNameOptions(userInfo));
    request.setAttribute("CarNameoptions", CEditConst.getCarNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "CarScheduling");
    request.setAttribute("describe", "车辆运行记录");
    request.setAttribute("OperateField",OperateField);
}
private List mkRtn(String cmd, String forward, CarScheduling form)
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
    CarScheduling form = getByParameterDb(request);
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
        	request.setAttribute("classname", "CarScheduling");
        	request.setAttribute("describe", "车辆运行记录");
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
log.debug("CarSchedulingAction");
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
forwardMap.put("list", "CarSchedulingAction.jsp");
forwardMap.put("failure", "CarSchedulingForm.jsp");
forwardMap.put("success", "CarSchedulingList.jsp");
forwardMap.put("listjquery", "CarSchedulingListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "CarSchedulingForm.jsp");
forwardMap.put("jqueryInput", "CarSchedulingFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='CarSchedulingAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
