<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,com.service.command.*"%>
<%@ page import="org.apache.commons.logging.*,com.service.commucation.client.*"%>
<%@ page import="com.software.util.*,com.software.main.*"%>

<%!
public static final String TESTCARID_STRING  ="TestCar0";
private static SVCMoveCmd getMoveTask(String car,String qd,String zd)
{
    SVCMoveCmd moveTask = new SVCMoveCmd();    
    moveTask.setStartPathNodeID(qd);
    moveTask.setEndPathNodeID(zd);    
    moveTask.setCarId(car);    
    return moveTask;
} 
private static SVCAddCarCmd getAddCar(int carid)
{
    Car c = new Car();
    c = c.getById(carid);
	SVCAddCarCmd moveTask = new SVCAddCarCmd();    
    moveTask.setCarId(c.getName());    
    moveTask.setIp(c.getIpaddress());
    moveTask.setName(c.getName());
    moveTask.setPort(c.getPort());    
    return moveTask;
}
%>
<%
int  carid = ParamUtils.getIntParameter(request,"carid",0);
int  taskid = ParamUtils.getIntParameter(request,"taskid",0);
int  qd = ParamUtils.getIntParameter(request,"qd",0);
int  zd = ParamUtils.getIntParameter(request,"zd",0);
String qda ="";
String zda ="";
String car ="";
if(carid>0)
{
car = getAddCar(carid).getCarId();

if(taskid>0)
{
	TaskQuene t = new TaskQuene();
	t = t.getById(taskid);
	qda = t.getQdUUId();
	zda = t.getZdUUId();
}else{
	Rfid r = new Rfid();
	r = r.getById(qd);
	qda = r.getPathbsUuId();
	r = r.getById(zd);
	zda = r.getPathbsUuId();
}

SVCCommucationClient sCommucationClient = new SVCCommucationClient();

String directingSystemIP = "127.0.0.1";
String directingSystemPort = "9123";

sCommucationClient.setServerAddress(directingSystemIP, directingSystemPort);

//打开和指挥系统的通信
sCommucationClient.open();
boolean quit = false;
    try {
        //进行模拟任务添加通信逻辑
        SVCBaseCmd cmd = null;      
        
        cmd = getMoveTask(car,qda,zda);
        SVCMoveCmd smc= getMoveTask(car,qda,zda);
        //如果命令有效，则发送出去
        if(cmd != null) {
            sCommucationClient.sendSVCCommand(cmd,smc);                    
        }
        Thread.sleep(100);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}

%>
