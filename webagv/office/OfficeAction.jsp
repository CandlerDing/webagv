<%@ page language="java" %>
<%--部门管理--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Office.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "FULLNAME", "IdP", "ZhengZhiName", "ZhengZhiId", "Flag", "State", "OFTYPE", "OrderNum", "KaoQinFlag", "Remark"};
private String[] DicKeys = {"Id", "Code", "Name", "FULLNAME", "IdP", "ZhengZhiName", "ZhengZhiId", "Flag", "State", "OFTYPE", "OrderNum", "KaoQinFlag", "Remark"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"string", "部门编码", "50", "text", ""}, {"string", "部门名称", "50", "text", ""}, {"string", "部门", "50", "hidden", ""}, {"int", "父ID", "-1", "hidden", ""}, {"string", "部门经理名称", "50", "text", ""}, {"string", "部门经理ID", "50", "hidden", ""}, {"int", "部门类型 业务部门0、管理部门1", "-1", "text", ""}, {"string", "状态1的能用", "10", "hidden", ""}, {"string", "OFTYPE", "50", "hidden", ""}, {"int", "部门排序", "-1", "text", ""}, {"int", "是否参与考勤公示", "-1", "YesNo", ""}, {"string", "备注", "255", "text", ""}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "Code", "Name", "FULLNAME", "IdP", "ZhengZhiName", "ZhengZhiId", "Flag", "State", "OFTYPE", "OrderNum", "KaoQinFlag", "Remark"};
private String[] ListFields = { "Name", "ZhengZhiName",  "OrderNum"};
private String[] PrintFields = {"Code", "Name", "ZhengZhiName", "Flag", "OrderNum", "KaoQinFlag", "Remark"};
private String[] FormFields = {"Code", "Name", "FULLNAME", "ZhengZhiName", "Flag", "State", "OFTYPE", "OrderNum", "KaoQinFlag", "Remark"};
private String[] QueryFields = {"Name"};
private Office getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Office v = new Office();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update")) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramFULLNAME(request, "FULLNAME");
        v.paramIdP(request, "IdP");
        v.paramZhengZhiName(request, "ZhengZhiName");
        v.paramZhengZhiId(request, "ZhengZhiId");
        v.paramFlag(request, "Flag");
        v.paramState(request, "State");
        v.paramOFTYPE(request, "OFTYPE");
        v.paramOrderNum(request, "OrderNum");
        v.paramKaoQinFlag(request, "KaoQinFlag");
        v.paramRemark(request, "Remark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setFULLNAME(ParamUtils.getParameter(request, "FULLNAME", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setZhengZhiName(ParamUtils.getParameter(request, "ZhengZhiName", ""));
        v.setZhengZhiId(ParamUtils.getParameter(request, "ZhengZhiId", ""));
        v.setFlag(ParamUtils.getIntParameter(request, "Flag", 0));
        v.setState(ParamUtils.getParameter(request, "State", ""));
        v.setOFTYPE(ParamUtils.getParameter(request, "OFTYPE", ""));
        v.setOrderNum(ParamUtils.getIntParameter(request, "OrderNum", 0));
        v.setKaoQinFlag(ParamUtils.getIntParameter(request, "KaoQinFlag", 1));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Office pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Office v = (Office)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add(Tool.jsSpecialChars(v.getFULLNAME()));
        row.add("" + v.getIdP());
        row.add(Tool.jsSpecialChars(v.getZhengZhiName()));
        row.add(Tool.jsSpecialChars(v.getZhengZhiId()));
        row.add("" + v.getFlag());
        row.add(Tool.jsSpecialChars(v.getState()));
        row.add(Tool.jsSpecialChars(v.getOFTYPE()));
        row.add("" + v.getOrderNum());
        row.add((String)YesNomap.get("" + v.getKaoQinFlag()));
        row.add(Tool.jsSpecialChars(v.getRemark()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Office pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Office pv, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    int shownum = ParamUtils.getIntParameter(request, "shownum", userInfo.getDispNum());
    String orderfield = ParamUtils.getParameter(request, "orderfield", "Id");
    String ordertype = ParamUtils.getParameter(request, "ordertype", "desc");
    List cdt = new ArrayList();
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qval = ParamUtils.getParameter(request, "_Name_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("name like '%" + qval + "%'");
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
    Office pv = new Office();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Office");
    request.setAttribute("describe", "部门管理");
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Office pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Office v = (Office)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("FULLNAME",Tool.jsSpecialChars(v.getFULLNAME()));
        map.put("IdP","" + v.getIdP());
        map.put("ZhengZhiName",Tool.jsSpecialChars(v.getZhengZhiName()));
        map.put("ZhengZhiId",Tool.jsSpecialChars(v.getZhengZhiId()));
        map.put("Flag","" + v.getFlag());
        map.put("State",Tool.jsSpecialChars(v.getState()));
        map.put("OFTYPE",Tool.jsSpecialChars(v.getOFTYPE()));
        map.put("OrderNum","" + v.getOrderNum());
        map.put("KaoQinFlag",(String)YesNomap.get("" + v.getKaoQinFlag()));
        map.put("Remark",Tool.jsSpecialChars(v.getRemark()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Office pv, List cdt)
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
    Office pv = new Office();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Office");
    request.setAttribute("describe", "部门管理");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Office pv = new Office();
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
private void setForm(javax.servlet.http.HttpServletRequest request, Office form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Office");
    request.setAttribute("describe", "部门管理");
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(Office form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, Office form)
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
    Office form = getByParameterDb(request);
    CodeUtils cu = new CodeUtils();
    String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
    String RootKey_1 = StrTool.DumStr("0",cu.getFirstLevelLen()-1)+"1";
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
        // Map deptmap = CEditConst.getKChengMap(userInfo);
         //request.setAttribute("PNAME",deptmap.get(""+pid));
         List cdt = new ArrayList();
         List aclist = new ArrayList();
         Office ac = new Office();
          if(pid>0) //有父
         {
        	  Office formP = form.getById(pid);

           if(formP!=null && formP.getId()>0)
           {
             //mysql length mssql len
             cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
             cdt.add("code like '"+ formP.getCode() +"%'");
             log.debug("length(code)="+(cu.getFirstLevelLen()*cu.getLevel(formP.getCode())));
             cdt.add("order by code desc");
             ac = new Office();
             aclist = ac.query(cdt);
             if(aclist==null || aclist.size()==0)
              form.setCode(formP.getCode()+RootKeyL1+"1");
             else
             {
               form.setCode(cu.getNextCode(((Office)aclist.get(0)).getCode(),cu.getLevel(((Office)aclist.get(0)).getCode())));
             }
           }
         }else
         {
           //默认系统添加
           cdt.add("length(code)="+cu.getFirstLevelLen());
           cdt.add("order by code desc");
           aclist = ac.query(cdt);
           if(aclist==null || aclist.size()==0)
             form.setCode(RootKeyL1+"1");
           else
           {
             form.setCode(cu.getNextCode(((Office)aclist.get(0)).getCode(),1));
           }
         }
          return mkRtn("save", "input", form);
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
        request.setAttribute("classname", "Office");
        request.setAttribute("describe", "部门管理");
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
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "部门编码重复!");
            setForm(request, form);
            return mkRtn("save", "input", form);
        }
        else {
            form.insert();
            return mkRtn("list", "list", form);
        }
    }
    if (cmd.equals("update"))
    {
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "部门编码重复!");
            setForm(request, form);
            return mkRtn("update", "input", form);
        }
        else {
            form.update();
            return mkRtn("list", "list", form);
        }
    }
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("list", "failure", form);
}
%>
<%
response.setHeader("Cache-Control", "no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
log.debug("OfficeAction");
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
forwardMap.put("list", "OfficeAction.jsp");
forwardMap.put("failure", "OfficeForm.jsp");
forwardMap.put("success", "OfficeList.jsp");
forwardMap.put("listjquery", "OfficeListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "OfficeForm.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='OfficeAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
}
else if(forwardKey.equals("listjson"))
{
    out.clear();
    List l  =  (List)request.getAttribute("List");
    out.print("{\"total\":"+ l.size() +",\"rows\":["+Tool.join(",",l)+"]}");
}
else if(forwardKey.equals("login"))
{
      out.println("<script type=\"text/JavaScript\">alert('登陆已超时！');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
