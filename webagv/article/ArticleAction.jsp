<%@ page language="java" %>
<%--文章信息--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Article.class); 
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Classid", "Title", "SubTitle", "Summary", "Img", "Author", "FromWhere", "KeyWords", "ReadLevel", "PubDate", "Pagenum", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck", "DoTime", "UserId", "UserName", "Siteurl"};
private String[] DicKeys = {"Id", "Classid", "Title", "SubTitle", "Summary", "Img", "Author", "FromWhere", "KeyWords", "ReadLevel", "PubDate", "Pagenum", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck", "DoTime", "UserId", "UserName", "Siteurl"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"int", "主栏目", "0", "ChannelName", ""}, {"string", "标题", "200", "text", ""}, {"string", "目录", "30", "text", ""}, {"string", "摘要", "300", "text", ""}, {"string", "主图片", "300", "text", ""}, {"string", "作者", "50", "text", ""}, {"string", "来源", "50", "text", ""}, {"string", "关键词", "200", "text", ""}, {"string", "阅读权限", "100", "text", ""}, {"string", "发布日期(1999-01-01)", "50", "text", ""}, {"int", "页数", "0", "text", ""}, {"int", "点击次数", "0", "text", ""}, {"int", "是否置顶", "0", "YesNo", ""}, {"int", "热点文章", "0", "YesNo", ""}, {"int", "推荐文章", "0", "YesNo", ""}, {"int", "回收站", "0", "YesNo", ""}, {"int", "是否审核发布", "0", "YesNo", ""}, {"date", "", "-1", "text", ""}, {"string", "发布人id", "50", "text", ""}, {"string", "发布人", "50", "text", ""}, {"string", "静态文章位置", "50", "text", ""}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "Classid", "Title", "SubTitle", "Summary", "Img", "Author", "FromWhere", "KeyWords", "ReadLevel", "PubDate", "Pagenum", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck", "DoTime", "UserId", "UserName", "Siteurl"};
private String[] ListFields = {"SubTitle","Title"};
private String[] ListFieldsgg = {"Title"};
private String[] PrintFields = {"Classid", "Title", "SubTitle", "Summary", "Img", "Author", "FromWhere", "KeyWords", "ReadLevel", "PubDate", "Pagenum", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck", "DoTime", "UserId", "UserName", "Siteurl"};
private String[] FormFields = {"Classid", "Title", "SubTitle", "Summary", "Img", "Author", "FromWhere", "KeyWords", "ReadLevel", "PubDate", "Pagenum", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck", "DoTime", "UserId", "UserName", "Siteurl"};
private String[] QueryFields = {"Classid", "Title", "SubTitle", "Summary", "Hits", "IsTop", "IsHot", "IsRecommend", "IsDel", "IsCheck"};
private Article getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    Article v = new Article();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update")) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramClassid(request, "Classid");
        v.paramTitle(request, "Title");
        v.paramSubTitle(request, "SubTitle");
        v.paramSummary(request, "Summary");
        v.paramImg(request, "Img");
        v.paramAuthor(request, "Author");
        v.paramFromWhere(request, "FromWhere");
        v.paramKeyWords(request, "KeyWords");
        v.paramReadLevel(request, "ReadLevel");
        v.paramPubDate(request, "PubDate");
        v.paramPagenum(request, "Pagenum");
        v.paramHits(request, "Hits");
        v.paramIsTop(request, "IsTop");
        v.paramIsHot(request, "IsHot");
        v.paramIsRecommend(request, "IsRecommend");
        v.paramIsDel(request, "IsDel");
        v.paramIsCheck(request, "IsCheck");
        v.paramDoTime(request, "DoTime");
        v.paramUserId(request, "UserId");
        v.paramUserName(request, "UserName");
        v.paramSiteurl(request, "Siteurl");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setClassid(ParamUtils.getIntParameter(request, "Classid", 0));
        v.setTitle(ParamUtils.getParameter(request, "Title", ""));
        v.setSubTitle(ParamUtils.getParameter(request, "SubTitle", ""));
        v.setSummary(ParamUtils.getParameter(request, "Summary", ""));
        v.setImg(ParamUtils.getParameter(request, "Img", ""));
        v.setAuthor(ParamUtils.getParameter(request, "Author", ""));
        v.setFromWhere(ParamUtils.getParameter(request, "FromWhere", ""));
        v.setKeyWords(ParamUtils.getParameter(request, "KeyWords", ""));
        v.setReadLevel(ParamUtils.getParameter(request, "ReadLevel", ""));
        v.setPubDate(ParamUtils.getParameter(request, "PubDate", ""));
        v.setPagenum(ParamUtils.getIntParameter(request, "Pagenum", 0));
        v.setHits(ParamUtils.getIntParameter(request, "Hits", 0));
        v.setIsTop(ParamUtils.getIntParameter(request, "IsTop", 0));
        v.setIsHot(ParamUtils.getIntParameter(request, "IsHot", 0));
        v.setIsRecommend(ParamUtils.getIntParameter(request, "IsRecommend", 0));
        v.setIsDel(ParamUtils.getIntParameter(request, "IsDel", 0));
        v.setIsCheck(ParamUtils.getIntParameter(request, "IsCheck", 0));
        v.setDoTime(ParamUtils.getDateTimeParameter(request, "DoTime", new java.util.Date()));
        v.setUserId(ParamUtils.getParameter(request, "UserId", ""));
        v.setUserName(ParamUtils.getParameter(request, "UserName", ""));
        v.setSiteurl(ParamUtils.getParameter(request, "Siteurl", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, Article pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map ChannelNamemap = CEditConst.getChannelNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Article v = (Article)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add((String)ChannelNamemap.get("" + v.getClassid()));
        row.add(Tool.jsSpecialChars(v.getTitle()));
        row.add(Tool.jsSpecialChars(v.getSubTitle()));
        row.add(Tool.jsSpecialChars(v.getSummary()));
        row.add(Tool.jsSpecialChars(v.getImg()));
        row.add(Tool.jsSpecialChars(v.getAuthor()));
        row.add(Tool.jsSpecialChars(v.getFromWhere()));
        row.add(Tool.jsSpecialChars(v.getKeyWords()));
        row.add(Tool.jsSpecialChars(v.getReadLevel()));
        row.add(Tool.jsSpecialChars(v.getPubDate()));
        row.add("" + v.getPagenum());
        row.add("" + v.getHits());
        row.add((String)YesNomap.get("" + v.getIsTop()));
        row.add((String)YesNomap.get("" + v.getIsHot()));
        row.add((String)YesNomap.get("" + v.getIsRecommend()));
        row.add((String)YesNomap.get("" + v.getIsDel()));
        row.add((String)YesNomap.get("" + v.getIsCheck()));
        row.add(Tool.stringOfDate(v.getDoTime()));
        row.add(Tool.jsSpecialChars(v.getUserId()));
        row.add(Tool.jsSpecialChars(v.getUserName()));
        row.add(Tool.jsSpecialChars(v.getSiteurl()));
        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, Article pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, Article pv, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    int shownum = ParamUtils.getIntParameter(request, "shownum", userInfo.getDispNum());
    String orderfield = ParamUtils.getParameter(request, "orderfield", "Id");
    String ordertype = ParamUtils.getParameter(request, "ordertype", "desc");
    List cdt = new ArrayList();
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qvali = ParamUtils.getIntParameter(request, "_Classid_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("classid=" + qvali);
    }
    qval = ParamUtils.getParameter(request, "_Title_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("title like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_SubTitle_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("subtitle like '%" + qval + "%'");
    }
    qval = ParamUtils.getParameter(request, "_Summary_", "");
    QueryValues.add(qval);
    if (qval.trim().length() > 0) {
        cdt.add("summary like '%" + qval + "%'");
    }
    qvali = ParamUtils.getIntParameter(request, "_Hits_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("hits=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_IsTop_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("istop=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_IsHot_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("ishot=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_IsRecommend_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("isrecommend=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_IsDel_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("isdel=" + qvali);
    }
    qvali = ParamUtils.getIntParameter(request, "_IsCheck_", -1);
    QueryValues.add(""+qvali);
    if (qvali >= 0) {
        cdt.add("ischeck=" + qvali);
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
    //request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo, "0"));
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo, "-1"));
    //2)查询的时候, select 默认值是default ,并且有空项
    //request.setAttribute("ChannelNameoptions", CEditConst.getChannelNameOptions(userInfo, "0"));
    request.setAttribute("ChannelNameoptions", CEditConst.getChannelNameOptions(userInfo, "-1"));
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
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    Article pv = new Article();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    if(cmd.equals("list")){
    request.setAttribute("fields", ListFields);
    }else{
    request.setAttribute("fields", ListFieldsgg);	
    }
    request.setAttribute("classname", "Article");
    request.setAttribute("describe", "文章信息");
}
private List getListJsonRows(javax.servlet.http.HttpServletRequest request, Article pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    Map YesNomap = CEditConst.getYesNoMap(userInfo);
    Map ChannelNamemap = CEditConst.getChannelNameMap(userInfo);
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        Article v = (Article)it.next();
        List row = new ArrayList();
        Map map = new HashMap();
        map.put("Id","" + v.getId());
        map.put("Classid",(String)ChannelNamemap.get("" + v.getClassid()));
        map.put("Title",Tool.jsSpecialChars(v.getTitle()));
        map.put("SubTitle",Tool.jsSpecialChars(v.getSubTitle()));
        map.put("Summary",Tool.jsSpecialChars(v.getSummary()));
        map.put("Img",Tool.jsSpecialChars(v.getImg()));
        map.put("Author",Tool.jsSpecialChars(v.getAuthor()));
        map.put("FromWhere",Tool.jsSpecialChars(v.getFromWhere()));
        map.put("KeyWords",Tool.jsSpecialChars(v.getKeyWords()));
        map.put("ReadLevel",Tool.jsSpecialChars(v.getReadLevel()));
        map.put("PubDate",Tool.jsSpecialChars(v.getPubDate()));
        map.put("Pagenum","" + v.getPagenum());
        map.put("Hits","" + v.getHits());
        map.put("IsTop",(String)YesNomap.get("" + v.getIsTop()));
        map.put("IsHot",(String)YesNomap.get("" + v.getIsHot()));
        map.put("IsRecommend",(String)YesNomap.get("" + v.getIsRecommend()));
        map.put("IsDel",(String)YesNomap.get("" + v.getIsDel()));
        map.put("IsCheck",(String)YesNomap.get("" + v.getIsCheck()));
        map.put("DoTime",Tool.stringOfDate(v.getDoTime()));
        map.put("UserId",Tool.jsSpecialChars(v.getUserId()));
        map.put("UserName",Tool.jsSpecialChars(v.getUserName()));
        map.put("Siteurl",Tool.jsSpecialChars(v.getSiteurl()));
        rows.add(JSON.toJSONString(map));
    }
    return rows;
}
private void setListJsonData(javax.servlet.http.HttpServletRequest request, Article pv, List cdt)
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
    Article pv = new Article();
    setListJsonData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "Article");
    request.setAttribute("describe", "文章信息");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    Article pv = new Article();
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
private void setForm(javax.servlet.http.HttpServletRequest request, Article form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("YesNooptions", CEditConst.getYesNoOptions(userInfo));
    request.setAttribute("ChannelNameoptions", CEditConst.getChannelNameOptions(userInfo));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "Article");
    request.setAttribute("describe", "文章信息");
}
private List mkRtn(String cmd, String forward, Article form)
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
    Article form = getByParameterDb(request);
    if (cmd.equals("list"))
    {
        setList(request);
        return mkRtn("list", "success", form);
    }
    if (cmd.equals("listgg"))
    {
        setList(request);
        return mkRtn("listgg", "success", form);
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
        request.setAttribute("classname", "Article");
        request.setAttribute("describe", "文章信息");
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
        cdt.add("Id in (" + idlist + ")");
        form.deleteByCondition(cdt);
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
    	String Siteurl = ParamUtils.getParameter(request, "Siteurl", ""); 
    	if(Siteurl!=null&&(Siteurl.endsWith(".doc")||Siteurl.endsWith(".docx"))){
        	String basePath = getServletConfig().getServletContext().getRealPath("").replaceAll("\\\\", "/");
            String[] urls = Tool.split(".",Siteurl);
        	String savePath = basePath +"/"+ Siteurl;
         	String[] fileStrings = Tool.split(".",savePath);        	
         	String docFile = fileStrings[0]+"."+urls[1];
         	String pdfFile = fileStrings[0]+".pdf";         	
         	String aSiteurl = urls[0]+".swf";
         	form.setSiteurl(aSiteurl);
           Word2Pdf wd = new Word2Pdf();
           wd.docToPdf(docFile,pdfFile);
    	}
    	form.insert();
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("update"))
    {
    	String Siteurl = ParamUtils.getParameter(request, "Siteurl", ""); 
    	if(Siteurl!=null&&(Siteurl.endsWith(".doc")||Siteurl.endsWith(".docx"))){
        	String basePath = getServletConfig().getServletContext().getRealPath("").replaceAll("\\\\", "/");
            String[] urls = Tool.split(".",Siteurl);
        	String savePath = basePath +"/"+ Siteurl;
         	String[] fileStrings = Tool.split(".",savePath);        	
         	String docFile = fileStrings[0]+"."+urls[1];
         	String pdfFile = fileStrings[0]+".pdf";         	
         	String aSiteurl = urls[0]+".swf";
         	form.setSiteurl(aSiteurl);
           Word2Pdf wd = new Word2Pdf();
           wd.docToPdf(docFile,pdfFile);
    	}
    	form.update();
        return mkRtn("list", "list", form);
    }
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("list", "failure", form);
}
%>
<%
response.setHeader("Cache-Control", "no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
log.debug("ArticleAction");
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
forwardMap.put("list", "ArticleAction.jsp");
forwardMap.put("failure", "ArticleForm.jsp");
forwardMap.put("success", "ArticleList.jsp");
forwardMap.put("listjquery", "ArticleListJquery.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "ArticleForm.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    out.println("<script type=\"text/JavaScript\">window.location='ArticleAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) + "';</script>");
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
