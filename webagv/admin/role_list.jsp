<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(Tool.class);
private UserInfo userInfo = null;
private static final String[] allFormNames = {};
private static String Name=""; 
private static String Id="";
private static String Code="";


private void setAreaCodeTree(javax.servlet.http.HttpServletRequest request)
{
    AreaCode v = new AreaCode();

    List cdt = new ArrayList();
    CodeUtils cu = new CodeUtils();
    cdt.add("length(code)="+cu.getFirstLevelLen());
    cdt.add("order by code desc");
    AreaCode ac = new AreaCode();
    List aclist = ac.query(cdt);
    if(aclist==null)
    {
        Id = "0";
        Name = "";
        Code = "000";
    }
    else
    {
        Id = ""+((AreaCode)aclist.get(0)).getId();
        Name = ((AreaCode)aclist.get(0)).getName();
        Code = ((AreaCode)aclist.get(0)).getCode();
    }
    cdt = new ArrayList();
    cdt.add("limit 0, 300");
    cdt.add("order by id");
    Map imap = v.initParentMap(cdt);
    String treeRootKey = v.findRootKey(imap);
    //找出一级代码的最高级

    String treeStr = "var tree = new WebFXTree(\"ROOT:区划编码\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'null',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
    log.debug("rootkey=" + treeRootKey);
    List tree = new ArrayList();
    if (imap.get(treeRootKey) == null) {
        treeStr = "var tree = new WebFXTree(\"ROOT:区划编码\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'null',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
    }
    StringBuffer strTree = new StringBuffer();
    for (Iterator it = ((List)imap.get(treeRootKey)).iterator(); it.hasNext();) {
        AreaCode pv = (AreaCode)it.next();
        TreeItem ti = v.initTree(pv, imap);
        //strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
        strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1));
    }

    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setAreaCode(javax.servlet.http.HttpServletRequest request)
{
    AreaCode v = new AreaCode();

    List cdt = new ArrayList();
    CodeUtils cu = new CodeUtils();
    String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());

    cdt.add("length(code)="+cu.getFirstLevelLen());
    cdt.add("order by code desc");
    AreaCode ac = new AreaCode();
    List aclist = ac.query(cdt);
    if(aclist==null || aclist.size()==0)
    {
        Id = "0";
        Name = "";
        Code = RootKey;
    }
    else
    {
        Id = ""+((AreaCode)aclist.get(0)).getId();
        Name = ((AreaCode)aclist.get(0)).getName();
        Code = ((AreaCode)aclist.get(0)).getCode();
    }
    cdt = new ArrayList();
    cdt.add("limit 0, 9999");
    cdt.add("order by id");
    Map imap = v.initParentMap(cdt);
    String treeRootKey = v.findRootKey(imap);
    //找出一级代码的最高级 dics '51201':'31~*~上解支出﹨一般预算上解支出'
    // list ['512_上解支出', '512',0,'0']

    String treeStr = "";
    log.debug("rootkey=" + treeRootKey);
    List tree = new ArrayList();
    if (imap.get(treeRootKey) == null) {
        treeStr = "[]";
    }
    else
    {
        StringBuffer strTree = new StringBuffer();
        List a = new ArrayList();
        List treeList = new ArrayList() ;
        for (Iterator it = ((List)imap.get(treeRootKey)).iterator(); it.hasNext();) {
            AreaCode pv = (AreaCode)it.next();
            TreeItem ti = v.initTree(pv, imap);
            //strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
            a.addAll(HtmlTool.getCheckBoxTreeStr(ti,"tree",1));
            treeList.addAll(HtmlTool.getCheckBoxTreeListStr(ti,"tree",0));

        }
        request.setAttribute("DicList", a);
        request.setAttribute("treeList", treeList);
        request.setAttribute("tree", treeStr);
        request.setAttribute("strTree", strTree.toString());
    }
}

private void setDegree1CodeTree(javax.servlet.http.HttpServletRequest request)
{
    Degree1Code v = new Degree1Code();
    List cdt = new ArrayList();
    cdt.add("order by code");
    Map<String, List<Degree1Code>> imap = v.initParentMap(cdt);
    StringBuffer strTree = new StringBuffer();
    String tree = "var tree = new WebFXTree(\"学历编码\", \"javascript:void(0);\", \"[]\",0, 0);";
    if (imap.get("0") != null) {
        Degree1Code init = (Degree1Code)imap.get("0").get(0);
        Id = String.valueOf(init.getId());
        Name = init.getName();
        for (Degree1Code pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
            strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "go", 1, true));
        }
    } else {
        tree = "var tree = new WebFXTree(\"学历编码\", \"javascript:parent.addNew();\", \"[]\",0, 0);";
    }
    request.setAttribute("tree", tree);
    request.setAttribute("strTree", strTree.toString());
}

