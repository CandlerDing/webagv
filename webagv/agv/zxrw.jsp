<%@ page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,com.service.command.*"%>
<%@ page import="org.apache.commons.logging.*,com.service.commucation.client.*,com.agvcommucation.*,com.agvdirecting.*"%>
<%@ page import="com.software.util.*"%>

<%!public static final String TESTCARID_STRING = "TestCar0";
	private static SVCMoveCmd getMoveTask(String car, String carPathNodeID,String qd, String zd) {
		SVCMoveCmd moveTask = new SVCMoveCmd();
		moveTask.setCarPathNodeID(carPathNodeID);
		moveTask.setStartPathNodeID(qd);
		moveTask.setEndPathNodeID(zd);
		moveTask.setCarId(car);
		return moveTask;
	}

	private static SVCAddCarCmd getAddCar(int carid) {
		CarDb c = new CarDb();
		c = c.getById(carid);
		SVCAddCarCmd moveTask = new SVCAddCarCmd();
		moveTask.setCarId(c.getName());
		moveTask.setIp(c.getIpaddress());
		moveTask.setName(c.getName());
		moveTask.setPort(c.getPort());

		return moveTask;
	}%>
<%
	int carid = ParamUtils.getIntParameter(request, "carid", 0);
	int taskid = ParamUtils.getIntParameter(request, "taskid", 0);
	TaskQuene task = new TaskQuene();
	task = task.getById(taskid);
	String qda = task.getQdUUId();// request.getParameter("qd");
	if(task.getRwzt().equals("3")){
		 qda = task.getCarUUId();
	}
	
	String zda = task.getZdUUId(); //request.getParameter("zd");
	if (taskid > 0) {
		String te ="";
		CarDb c = new CarDb();
		CarDb cd=new CarDb();
		List cdt = new ArrayList();
		cdt.add("Isuse=0");
		cdt.add("pid=2");
		List<CarDb> cars = c.query(cdt);
		if (cars.size() == 0) {
			te = "没有可用的车辆，请稍候再试！！！";
			out.println(te);
			out.clear();
			out.print(te);
		} else{
			c = cars.get(0);
			SVCCommucationClient sCommucationClient = new SVCCommucationClient();
			String directingSystemIP = "127.0.0.1";
			String directingSystemPort = "9123";
			te = sCommucationClient.connectionToService(directingSystemIP, directingSystemPort);
			CommucationClientStatus sCommucationClients = new CommucationClientStatus();
			com.agvdirecting.car.Car clentCar=new 	com.agvdirecting.car.Car();
			clentCar.setIPAddress(c.getIpaddress());
			clentCar.setPort(c.getPort());
			sCommucationClients.connectionCar(clentCar);
			CommucationClient commucationClient = new CommucationClient();
			//if(	commucationClient.connectionCar(clentCar)){
				//打开和指挥系统的通信
				if (te.equals("连接成功")) {
					sCommucationClients.open();
					sCommucationClient.open();
					try {
						task.setCarid(c.getId());//寻找空的小车
						//如果没有空的小车，提示
						task.setStartTime(Tool.stringOfDateTime());//记录开始执行的时间
						task.setRwzt("0");
						task.update();
						c.setIsuse(1);//更新车辆状态为在用状态
						        //进行模拟任务添加通信逻辑
						  SVCBaseCmd cmd = null;
						    cmd = getAddCar(c.getId());       
						   //如果命令有效，则发送出去
						   if(cmd != null) {
						            sCommucationClient.sendSVCCommand(cmd);                    
						    }
						        Thread.sleep(100);       
						    } catch (InterruptedException e) {
						        e.printStackTrace();
						        sCommucationClient.close();
						        out.println("连接失败！！！请检查配置！！！");
								out.clear();
						    }
					
					try {
					//	sCommucationClient.open();
						//发送命令
				        SVCMoveCmd cmd = null;
						cmd = getMoveTask(c.getName(), c.getLjsb(),qda, zda);
						//如果命令有效，则发送出去
						if (cmd != null) {
							sCommucationClient.sendSVCCommand(cmd);
						}
					
						Thread.sleep(100);
						
						out.println(te);
						out.clear();
						out.print(te);
					} catch (InterruptedException e) {
						e.printStackTrace();
						out.println("连接失败！！！请检查配置！！！");
						out.clear();
					}
				}
			/* }else{
				sCommucationClient.closeConnectionToCar();
			//	commucationClient.closeConnection();
				te = "车辆连接失败，请检查车辆配置！！！";
				out.println(te);
				out.clear();
				out.print(te);
			} */
		
		}
	}
%>
