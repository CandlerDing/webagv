<%@ page language="java" %>
<%--用户管理--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(User.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "OFFICEID", "LOGID", "LOGPASS", "Phone", "SubPhone", "Address", "E_MAIL", "Jguan", "XB", "CSRQ", "MZ", "Sfzhm", "Zzmm", "MarryFlag", "DegreeCode", "WorkStart", "TechPostCode", "ZhiWu", "Photo", "Ip", "OrderNum", "STATE", "DelFlag", "ErrorNum", "Remark"};
private String[] DicKeys = {"Id", "Code", "Name", "OFFICEID", "LOGID", "LOGPASS", "Phone", "SubPhone", "Address", "E_MAIL", "Jguan", "XB", "CSRQ", "MZ", "Sfzhm", "Zzmm", "MarryFlag", "DegreeCode", "WorkStart", "TechPostCode", "ZhiWu", "Photo", "Ip", "OrderNum", "STATE", "DelFlag", "ErrorNum", "Remark"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"string", "用户编码", "50", "text", ""}, {"string", "用户姓名", "50", "text", ""}, {"int", "所属部门", "-1", "hidden", ""}, {"string", "登录用户名", "50", "text", ""}, {"string", "登录口令", "50", "text", ""}, {"string", "手机", "50", "text", ""}, {"string", "联系电话", "30", "hidden", ""}, {"string", "地址", "100", "hidden", ""}, {"string", "电子邮件", "50", "text", ""}, {"string", "籍贯", "100", "text", ""}, {"string", "性别", "50", "text", ""}, {"string", "出生日期", "50", "text", ""}, {"string", "民族", "50", "NationName", ""}, {"string", "身份证号码", "50", "text", ""}, {"string", "政治面貌", "50", "Politics", ""}, {"int", "婚否", "-1", "YesNo", ""}, {"int", "学历", "-1", "Degree1Code", ""}, {"string", "开始工作时间", "20", "text", ""}, {"int", "职称", "-1", "TechPostCode", ""}, {"string", "职务", "50", "text", ""}, {"string", "照片", "100", "text", ""}, {"string", "Ip", "50", "text", ""}, {"int", "排序", "-1", "text", ""}, {"string", "状态   ", "50", "text", ""}, {"int", "人员是否删除", "-1", "YesNo", ""}, {"int", "密码错误次数", "-1", "text", ""}, {"string", "备注", "255", "text", ""}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "Code", "Name", "OFFICEID", "LOGID", "LOGPASS", "Phone", "SubPhone", "Address", "E_MAIL", "Jguan", "XB", "CSRQ", "MZ", "Sfzhm", "Zzmm", "MarryFlag", "DegreeCode", "WorkStart", "TechPostCode", "ZhiWu", "Photo", "Ip", "OrderNum", "STATE", "DelFlag", "ErrorNum", "Remark"};
private String[] ListFields = { "Name", "LOGID",  "Phone",  "XB"};
private String[] PrintFields = {"Code", "Name", "LOGID", "LOGPASS", "Phone", "E_MAIL", "Jguan", "XB", "CSRQ", "MZ", "Sfzhm", "Zzmm", "MarryFlag", "DegreeCode", "WorkStart", "TechPostCode", "ZhiWu", "Photo", "Ip", "OrderNum", "STATE", "DelFlag", "ErrorNum", "Remark"};
private String[] FormFields = {"Code", "Name", "LOGID", "LOGPASS", "Phone", "SubPhone", "Address", "E_MAIL", "Jguan", "XB", "CSRQ", "MZ", "Sfzhm", "Zzmm", "MarryFlag", "DegreeCode", "WorkStart", "TechPostCode", "ZhiWu", "Photo", "Ip", "OrderNum", "STATE", "DelFlag", "ErrorNum", "Remark"};
private String[] QueryFields = {"Name", "OFFICEID", "LOGID", "LOGPASS", "Phone", "SubPhone", "Address", "XB", "Sfzhm", "Zzmm", "DegreeCode", "WorkStart", "TechPostCode", "OrderNum", "STATE"};
private User getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    User v = new User();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update")) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramOFFICEID(request, "OFFICEID");
        v.paramLOGID(request, "LOGID");
        v.paramLOGPASS(request, "LOGPASS");
        v.paramPhone(request, "Phone");
        v.paramSubPhone(request, "SubPhone");
        v.paramAddress(request, "Address");
        v.paramE_MAIL(request, "E_MAIL");
        v.paramJguan(request, "Jguan");
        v.paramXB(request, "XB");
        v.paramCSRQ(request, "CSRQ");
        v.paramMZ(request, "MZ");
        v.paramSfzhm(request, "Sfzhm");
        v.paramZzmm(request, "Zzmm");
        v.paramMarryFlag(request, "MarryFlag");
        v.paramDegreeCode(request, "DegreeCode");
        v.paramWorkStart(request, "WorkStart");
        v.paramTechPostCode(request, "TechPostCode");
        v.paramZhiWu(request, "ZhiWu");
        v.paramPhoto(request, "Photo");
        v.paramIp(request, "Ip");
        v.paramOrderNum(request, "OrderNum");
        v.paramSTATE(request, "STATE");
        v.paramDelFlag(request, "DelFlag");
        v.paramErrorNum(request, "ErrorNum");
        v.paramRemark(request, "Remark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setOFFICEID(ParamUtils.getIntParameter(request, "OFFICEID", -1));
        v.setLOGID(ParamUtils.getParameter(request, "LOGID", ""));
        v.setLOGPASS(ParamUtils.getParameter(request, "LOGPASS", ""));
        v.setPhone(ParamUtils.getParameter(request, "Phone", ""));
        v.setSubPhone(ParamUtils.getParameter(request, "SubPhone", ""));
        v.setAddress(ParamUtils.getParameter(request, "Address", ""));
        v.setE_MAIL(ParamUtils.getParameter(request, "E_MAIL", ""));
        v.setJguan(ParamUtils.getParameter(request, "Jguan", ""));
        v.setXB(ParamUtils.getParameter(request, "XB", ""));
        v.setCSRQ(ParamUtils.getParameter(request, "CSRQ", ""));
        v.setMZ(ParamUtils.getParameter(request, "MZ", ""));
        v.setSfzhm(ParamUtils.getParameter(request, "Sfzhm", ""));
        v.setZzmm(ParamUtils.getParameter(request, "Zzmm", ""));
        v.setMarryFlag(ParamUtils.getIntParameter(request, "MarryFlag", 0));
        v.setDegreeCode(ParamUtils.getIntParameter(request, "DegreeCode", -1));
        v.setWorkStart(ParamUtils.getParameter(request, "WorkStart", ""));
        v.setTechPostCode(ParamUtils.getParameter(request, "TechPostCode", ""));
        v.setZhiWu(ParamUtils.getParameter(request, "ZhiWu", ""));
        v.setPhoto(ParamUtils.getParameter(request, "Photo", ""));
        v.setIp(ParamUtils.getParameter(request, "Ip", ""));
        v.setOrderNum(ParamUtils.getIntParameter(request, "OrderNum", 0));
        v.setSTATE(ParamUtils.getParameter(request, "STATE", ""));
        v.setDelFlag(ParamUtils.getIntParameter(request, "DelFlag", 0));
        v.setErrorNum(ParamUtils.getIntParameter(request, "ErrorNum", 0));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, User pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map Politicsmap = CEditConst.getPoliticsMap(userInfo);
    
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map Degree1Codemap = CEditConst.getDegree1CodeMap(userInfo);
    Map NationNamemap = CEditConst.getNationNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        User v = (User)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getOFFICEID());
        row.add(Tool.jsSpecialChars(v.getLOGID()));
        row.add(Tool.jsSpecialChars(v.getLOGPASS()));
        row.add(Tool.jsSpecialChars(v.getPhone()));
        row.add(Tool.jsSpecialChars(v.getSubPhone()));
        row.add(Tool.jsSpecialChars(v.getAddress()));
        row.add(Tool.jsSpecialChars(v.getE_MAIL()));
        row.add(Tool.jsSpecialChars(v.getJguan()));
        row.add(Tool.jsSpecialChars(v.getXB()));
        row.add(Tool.jsSpecialChars(v.getCSRQ()));
        row.add((String)NationNamemap.get("" + v.getMZ()));
        row.add(Tool.jsSpecialChars(v.getSfzhm()));
        row.add((String)Politicsmap.get("" + v.getZzmm()));
        row.add((String)YesNomap.get("" + v.getMarryFlag()));
        row.add((String)Degree1Codemap.get("" + v.getDegreeCode()));
        row.add(Tool.jsSpecialChars(v.getWorkStart()));
        row.add(Tool.jsSpecialChars(v.getTechPostCode()));
        row.add(Tool.jsSpecialChars(v.getZhiWu()));
        row.add(Tool.jsSpecialChars(v.getPhoto()));
        row.add(Tool.jsSpecialChars(v.getIp()));
        row.add("" + v.getOrderNum());
        row.add(Tool.jsSpecialChars(v.getSTATE()));
        row.add((String)YesNomap.get("" + v.getDelFlag()));
        row.add("" + v.getErrorNum());
        row.add(Tool.jsSpecialChars(v.getRemark()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, User pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, User pv, boolean isAll)
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
    qvali = ParamUtils.getIntParameter(request, "_OFFICEID_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("OFFICEID=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_LOGID_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("LOGID like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_LOGPASS_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("LOGPASS like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Phone_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("phone like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_SubPhone_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("subphone like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Address_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Address like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_XB_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("XB like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Sfzhm_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Sfzhm like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zzmm_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zzmm like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_DegreeCode_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("DegreeCode=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_WorkStart_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("WorkStart like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_TechPostCode_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("TechPostCode=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_OrderNum_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("OrderNum=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_STATE_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("STATE like '%" + qval + "%'");
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
    request.setAttribute("Politicsoptions", CEditConst.getPoliticsOptions(userInfo,""));
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("TechPostCodeoptions", CEditConst.getTechPostCodeOptions(userInfo, "-1"));
   // request.setAttribute("TechPostCodeoptions", CEditConst.getTechPostCodeOptions(userInfo, "-1"));
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("Degree1Codeoptions", CEditConst.getDegree1CodeOptions(userInfo, "-1"));
    request.setAttribute("Degree1Codeoptions", CEditConst.getDegree1CodeOptions(userInfo, "-1"));
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
    User pv = new User();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "User");
    request.setAttribute("describe", "用户管理");
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, User pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map Politicsmap = CEditConst.getPoliticsMap(userInfo);
   // Map TechPostCodemap = CEditConst.getTechPostCodeMap(userInfo);
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map Degree1Codemap = CEditConst.getDegree1CodeMap(userInfo);
    Map NationNamemap = CEditConst.getNationNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        User v = (User)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("OFFICEID","" + v.getOFFICEID());
        map.put("LOGID",Tool.jsSpecialChars(v.getLOGID()));
        map.put("LOGPASS",Tool.jsSpecialChars(v.getLOGPASS()));
        map.put("Phone",Tool.jsSpecialChars(v.getPhone()));
        map.put("SubPhone",Tool.jsSpecialChars(v.getSubPhone()));
        map.put("Address",Tool.jsSpecialChars(v.getAddress()));
        map.put("E_MAIL",Tool.jsSpecialChars(v.getE_MAIL()));
        map.put("Jguan",Tool.jsSpecialChars(v.getJguan()));
        map.put("XB",Tool.jsSpecialChars(v.getXB()));
        map.put("CSRQ",Tool.jsSpecialChars(v.getCSRQ()));
        map.put("MZ",(String)NationNamemap.get("" + v.getMZ()));
        map.put("Sfzhm",Tool.jsSpecialChars(v.getSfzhm()));
        map.put("Zzmm",(String)Politicsmap.get("" + v.getZzmm()));
        map.put("MarryFlag",(String)YesNomap.get("" + v.getMarryFlag()));
        map.put("DegreeCode",(String)Degree1Codemap.get("" + v.getDegreeCode()));
        map.put("WorkStart",Tool.jsSpecialChars(v.getWorkStart()));
        map.put("TechPostCode",Tool.jsSpecialChars( v.getTechPostCode()));
        map.put("ZhiWu",Tool.jsSpecialChars(v.getZhiWu()));
        map.put("Photo",Tool.jsSpecialChars(v.getPhoto()));
        map.put("Ip",Tool.jsSpecialChars(v.getIp()));
        map.put("OrderNum","" + v.getOrderNum());
        map.put("STATE",Tool.jsSpecialChars(v.getSTATE()));
        map.put("DelFlag",(String)YesNomap.get("" + v.getDelFlag()));
        map.put("ErrorNum","" + v.getErrorNum());
        map.put("Remark",Tool.jsSpecialChars(v.getRemark()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, User pv, List cdt)
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
    User pv = new User();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "User");
    request.setAttribute("describe", "用户管理");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    User pv = new User();
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
private void setForm(javax.servlet.http.HttpServletRequest request, User form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("Politicsoptions", CEditConst.getPoliticsOptions(userInfo));
  //  request.setAttribute("TechPostCodeoptions", CEditConst.getTechPostCodeOptions(userInfo));
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("Degree1Codeoptions", CEditConst.getDegree1CodeOptions(userInfo));
    request.setAttribute("NationNameoptions", CEditConst.getNationNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "User");
    request.setAttribute("describe", "用户管理");
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(User form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, User form)
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
    User form = getByParameterDb(request);
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
         String RootKeyL1 = StrTool.DumStr("0",cu.getFirstLevelLen()-1);
        // Map deptmap = CEditConst.getKChengMap(userInfo);
         //request.setAttribute("PNAME",deptmap.get(""+pid));
         List cdt = new ArrayList();
         List aclist = new ArrayList();
         User ac = new User();

           //默认系统添加
           cdt.add("length(code)="+cu.getFirstLevelLen());
           cdt.add("order by code desc");
           aclist = ac.query(cdt);
           if(aclist==null || aclist.size()==0)
             form.setCode(RootKeyL1+"1");
           else
           {
             form.setCode(cu.getNextCode(((User)aclist.get(0)).getCode(),1));
           }
        
          return mkRtn("save", "input", form);
    }
    if (cmd.equals("modifyPwd"))
    {
       List cdt = new ArrayList();
	    cdt.add("logid='"+ userInfo.getName() +"'");
	    List<User> forms = form.query(cdt);
	    if(forms.size()>0)
	    {  
	      form = forms.get(0);
	      setForm(request, form);
	      return mkRtn("updatePwd", "inputPwd", form);
	    }else
	    {
	     request.setAttribute("msg", "未规定的cmd:" + cmd);
	     return mkRtn("list", "failure", form);
	    }
    }
    if (cmd.equals("updatePwd"))
    {
    //只修改ID
    List cdt = new ArrayList();
    cdt.add("logid='"+ userInfo.getName() +"'");
    List<User> forms = form.query(cdt);
    if(forms.size()>0)
    {
      
      form = forms.get(0);
      setForm(request,form);
      
      String pwd = ParamUtils.getParameter(request,"Pwd","");
      
      if(!Tool.getDigest(pwd).equals(form.getLOGPASS()))
      {
        request.setAttribute("msg","用户原口令（密码）校验错误！");
        return mkRtn("updatePwd", "inputPwd", form);
      }
      else
      {
        String pwd1 = ParamUtils.getParameter(request,"Pwd1","");
        if(pwd1.length() > 0)
        form.setLOGPASS(Tool.getDigest(pwd1));
        form.update();
        request.setAttribute("msg","用户口令（密码）更新成功！下次登陆请使用新密码！");
        return mkRtn("updatePwd", "inputPwd", form);
      }
    }
    }
    if (cmd.equals("modiczpwd"))
    {int id = ParamUtils.getIntParameter(request, "Id", 0);
       
	    if(id>0)
	    {  
	      form = form.getById(id);
	      setForm(request, form);
	      return mkRtn("updateczpwd", "czpwd", form);
	    }else
	    {
	     request.setAttribute("msg", "未规定的cmd:" + cmd);
	     return mkRtn("list", "failure", form);
	    }
    }
    if (cmd.equals("updateczpwd"))
    {
    int id = ParamUtils.getIntParameter(request, "Id", 0);
    
    if(id>0)
    {      
      form = form.getById(id);
      setForm(request,form);
      
        String pwd1 = ParamUtils.getParameter(request,"Pwd1","");
        if(pwd1.length() > 0)
        form.setLOGPASS(Tool.getDigest(pwd1));
        form.setErrorNum(0);
        form.update();
        request.setAttribute("msg","用户口令（密码）更新成功！");
        return mkRtn("updateczpwd", "czpwd", form);
      
    }
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
        request.setAttribute("classname", "User");
        request.setAttribute("describe", "用户管理");
        return mkRtn("listjquery", "listjquery", form);
    }
    if (cmd.equals("delete"))
    {
    	 int id = form.getId();
         form = form.getById(id);
         if(!form.getLOGID().equals("admin"))
        {form.delete(form.getId());}
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("deletelist"))
    {
    	 String idlist = ParamUtils.getParameter(request, "idlist", "-1");
         List cdt = new ArrayList();
         cdt.add("id in (" + idlist + ")");
         cdt.add("logid!='admin'");
         form.deleteByCondition(cdt);
         return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
     String LOGPASS = ParamUtils.getParameter(request,"LOGPASS","");    	
   	 String LOGID = ParamUtils.getParameter(request,"LOGID","");
   	if(LOGPASS.length() > 0)
   	{form.setLOGPASS(Tool.getDigest(LOGPASS));}
   	List cdt = new ArrayList();
   	cdt.clear();
   	cdt.add("logid='"+LOGID+"'");
   	 User user = new User();
   	 if(user.getCount(cdt)>0){
   		 request.setAttribute("message", "用户名已存在!");
   	 }else{
       form.insert();
       request.setAttribute("message", "保存成功!");
       }
       setForm(request, form);
       
       return mkRtn("list", "input", form);
    }
    if (cmd.equals("update"))
    {
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "用户编码重复!");
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
log.debug("UserAction");
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
forwardMap.put("list", "UserAction.jsp");
forwardMap.put("failure", "UserForm.jsp");
forwardMap.put("success", "UserList.jsp");
forwardMap.put("listjquery", "UserListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "UserForm.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='UserAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