private void setSpecialCodeTree(javax.servlet.http.HttpServletRequest request)
{
    SpecialCode v = new SpecialCode();
    List cdt = new ArrayList();
    cdt.add("enabled=1");
    cdt.add("order by code");

    Map<String, List<SpecialCode>> imap = v.initParentMap(cdt);
    StringBuffer strTree = new StringBuffer();
    String tree = "var tree = new WebFXTree(\"专业目录\", \"javascript:void(0);\", \"[]\",0, 0);";
    if (imap.get("0") != null) {
        SpecialCode init = (SpecialCode)imap.get("0").get(0);
        Id = String.valueOf(init.getId());
        Name = init.getName();
        for (SpecialCode pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
            strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "go", 1, true));
        }
    } else {
        tree = "var tree = new WebFXTree(\"专业目录\", \"javascript:parent.addNew();\", \"[]\",0, 0);";
    }
    request.setAttribute("tree", tree);
    request.setAttribute("strTree", strTree.toString());
}
///权限管理
private void setUserModuleTree(javax.servlet.http.HttpServletRequest request)
{

  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                User_Module v = new User_Module();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by id");
		CDataCenterOffice cco = new CDataCenterOffice();		
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"系统功能模块\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"系统功能模块\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    User_Module pv = (User_Module)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
		}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}

///角色管理
private void setJiaoSeTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                User_JiaoSe v = new User_JiaoSe();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by Id");
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"系统角色管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"系统角色管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    User_JiaoSe pv = (User_JiaoSe)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
		}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setCarCodeTree(javax.servlet.http.HttpServletRequest request)
{

	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	                Car v = new Car();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			cdt.add("order by id");
			CDataCenterOffice cco = new CDataCenterOffice();		
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"车辆管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"车辆管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			    Car pv = (Car)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setTaskCodeTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	                Task v = new Task();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			cdt.add("order by id");
			CDataCenterOffice cco = new CDataCenterOffice();		
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"任务管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"任务管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			    Task pv = (Task)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setRfidCodeTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	                Rfid v = new Rfid();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			cdt.add("order by id");
			CDataCenterOffice cco = new CDataCenterOffice();		
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"RFID站点\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"RFID站点\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			    Rfid pv = (Rfid)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setGoodsTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	   Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	   String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	   Goods v = new Goods();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			
			cdt.add("order by id");
				
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"货品管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"货品管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Goods pv = (Goods)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setAddressTree(javax.servlet.http.HttpServletRequest request,int pid)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	   Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	   String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	   Address v = new Address();
			List cdt = new ArrayList();
			cdt.add("pid="+pid);
			
			cdt.add("order by id");
				
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"存放地址\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"存放地址\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Address pv = (Address)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setCjTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	   Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	   String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	   Workshop v = new Workshop();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			
			cdt.add("order by id");
				
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"车间管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"车间管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Workshop pv = (Workshop)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setOpeorderTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	   Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	   String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	   Opeorder v = new Opeorder();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			
			cdt.add("order by id");
				
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"操作指令\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"操作指令\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Opeorder pv = (Opeorder)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setControlcarTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	   Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	   String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	   Controltype v = new Controltype();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			
			cdt.add("order by id");
				
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"车辆控制参数\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"车辆控制参数\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Controltype pv = (Controltype)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}
private void setArticleTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                Channel v = new Channel();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by id");
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    Channel pv = (Channel)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
		}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}


