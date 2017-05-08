<%@ page language="java" %>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(TaskQuene.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Uuid", "Name", "TaskId", "Carid", "CarUUId", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "QdUUId", "ZdUUId", "Flow", "His_itemids", "Cur_itemsids", "Cur_dates", "Flow_logs", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Orderno", "Userid"};
private String[] DicKeys = {"Id", "Uuid", "Name", "TaskId", "Carid", "CarUUId", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "QdUUId", "ZdUUId", "Flow", "His_itemids", "Cur_itemsids", "Cur_dates", "Flow_logs", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Orderno", "Userid"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"string", "Uuid", "50", "text", ""}, {"string", "名称", "50", "text", ""}, {"int", "任务ID", "-1", "hidden", ""}, {"int", "小车", "-1", "hidden", ""}, {"string", "小车Uuid", "50", "text", ""}, {"string", "优先级", "50", "text", ""}, {"string", "任务状态0未定义1待命区2缓冲3执行区", "50", "text", ""}, {"string", "起点地址", "50", "text", ""}, {"string", "终点地址", "50", "text", ""}, {"int", "起点RFID", "-1", "hidden", ""}, {"int", "终点RFID", "-1", "hidden", ""}, {"string", "起点RFID", "50", "hidden", ""}, {"string", "终点RFID", "50", "hidden", ""}, {"string", "路径流程", "500", "hidden", ""}, {"string", "历史流程", "500", "hidden", ""}, {"string", "当前流程", "500", "hidden", ""}, {"string", "当前状态时间", "50", "hidden", ""}, {"string", "日志", "5000", "hidden", ""}, {"int", "执行状态0未执行1正在执行2结束3异常", "0", "text", ""}, {"int", "可用标志", "-1", "text", ""}, {"string", "货物种类", "50", "text", ""}, {"string", "货物编码", "50", "text", ""}, {"string", "货物名称", "50", "text", ""}, {"string", "货物RFID", "50", "text", ""}, {"double", "发货量", "0", "text", ""}, {"string", "创建时间", "50", "text", ""}, {"string", "下发时间", "50", "text", ""}, {"string", "执行时间 ", "50", "text", ""}, {"string", "执行完成时间", "50", "text", ""}, {"int", "任务类型0无效1运货2充电3维修", "-1", "text", ""}, {"int", "排序", "-1", "text", ""}, {"int", "用户编号", "-1", "text", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Uuid", "Name", "TaskId", "Carid", "CarUUId", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "QdUUId", "ZdUUId", "Flow", "His_itemids", "Cur_itemsids", "Cur_dates", "Flow_logs", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Orderno", "Userid"};
private String[] ListFields = {"Name", "Carid", "Yxj", "Qd", "Zd",  "Fhl", "CreateTime", "XfTime", "StartTime"};
private String[] PrintFields = {"Uuid", "Name", "CarUUId", "Yxj", "Rwzt", "Qd", "Zd", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Orderno", "Userid"};
private String[] FormFields = {"Uuid", "Name", "Carid", "CarUUId", "Yxj", "Rwzt", "Qd", "Zd", "Flow", "His_itemids", "Cur_itemsids", "Cur_dates", "Flow_logs", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Orderno"};
private String[] QueryFields = {"Name", "Carid", "Yxj", "Rwzt", "Qd", "Zd", "QdId", "ZdId", "QdUUId", "ZdUUId", "EndFlag", "Kybz", "Hwzl", "Hwbm", "Hwmc", "Hwrfid", "Fhl", "CreateTime", "XfTime", "StartTime", "EndTime", "Type", "Userid"};
private TaskQuene getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    TaskQuene v = new TaskQuene();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramUuid(request, "Uuid");
        v.paramName(request, "Name");
        v.paramTaskId(request, "TaskId");
        v.paramCarid(request, "Carid");
        v.paramCarUUId(request, "CarUUId");
        v.paramYxj(request, "Yxj");
        v.paramRwzt(request, "Rwzt");
        v.paramQd(request, "Qd");
        v.paramZd(request, "Zd");
        v.paramQdId(request, "QdId");
        v.paramZdId(request, "ZdId");
        v.paramQdUUId(request, "QdUUId");
        v.paramZdUUId(request, "ZdUUId");
        v.paramFlow(request, "Flow");
        v.paramHis_itemids(request, "His_itemids");
        v.paramCur_itemsids(request, "Cur_itemsids");
        v.paramCur_dates(request, "Cur_dates");
        v.paramFlow_logs(request, "Flow_logs");
        v.paramEndFlag(request, "EndFlag");
        v.paramKybz(request, "Kybz");
        v.paramHwzl(request, "Hwzl");
        v.paramHwbm(request, "Hwbm");
        v.paramHwmc(request, "Hwmc");
        v.paramHwrfid(request, "Hwrfid");
        v.paramFhl(request, "Fhl");
        v.paramCreateTime(request, "CreateTime");
        v.paramXfTime(request, "XfTime");
        v.paramStartTime(request, "StartTime");
        v.paramEndTime(request, "EndTime");
        v.paramType(request, "Type");
        v.paramOrderno(request, "Orderno");
        v.paramUserid(request, "Userid");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setUuid(ParamUtils.getParameter(request, "Uuid", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setTaskId(ParamUtils.getIntParameter(request, "TaskId", -1));
        v.setCarid(ParamUtils.getIntParameter(request, "Carid", -1));
        v.setCarUUId(ParamUtils.getParameter(request, "CarUUId", ""));
        v.setYxj(ParamUtils.getParameter(request, "Yxj", ""));
        v.setRwzt(ParamUtils.getParameter(request, "Rwzt", ""));
        v.setQd(ParamUtils.getParameter(request, "Qd", ""));
        v.setZd(ParamUtils.getParameter(request, "Zd", ""));
        v.setQdId(ParamUtils.getIntParameter(request, "QdId", -1));
        v.setZdId(ParamUtils.getIntParameter(request, "ZdId", -1));
        v.setQdUUId(ParamUtils.getParameter(request, "QdUUId", ""));
        v.setZdUUId(ParamUtils.getParameter(request, "ZdUUId", ""));
        v.setFlow(ParamUtils.getParameter(request, "Flow", ""));
        v.setHis_itemids(ParamUtils.getParameter(request, "His_itemids", ""));
        v.setCur_itemsids(ParamUtils.getParameter(request, "Cur_itemsids", ""));
        v.setCur_dates(ParamUtils.getParameter(request, "Cur_dates", ""));
        v.setFlow_logs(ParamUtils.getParameter(request, "Flow_logs", ""));
        v.setEndFlag(ParamUtils.getIntParameter(request, "EndFlag", 0));
        v.setKybz(ParamUtils.getIntParameter(request, "Kybz", -1));
        v.setHwzl(ParamUtils.getParameter(request, "Hwzl", ""));
        v.setHwbm(ParamUtils.getParameter(request, "Hwbm", ""));
        v.setHwmc(ParamUtils.getParameter(request, "Hwmc", ""));
        v.setHwrfid(ParamUtils.getParameter(request, "Hwrfid", ""));
        v.setFhl(ParamUtils.getDoubleParameter(request, "Fhl", 0));
        v.setCreateTime(ParamUtils.getParameter(request, "CreateTime", ""));
        v.setXfTime(ParamUtils.getParameter(request, "XfTime", ""));
        v.setStartTime(ParamUtils.getParameter(request, "StartTime", ""));
        v.setEndTime(ParamUtils.getParameter(request, "EndTime", ""));
        v.setType(ParamUtils.getIntParameter(request, "Type", -1));
        v.setOrderno(ParamUtils.getIntParameter(request, "Orderno", -1));
        v.setUserid(ParamUtils.getIntParameter(request, "Userid", -1));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, TaskQuene pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        TaskQuene v = (TaskQuene)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getUuid()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getTaskId());
        Car c = new Car();
        String car ="";
        if(v.getCarid()>0)
        {
        c = c.getById(v.getCarid());
        car = c.getName();
        }
        row.add(car);
        row.add(Tool.jsSpecialChars(v.getCarUUId()));
        row.add(Tool.jsSpecialChars(v.getYxj()));
        row.add(Tool.jsSpecialChars(v.getRwzt()));
        row.add(Tool.jsSpecialChars(v.getQd()));
        row.add(Tool.jsSpecialChars(v.getZd()));
        row.add("" + v.getQdId());
        row.add("" + v.getZdId());
        row.add(Tool.jsSpecialChars(v.getQdUUId()));
        row.add(Tool.jsSpecialChars(v.getZdUUId()));
        row.add(Tool.jsSpecialChars(v.getFlow()));
        row.add(Tool.jsSpecialChars(v.getHis_itemids()));
        row.add(Tool.jsSpecialChars(v.getCur_itemsids()));
        row.add(Tool.jsSpecialChars(v.getCur_dates()));
        row.add(Tool.jsSpecialChars(v.getFlow_logs()));
        row.add("" + v.getEndFlag());
        row.add("" + v.getKybz());
        row.add(Tool.jsSpecialChars(v.getHwzl()));
        row.add(Tool.jsSpecialChars(v.getHwbm()));
        row.add(Tool.jsSpecialChars(v.getHwmc()));
        row.add(Tool.jsSpecialChars(v.getHwrfid()));
        row.add("" + v.getFhl());
        row.add(Tool.jsSpecialChars(v.getCreateTime()));
        row.add(Tool.jsSpecialChars(v.getXfTime()));
        row.add(Tool.jsSpecialChars(v.getStartTime()));
        row.add(Tool.jsSpecialChars(v.getEndTime()));
        row.add("" + v.getType());
        row.add("" + v.getOrderno());
        row.add("" + v.getUserid());
        rows.add(row);
    }
    return rows;
}

private void setListData(javax.servlet.http.HttpServletRequest request, TaskQuene pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, TaskQuene pv, boolean isAll)
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
    qvali = ParamUtils.getIntParameter(request, "_Carid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Carid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Yxj_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Yxj like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Rwzt_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Rwzt = " + qval );
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
    qvali = ParamUtils.getIntParameter(request, "_EndFlag_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("endFlag=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Kybz_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Kybz=" + qvali);
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
        cdt.add("XfTime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_StartTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("StartTime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_EndTime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("EndTime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Type_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Type like '%" + qval + "%'");
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
    TaskQuene pv = new TaskQuene();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "TaskQuene");
    request.setAttribute("describe", "任务队列");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, TaskQuene pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        TaskQuene v = (TaskQuene)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Uuid",Tool.jsSpecialChars(v.getUuid()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("TaskId","" + v.getTaskId());
        map.put("Carid","" + v.getCarid());
        map.put("CarUUId",Tool.jsSpecialChars(v.getCarUUId()));
        map.put("Yxj",Tool.jsSpecialChars(v.getYxj()));
        map.put("Rwzt",Tool.jsSpecialChars(v.getRwzt()));
        map.put("Qd",Tool.jsSpecialChars(v.getQd()));
        map.put("Zd",Tool.jsSpecialChars(v.getZd()));
        map.put("QdId","" + v.getQdId());
        map.put("ZdId","" + v.getZdId());
        map.put("QdUUId",Tool.jsSpecialChars(v.getQdUUId()));
        map.put("ZdUUId",Tool.jsSpecialChars(v.getZdUUId()));
        map.put("Flow",Tool.jsSpecialChars(v.getFlow()));
        map.put("His_itemids",Tool.jsSpecialChars(v.getHis_itemids()));
        map.put("Cur_itemsids",Tool.jsSpecialChars(v.getCur_itemsids()));
        map.put("Cur_dates",Tool.jsSpecialChars(v.getCur_dates()));
        map.put("Flow_logs",Tool.jsSpecialChars(v.getFlow_logs()));
        map.put("EndFlag","" + v.getEndFlag());
        map.put("Kybz","" + v.getKybz());
        map.put("Hwzl",Tool.jsSpecialChars(v.getHwzl()));
        map.put("Hwbm",Tool.jsSpecialChars(v.getHwbm()));
        map.put("Hwmc",Tool.jsSpecialChars(v.getHwmc()));
        map.put("Hwrfid",Tool.jsSpecialChars(v.getHwrfid()));
        map.put("Fhl","" + v.getFhl());
        map.put("CreateTime",Tool.jsSpecialChars(v.getCreateTime()));
        map.put("XfTime",Tool.jsSpecialChars(v.getXfTime()));
        map.put("StartTime",Tool.jsSpecialChars(v.getStartTime()));
        map.put("EndTime",Tool.jsSpecialChars(v.getEndTime()));
        map.put("Type","" + v.getType());
        map.put("Orderno","" + v.getOrderno());
        map.put("Userid","" + v.getUserid());
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, TaskQuene pv, List cdt)
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
    TaskQuene pv = new TaskQuene();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "TaskQuene");
    request.setAttribute("describe", "任务队列");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    TaskQuene pv = new TaskQuene();
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
private void setForm(javax.servlet.http.HttpServletRequest request, TaskQuene form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "TaskQuene");
    request.setAttribute("describe", "任务队列");
    request.setAttribute("OperateField",OperateField);
}
private List mkRtn(String cmd, String forward, TaskQuene form)
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
    TaskQuene form = getByParameterDb(request);
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
    if (cmd.equals("searchcar"))
    {
        setForm(request, form);
        return mkRtn("updatecar", "searchcar", form);
    }
    if (cmd.equals("updatecar") )
    {
   	 int idlist = ParamUtils.getIntParameter(request, "idlist", 0);
   	 int taskid = ParamUtils.getIntParameter(request, "taskid", 0);
   	 System.out.println("idlist=="+idlist+"=taskid"+taskid);
   	TaskQuene t = new TaskQuene();
   	 t = t.getById(taskid);
    
     t.setCarid(idlist);
     t.setRwzt("3");
    	t.update();
        request.setAttribute("backInfo", "操作成功！");
     	 return mkRtn("cmd", "backInfo", form);
    }
    if (cmd.equals("runtask"))
    {
    	 int taskid = ParamUtils.getIntParameter(request, "taskid", 0);
    	form = form.getById(taskid);
    	setForm(request, form);
        return mkRtn("updateruntask", "runtask", form);
    }
    if (cmd.equals("updateruntask") )
    {
   	 int idlist = ParamUtils.getIntParameter(request, "idlist", 0);
   	 int taskid = ParamUtils.getIntParameter(request, "taskid", 0);
   	 System.out.println("idlist=="+idlist+"=taskid"+taskid);
   	TaskQuene t = new TaskQuene();
   	 t = t.getById(taskid);
    
     t.setCarid(idlist);
     t.setRwzt("3");
    	t.update();
        request.setAttribute("backInfo", "操作成功！");
     	 return mkRtn("cmd", "backInfo", form);
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
        	request.setAttribute("classname", "TaskQuene");
        	request.setAttribute("describe", "任务队列");
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
log.debug("TaskQueneAction");
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
forwardMap.put("list", "TaskQueneAction.jsp");
forwardMap.put("failure", "TaskQueneForm.jsp");
forwardMap.put("success", "TaskQueneList.jsp");
forwardMap.put("listjquery", "TaskQueneListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "TaskQueneForm.jsp");
forwardMap.put("searchcar", "cars.jsp");
forwardMap.put("runtask", "TaskQueneFormrun.jsp");
forwardMap.put("jqueryInput", "TaskQueneFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='TaskQueneAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
}else if(forwardKey.equals("backInfo"))
{
	  out.clear();
	  out.print("<script>alert('"+request.getAttribute("backInfo")+"');</script>");
	  out.flush();
	  return;
}else if(forwardKey.equals("login"))
{
      out.println("<script type=\"text/JavaScript\">alert('登陆已超时！');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
