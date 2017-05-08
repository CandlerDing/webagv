<%@ page language="java" %>
<%--RFID站点--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Rfid.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "Wladdress", "Rfid", "PathbsUuId", "IdP", "Flag", "Pathid", "Orderno", "Type", "Remark"};
private String[] DicKeys = {"Id", "Code", "Name", "Wladdress", "Rfid", "PathbsUuId", "IdP", "Flag", "Pathid", "Orderno", "Type", "Remark"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"string", "编码", "50", "text", ""}, {"string", "名称", "50", "text", ""}, {"string", "物理地址", "50", "text", ""}, {"string", "RFID", "50", "text", ""}, {"string", "路径标识ID", "50", "text", ""}, {"int", "父ID", "-1", "hidden", ""}, {"int", "是否可用", "-1", "YesNo", ""}, {"int", "路径ID", "-1", "PathsName", ""}, {"int", "排序", "-1", "text", ""}, {"string", "类型", "50", "text", ""}, {"string", "备注", "50", "text", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Code", "Name", "Wladdress", "Rfid", "PathbsUuId", "IdP", "Flag", "Pathid", "Orderno", "Type", "Remark"};
private String[] ListFields = {"Code", "Name",  "Rfid", "PathbsUuId"};
private String[] PrintFields = {"Code", "Name", "Wladdress", "Rfid", "PathbsUuId", "Flag", "Pathid", "Orderno", "Type", "Remark"};
private String[] FormFields = {"Code", "Name", "Wladdress", "Rfid", "PathbsUuId", "Flag", "Pathid", "Orderno", "Type", "Remark"};
private String[] QueryFields = {"Name", "Wladdress", "Rfid", "PathbsUuId", "Flag", "Pathid", "Type"};
private Rfid getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Rfid v = new Rfid();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramWladdress(request, "Wladdress");
        v.paramRfid(request, "Rfid");
        v.paramPathbsUuId(request, "PathbsUuId");
        v.paramIdP(request, "IdP");
        v.paramFlag(request, "Flag");
        v.paramPathid(request, "Pathid");
        v.paramOrderno(request, "Orderno");
        v.paramType(request, "Type");
        v.paramRemark(request, "Remark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setWladdress(ParamUtils.getParameter(request, "Wladdress", ""));
        v.setRfid(ParamUtils.getParameter(request, "Rfid", ""));
        v.setPathbsUuId(ParamUtils.getParameter(request, "PathbsUuId", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setFlag(ParamUtils.getIntParameter(request, "Flag", -1));
        v.setPathid(ParamUtils.getIntParameter(request, "Pathid", -1));
        v.setOrderno(ParamUtils.getIntParameter(request, "Orderno", -1));
        v.setType(ParamUtils.getParameter(request, "Type", ""));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Rfid pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map PathsNamemap = CEditConst.getPathsNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Rfid v = (Rfid)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add(Tool.jsSpecialChars(v.getWladdress()));
        row.add(Tool.jsSpecialChars(v.getRfid()));
        row.add(Tool.jsSpecialChars(v.getPathbsUuId()));
        row.add("" + v.getIdP());
        row.add((String)YesNomap.get("" + v.getFlag()));
        row.add((String)PathsNamemap.get("" + v.getPathid()));
        row.add("" + v.getOrderno());
        row.add(Tool.jsSpecialChars(v.getType()));
        row.add(Tool.jsSpecialChars(v.getRemark()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Rfid pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Rfid pv, boolean isAll)
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
    qvali = ParamUtils.getIntParameter(request,"Classid",0);
    if(qvali>0)
    {
      cdt.add("(pid="+qvali+" or id="+ qvali +")");
    }
    List QueryValues = new ArrayList();
    qval = ParamUtils.getParameter(request, "_Name_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("name like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Wladdress_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Wladdress like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Rfid_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Rfid like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_PathbsUuId_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("PathbsUuId like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Flag_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Flag=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Pathid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Pathid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Type_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Type like '%" + qval + "%'");
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
    //request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo, "-1"));
    request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo, "-1"));
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
    Rfid pv = new Rfid();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Rfid");
    request.setAttribute("describe", "RFID站点");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Rfid pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map PathsNamemap = CEditConst.getPathsNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Rfid v = (Rfid)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("Wladdress",Tool.jsSpecialChars(v.getWladdress()));
        map.put("Rfid",Tool.jsSpecialChars(v.getRfid()));
        map.put("PathbsUuId",Tool.jsSpecialChars(v.getPathbsUuId()));
        map.put("IdP","" + v.getIdP());
        map.put("Flag",(String)YesNomap.get("" + v.getFlag()));
        map.put("Pathid",(String)PathsNamemap.get("" + v.getPathid()));
        map.put("Orderno","" + v.getOrderno());
        map.put("Type",Tool.jsSpecialChars(v.getType()));
        map.put("Remark",Tool.jsSpecialChars(v.getRemark()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Rfid pv, List cdt)
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
    Rfid pv = new Rfid();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Rfid");
    request.setAttribute("describe", "RFID站点");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Rfid pv = new Rfid();
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
private void setForm(javax.servlet.http.HttpServletRequest request, Rfid form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("PathsNameoptions", CEditConst.getPathsNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Rfid");
    request.setAttribute("describe", "RFID站点");
    request.setAttribute("OperateField",OperateField);
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(Rfid form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update") || cmd.equals("jqueryUpdate")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, Rfid form)
{
    List rtn = new ArrayList();
    rtn.add(cmd);
    rtn.add(forward);
    rtn.add(form);
    return rtn;
}
public List main(javax.servlet.http.HttpServletRequest request)
{
	CodeUtils cu = new CodeUtils();
	List cdt = new ArrayList();
	UserInfo userInfo = Tool.getUserInfo(request);
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
    String RootKey_1 = StrTool.DumStr("0",cu.getFirstLevelLen()-1)+"1";
    Rfid form = getByParameterDb(request);
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
          int pid = ParamUtils.getIntParameter(request,"Classid",0);       
          form.setIdP(pid);       
          String RootKeyL1 = StrTool.DumStr("0",cu.getFirstLevelLen()-1);    
          List aclist = new ArrayList();
          Rfid ac = new Rfid();
           if(pid>0) //有父
          {
        	   Rfid formP = form.getById(pid);
            if(formP!=null && formP.getId()>0)
            {           
              cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
              cdt.add("code like '"+ formP.getCode() +"%'");            
              cdt.add("order by code desc");
              ac = new Rfid();
              aclist = ac.query(cdt);
              if(aclist==null || aclist.size()==0)
               form.setCode(formP.getCode()+RootKeyL1+"1");
              else
              {
                form.setCode(cu.getNextCode(((Rfid)aclist.get(0)).getCode(),cu.getLevel(((Rfid)aclist.get(0)).getCode())));
              }
            }
          }else
          {         
            cdt.add("length(code)="+cu.getFirstLevelLen());
            cdt.add("order by code desc");
            aclist = ac.query(cdt);
            if(aclist==null || aclist.size()==0)
              form.setCode(RootKeyL1+"1");
            else
            {
              form.setCode(cu.getNextCode(((Rfid)aclist.get(0)).getCode(),1));
            }
          }
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
        	request.setAttribute("classname", "Rfid");
        	request.setAttribute("describe", "RFID站点");
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
        cdt.clear();
        cdt.add("id in (" + idlist + ")");
        form.deleteByCondition(cdt);
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "编码重复!");
            setForm(request, form);
            return mkRtn("save", "input", form);
        }
        else {
            form.insert();
            return mkRtn("list", "list", form);
        }
    }
    if (cmd.equals("update") )
    {
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "编码重复!");
            setForm(request, form);
            return mkRtn("update", "input", form);
        }
        else {
            form.update();
            return mkRtn("list", "list", form);
        }
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
        	if (isDuplicated(form, cmd)) {
            		resultMap.put("success", "false");
            		resultMap.put("msg", "模块编码重复");
            		request.setAttribute("jsonMap",resultMap);
            		return mkRtn("showjson", "showjson", form);
        }
        else {
            	form.update();
            	resultMap.put("success", "true");
            	resultMap.put("msg", "成功");
            	request.setAttribute("jsonMap",resultMap);
            	return mkRtn("showjson", "showjson", form);
        }
    }
    if (cmd.equals("jquerySave"))
    {
        Map resultMap = new HashMap();
        if (isDuplicated(form, cmd)) {
            	resultMap.put("success", "false");
            	resultMap.put("msg", "编码重复");
            	request.setAttribute("jsonMap",resultMap);
            	return mkRtn("showjson", "showjson", form);
        }
        else {
            form.insert();
            	resultMap.put("success", "true");
            	resultMap.put("msg", "编码操作成功");
            	request.setAttribute("jsonMap",resultMap);
            return mkRtn("showjson", "showjson", form);
        }
    }
    if (cmd.equals("jqueryDeletelist"))
    {
        	String idlist = ParamUtils.getParameter(request, "idlist", "-1");
        	cdt.clear();
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
log.debug("RfidAction");
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
forwardMap.put("list", "RfidAction.jsp");
forwardMap.put("failure", "RfidForm.jsp");
forwardMap.put("success", "RfidList.jsp");
forwardMap.put("listjquery", "RfidListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "RfidForm.jsp");
forwardMap.put("jqueryInput", "RfidFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='RfidAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
