<%@ page language="java" %>
<%--角色表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%!
private static Log log = LogFactory.getLog(User_JiaoSe.class); 
private static final String[] allFormNames = {"cmd", "page", "idlist", "Id", "Code", "Name", "IdP", "Module", "Remark","JiaoSeUserList","ModuleNames","UserNameList"};
private String[] DicKeys = {"Id", "Code", "Name", "IdP", "Module", "Remark","JiaoSeUserList","ModuleNames","UserNameList"};
private String[][] DicValues = {{"int", "ID", "-1", "hidden", ""}, {"string", "角色编码", "50", "text", ""}, {"string", "角色名称", "50", "text", ""}, {"int", "父ID", "-1", "hidden", ""}, {"string", "对应模块列表", "300", "text", ""}, {"string", "备注", "255", "text", ""}, {"string", "备注", "255", "text", ""}, {"string", "备注", "255", "text", ""}, {"string", "拥有该角色的用户", "255", "text", ""}};
private String KeyField = "Id";
private String[] AllFields = {"Id", "Code", "Name", "IdP", "Module", "Remark","JiaoSeUserList","ModuleNames","UserNameList"};
private String[] ListFields = { "Name", "Module", "UserNameList"};
private String[] PrintFields = {"Code", "Name", "Module", "Remark"};
private String[] FormFields = {"Code", "Name", "Module", "Remark"};
private String[] QueryFields = {"Name"};
private User_JiaoSe getByParameterDb(javax.servlet.http.HttpServletRequest request)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    User_JiaoSe v = new User_JiaoSe();
    v.setId(ParamUtils.getIntParameter(request, "Id", -1));
    String cmd = ParamUtils.getParameter(request, "cmd", "list");
    if (cmd.equals("update")) {
        v = v.getById(v.getId());
        v.paramId(request, "Id");
        v.paramCode(request, "Code");
        v.paramName(request, "Name");
        v.paramIdP(request, "IdP");
        v.paramModule(request, "Module");
        v.paramRemark(request, "Remark");
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    else {
        v.setId(ParamUtils.getIntParameter(request, "Id", -1));
        v.setCode(ParamUtils.getParameter(request, "Code", ""));
        v.setName(ParamUtils.getParameter(request, "Name", ""));
        v.setIdP(ParamUtils.getIntParameter(request, "IdP", -1));
        v.setModule(ParamUtils.getParameter(request, "Module", ""));
        v.setRemark(ParamUtils.getParameter(request, "Remark", ""));
        //获取checkbox值用以下方式
        //v.setFlag(Tool.join(",",ParamUtils.getArrayParameter(request,"Flag")));
    }
    return v;
}
private List getListRows(javax.servlet.http.HttpServletRequest request, User_JiaoSe pv, List cdt)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    //查询符合条件的资料
    List vs = pv.query(cdt);
    List rows = new ArrayList();
    for (Iterator it = vs.iterator(); it.hasNext();) {
        User_JiaoSe v = (User_JiaoSe)it.next();
        List row = new ArrayList();
        row.add("" + v.getId());
        row.add(Tool.jsSpecialChars(v.getCode()));
        row.add(Tool.jsSpecialChars(v.getName()));
        row.add("" + v.getIdP());
        String[] module = Tool.split(",",v.getModule());
        List rowM = new ArrayList();
        if(module!=null && module.length>0)
        {
          for(int i=0;i<module.length;i++)
          {
            User_Module usermodule = new User_Module();
            usermodule = usermodule.getById(Integer.parseInt(module[i]));
            if(usermodule!=null && usermodule.getId()>0)
            {
              rowM.add(usermodule.getName());
            }
          }
        }
        row.add(Tool.jsSpecialChars(Tool.join(",",rowM)));
        row.add(Tool.jsSpecialChars(v.getRemark()));
        row.add("");
        row.add("");
        User_JiaoSeList jiaoseList = new User_JiaoSeList();
        cdt.clear();
        cdt.add("jiaoseid="+v.getId());
        List<User_JiaoSeList> jiaoseLists = jiaoseList.query(cdt);
        List userRow = new ArrayList();
        for(int i=0;i<jiaoseLists.size();i++)
        {
          String uid = jiaoseLists.get(i).getUserId();
          String bm = jiaoseLists.get(i).getDeptName();

           User ucuc = new User();
      ucuc = ucuc.getById(Integer.parseInt(uid));
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
private void setListData(javax.servlet.http.HttpServletRequest request, User_JiaoSe pv, List cdt)
{
    List rows = new ArrayList();
    for (Iterator it = getListRows(request, pv, cdt).iterator(); it.hasNext();) {
        List row = (List)it.next();
        rows.add("[\"" + Tool.join("\",\"", row) + "\"]");
    }
    request.setAttribute("List", rows);
}
private List getListCondition(javax.servlet.http.HttpServletRequest request, User_JiaoSe pv, boolean isAll)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    int shownum = ParamUtils.getIntParameter(request, "shownum", userInfo.getDispNum());
    String orderfield = ParamUtils.getParameter(request, "orderfield", "Id");
    String ordertype = ParamUtils.getParameter(request, "ordertype", "desc");
    List cdt = new ArrayList();
    String qval = "";
    int qvali = -1;
    List QueryValues = new ArrayList();
    qvali = ParamUtils.getIntParameter(request,"Classid",0);
    if(qvali>0)
    {
      cdt.add("(pid="+qvali+" or id="+ qvali +")");
    }
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
    User_JiaoSe pv = new User_JiaoSe();
    setListData(request, pv, getListCondition(request, pv, isAll));
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", ListFields);
    request.setAttribute("classname", "User_JiaoSe");
    request.setAttribute("describe", "角色表");
}
private void writeExcel(HttpServletRequest request, String filename) {
    UserInfo userInfo = Tool.getUserInfo(request);
    User_JiaoSe pv = new User_JiaoSe();
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
private void setForm(javax.servlet.http.HttpServletRequest request, User_JiaoSe form)
{
    UserInfo userInfo = Tool.getUserInfo(request);
    //默认值定义
    request.setAttribute("dickeys", DicKeys);
    request.setAttribute("dicvalues", DicValues);
    request.setAttribute("keyfield", KeyField);
    request.setAttribute("allfields", AllFields);
    request.setAttribute("fields", FormFields);
    request.setAttribute("classname", "User_JiaoSe");
    request.setAttribute("describe", "角色表");
}
/*
 * 校验提交保存数据的重复性问题
 * 如果有重复数据，返回true, 否则返回false
 */
private boolean isDuplicated(User_JiaoSe form, String cmd)
{
    List cdt = new ArrayList();
    cdt.add("code='" + form.getCode() + "'");
    if(cmd.equals("update")) {
        cdt.add("id<>" + form.getId());
    }
    return (form.getCount(cdt) > 0);
}
private List mkRtn(String cmd, String forward, User_JiaoSe form)
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
    User_JiaoSe form = getByParameterDb(request);

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
    if (cmd.equals("excel"))
    {
        String filename = HeadConst.root_file_path + "/upload/temp/" + userInfo.getName() + ".xls";
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
        User_JiaoSe ac = new User_JiaoSe();
         if(pid>0) //有父
        {
          User_JiaoSe formP = form.getById(pid);

          if(formP!=null && formP.getId()>0)
          {
            //mysql length mssql len
            cdt.add("length(code)="+(cu.getFirstLevelLen()*(cu.getLevel(formP.getCode())+1)));
            cdt.add("code like '"+ formP.getCode() +"%'");
            log.debug("length(code)="+(cu.getFirstLevelLen()*cu.getLevel(formP.getCode())));
            cdt.add("order by code desc");
            ac = new User_JiaoSe();
            aclist = ac.query(cdt);
            if(aclist==null || aclist.size()==0)
             form.setCode(formP.getCode()+RootKeyL1+"1");
            else
            {
              form.setCode(cu.getNextCode(((User_JiaoSe)aclist.get(0)).getCode(),cu.getLevel(((User_JiaoSe)aclist.get(0)).getCode())));
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
            form.setCode(cu.getNextCode(((User_JiaoSe)aclist.get(0)).getCode(),1));
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
        List row = new ArrayList();
        Map moduleMap = new HashMap();
        List<User_JiaoSe> forms = form.query(cdt);
        for(int i=0;i<forms.size();i++)
        {
          User_JiaoSe jiaose = forms.get(i);
          String module = jiaose.getModule();
          String[] modules = module.split(",");
          for(int j=0;j<modules.length;j++)
          {
            if(moduleMap.get(""+modules[j])==null)
            {
              moduleMap.put(""+modules[j],""+modules[j]);
              row.add(""+modules[j]);//需要删除的权限
            }
          }
        }
        form.deleteByCondition(cdt);

         //删除该角色的所有用户
              User_JiaoSeList moduleList = new User_JiaoSeList();
               cdt = new ArrayList();
              cdt.add("jiaoseid in("+ idlist +")");
              List<User_JiaoSeList> moduleLists = moduleList.query(cdt);
              List user = new ArrayList();
              for(int i=0;i<moduleLists.size();i++)
              {
                user.add("'"+moduleLists.get(i).getUserId()+"'");
              }
              moduleList.deleteByCondition(cdt);
              //删除该用户，该角色的权限
              if(row.size()>0 && user.size()>0)
              {
                cdt.clear();
                cdt.add("moduleId in("+ Tool.join(",",row) +")");
                cdt.add("userid in("+ Tool.join(",",user) +")");
                User_ModuleList userModule = new User_ModuleList();
                userModule.deleteByCondition(cdt);
              }
         String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=JiaoSe&Classid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);
        return mkRtn("list", "list", form);
    }
    if (cmd.equals("save"))
    {
      String JiaoSeUserList = ParamUtils.getParameter(request,"JiaoSeUserList","");
      String UserNameList = ParamUtils.getParameter(request,"UserNameList","");
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "角色编码重复!");
            request.setAttribute("JiaoSeUserList",JiaoSeUserList);
            request.setAttribute("UserNameList",UserNameList);
            setForm(request, form);
            return mkRtn("save", "input", form);
        }
        else {
            form.insert();
            String[] jiaoseuser = Tool.split(",",JiaoSeUserList);
            String[] module = Tool.split(",",form.getModule());

            List cdt = new ArrayList();
            for(int i=0;i<jiaoseuser.length;i++)   //所有的该角色用户
            {
              String uid = jiaoseuser[i];
              //写入角色人员表
              User_JiaoSeList user_jiaose = new User_JiaoSeList();
              cdt.clear();
               cdt.add("jiaoseid="+form.getId());
               cdt.add("userid='"+uid+"'");
               if(user_jiaose.getCount(cdt)==0)
               {
                 user_jiaose.setJiaoSeId(form.getId());
                 user_jiaose.setJiaoSeName(form.getName());
                 user_jiaose.setUserId(""+uid);
//用户
                User ucuc = new User();
                ucuc = ucuc.getById(Integer.parseInt(uid) );
                if(ucuc!=null &&  ucuc.getCode().length()>0)
                {
                  user_jiaose.setDeptId(""+ucuc.getOFFICEID());
                  //部门名称
                  Office office = new Office();
                  office = office.getById(ucuc.getOFFICEID());
                  if(office!=null && office.getCode().length()>0)
                  {
                    user_jiaose.setDeptName(office.getName());
                  }
                  user_jiaose.setUserName(ucuc.getName());
                }
                 user_jiaose.insert();
               }


              ////////给该用户赋于权限
              for(int j=0;j<module.length;j++)
              {
                User_Module usermodule = new User_Module();

                int mid = Integer.parseInt(module[j]);
                usermodule = usermodule.getById(mid);
                if(usermodule!=null && usermodule.getId()>0)
                {
                  User_ModuleList moduleList = new User_ModuleList();
                  moduleList.setModuleId(mid);
                  moduleList.setModuleCode(usermodule.getCode());
                  moduleList.setModuleName(usermodule.getName());
                  moduleList.setUserId(""+uid);
                  //用户
                User ucuc = new User();
                ucuc = ucuc.getById(Integer.parseInt(uid)); 

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
                   cdt = new ArrayList();
                  cdt.add("ModuleId="+mid);
                  cdt.add("userid='"+uid+"'");
                  if(moduleList.getCount(cdt)==0)
                  {
                    moduleList.insert();
                  }else
                  {
                    moduleList.update();
                  }
                }
              }
            }
            String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=JiaoSe&Classid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);
            return mkRtn("list", "list", form);
        }
    }
    if (cmd.equals("update"))
    {
      String JiaoSeUserList = ParamUtils.getParameter(request,"JiaoSeUserList","");
      String UserNameList = ParamUtils.getParameter(request,"UserNameList","");
        if (isDuplicated(form, cmd)) {
            request.setAttribute("back_msg", "角色编码重复!");
            setForm(request, form);
             request.setAttribute("JiaoSeUserList",JiaoSeUserList);
            request.setAttribute("UserNameList",UserNameList);
            return mkRtn("update", "input", form);
        }
        else {
            ///原来的权限
            User_JiaoSe oldJiaoSe = new User_JiaoSe();
            oldJiaoSe = oldJiaoSe.getById(form.getId());
            String oldModule = oldJiaoSe.getModule();
            String[] oldModules = Tool.split(",",oldModule);

            /////找出原来该角色下的的用户，本次修改需要去掉的
            User_JiaoSeList olduser = new User_JiaoSeList();
            List cdt = new ArrayList() ;
            List row = new ArrayList();
            cdt.add("JiaoSeId="+form.getId());
            List<User_JiaoSeList> oldUsers = olduser.query(cdt);
            for(int i=0;i<oldUsers.size();i++)
            {
              olduser = oldUsers.get(i);
              row.add("'"+olduser.getUserId()+"'");
            }
            ///找出本次减少的用户


            form.update();
            String[] jiaoseuser = Tool.split(",",JiaoSeUserList);
            String[] module = Tool.split(",",form.getModule());
            //将删除的用户在角色表里去掉
            List delUserList = new ArrayList();
            for(int i=0;i<row.size();i++)
            {
              String oldUid =(String) row.get(i);
              if(!Tool.inArray(oldUid,jiaoseuser))
              {
                delUserList.add(""+oldUid);
              }
           }

            if(delUserList.size()>0)
            { //1.先删除这些用户，该角色的模块权限
              User_ModuleList moduleList = new User_ModuleList();
              for(int i=0;i<oldModules.length;i++)
              {
                cdt.clear();
                cdt.add("moduleId="+oldModules[i]);
                cdt.add("userid in ("+  Tool.join(",",delUserList)+")");
                moduleList.deleteByCondition(cdt);
              }
              //2.再删除这些用户，在角色表的记录
              cdt.clear();
              cdt.add("jiaoseid="+form.getId());
              cdt.add("userid in ("+  Tool.join(",",delUserList)+")");
              User_JiaoSeList user_jiaose = new User_JiaoSeList();
              user_jiaose.deleteByCondition(cdt);
            }
             /////////找出权限的变化，需要删除的权限
            List delModule = new ArrayList();
            for(int i=0;i<oldModules.length;i++)
            {
               String oldMid = oldModules[i];
              if(!Tool.inArray(oldMid,module))
              {
                delModule.add(oldMid);
              }
            }
            //删除 有该角色的用户的 权限
            if(delModule.size()>0)
            {
              if(row.size()>0)
              {
                cdt.clear();
                cdt.add("moduleId in ("+ Tool.join(",",delModule) +")");
                cdt.add("userid in ("+  Tool.join(",",row)+")");
                User_ModuleList moduleList = new User_ModuleList();
                moduleList.deleteByCondition(cdt);
              }
            }
            ////////////
            for(int i=0;i<jiaoseuser.length;i++)   //所有的用户
            {
              String uid = jiaoseuser[i];
              //写入角色人员表
              User_JiaoSeList user_jiaose = new User_JiaoSeList();
              cdt.clear();
               cdt.add("jiaoseid="+form.getId());
               cdt.add("userid='"+uid+"'");
                 user_jiaose.setJiaoSeId(form.getId());
                 user_jiaose.setJiaoSeName(form.getName());
                 user_jiaose.setUserId(""+uid);
  //用户
                User ucuc =new User();
                ucuc = ucuc.getById(Integer.parseInt(uid));

                if(ucuc!=null &&  ucuc.getCode().length()>0)
                {
                  user_jiaose.setDeptId(""+ucuc.getOFFICEID());
                  //部门名称
                  Office office = new Office();
                  office = office.getById(ucuc.getOFFICEID());
                  if(office!=null && office.getCode().length()>0)
                  {
                    user_jiaose.setDeptName(office.getName());
                  }
                  user_jiaose.setUserName(ucuc.getName());
                }
                 if(user_jiaose.getCount(cdt)==0)
               {
                 user_jiaose.insert();
               }else
               {
                 user_jiaose.update();
               }
              ////////给该用户赋于权限
              for(int j=0;j<module.length;j++)
              {
                User_Module usermodule = new User_Module();
                int mid = Integer.parseInt(module[j]);
                usermodule = usermodule.getById(mid);
                if(usermodule!=null && usermodule.getId()>0)
                {
                  User_ModuleList moduleList = new User_ModuleList();
                  moduleList.setModuleId(mid);
                  moduleList.setModuleCode(usermodule.getCode());
                  moduleList.setModuleName(usermodule.getName());
                  moduleList.setUserId(""+uid);
                   //用户
                 ucuc = new User();
                            
                ucuc = ucuc.getById(Integer.parseInt(uid) );

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
                   cdt = new ArrayList();
                  cdt.add("ModuleId="+mid);
                  cdt.add("userid='"+uid+"'");
                  if(moduleList.getCount(cdt)==0)
                  {
                    moduleList.insert();
                  }else
                  {
                    moduleList.update();
                  }
                }
              }
            }
            String listSrc = request.getContextPath()+"/admin/role_list.jsp?cmd=JiaoSe&Classid="+(form.getIdP()==0?form.getId():form.getIdP());
            request.setAttribute("listSrc",listSrc);
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
log.debug("User_JiaoSeAction");
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
forwardMap.put("list", "User_JiaoSeAction.jsp");
forwardMap.put("failure", "User_JiaoSeForm.jsp");
forwardMap.put("success", "User_JiaoSeList.jsp");
if(userInfo!=null)
{
    String fname = "/upload/temp/" + userInfo.getName() + "_export.xls";
    forwardMap.put("excel", fname);
    if(forwardKey.equals("excel"))
    {
        response.addHeader("Content-Disposition", "attachment; filename="+ new String("export.xls".getBytes("GBK"),"ISO-8859-1") + "");
    }
}
forwardMap.put("input", "User_JiaoSeForm.jsp");
HttpTool.saveParameters(request, "Ext", allFormNames);
log.debug("cmd=" + cmd + ", forward=" + forwardKey);
if (forwardKey.equals("list")) {
    List paras = HttpTool.getSavedUrlForm(request, "Ext");
    List urls = (List)paras.get(0);
    urls.addAll((List)paras.get(2));
    String url = Tool.join("&", urls);
    String listSrc =(String) request.getAttribute("listSrc");
    out.println("<script type=\"text/JavaScript\">window.location='User_JiaoSeAction.jsp?cmd=list&page=" + currpage +"&listSrc="+listSrc+ ((url.length() == 0) ? "" : "&" + url) + "';</script>");
}
else if(forwardKey.equals("login"))
{
      out.println("<script type=\"text/JavaScript\">alert('登陆已超时！');top.location.href='"+ request.getContextPath() +"/logon';</script>");
}
else
  pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&page=" + currpage);
%>
