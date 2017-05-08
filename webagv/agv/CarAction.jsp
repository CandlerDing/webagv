<%@ page language="java" %>
<%--车辆管理--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Car.class);
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Uuid", "Code", "Name", "IdP", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Hwsl", "Hwzl", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Isuse", "Flag", "TxFlag"};
private String[] DicKeys = {"Id", "Uuid", "Code", "Name", "IdP", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Hwsl", "Hwzl", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Isuse", "Flag", "TxFlag"};
private String[][] DicValues = {{"int", "id", "-1", "hidden", ""}, {"string", "Uuid", "50", "text", ""}, {"string", "编码", "50", "text", ""}, {"string", "名称", "50", "text", ""}, {"int", "父ID", "-1", "hidden", ""}, {"string", "精度", "50", "text", ""}, {"string", "电池电压", "50", "text", ""}, {"double", "最大直线速度", "0", "text", ""}, {"double", "最大拐弯速度", "0", "text", ""}, {"double", "加速度", "0", "text", ""}, {"double", "减速度", "0", "text", ""}, {"string", "上料方式", "50", "text", ""}, {"double", "速度", "0", "text", ""}, {"string", "导引方式", "50", "text", ""}, {"string", "外形尺寸", "50", "text", ""}, {"string", "负载", "50", "text", ""}, {"string", "定位精度", "50", "text", ""}, {"string", "驱动形式", "50", "text", ""}, {"string", "连续工作时间", "50", "text", ""}, {"string", "充电方式", "50", "text", ""}, {"string", "最小转弯半径", "50", "text", ""}, {"string", "安全感应范围", "50", "text", ""}, {"string", "路径识别", "50", "text", ""}, {"string", "行走提示", "50", "text", ""}, {"string", "故障报警", "50", "text", ""}, {"string", "安全防护", "50", "text", ""}, {"string", "最大负重", "50", "text", ""}, {"string", "最大直线行程", "50", "text", ""}, {"string", "电池充电电压", "50", "text", ""}, {"string", "最低工作电压", "50", "text", ""}, {"string", "车身长度", "50", "text", ""}, {"string", "车身宽度", "50", "text", ""}, {"string", "通讯方式 ", "50", "text", ""}, {"int", "车身货位数量", "-1", "hidden", ""}, {"int", "车身货位重量", "-1", "hidden", ""}, {"string", "串口IP地址", "100", "text", ""}, {"string", "串口端口", "20", "text", ""}, {"string", "无线IP地址", "100", "text", ""}, {"string", "无线端口", "20", "text", ""}, {"int", "机械手数量", "-1", "text", ""}, {"int", "IO通道数量", "-1", "text", ""}, {"int", "车辆地址", "-1", "RfidName", ""}, {"int", "是否在用0否1是", "-1", "YesNo", ""}, {"int", "是否故障0否1是", "-1", "YesNo", ""}, {"int", "通讯是否正常", "-1", "YesNo", ""}};
private String KeyField = "Id";
private String OperateField = DicKeys[DicKeys.length-1];//操作字段
private String[] AllFields = {"Id", "Uuid", "Code", "Name", "IdP", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Hwsl", "Hwzl", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Isuse", "Flag", "TxFlag"};
private String[] ListFields = { "Name",  "Dyfs", "Qdxs","Ipaddress", "Flag", "TxFlag"};
private String[] PrintFields = {"Uuid", "Code", "Name", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Isuse", "Flag", "TxFlag"};
private String[] FormFields = {"Uuid", "Code", "Name", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Isuse", "Flag", "TxFlag"};
private String[] QueryFields = {"Name", "Jd", "Dcdy", "Zxsd", "Gwsd", "Jiasd", "Jiansd", "Slfs", "Sd", "Dyfs", "Wxcc", "Fz", "Dwjd", "Qdxs", "Lxtime", "Cdfs", "Zwlj", "Aqgyfw", "Ljsb", "Xzts", "Gzbj", "Aqfh", "Zdfz", "Zdzxxc", "Cddy", "Zddy", "Cd", "Kd", "Txfs", "Hwsl", "Hwzl", "Ipaddress", "Port", "WifiIpaddress", "WifiPort", "Handnum", "Ionum", "AddressId", "Flag", "TxFlag"};
private Car getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Car v = new Car();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update") || cmd.equals("jqueryUpdate") ) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramUuid(request, "Uuid");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramIdP(request, "IdP");
        v.paramJd(request, "Jd");
        v.paramDcdy(request, "Dcdy");
        v.paramZxsd(request, "Zxsd");
        v.paramGwsd(request, "Gwsd");
        v.paramJiasd(request, "Jiasd");
        v.paramJiansd(request, "Jiansd");
        v.paramSlfs(request, "Slfs");
        v.paramSd(request, "Sd");
        v.paramDyfs(request, "Dyfs");
        v.paramWxcc(request, "Wxcc");
        v.paramFz(request, "Fz");
        v.paramDwjd(request, "Dwjd");
        v.paramQdxs(request, "Qdxs");
        v.paramLxtime(request, "Lxtime");
        v.paramCdfs(request, "Cdfs");
        v.paramZwlj(request, "Zwlj");
        v.paramAqgyfw(request, "Aqgyfw");
        v.paramLjsb(request, "Ljsb");
        v.paramXzts(request, "Xzts");
        v.paramGzbj(request, "Gzbj");
        v.paramAqfh(request, "Aqfh");
        v.paramZdfz(request, "Zdfz");
        v.paramZdzxxc(request, "Zdzxxc");
        v.paramCddy(request, "Cddy");
        v.paramZddy(request, "Zddy");
        v.paramCd(request, "Cd");
        v.paramKd(request, "Kd");
        v.paramTxfs(request, "Txfs");
        v.paramHwsl(request, "Hwsl");
        v.paramHwzl(request, "Hwzl");
        v.paramIpaddress(request, "Ipaddress");
        v.paramPort(request, "Port");
        v.paramWifiIpaddress(request, "WifiIpaddress");
        v.paramWifiPort(request, "WifiPort");
        v.paramHandnum(request, "Handnum");
        v.paramIonum(request, "Ionum");
        v.paramAddressId(request, "AddressId");
        v.paramIsuse(request, "Isuse");
        v.paramFlag(request, "Flag");
        v.paramTxFlag(request, "TxFlag");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setUuid(ParamUtils.getParameter(request, "Uuid", ""));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setJd(ParamUtils.getParameter(request, "Jd", ""));
        v.setDcdy(ParamUtils.getParameter(request, "Dcdy", ""));
        v.setZxsd(ParamUtils.getDoubleParameter(request, "Zxsd", 0));
        v.setGwsd(ParamUtils.getDoubleParameter(request, "Gwsd", 0));
        v.setJiasd(ParamUtils.getDoubleParameter(request, "Jiasd", 0));
        v.setJiansd(ParamUtils.getDoubleParameter(request, "Jiansd", 0));
        v.setSlfs(ParamUtils.getParameter(request, "Slfs", ""));
        v.setSd(ParamUtils.getDoubleParameter(request, "Sd", 0));
        v.setDyfs(ParamUtils.getParameter(request, "Dyfs", ""));
        v.setWxcc(ParamUtils.getParameter(request, "Wxcc", ""));
        v.setFz(ParamUtils.getParameter(request, "Fz", ""));
        v.setDwjd(ParamUtils.getParameter(request, "Dwjd", ""));
        v.setQdxs(ParamUtils.getParameter(request, "Qdxs", ""));
        v.setLxtime(ParamUtils.getParameter(request, "Lxtime", ""));
        v.setCdfs(ParamUtils.getParameter(request, "Cdfs", ""));
        v.setZwlj(ParamUtils.getParameter(request, "Zwlj", ""));
        v.setAqgyfw(ParamUtils.getParameter(request, "Aqgyfw", ""));
        v.setLjsb(ParamUtils.getParameter(request, "Ljsb", ""));
        v.setXzts(ParamUtils.getParameter(request, "Xzts", ""));
        v.setGzbj(ParamUtils.getParameter(request, "Gzbj", ""));
        v.setAqfh(ParamUtils.getParameter(request, "Aqfh", ""));
        v.setZdfz(ParamUtils.getParameter(request, "Zdfz", ""));
        v.setZdzxxc(ParamUtils.getParameter(request, "Zdzxxc", ""));
        v.setCddy(ParamUtils.getParameter(request, "Cddy", ""));
        v.setZddy(ParamUtils.getParameter(request, "Zddy", ""));
        v.setCd(ParamUtils.getParameter(request, "Cd", ""));
        v.setKd(ParamUtils.getParameter(request, "Kd", ""));
        v.setTxfs(ParamUtils.getParameter(request, "Txfs", ""));
        v.setHwsl(ParamUtils.getIntParameter(request, "Hwsl", -1));
        v.setHwzl(ParamUtils.getIntParameter(request, "Hwzl", -1));
        v.setIpaddress(ParamUtils.getParameter(request, "Ipaddress", ""));
        v.setPort(ParamUtils.getParameter(request, "Port", ""));
        v.setWifiIpaddress(ParamUtils.getParameter(request, "WifiIpaddress", ""));
        v.setWifiPort(ParamUtils.getParameter(request, "WifiPort", ""));
        v.setHandnum(ParamUtils.getIntParameter(request, "Handnum", -1));
        v.setIonum(ParamUtils.getIntParameter(request, "Ionum", -1));
        v.setAddressId(ParamUtils.getIntParameter(request, "AddressId", -1));
        v.setIsuse(ParamUtils.getIntParameter(request, "Isuse", -1));
        v.setFlag(ParamUtils.getIntParameter(request, "Flag", -1));
        v.setTxFlag(ParamUtils.getIntParameter(request, "TxFlag", -1));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Car pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map RfidNamemap = CEditConst.getRfidNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Car v = (Car)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getUuid()));
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getIdP());
        row.add(Tool.jsSpecialChars(v.getJd()));
        row.add(Tool.jsSpecialChars(v.getDcdy()));
        row.add("" + v.getZxsd());
        row.add("" + v.getGwsd());
        row.add("" + v.getJiasd());
        row.add("" + v.getJiansd());
        row.add(Tool.jsSpecialChars(v.getSlfs()));
        row.add("" + v.getSd());
        row.add(Tool.jsSpecialChars(v.getDyfs()));
        row.add(Tool.jsSpecialChars(v.getWxcc()));
        row.add(Tool.jsSpecialChars(v.getFz()));
        row.add(Tool.jsSpecialChars(v.getDwjd()));
        row.add(Tool.jsSpecialChars(v.getQdxs()));
        row.add(Tool.jsSpecialChars(v.getLxtime()));
        row.add(Tool.jsSpecialChars(v.getCdfs()));
        row.add(Tool.jsSpecialChars(v.getZwlj()));
        row.add(Tool.jsSpecialChars(v.getAqgyfw()));
        row.add(Tool.jsSpecialChars(v.getLjsb()));
        row.add(Tool.jsSpecialChars(v.getXzts()));
        row.add(Tool.jsSpecialChars(v.getGzbj()));
        row.add(Tool.jsSpecialChars(v.getAqfh()));
        row.add(Tool.jsSpecialChars(v.getZdfz()));
        row.add(Tool.jsSpecialChars(v.getZdzxxc()));
        row.add(Tool.jsSpecialChars(v.getCddy()));
        row.add(Tool.jsSpecialChars(v.getZddy()));
        row.add(Tool.jsSpecialChars(v.getCd()));
        row.add(Tool.jsSpecialChars(v.getKd()));
        row.add(Tool.jsSpecialChars(v.getTxfs()));
        row.add("" + v.getHwsl());
        row.add("" + v.getHwzl());
        row.add(Tool.jsSpecialChars(v.getIpaddress()));
        row.add(Tool.jsSpecialChars(v.getPort()));
        row.add(Tool.jsSpecialChars(v.getWifiIpaddress()));
        row.add(Tool.jsSpecialChars(v.getWifiPort()));
        row.add("" + v.getHandnum());
        row.add("" + v.getIonum());
        row.add((String)RfidNamemap.get("" + v.getAddressId()));
        row.add((String)YesNomap.get("" + v.getIsuse()));
        row.add((String)YesNomap.get("" + v.getFlag()));
        row.add((String)YesNomap.get("" + v.getTxFlag()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Car pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Car pv, boolean isAll)
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
    qval = ParamUtils.getParameter(request, "_Jd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Jd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Dcdy_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Dcdy like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Zxsd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Zxsd=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Gwsd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Gwsd=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Jiasd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Jiasd=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Jiansd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Jiansd=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Slfs_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Slfs like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Sd_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Sd=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Dyfs_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Dyfs like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Wxcc_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Wxcc like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Fz_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Fz like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Dwjd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Dwjd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Qdxs_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Qdxs like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Lxtime_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Lxtime like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Cdfs_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Cdfs like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zwlj_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zwlj like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Aqgyfw_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Aqgyfw like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Ljsb_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Ljsb like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Xzts_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Xzts like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Gzbj_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Gzbj like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Aqfh_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Aqfh like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zdfz_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zdfz like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zdzxxc_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zdzxxc like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Cddy_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Cddy like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Zddy_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Zddy like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Cd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Cd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Kd_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Kd like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Txfs_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Txfs like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Hwsl_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Hwsl=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Hwzl_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Hwzl=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Ipaddress_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Ipaddress like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Port_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("Port like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_WifiIpaddress_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("WifiIpaddress like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_WifiPort_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("WifiPort like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Handnum_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Handnum=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Ionum_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Ionum=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_AddressId_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("AddressId=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_Flag_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("Flag=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_TxFlag_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("TxFlag=" + qvali);
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
    Car pv = new Car();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Car");
    request.setAttribute("describe", "车辆管理");
    request.setAttribute("OperateField",OperateField);
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Car pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map RfidNamemap = CEditConst.getRfidNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Car v = (Car)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Uuid",Tool.jsSpecialChars(v.getUuid()));
        map.put("Code",Tool.jsSpecialChars(v.getCode()));
        map.put("Name",Tool.jsSpecialChars(v.getName()));
        map.put("IdP","" + v.getIdP());
        map.put("Jd",Tool.jsSpecialChars(v.getJd()));
        map.put("Dcdy",Tool.jsSpecialChars(v.getDcdy()));
        map.put("Zxsd","" + v.getZxsd());
        map.put("Gwsd","" + v.getGwsd());
        map.put("Jiasd","" + v.getJiasd());
        map.put("Jiansd","" + v.getJiansd());
        map.put("Slfs",Tool.jsSpecialChars(v.getSlfs()));
        map.put("Sd","" + v.getSd());
        map.put("Dyfs",Tool.jsSpecialChars(v.getDyfs()));
        map.put("Wxcc",Tool.jsSpecialChars(v.getWxcc()));
        map.put("Fz",Tool.jsSpecialChars(v.getFz()));
        map.put("Dwjd",Tool.jsSpecialChars(v.getDwjd()));
        map.put("Qdxs",Tool.jsSpecialChars(v.getQdxs()));
        map.put("Lxtime",Tool.jsSpecialChars(v.getLxtime()));
        map.put("Cdfs",Tool.jsSpecialChars(v.getCdfs()));
        map.put("Zwlj",Tool.jsSpecialChars(v.getZwlj()));
        map.put("Aqgyfw",Tool.jsSpecialChars(v.getAqgyfw()));
        map.put("Ljsb",Tool.jsSpecialChars(v.getLjsb()));
        map.put("Xzts",Tool.jsSpecialChars(v.getXzts()));
        map.put("Gzbj",Tool.jsSpecialChars(v.getGzbj()));
        map.put("Aqfh",Tool.jsSpecialChars(v.getAqfh()));
        map.put("Zdfz",Tool.jsSpecialChars(v.getZdfz()));
        map.put("Zdzxxc",Tool.jsSpecialChars(v.getZdzxxc()));
        map.put("Cddy",Tool.jsSpecialChars(v.getCddy()));
        map.put("Zddy",Tool.jsSpecialChars(v.getZddy()));
        map.put("Cd",Tool.jsSpecialChars(v.getCd()));
        map.put("Kd",Tool.jsSpecialChars(v.getKd()));
        map.put("Txfs",Tool.jsSpecialChars(v.getTxfs()));
        map.put("Hwsl","" + v.getHwsl());
        map.put("Hwzl","" + v.getHwzl()); 
        map.put("Ipaddress",Tool.jsSpecialChars(v.getIpaddress()));
        map.put("Port",Tool.jsSpecialChars(v.getPort()));
        map.put("WifiIpaddress",Tool.jsSpecialChars(v.getWifiIpaddress()));
        map.put("WifiPort",Tool.jsSpecialChars(v.getWifiPort()));
        map.put("Handnum","" + v.getHandnum());
        map.put("Ionum","" + v.getIonum());
        map.put("AddressId",(String)RfidNamemap.get("" + v.getAddressId()));
        map.put("Isuse",(String)YesNomap.get("" + v.getIsuse()));
        map.put("Flag",(String)YesNomap.get("" + v.getFlag()));
        map.put("TxFlag",(String)YesNomap.get("" + v.getTxFlag()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Car pv, List cdt)
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
    Car pv = new Car();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Car");
    request.setAttribute("describe", "车辆管理");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Car pv = new Car();
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
private void setForm(javax.servlet.http.HttpServletRequest request, Car form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("RfidNameoptions", CEditConst.getRfidNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Car");
    request.setAttribute("describe", "车辆管理");
    request.setAttribute("OperateField",OperateField);
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(Car form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update") || cmd.equals("jqueryUpdate")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, Car form)
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
    Car form = getByParameterDb(request);
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
      Car ac = new Car();
       if(pid>0) //有父
      {
    	   Car formP = form.getById(pid);
        if(formP!=null && formP.getId()>0)
        {           
          cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
          cdt.add("code like '"+ formP.getCode() +"%'");            
          cdt.add("order by code desc");
          ac = new Car();
          aclist = ac.query(cdt);
          if(aclist==null || aclist.size()==0)
           form.setCode(formP.getCode()+RootKeyL1+"1");
          else
          {
            form.setCode(cu.getNextCode(((Car)aclist.get(0)).getCode(),cu.getLevel(((Car)aclist.get(0)).getCode())));
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
          form.setCode(cu.getNextCode(((Car)aclist.get(0)).getCode(),1));
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
        	request.setAttribute("classname", "Car");
        	request.setAttribute("describe", "车辆管理");
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
        	form.setUuid(UUID.randomUUID().toString());
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
log.debug("CarAction");
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
forwardMap.put("list", "CarAction.jsp");
forwardMap.put("failure", "CarForm.jsp");
forwardMap.put("success", "CarList.jsp");
forwardMap.put("listjquery", "CarListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "CarForm.jsp");
forwardMap.put("jqueryInput", "CarFormJquery.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='CarAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
