<%@ page language="java" %>
<%--系统功能模块表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%!
private static Log log = LogFactory.getLog(User_Module.class); 
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "IdP", "FileName", "CanShu", "Remark","JiaoSeUserList","UserNameList"};
private String[] DicKeys = {"Id", "Code", "Name", "IdP", "FileName", "CanShu", "Remark","JiaoSeUserList","UserNameList"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"string", "模块编码", "50", "text", ""}, {"string", "模块名称", "50", "text", ""}, {"int", "父ID", "-1", "hidden", ""}, {"string", "模块操作文件", "300", "text", ""}, {"string", "参数列表", "300", "text", ""}, {"string", "备注", "255", "text", ""}, {"string", "参数列表", "300", "text", ""}, {"string", "拥有此模块的人员", "255", "text", ""}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "Code", "Name", "IdP", "FileName", "CanShu", "Remark","JiaoSeUserList","UserNameList"};
private String[] ListFields = {"Code", "Name",  "UserNameList"};
private String[] PrintFields = {"Code", "Name", "FileName",  "Remark"};
private String[] FormFields = {"Code", "Name", "FileName", "CanShu", "Remark"};
private String[] QueryFields = {""};
private User_Module getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    User_Module v = new User_Module();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update")) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramIdP(request, "IdP");
        v.paramFileName(request, "FileName");
        v.paramCanShu(request, "CanShu");
        v.paramRemark(request, "Remark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setFileName(ParamUtils.getParameter(request, "FileName", ""));
        v.setCanShu(ParamUtils.getParameter(request, "CanShu", ""));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, User_Module pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        User_Module v = (User_Module)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getIdP());
        row.add(Tool.jsSpecialChars(v.getFileName()));
        row.add(Tool.jsSpecialChars(v.getCanShu()));
        row.add(Tool.jsSpecialChars(v.getRemark()));
        row.add("");
        User_ModuleList module = new User_ModuleList();
         cdt = new ArrayList();
        cdt.add("moduleId="+v.getId());
        cdt.add("order by id ");
        List<User_ModuleList> users = module.query(cdt);
        List userRow = new ArrayList();
        for(int i=0;i<users.size();i++)
        {
          module = users.get(i);
           String bm = users.get(i).getDeptName();
          User ucuc = new User();
                ucuc = ucuc.getById(Integer.parseInt(module.getUserId()));
                if(ucuc!=null && ucuc.getCode().length()>0)
                {

                  userRow.add("("+bm+")"+ucuc.getName());
                }
        }

          row.add(""+Tool.join(" ",userRow));

        rows.add(row);
    }
    return rows;
}
private void setListData(javax.servlet.http.HttpServletRequest request, User_Module pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, User_Module pv, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    int shownum = ParamUtils.getIntParameter(request, "shownum", userInfo.getDispNum());
    String orderfield = ParamUtils.getParameter(request, "orderfield", "Id");
    String ordertype = ParamUtils.getParameter(request, "ordertype", "asc");
    List cdt = new ArrayList();
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qvali = ParamUtils.getIntParameter(request,"Classid",0);
    if(qvali>0)
    {
      cdt.add("(pid="+qvali+" or id="+ qvali +")");
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
    User_Module pv = new User_Module();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "User_Module");
    request.setAttribute("describe", "系统功能模块表");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    User_Module pv = new User_Module();
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
private void setForm(javax.servlet.http.HttpServletRequest request, User_Module form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "User_Module");
    request.setAttribute("describe", "系统功能模块表");
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(User_Module form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, User_Module form)
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
    User_Module form = getByParameterDb(request);
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

    if (cmd.equals("create"))
    {
       setForm(request, form);
        int pid = ParamUtils.getIntParameter(request,"Classid",0);
        String moduleType = ParamUtils.getParameter(request,"ModuleType","");
        form.setIdP(pid);
        form.setModuleType(moduleType);
        String RootKeyL1 = StrTool.DumStr("0",cu.getFirstLevelLen()-1);
       // Map deptmap = CEditConst.getKChengMap(userInfo);
        //request.setAttribute("PNAME",deptmap.get(""+pid));
        List cdt = new ArrayList();
        List aclist = new ArrayList();
        User_Module ac = new User_Module();
         if(pid>0) //有父
        {
          User_Module formP = form.getById(pid);

          if(formP!=null && formP.getId()>0)
          {
            //mysql length mssql len
            cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
            cdt.add("code like '"+ formP.getCode() +"%'");
            log.debug("length(code)="+(cu.getFirstLevelLen()*cu.getLevel(formP.getCode())));
            cdt.add("order by code desc");
            ac = new User_Module();
            aclist = ac.query(cdt);
            if(aclist==null || aclist.size()==0)
             form.setCode(formP.getCode()+RootKeyL1+"1");
            else
            {
              form.setCode(cu.getNextCode(((User_Module)aclist.get(0)).getCode(),cu.getLevel(((User_Module)aclist.get(0)).getCode())));
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
            form.setCode(cu.getNextCode(((User_Module)aclist.get(0)).getCode(),1));
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
        //删除该模块的所有赋权限

              User_ModuleList moduleList = new User_ModuleList();
               cdt = new ArrayList();
              cdt.add("moduleId in("+ idlist +")");
              moduleList.deleteByCondition(cdt);

        String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=UserModule&deptid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);

            request.setAttribute("msg", "系统模块 删除  成功!");
            return mkRtn("list", "failure", form);
    }
    if (cmd.equals("save"))
    {
            String JiaoSeUserList = ParamUtils.getParameter(request,"JiaoSeUserList","");
            String UserNameList = ParamUtils.getParameter(request,"UserNameList","");
            String ModuleType = ParamUtils.getParameter(request,"ModuleType","");
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "模块编码重复!");
            request.setAttribute("JiaoSeUserList",JiaoSeUserList);
             request.setAttribute("UserNameList",UserNameList);
            setForm(request, form);
            return mkRtn("save", "input", form);
        }
        else {
        	form.setModuleType(ModuleType);
            form.insert();
            /////////拥有该权限的用户
            String[] users = Tool.split(",",JiaoSeUserList);
            for(int i=0;i<users.length;i++)
            {
              User_ModuleList moduleList = new User_ModuleList();
              List cdt = new ArrayList();
              cdt.add("userid='"+users[i]+"'");
              cdt.add("moduleId="+form.getId());
              if(moduleList.getCount(cdt)==0)
              {
                moduleList.setModuleCode(form.getCode());
                moduleList.setModuleId(form.getId());
                moduleList.setModuleName(form.getName());
                moduleList.setUserId(users[i]);
                //用户
                User ucuc = new User();
                ucuc = ucuc.getById(Integer.parseInt(users[i] ));
                if(ucuc!=null &&  ucuc.getCode().length()>0)
                {
                  moduleList.setDeptId(""+ucuc.getOFFICEID());
                  //部门名称
                  Office office = new Office();
                  office = office.getById(ucuc.getOFFICEID());
                  if(office!=null && office.getCode().length()>0)
                  {
                    moduleList.setDeptName(office.getName());
                  }
                  moduleList.setUserName(ucuc.getName());

                }
                moduleList.insert();
              }
            }
            String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=UserModule&deptid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);

            request.setAttribute("msg", "系统模块 添加  成功!");
            return mkRtn("list", "failure", form);
        }
    }
    if (cmd.equals("update"))
    {
            String JiaoSeUserList = ParamUtils.getParameter(request,"JiaoSeUserList","");
            String UserNameList = ParamUtils.getParameter(request,"UserNameList","");

        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "模块编码重复，不能修改!");
            setForm(request, form);
               request.setAttribute("JiaoSeUserList",JiaoSeUserList);
             request.setAttribute("UserNameList",UserNameList);
            return mkRtn("update", "input", form);
        }
        else {
            ///原来的用户
              List cdt = new ArrayList();
              cdt.add("moduleId="+form.getId());
              User_ModuleList moduleList = new User_ModuleList();
              List<User_ModuleList> moduleLists = moduleList.query(cdt);
              List row = new ArrayList();
              for(int i=0;i<moduleLists.size();i++)
              {
                moduleList = moduleLists.get(i);
                row.add("'"+moduleList.getUserId()+"'");
              }
             // System.out.println("===="+form.toJsMap());
            form.update();
             /////////拥有该权限的用户
            String[] users = Tool.split(",",JiaoSeUserList);
            //1.找出此次删除的用户，删除其对此模块的权限
            List delUser = new ArrayList();
            for(int i=0;i<row.size();i++)
            {
              if(!Tool.inArray((String)row.get(i),users))
              {
                delUser.add(""+row.get(i));
              }
            }
            if(delUser.size()>0)
            {
               cdt.clear();
               cdt.add("moduleId="+form.getId());
               cdt.add("userid in("+Tool.join(",",delUser)+")");
                 moduleList = new User_ModuleList();
                 moduleList.deleteByCondition(cdt);
            }
            //2.找出此次增加的用户
            List addUser = new ArrayList();
            for(int i=0;i<users.length;i++)
            {
              if(!Tool.inList(users[i],row))
              {
                addUser.add(""+users[i]);
              }
            }

            for(int i=0;i<addUser.size();i++)
            {
               moduleList = new User_ModuleList();
               cdt = new ArrayList();
              cdt.add("userid='"+addUser.get(i)+"'");
              cdt.add("moduleId="+form.getId());

              if(moduleList.getCount(cdt)==0)
              {
                moduleList.setModuleCode(form.getCode());
                moduleList.setModuleId(form.getId());
                moduleList.setModuleName(form.getName());

                User ucuc = new User();
                ucuc = ucuc.getById(Integer.parseInt((String)addUser.get(i)) );
                if(ucuc!=null && ucuc.getCode().length()>0)
                {
                  moduleList.setDeptId(""+ucuc.getOFFICEID());
                  //部门名称
                  Office office = new Office();
                  office = office.getById(ucuc.getOFFICEID());
                  if(office!=null && office.getCode().length()>0)
                  {
                    moduleList.setDeptName(office.getName());
                  }
                  moduleList.setUserId(ucuc.getId()+"");
                  moduleList.setUserName(ucuc.getName());
                }
                moduleList.insert();
              }
            }
            String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=UserModule&deptid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);

            request.setAttribute("msg", "系统模块 修改  成功!");
            return mkRtn("list", "failure", form);
        }
    }
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("list", "failure", form);
}
%>
<%
response.setHeader("Cache-Control", "no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
log.debug("User_ModuleAction");
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
forwardMap.put("list", "User_ModuleAction.jsp");
forwardMap.put("failure", "User_ModuleForm.jsp");
forwardMap.put("success", "User_ModuleList.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}

forwardMap.put("input", "User_ModuleForm.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    String listStr =(String) request.getAttribute("listSrc");

    out.println("<script type=\"text/JavaScript\">window.location='User_ModuleAction.jsp?cmd=list&page=" + currpage +"&listStr="+listStr+ ((url.length() == 0) ? "" : "&" + url) + "';</script>");
}
else if(forwardKey.equals("login"))
{
      out.println("<script type=\"text/JavaScript\">alert('登陆已超时！');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
