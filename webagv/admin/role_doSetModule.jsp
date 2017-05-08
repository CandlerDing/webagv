<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
int userid = ParamUtils.getIntParameter(request,"userid",0);
String moduleids = ParamUtils.getParameter(request,"JiaoSeUserList","");
String[] mids = Tool.split(",",moduleids);
 User_ModuleList userModule = new User_ModuleList(); 
    List cdt = new ArrayList();
    cdt.add("userid="+userid);
    List<User_ModuleList> userModules = userModule.query(cdt);
    List row = new ArrayList();
    for(int i=0;i<userModules.size();i++)
    {
      userModule = userModules.get(i);
      row.add(""+userModule.getModuleId());
    }
    ///����Ҫɾ����Ȩ��
    List delRow = new ArrayList();
    for(int i=0;i<row.size();i++)
    {
      if(!Tool.inArray((String)row.get(i),mids))
      {
        delRow.add(""+row.get(i));
      }
    }

    List addRow = new ArrayList();
    ///����Ҫ���ӵ�Ȩ��
    for(int i=0;i<mids.length ;i++)
    {
      if(!Tool.inList(mids[i],row))
      {
        addRow.add(""+mids[i]);
      }
    }
   // System.out.println("===="+addRow.toString());
    ////ɾ��
    if(delRow.size()>0)
    {
      cdt.clear();
      cdt.add("userid="+userid);
      cdt.add("moduleId in("+ Tool.join(",",delRow )+")");
      userModule.deleteByCondition(cdt);
    }
    //����
    if(addRow.size()>0)
    {
      for(int i=0;i<addRow.size();i++)
      {
        cdt.clear();
        cdt.add("userid="+userid);
        cdt.add("moduleId="+addRow.get(i));

        userModule = new User_ModuleList();
        userModule.setUserId(""+userid);

        User ucuc = new User();
        ucuc = ucuc.getById(userid);
        if(ucuc!=null )
        {
          userModule.setUserName(ucuc.getName());
          Office office = new Office();
          office = office.getById(ucuc.getOFFICEID());
         if(office!=null )
         {
           userModule.setDeptId(""+office.getId());
           userModule.setDeptName(office.getName());

         }
        }


        userModule.setModuleId(Integer.parseInt((String)addRow.get(i)));
        User_Module module = new User_Module();
        module = module.getById(Integer.parseInt((String)addRow.get(i)));
       // System.out.print("----"+userModule.toJsMap());
        if(module!=null && module.getId()>0)
        {
          userModule.setModuleCode(module.getCode());
          userModule.setModuleName(module.getName());
          if(userModule.getCount(cdt)==0)
          {
            userModule.insert();
          }else
          {
            userModule.update();
          }
        }

      }
    }
%><script>alert("Ȩ�����óɹ���");</script>