private void setArticleCheckBoxTree(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                Channel v = new Channel();
		List cdt = new ArrayList();
		//cdt.add("limit 0, 300");
		cdt.add("order by id");
		Map imap = v.initParentMap(cdt);
		String treeRootKey = v.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"网站栏目\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else{
                  int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
		    Channel pv = (Channel)it.next();
                    if(j==0)
                    {
                      Id = String.valueOf(pv.getId());
                      Name = pv.getName();
                    }
                    j++;
                      TreeItem ti = v.initTree(pv, imap);
                      List getTree = CTreeItem.getTreeListASC(ti);
                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
                          ti.setOpened(1);
//                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
strTree.append(TreeTool.getCheckBoxTree(ti,"",1,"",""));
//                      strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1));
                    }
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}


 public Map initDeptParentMap(List cdt) {
   Office dc = new Office();
        List vs = dc.query(cdt);
        Map code2idmap = new HashMap();
        for (Iterator it = vs.iterator(); it.hasNext(); ) {
        	Office v = (Office)it.next();
            String code = v.getCode();
            code2idmap.put(code, "" + v.getId());
        }
        CodeUtils codeutils = new CodeUtils(HeadConst.splitType);
        Map map = new HashMap();
        for (Iterator it = vs.iterator(); it.hasNext(); ) {
        	Office v = (Office)it.next();
            String pid = "0";

            if (pid == null) {
                pid = "0";
            }
            List child = (List)map.get(pid);
            if (child == null) {
                child = new ArrayList();
            }
            child.add(v);
            map.put(pid, child);
        }
        return map;
    }

//显示部门、用户的treebox ti是部门的tree
 public static String getDataCenterOfficeTree(TreeItem ti, String treeName, String parent, int level, String checkedIds) {

StringBuffer rtn = new StringBuffer();

String currlvl = "lvl" + level;
//部门都是不显示checkbox

rtn.append(parent + ".add(" + currlvl + " = new WebFXTreeItem('" + ti.getName() + "'));\n");

return rtn.toString();
}
 
 
 //显示部门、用户的treebox ti是部门的tree
       public static String getQuanXianTree(TreeItem ti, String treeName, String parent, int level, String checkedIds) {

      StringBuffer rtn = new StringBuffer();

      String currlvl = "lvl" + level;
      //部门都是不显示checkbox

      rtn.append(parent + ".add(" + currlvl + " = new WebFXTreeItem('" + ti.getName() + "'));\n");

      List cdt = new ArrayList();
      String deptCode = ti.getCode();
      Office dc = new Office();
      cdt.add("code like '%"+ deptCode +"'");//部门Code ，找到ID
      List<Office> dcs = dc.query(cdt);
      if(dcs!=null && dcs.size()>0)
      {
        dc = dcs.get(0);
      }

      User ucuc = new User();
      cdt.clear();
      cdt.add("OFFICEID="+ dc.getId() +"");
      cdt.add("order by ordernum*1");
      List<User> ucucs = ucuc.query(cdt);
      for(int i=0;i<ucucs.size();i++)
      {
        ucuc = ucucs.get(i);
        int checked = 0;
        if(StrTool.inList(checkedIds, "" + ucuc.getCode(), ","))
        {
          checked = 1;
        }
         StringBuffer str = new StringBuffer();
        str.append("[{type:'user',");
        str.append("id:'" + ucuc.getCode() + "',");
        str.append("pid:'0',");
        str.append("code:'" + ucuc.getLOGID() + "',");
        str.append("pcode:'',");
        str.append("name:'" + ucuc.getName() + "',");
        str.append("url:'',");
        str.append("checked:'" + checked + "'}]");


//        rtn.append(currlvl+".add(lvl" + (level + 1) + " = new WebFXTreeItem('"+ ucuc.getCnName() + "' ,\"javascript:treeClick(tree.getSelected());\", \"" + str + "\", 1 , " + checked + "));\n");
        rtn.append(currlvl+".add(lvl" + (level + 1) + " = new WebFXTreeItem('"+ ucuc.getName() + "' ,\"javascript:treeClick(tree.getSelected());\", \"" + str + "\", 0));\n");
      }
      Collection sublist = ti.values();
      Iterator it = sublist.iterator();
      while (it.hasNext()) {
          TreeItem pt = (TreeItem)(it.next());
          rtn.append(getQuanXianTree(pt, treeName, currlvl, level + 1, checkedIds));
      }
      return rtn.toString();
  }
private void makeQuanXianUserTree(javax.servlet.http.HttpServletRequest request,String checkIds)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = checkIds;
    StringBuffer strTree = new StringBuffer();
    Office v = new Office();
    List cdt = new ArrayList();
    cdt.add("order by ordernum*1");
   // CDataCenterOffice cco = new CDataCenterOffice();
    Map<String, List<Office>> imap = initDeptParentMap(cdt);
    if (imap.get("0") != null) {
        for (Office pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);
             strTree.append(getQuanXianTree(ti, "tree", "tree", 1, checked_ids));
            }
        }
    String treeStr = "var tree = new WebFXTree(\"系统人员\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
    request.setAttribute("Tree", strTree.toString());
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}

