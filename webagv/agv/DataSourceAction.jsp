<%@ page language="java" %>
<%--������Դ--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(DataSource.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "IdP", "Retvalue", "Type", "Orderno", "Remark"};
private String[] DicKeys = {"Id", "Code", "Name", "IdP", "Retvalue", "Type", "Orderno", "Remark"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"string", "����", "50", "text", ""}, {"string", "����", "50", "text", ""}, {"int", "��ID", "-1", "hidden", ""}, {"string", "��ʶ", "50", "text", ""}, {"string", "����", "50", "text", ""}, {"int", "����", "-1", "text", ""}, {"string", "��ע", "50", "text", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//�����ֶ�
private String[] AllFields = {"Id", "Code", "Name", "IdP", "Retvalue", "Type", "Orderno", "Remark"};
private String[] ListFields = { "Name", "Retvalue",  "Orderno", "Remark"};
private String[] PrintFields = {"Code", "Name", "Retvalue", "Type", "Orderno", "Remark"};
private String[] FormFields = {"Code", "Name", "Retvalue", "Type", "Orderno", "Remark"};
private String[] QueryFields = {"Name", "Type"};
private DataSource getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    DataSource v = new DataSource();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramIdP(request, "IdP");
        v.paramRetvalue(request, "Retvalue");
        v.paramType(request, "Type");
        v.paramOrderno(request, "Orderno");
        v.paramRemark(request, "Remark");
        //��ȡcheckboxֵ�����·�ʽ
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setRetvalue(ParamUtils.getParameter(request, "Retvalue", ""));
        v.setType(ParamUtils.getParameter(request, "Type", ""));
        v.setOrderno(ParamUtils.getIntParameter(request, "Orderno", 1));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //��ȡcheckboxֵ�����·�ʽ
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, DataSource pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //Ĭ��ֵ����
    //��ѯ��������������
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        DataSource v = (DataSource)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getIdP());
        row.add(Tool.jsSpecialChars(v.getRetvalue()));
        row.add(Tool.jsSpecialChars(v.getType()));
        row.add("" + v.getOrderno());
        row.add(Tool.jsSpecialChars(v.getRemark()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, DataSource pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, DataSource pv, boolean isAll)
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
    qval = ParamUtils.getParameter(request, "_Name_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("name like '%" + qval + "%'");
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
    DataSource pv = new DataSource();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "DataSource");
    request.setAttribute("describe", "������Դ");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, DataSource pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //Ĭ��ֵ����
    //��ѯ��������������
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        DataSource v = (DataSource)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("IdP","" + v.getIdP());
        map.put("Retvalue",Tool.jsSpecialChars(v.getRetvalue()));
        map.put("Type",Tool.jsSpecialChars(v.getType()));
        map.put("Orderno","" + v.getOrderno());
        map.put("Remark",Tool.jsSpecialChars(v.getRemark()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, DataSource pv, List cdt)
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
    DataSource pv = new DataSource();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "DataSource");
    request.setAttribute("describe", "������Դ");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    DataSource pv = new DataSource();
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
private void setForm(javax.servlet.http.HttpServletRequest request, DataSource form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //Ĭ��ֵ����
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "DataSource");
    request.setAttribute("describe", "������Դ");
    request.setAttribute("OperateField",OperateField);
}
/*
 * У���ύ�������ݵ��ظ�������
 * ������ظ����ݣ�����true, ���򷵻�false
 */
private boolean isDuplicated(DataSource form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update") || cmd.equals("jqueryUpdate")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, DataSource form)
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
    DataSource form = getByParameterDb(request);
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
        DataSource ac = new DataSource();
         if(pid>0) //�и�
        {
          DataSource formP = form.getById(pid);
          if(formP!=null && formP.getId()>0)
          {           
            cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
            cdt.add("code like '"+ formP.getCode() +"%'");            
            cdt.add("order by code desc");
            ac = new DataSource();
            aclist = ac.query(cdt);
            if(aclist==null || aclist.size()==0)
             form.setCode(formP.getCode()+RootKeyL1+"1");
            else
            {
              form.setCode(cu.getNextCode(((DataSource)aclist.get(0)).getCode(),cu.getLevel(((DataSource)aclist.get(0)).getCode())));
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
            form.setCode(cu.getNextCode(((DataSource)aclist.get(0)).getCode(),1));
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
        	request.setAttribute("classname", "DataSource");
        	request.setAttribute("describe", "������Դ");
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
        cdt.add("id in (" + idlist + ")");
        form.deleteByCondition(cdt);
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "�����ظ�!");
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
            request.setAttribute("back_msg", "�����ظ�!");
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
            		resultMap.put("msg", "ģ������ظ�");
            		request.setAttribute("jsonMap",resultMap);
            		return mkRtn("showjson", "showjson", form);
        }
        else {
            	form.update();
            	resultMap.put("success", "true");
            	resultMap.put("msg", "�ɹ�");
            	request.setAttribute("jsonMap",resultMap);
            	return mkRtn("showjson", "showjson", form);
        }
    }
    if (cmd.equals("jquerySave"))
    {
        Map resultMap = new HashMap();
        if (isDuplicated(form, cmd)) {
            	resultMap.put("success", "false");
            	resultMap.put("msg", "�����ظ�");
            	request.setAttribute("jsonMap",resultMap);
            	return mkRtn("showjson", "showjson", form);
        }
        else {
            form.insert();
            	resultMap.put("success", "true");
            	resultMap.put("msg", "��������ɹ�");
            	request.setAttribute("jsonMap",resultMap);
            return mkRtn("showjson", "showjson", form);
        }
    }
    if (cmd.equals("jqueryDeletelist"))
    {
        	String idlist = ParamUtils.getParameter(request, "idlist", "-1");        	
        	cdt.add("id in (" + idlist + ")");
        	form.deleteByCondition(cdt);
        	Map resultMap = new HashMap();
        	resultMap.put("success", "true");
        	resultMap.put("msg", "�ɹ�");
        	request.setAttribute("jsonMap",resultMap);
        	return mkRtn("showjson", "showjson", form);
    }
    request.setAttribute("msg", "δ�涨��cmd:" + cmd);
    return mkRtn("list", "failure", form);
}
%>
<%
response.setHeader("Cache-Control", "no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
log.debug("DataSourceAction");
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
forwardMap.put("list", "DataSourceAction.jsp");
forwardMap.put("failure", "DataSourceForm.jsp");
forwardMap.put("success", "DataSourceList.jsp");
forwardMap.put("listjquery", "DataSourceListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "DataSourceForm.jsp");
forwardMap.put("jqueryInput", "DataSourceFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='DataSourceAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
      out.println("<script type=\"text/JavaScript\">alert('��½�ѳ�ʱ��');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
