<%@ page language="java" %>
<%--任务--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Task.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Uuid", "Code", "Name", "IdP", "Carid", "Sd", "Pathid", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "Commands", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private String[] DicKeys = {"Id", "Uuid", "Code", "Name", "IdP", "Carid", "Sd", "Pathid", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "Commands", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"string", "Uuid", "50", "text", ""}, {"string", "编码", "50", "text", ""}, {"string", "名称", "50", "text", ""}, {"int", "父ID", "-1", "hidden", ""}, {"int", "小车", "-1", "hidden", ""}, {"double", "速度", "0", "text", ""}, {"int", "路径", "-1", "hidden", ""}, {"string", "优先级", "50", "text", ""}, {"string", "任务状态0", "50", "text", ""}, {"string", "起点地址", "50", "text", ""}, {"string", "终点地址", "50", "text", ""}, {"int", "起点RFID", "-1", "RfidName", ""}, {"int", "终点RFID", "-1", "RfidName", ""}, {"int", "命令", "-1", "hidden", ""}, {"string", "命令代码", "50", "text", ""}, {"string", "当前点", "50", "text", ""}, {"double", "路径长度", "0", "text", ""}, {"double", "权重", "0", "text", ""}, {"int", "可用标志", "-1", "text", ""}, {"string", "货物种类", "50", "text", ""}, {"string", "货物编码", "50", "text", ""}, {"string", "货物名称", "50", "text", ""}, {"string", "货物RFID", "50", "text", ""}, {"int", "货物数量", "-1", "text", ""}, {"double", "单位输送量", "0", "text", ""}, {"double", "发货量", "0", "text", ""}, {"string", "创建时间", "50", "text", ""}, {"string", "下发时间", "50", "text", ""}, {"string", "用户执行时间 ", "50", "text", ""}, {"string", "执行完成时间", "50", "text", ""}, {"int", "任务类型0无效1运货2充电3维修", "-1", "text", ""}, {"string", "是否结束", "50", "text", ""}, {"int", "用户编号", "-1", "text", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Uuid", "Code", "Name", "IdP", "Carid", "Sd", "Pathid", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "Commands", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private String[] ListFields = { "Name",   "Qd", "Zd",  "Fhl",  "Yxj"};
private String[] PrintFields = {"Uuid", "Code", "Name", "Sd", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private String[] FormFields = {"Uuid", "Code", "Name", "Sd", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private String[] QueryFields = {"Name", "Carid", "Sd", "Pathid", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "Commands", "ComandsCode", "Currfid", "Length", "Weigh", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Hwsl", "Dwssl", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Endflag", "Userid"};
private Task getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Task v = new Task();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramUuid(request, "Uuid");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramIdP(request, "IdP");
        v.paramCarid(request, "Carid");
        v.paramSd(request, "Sd");
        v.paramPathid(request, "Pathid");
        v.paramYxj(request, "Yxj");
        v.paramRwzt(request, "Rwzt");
        v.paramQd(request, "Qd");
        v.paramZd(request, "Zd");
        v.paramQdId(request, "QdId");
        v.paramZdId(request, "ZdId");
        v.paramCommands(request, "Commands");
        v.paramComandsCode(request, "ComandsCode");
        v.paramCurrfid(request, "Currfid");
        v.paramLength(request, "Length");
        v.paramWeigh(request, "Weigh");
        v.paramKybz(request, "Kybz");
        v.paramHwzl(request, "Hwzl");
        v.paramHwbm(request, "Hwbm");
        v.paramHwmc(request, "Hwmc");
        v.paramHwrfid(request, "Hwrfid");
        v.paramHwsl(request, "Hwsl");
        v.paramDwssl(request, "Dwssl");
        v.paramFhl(request, "Fhl");
        v.paramCreateTime(request, "CreateTime");
        v.paramXfTime(request, "XfTime");
        v.paramStartTime(request, "StartTime");
        v.paramEndTime(request, "EndTime");
        v.paramType(request, "Type");
        v.paramEndflag(request, "Endflag");
        v.paramUserid(request, "Userid");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setUuid(ParamUtils.getParameter(request, "Uuid", ""));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setCarid(ParamUtils.getIntParameter(request, "Carid", -1));
        v.setSd(ParamUtils.getDoubleParameter(request, "Sd", 0));
        v.setPathid(ParamUtils.getIntParameter(request, "Pathid", -1));
        v.setYxj(ParamUtils.getParameter(request, "Yxj", ""));
        v.setRwzt(ParamUtils.getParameter(request, "Rwzt", ""));
        v.setQd(ParamUtils.getParameter(request, "Qd", ""));
        v.setZd(ParamUtils.getParameter(request, "Zd", ""));
        v.setQdId(ParamUtils.getIntParameter(request, "QdId", -1));
        v.setZdId(ParamUtils.getIntParameter(request, "ZdId", -1));
        v.setCommands(ParamUtils.getIntParameter(request, "Commands", -1));
        v.setComandsCode(ParamUtils.getParameter(request, "ComandsCode", ""));
        v.setCurrfid(ParamUtils.getParameter(request, "Currfid", ""));
        v.setLength(ParamUtils.getDoubleParameter(request, "Length", 0));
        v.setWeigh(ParamUtils.getDoubleParameter(request, "Weigh", 0));
        v.setKybz(ParamUtils.getIntParameter(request, "Kybz", -1));
        v.setHwzl(ParamUtils.getParameter(request, "Hwzl", ""));
        v.setHwbm(ParamUtils.getParameter(request, "Hwbm", ""));
        v.setHwmc(ParamUtils.getParameter(request, "Hwmc", ""));
        v.setHwrfid(ParamUtils.getParameter(request, "Hwrfid", ""));
        v.setHwsl(ParamUtils.getIntParameter(request, "Hwsl", 0));
        v.setDwssl(ParamUtils.getDoubleParameter(request, "Dwssl", 0));
        v.setFhl(ParamUtils.getDoubleParameter(request, "Fhl", 0));
        v.setCreateTime(ParamUtils.getParameter(request, "CreateTime", ""));
        v.setXfTime(ParamUtils.getParameter(request, "XfTime", ""));
        v.setStartTime(ParamUtils.getParameter(request, "StartTime", ""));
        v.setEndTime(ParamUtils.getParameter(request, "EndTime", ""));
        v.setType(ParamUtils.getIntParameter(request, "Type", -1));
        v.setEndflag(ParamUtils.getParameter(request, "Endflag", "0"));
        v.setUserid(ParamUtils.getIntParameter(request, "Userid", -1));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Task pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map RfidNamemap = CEditConst.getRfidNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Task v = (Task)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getUuid()));
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getIdP());
        row.add("" + v.getCarid());
        row.add("" + v.getSd());
        row.add("" + v.getPathid());
        row.add(Tool.jsSpecialChars(v.getYxj()));
        row.add(Tool.jsSpecialChars(v.getRwzt()));
        Rfid q = new Rfid();
		q = q.getById(v.getQdId());
		Rfid r = new Rfid();
		r = r.getById(v.getZdId());
        row.add(Tool.jsSpecialChars(q.getName()));
        row.add(Tool.jsSpecialChars(r.getName()));
        row.add((String)RfidNamemap.get("" + v.getQdId()));
        row.add((String)RfidNamemap.get("" + v.getZdId()));
        row.add("" + v.getCommands());
        row.add(Tool.jsSpecialChars(v.getComandsCode()));
        row.add(Tool.jsSpecialChars(v.getCurrfid()));
        row.add("" + v.getLength());
        row.add("" + v.getWeigh());
        row.add("" + v.getKybz());
        row.add(Tool.jsSpecialChars(v.getHwzl()));
        row.add(Tool.jsSpecialChars(v.getHwbm()));
        row.add(Tool.jsSpecialChars(v.getHwmc()));
        row.add(Tool.jsSpecialChars(v.getHwrfid()));
        row.add("" + v.getHwsl());
        row.add("" + v.getDwssl());
        row.add("" + v.getFhl());
        row.add(Tool.jsSpecialChars(v.getCreateTime()));
        row.add(Tool.jsSpecialChars(v.getXfTime()));
        row.add(Tool.jsSpecialChars(v.getStartTime()));
        row.add(Tool.jsSpecialChars(v.getEndTime()));
        row.add("" + v.getType());
        row.add(Tool.jsSpecialChars(v.getEndflag()));
        row.add("" + v.getUserid());
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Task pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Task pv, boolean isAll)
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
    cdt.add("Kybz<=0");//判断状态-1的显示，为没有进入缓冲区的任务
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qval = ParamUtils.getParameter(request, "_Name_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("name like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Carid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Carid=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Sd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Sd=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Pathid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Pathid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Yxj_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Yxj like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Rwzt_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Rwzt =" + qval);
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
    qvali = ParamUtils.getIntParameter(request, "_QdId_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("QdId=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_ZdId_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("ZdId=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Commands_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Commands=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_ComandsCode_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("ComandsCode like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Currfid_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Currfid like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Length_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Length=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Weigh_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Weigh=" + qvali);
    }
    
    qval = ParamUtils.getParameter(request, "_Hwzl_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Hwzl like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Hwbm_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Hwbm like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Hwmc_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Hwmc like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Hwrfid_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Hwrfid like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Hwsl_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Hwsl=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Dwssl_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Dwssl=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Fhl_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Fhl=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_CreateTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("CreateTime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_XfTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("XfTime='" + qval + "'");
    }
    qval = ParamUtils.getParameter(request, "_StartTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("StartTime='" + qval + "'");
    }
    qval = ParamUtils.getParameter(request, "_EndTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("EndTime='" + qval + "'");
    }
    qval = ParamUtils.getParameter(request, "_Type_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Type like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Endflag_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Endflag like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Userid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Userid=" + qvali);
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
    //request.setAttribute("RfidNameoptions", CEditConst.getRfidNameOptions(userInfo, "-1"));
    request.setAttribute("RfidNameoptions", CEditConst.getRfidNameOptions(userInfo, "-1"));
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
    Task pv = new Task();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Task");
    request.setAttribute("describe", "任务");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Task pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map RfidNamemap = CEditConst.getRfidNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Task v = (Task)it.next();
        List row = new ArrayList();
        Rfid r=new Rfid();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Uuid",Tool.jsSpecialChars(v.getUuid()));
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("IdP","" + v.getIdP());
        map.put("Carid","" + v.getCarid());
        map.put("Sd","" + v.getSd());
        map.put("Pathid","" + v.getPathid());
        map.put("Yxj",Tool.jsSpecialChars(v.getYxj()));
        map.put("Rwzt",Tool.jsSpecialChars(v.getRwzt()));
		r = r.getById(v.getQdId());
		Rfid q = new Rfid();
		q = q.getById(v.getZdId());
        map.put("Qd",Tool.jsSpecialChars(r.getName()));
        map.put("Zd",Tool.jsSpecialChars(q.getName()));
        map.put("QdId",(String)RfidNamemap.get("" + v.getQdId()));
        map.put("ZdId",(String)RfidNamemap.get("" + v.getZdId()));
        map.put("Commands","" + v.getCommands());
        map.put("ComandsCode",Tool.jsSpecialChars(v.getComandsCode()));
        map.put("Currfid",Tool.jsSpecialChars(v.getCurrfid()));
        map.put("Length","" + v.getLength());
        map.put("Weigh","" + v.getWeigh());
        map.put("Kybz","" + v.getKybz());
        map.put("Hwzl",Tool.jsSpecialChars(v.getHwzl()));
        map.put("Hwbm",Tool.jsSpecialChars(v.getHwbm()));
        map.put("Hwmc",Tool.jsSpecialChars(v.getHwmc()));
        map.put("Hwrfid",Tool.jsSpecialChars(v.getHwrfid()));
        map.put("Hwsl","" + v.getHwsl());
        map.put("Dwssl","" + v.getDwssl());
        map.put("Fhl","" + v.getFhl());
        map.put("CreateTime",Tool.jsSpecialChars(v.getCreateTime()));
        map.put("XfTime",Tool.jsSpecialChars(v.getXfTime()));
        map.put("StartTime",Tool.jsSpecialChars(v.getStartTime()));
        map.put("EndTime",Tool.jsSpecialChars(v.getEndTime()));
        map.put("Type","" + v.getType());
        map.put("Endflag",Tool.jsSpecialChars(v.getEndflag()));
        map.put("Userid","" + v.getUserid());
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Task pv, List cdt)
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
    Task pv = new Task();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Task");
    request.setAttribute("describe", "任务");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Task pv = new Task();
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
private void setForm(javax.servlet.http.HttpServletRequest request, Task form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("RfidNameoptions", CEditConst.getRfidNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Task");
    request.setAttribute("describe", "任务");
    request.setAttribute("OperateField",OperateField);
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(Task form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update") || cmd.equals("jqueryUpdate")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, Task form)
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
    System.out.println("cmd=="+cmd);
    Task form = getByParameterDb(request);
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
        	request.setAttribute("classname", "Task");
        	request.setAttribute("describe", "任务");
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
    if (cmd.equals("subtask"))
	{
		int id = ParamUtils.getIntParameter(request, "id", 0);
		int Zxmonth = ParamUtils.getIntParameter(request, "Zxmonth", 0);
		int Zxday = ParamUtils.getIntParameter(request, "Zxday", 0);
		int Zxhour = ParamUtils.getIntParameter(request, "Zxhour", 0);
		int Zxpl = ParamUtils.getIntParameter(request, "Zxpl", 0);
		//String Zxtime = ParamUtils.getParameter(request, "Zxtime", "");
		String Zxtime ="";//执行时间为空还进行执行，在执行时再设置执行时间
		double Fhl = ParamUtils.getDoubleParameter(request, "Fhl", 0);
		double dwssl = ParamUtils.getDoubleParameter(request, "dwssl", 0);
		System.out.println("id=="+id+"=="+Fhl);
		//连续执行××天，执行1次
		//隔×天，执行n次
		String zxend ="";
		/* if(Zxpl>1)
		{
			
		}else{
			if(Zxmonth>0){
				zxend = Tool.stringOfDate(Tool.addDateByMonth(Tool.stringToDate(Zxtime), Zxmonth));	
				if(Zxday>0)
				{
					zxend = Tool.stringOfDate(Tool.addDateByDay(Tool.stringToDate(zxend), Zxday));	
				}
				if(Zxhour>0)
				{
					zxend = Tool.stringOfDate(Tool.addDateByHour(Tool.stringToDate(zxend), Zxhour));	
				}
			}else{
				if(Zxday>0)
				{
					zxend = Tool.stringOfDate(Tool.addDateByDay(Tool.stringToDate(Zxtime), Zxday));	
					if(Zxhour>0)
					{
						zxend = Tool.stringOfDate(Tool.addDateByHour(Tool.stringToDate(zxend), Zxhour));	
					}
				}else
				{
					if(Zxhour>0)
					{
						zxend = Tool.stringOfDate(Tool.addDateByHour(Tool.stringToDate(Zxtime), Zxhour));	
					}	
				}				
			}			
		} */
			Task task = new Task();
			task= task.getById(id);
			System.out.println("id=="+id);
			double allfhl = Fhl;//task.getFhl();
			double unitfhl = dwssl;//task.getDwssl();
			double cs = Math.ceil(allfhl/unitfhl);
			for(int j=0;j<cs;j++)
			{
				TaskQuene unittask = new TaskQuene();
				unittask.setUuid(UUID.randomUUID().toString());
				unittask.setFhl(unitfhl);				
				unittask.setName(task.getName()+"_"+(j+1));
				unittask.setTaskId(id);
				unittask.setCarid(task.getCarid());				
				unittask.setYxj(task.getYxj());
				unittask.setRwzt("0");
				
				unittask.setQdId(task.getQdId());
				unittask.setZdId(task.getZdId());
				Rfid r = new Rfid();
				r = r.getById(task.getQdId());
				unittask.setQd(r.getName());
				unittask.setQdUUId(r.getPathbsUuId());
				r = r.getById(task.getZdId());
				unittask.setZd(r.getName());				
				unittask.setZdUUId(r.getPathbsUuId());
				unittask.setKybz(task.getKybz());
				unittask.setHwzl(task.getHwzl());
				unittask.setHwbm(task.getHwbm());
				unittask.setHwmc(task.getHwmc());
				unittask.setHwrfid(task.getHwrfid());
			    unittask.setCreateTime(Tool.stringOfDateTime());
			    unittask.setXfTime(Tool.stringOfDateTime());
			    unittask.setStartTime(Zxtime);
			    //unittask.setEndTime();
			    unittask.setType(task.getType());
			    unittask.setEndFlag(0);
			    unittask.setUserid(task.getUserid());
			    unittask.insert();
		}
			task.setKybz(1);
			task.update();
		request.setAttribute("backInfo", "操作成功！");
		setList(request);
		return mkRtn("list", "list", form);		
	}
    if (cmd.equals("save"))
    {
        /* if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "编码重复!");
            setForm(request, form);
            return mkRtn("save", "input", form);
        }
        else { */
        	form.setUuid(UUID.randomUUID().toString());
        	form.setCreateTime(Tool.stringOfDateTime());
            form.insert();
            return mkRtn("list", "list", form);
        /* } */
    }
    if (cmd.equals("update") )
    {
        /* if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "编码重复!");
            setForm(request, form);
            return mkRtn("update", "input", form);
        }
        else { */
            form.update();
            return mkRtn("list", "list", form);
        /* } */
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
log.debug("TaskAction");
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
forwardMap.put("list", "TaskAction.jsp");
forwardMap.put("failure", "TaskForm.jsp");
forwardMap.put("success", "TaskList.jsp");
forwardMap.put("listjquery", "TaskListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "TaskForm.jsp");
forwardMap.put("jqueryInput", "TaskFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='TaskAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