private void makeUserBaseInfoTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	  Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	  String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	  Office v = new Office();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			cdt.add("order by Id");
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"用户管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"用户管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Office pv = (Office)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
	    request.setAttribute("tree", treeStr);
	    request.setAttribute("strTree", strTree.toString());
}
private void makeOfficeInfoTree(javax.servlet.http.HttpServletRequest request)
{
	 CodeUtils cu = new CodeUtils();
	  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
	  Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
	  String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
	  Office v = new Office();
			List cdt = new ArrayList();
			//cdt.add("limit 0, 300");
			cdt.add("order by Id");
			Map imap = v.initParentMap(cdt);
			String treeRootKey = v.findRootKey(imap);
			String treeStr = "var tree = new WebFXTree(\"部门管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			List tree = new ArrayList();
			StringBuffer strTree = new StringBuffer();
			if (imap.get(treeRootKey) == null) {
			    treeStr = "var tree = new WebFXTree(\"部门管理\", \"javascript:tree0Click();\", \"[{type:'DeptCode',id:'0',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
			}else{
	                  int j = 0 ;
			for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
				Office pv = (Office)it.next();
	                    if(j==0)
	                    {
	                      Id = String.valueOf(pv.getId());
	                      Name = pv.getName();
	                    }
	                    j++;
	                      TreeItem ti = v.initTree(pv, imap);
	                      List getTree = CTreeItem.getTreeListASC(ti);
	                      if(Tool.inList(ParamUtils.getParameter(request,"deptid",""),getTree))
	                          ti.setOpened(1);
	                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
			}
			}
	    request.setAttribute("tree", treeStr);
	    request.setAttribute("strTree", strTree.toString());
}
private void setDictCode(javax.servlet.http.HttpServletRequest request)
{
  CodeUtils cu = new CodeUtils();
  //String deptid=ParamUtils.getParameter(request,"deptid","0001");
  String RootKey = StrTool.DumStr("0",cu.getFirstLevelLen());
                Map yesno = CEditConst.getYesNoMap(Tool.getUserInfo(request));
                String yes =(String) Tool.getMapKeyFromValue(yesno,"是");
                DictCode um=new DictCode();
		List cdt = new ArrayList();
       
		cdt.add("order by id");
		Map imap = um.initParentMap(cdt);
		String treeRootKey = um.findRootKey(imap);
		String treeStr = "var tree = new WebFXTree(\"参数管理\", \"javascript:tree0Click();\", \"[{type:'DictCode',id:'-1',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		List tree = new ArrayList();
		StringBuffer strTree = new StringBuffer();
		if (imap.get(treeRootKey) == null) {
		    treeStr = "var tree = new WebFXTree(\"参数管理\", \"javascript:tree0Click();\", \"[{type:'DictCode',id:'-1',pid:'0',code:'"+RootKey+"',pcode:'',name:'null',url:'',checked:'0'}]\",0, 0);";
		}else
			{
			 int j = 0 ;
		for (Iterator it = ((List)imap.get("0")).iterator(); it.hasNext();) {
			DictCode pv = (DictCode)it.next();
			 if(j==0)
             {
               Id = String.valueOf(pv.getId());
               Code = pv.getCode();
               Name = pv.getName();
             }
             j++;
                      TreeItem ti = um.initTree(pv, imap);
                      strTree.append(HtmlTool.getTreeCodeView(ti, "tree", "tree", "treeClick", 1, true));
	}
		}
    request.setAttribute("tree", treeStr);
    request.setAttribute("strTree", strTree.toString());
}

private List mkRtn(String cmd, String forward)
{
    List rtn = new ArrayList();
    rtn.add(cmd);
    rtn.add(forward);
    return rtn;
}
public List main(javax.servlet.http.HttpServletRequest request)
{
    String cmd = ParamUtils.getParameter(request,"cmd","DeptCode");
    log.debug("cmd=" + cmd);

   
    
    if (cmd.equals("AreaCode")) {
        setAreaCode(request);
        return mkRtn(cmd, cmd);
    }

  if ( cmd.equals("ArticleCode") || cmd.equals("ArticleCodeModi") || cmd.equals("ChannelCode")) {
        setArticleTree(request);
        return mkRtn(cmd, cmd);
    }
    if ( cmd.equals("ChannelSelect")) {
      Id="0";
      setArticleCheckBoxTree(request);
       return mkRtn(cmd, cmd);
    }

     if(cmd.equals("UserModule"))
    {
      Id="0";
      /////
      this.setUserModuleTree(request);
       return mkRtn(cmd, cmd);
    }
     if(cmd.equals("CarCode"))
     {
       Id="0";
       /////
       this.setCarCodeTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("TaskCode"))
     {
       Id="0";
       /////
       this.setTaskCodeTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("RfidCode"))
     {
       Id="0";
       /////
       this.setRfidCodeTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("GoodsTree"))
     {
       Id="0";
       /////
       this.setGoodsTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("AddressTree"))
     {
       Id="0";
       int pid = ParamUtils.getIntParameter(request,"pid",0);
       
       this.setAddressTree(request,pid);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("CjTree"))
     {
       Id="0";
       /////
       this.setCjTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("Opeorder"))
     {
       Id="0";
       /////
       this.setOpeorderTree(request);
        return mkRtn(cmd, cmd);
     }
     if(cmd.equals("Controlcar"))
     {
       Id="0";
       /////
       this.setControlcarTree(request);
        return mkRtn(cmd, cmd);
     }
      if(cmd.equals("JiaoSe"))
    {
      /////
      Id="0";
      this.setJiaoSeTree(request);
       return mkRtn(cmd, cmd);
    }
      if(cmd.equals("QuanXian"))
    {
      /////
      Id="0";
      this.makeQuanXianUserTree(request,"");
       return mkRtn(cmd, cmd);
    }
      if(cmd.equals("OfficeInfo"))
      {
    	  makeOfficeInfoTree(request);
    	  return mkRtn(cmd, cmd);
    	  
      }
      if(cmd.equals("userBaseInfo"))
      {
    	  makeUserBaseInfoTree(request);
    	  return mkRtn(cmd, cmd);
    	  
      }
      if (cmd.equals("DictCode")) {
          setDictCode(request);
          return mkRtn(cmd, cmd);
      }
      
    request.setAttribute("msg", "未规定的cmd:" + cmd);
    return mkRtn("", "failure");
}
%>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
log.debug("list.jsp");
List rtn = null;
synchronized(this) {
    userInfo = Tool.getUserInfo(request);
    if (userInfo==null) {
        rtn = mkRtn("login", "login");
    }
    else {
        rtn = main(request);
    }
}
String cmd = (String)rtn.get(0);
String forwardKey = (String)rtn.get(1);
Map forwardMap = new HashMap();
Random randow = new Random(100);
int  rd = Math.abs(randow.nextInt());
forwardMap.put("login", "/logon");
forwardMap.put("failure", "role_Tree.jsp");
forwardMap.put("DeptCode", "role_Tree.jsp");
forwardMap.put("AreaCode", "TreeBox.jsp");
forwardMap.put("DeptUserCode", "role_Tree.jsp");
forwardMap.put("DeptUser", "role_Tree.jsp");
forwardMap.put("ArticleCode", "TreeNode.jsp");
forwardMap.put("ChannelCode", "role_Tree.jsp");
///角色
forwardMap.put("JiaoSe", "role_Tree.jsp");
///////////功能模块
forwardMap.put("UserModule","role_Tree.jsp");
///权限
forwardMap.put("QuanXian","role_Tree.jsp");
//部门信息
forwardMap.put("OfficeInfo","role_Tree.jsp");
//userBaseInfo
forwardMap.put("userBaseInfo","role_Tree.jsp");
forwardMap.put("CarCode","role_Tree.jsp");
forwardMap.put("TaskCode","role_Tree.jsp");
forwardMap.put("RfidCode", "role_Tree.jsp");
forwardMap.put("GoodsTree", "role_Tree.jsp");
forwardMap.put("AddressTree", "role_Tree.jsp");
forwardMap.put("CjTree", "role_Tree.jsp");
forwardMap.put("Opeorder", "role_Tree.jsp");
forwardMap.put("Controlcar", "role_Tree.jsp");
forwardMap.put("ArticleCodeModi", "TreeNode.jsp");
forwardMap.put("ChannelSelect", "TreeCheckbox.jsp");
HttpTool.saveParameters(request, "TreeExt", allFormNames);
log.debug("cmd=" + cmd + ",forward=" + forwardKey);

pageContext.forward((String)forwardMap.get(forwardKey) + "?cmd=" + cmd + "&Id=" + Id + "&Name=" + Name+"&Code="+Code);
%>