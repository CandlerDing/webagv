<%@ page language="java"%>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
List cdts = new ArrayList();
CarPath cp = new CarPath();
cdts.clear();
cdts.add("Carid=8");
cdts.add("order by id desc");
List<CarPath> cps = cp.query(cdts);
	cp=cps.get(0);
	cp.getQd();
%>
<html>
<head>
<title>监控</title>
<link rel="stylesheet" href="../html/css/style.css">
    <script type="text/javascript" src="../html/js/core/paper-full.js"></script>
    	<script type="text/javascript" src="../html/js/core/sax.js"></script>
    <script type="text/javascript" src="../html/js/core/xmldoc.js"></script>
	<script type="text/javascript" >
	var AGV = function () {
	    REVISION: '1'
	};

	AGV.SETTING = '';

	AGV.BASE = function () {
	    this.name = null;
	    this.id = null;
	    this.selected = false;
	    this.type = null;
	    this.origColor = null;//原始颜色
	    this.drawData = null;
	};

	AGV.BASE.prototype.SetName = function (value) {
	    this.name = value;
	};
	AGV.BASE.prototype.GetName = function () {
	    return this.name;
	};
	AGV.BASE.prototype.SetId = function (value) {
	    this.id = value;
	};
	AGV.BASE.prototype.GetId = function () {
	    return this.id;
	};

	  AGV.BASE.prototype.SetSelected = function (isSelected) {
	      this.selected = isSelected;

	    var type = this.type;
	      if(type == 'Path'){
	        
	         if(isSelected == false)
	      {
	        this.drawData.strokeColor = this.origColor;
	      }else
	      {
	        this.drawData.strokeColor = 'red';
	      }
	     }else if(type == 'RFID'){
	      if(isSelected == false)
	      {
	        this.drawData.strokeColor = this.origColor;
	        this.drawData.fillColor = this.origColor;
	      }else
	      {
	        this.drawData.strokeColor = 'red';
	        this.drawData.fillColor = 'red';
	      }
	     }
	  };

	//var center =  paper.project.view.center;

	AGV.Model = function () {
	    AGV.BASE.call(this);
	    this.type = 'Model';
	    this.zoom = null;
	    this.layers = [];
	    this.iagvs = new Map();

	    this.width = 20;
	    this.height = 5;

	    this.screenResolution = 50;
	    this.center = new paper.Point(800, 20);
	};
	AGV.Model.prototype = Object.create(AGV.BASE.prototype);
	AGV.Model.prototype.constructor = AGV.Model;

	AGV.Model.prototype.Zoom = function () {
	    return this.zoom;
	};

	AGV.Model.prototype.Layers = function () {
	    return this.layers;
	};

	AGV.Model.prototype.AddLayer = function (layer) {
	    this.layers.push(layer);
	};

	AGV.Model.prototype.IAgvs = function () {
	    return this.iagvs;
	};

	AGV.Model.prototype.AddAgv = function (iagv) {
	    if (iagv != null) {
	        this.iagvs.set(iagv.GetId, iagv);
	    }
	};

	AGV.Model.prototype.OffsetPnt = function (pnt) {
	    pnt.y = this.height - pnt.y;
	    var newPnt = pnt.multiply(this.screenResolution).add(this.center);
	    return newPnt;
	};
	var startId="<%=cp.getQd()%>";
	AGV.Model.prototype.FromXML = function (xmlString) {

	    var layer = new AGV.AGVLayer();
	    this.AddLayer(layer);
	    var model = this;
	 
	    var agvitems = new XmlDocument(xmlString);
	    // Demonstrate how toString() will pretty-print an abbreviated version of the XML for debugging
	    //console.log("Parsed: \n" + agvitems);

	    agvitems.eachChild(function (agvItem) {
	        var agvObjName = agvItem.name;
	        if (agvObjName == 'Path') {
	            var agvPath = model.SetupPath(agvItem);
	            //alert(agvPath.startpathnodeid);
	            if(agvPath.startpathnodeid==startId) {
	            	agvPath.SetSelected(true);
	            }
	            layer.AddAgv(agvPath);

	            //path.remove();
	            model.AddAgv(agvPath);
	        }
	        else if (agvObjName == 'RFID') {
	            var agvRFID = model.SetupRFID(agvItem);
	            layer.AddAgv(agvRFID);
	            
	            model.AddAgv(agvRFID);
	        }
	       else if (agvObjName == 'PathNode') {
	            var agvpoint = model.SetupPathNode(agvItem);
	            layer.AddAgv(agvpoint);
	            
	            model.AddAgv(agvpoint);
	        }
	         else if (agvObjName == 'AGVText') {
	            var agvtext = model.SetupAGVText(agvItem);
	            layer.AddAgv(agvtext);
	            
	            model.AddAgv(agvtext);
	        }
	        // document.write("<p>Path: '" + Path.name +  Path.attr.ID + "'</p>");
	    });
	};

	AGV.Model.prototype.GetPoints = function (agvItem) {
	    var newPnts = new Array();
	    agvItem.eachChild(function (pnts) {
	        var agvObjName = pnts.name;
	        if (agvObjName == 'Points') {
	            var pntsValue = pnts.val.split(' ');

	            for (i = 0; i < pntsValue.length; i++) {
	                if (pntsValue[i].length > 0) {
	                    newPnts.push(parseFloat(pntsValue[i]));
	                }
	            }
	        }
	    });
	    return newPnts;
	};

	var lineWidth = 3;

	AGV.Model.prototype.GetRFIDPoints = function (rfidPnt) {
	    var newPnts = new Array();
	    var pntsValue = rfidPnt.split(' ');
	    for (i = 0; i < pntsValue.length; i++) {
	        if (pntsValue[i].length > 0) {
	            newPnts.push(parseFloat(pntsValue[i]));
	        }
	    }
	    return newPnts;
	}

	AGV.Model.prototype.SetupPath = function (agvItem) {
	    var name = agvItem.attr.Name;
	    var id = agvItem.attr.ID;
	    var rfid1id = agvItem.attr.RFID1ID;
	    var rfid2id = agvItem.attr.RFID2ID;
	    var tracktype = agvItem.attr.TrackType;
	    var pathType = agvItem.attr.PathType;
	    var weigh = agvItem.attr.Weigh;
	    var length = agvItem.attr.Length;
	    var direction = agvItem.attr.Direction;
	    //startId
	    var startpathnodeid = agvItem.attr.StartPathNodeId;

	    var points = AGV.Model.prototype.GetPoints(agvItem);

	    var agvPath = new AGV.AGVPath();
	    agvPath.name = name;
	    agvPath.id = id;
	    agvPath.startpathnodeid = startpathnodeid;

	    agvPath.trackType = tracktype;
	    agvPath.pathType = pathType;
	    agvPath.direction = direction;
	    agvPath.rfid1id = rfid1id;
	    agvPath.rfid2id = rfid2id;
	    agvPath.weigh = weigh;
	    agvPath.length = length;


	    var path;
	    if (tracktype == '0' && points.length == 4) {
	        var from = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        var to = this.OffsetPnt(new paper.Point(points[2], points[3]));
	        path = new paper.Path.Line(from, to);
	    }
	    else if (tracktype == '1' && points.length == 6) {
	        var from = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        var through = this.OffsetPnt(new paper.Point(points[2], points[3]));
	        var to = this.OffsetPnt(new paper.Point(points[4], points[5]));
	        path = new paper.Path.Arc(from, through, to);
	    }
	    else if (tracktype == '2' && points.length == 6) {
	        var from = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        var through = this.OffsetPnt(new paper.Point(points[2], points[3]));
	        var to = this.OffsetPnt(new paper.Point(points[4], points[5]));
	        path = new paper.Path.Arc(from, through, to);
	    }
	    path.strokeColor = AGV.Model.prototype.getPathDrawColor(pathType,direction);
	    path.strokeWidth = lineWidth;
	    path.data = agvPath;
	    agvPath.drawData = path;
	    agvPath.origColor = path.strokeColor;//记录原始颜色值

	    path.onMouseDown = AGV.Model.prototype.onMouseDown;
	    path.strokeWidth = lineWidth;
	    agvPath.SetPath(path);

	    paper.project.activeLayer.addChild(path);

	    return agvPath;
	};

	AGV.Model.prototype.getPathDrawColor = function(pathType,direction){
	    var drawColor = 'black';
	    //正常路
	    if(pathType == 0 ){
	        drawColor = 'black';
	    }else if(pathType == 1 ){//避让区
	        drawColor = 'green';
	    }

	    if(direction == 0)
	    {
	       drawColor = 'black';
	    }
	    else if(direction == 1)
	    {
	        drawColor = 'black';
	    }

	    return drawColor;
	};

	AGV.Model.prototype.getRFIDDrawColor = function(rfidType,direction){
	    var drawColor = 'black';

	    if(rfidType == 0){

	    }
	    else if (rfidType == 1)
	    {

	    } else if (rfidType == 2)
	    {

	    }else if (rfidType == 3)
	    {

	    }

	    return drawColor;
	};

	var pointSize = 8;
	AGV.Model.prototype.SetupRFID = function (agvItem, model) {
	    var name = agvItem.attr.Name;
	    var id = agvItem.attr.ID;

	    var type = agvItem.attr.RfidType;
	    var weigh = agvItem.attr.Weigh;
	    var position = agvItem.attr.Position;

	    var points = AGV.Model.prototype.GetRFIDPoints(position);

	    var agvRFID = new AGV.AGVRFID();

	    agvRFID.name = name;
	    agvRFID.id = id;
	    agvRFID.rfidType = type;
	    agvRFID.position = position;


	    var paperCircle = null;
	    if (type == '0' && points.length == 2) {
	        var paperPoint = null;
	        paperPoint = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        paperCircle = new Path.Circle(paperPoint, pointSize);
	        paperCircle.strokeColor = 'black';
	        paperCircle.fillColor = 'black';
	    }else if (type == '1' && points.length == 2) {
	        var paperPoint = null;
	        paperPoint = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        paperCircle = new Path.Circle(paperPoint, pointSize);
	        paperCircle.strokeColor = 'green';
	        paperCircle.fillColor = 'green';
	    }

	    paperCircle.strokeWidth = lineWidth;
	    agvRFID.SetPoint(paperCircle);

	    paperCircle.data = agvRFID;
	    agvRFID.drawData = paperCircle;
	    agvRFID.origColor = paperCircle.strokeColor;

	    paperCircle.onMouseDown = AGV.Model.prototype.onMouseDown;
	    paper.project.activeLayer.addChild(paperCircle);

	    return agvRFID;
	};

	AGV.Model.prototype.onMouseDown = function (event) {
	    this.strokeColor = 'red';
	};

	AGV.Model.prototype.FromJson = function () {

	};
	 
	AGV.AGVLayer = function () {
	    this.iagvs = new Set();
	};
	AGV.AGVLayer.prototype = Object.create(AGV.BASE.prototype);
	AGV.AGVLayer.prototype.IAgvs = function () {
	    return this.iagvs;
	};

	AGV.AGVLayer.prototype.AddAgv = function (agv) {
	    this.iagvs.add(agv);
	};
	AGV.AGVLayer.prototype.RemoveAgv = function (agv) {
	    this.iagvs.delete(agv);
	};

	AGV.AGVPath = function () {
	    this.path = null;

	    this.type = 'Path';

	    this.pathType = null;//路径类型 避让和正常路径

	    this.trackType = null;//轨迹类型
	    this.direction = null;//方向 单向 双向
	    
	    this.rfid1id = null;
	    this.rfid2id = null;

	    this.length = null;
	    this.weigh = null;
	};

	AGV.AGVPath.prototype = Object.create(AGV.BASE.prototype);
	AGV.AGVPath.prototype.SetPath = function (value) {
	    this.path = value;
	};

	AGV.AGVPath.prototype.GetPath = function () {
	    return this.path;
	};

	AGV.AGVRFID = function () {
	    this.type = 'RFID';
	    
	    this.rfidType = null;
	    this.position = null;

	    this.point = null;
	};

	AGV.AGVRFID.prototype = Object.create(AGV.BASE.prototype);

	AGV.AGVRFID.prototype.SetPoint = function (value) {
	    this.point = value;
	};
	AGV.AGVRFID.prototype.GetPoint = function () {
	    return this.point;
	};

	AGV.AGVBackground = function () {
	    this.image = null;
	};

	AGV.AGVBackground.prototype = Object.create(AGV.BASE.prototype);
	 
	AGV.AGVString = function () {
	    this.showString = null;
	};
	AGV.AGVString.prototype = Object.create(AGV.BASE.prototype);
	AGV.AGVString.prototype.SetString = function (value) {
	    this.showString = value;
	};
	AGV.AGVString.prototype.GetString = function () {
	    return this.showString;
	};
	
	AGV.AGVPATHNODE = function () {
	    this.type = 'PathNode';
	    
	    this.pathnodetype = null;
	    this.position = null;

	    this.point = null;
	};
	//展示地图上的点
	var pointNodeSize = 5;//控制点的大小
	AGV.Model.prototype.SetupPathNode = function (agvItem, model) {
	    var name = agvItem.attr.Name;
	    var id = agvItem.attr.ID;

	    var type = agvItem.attr.PathNodeType;
	    var position = agvItem.attr.Position;

	    var points = AGV.Model.prototype.GetRFIDPoints(position);

	    var agvRFID = new AGV.AGVRFID();

	    agvRFID.name = name;
	    agvRFID.id = id;
	    agvRFID.pathnodetype = type;
	    agvRFID.position = position;


	    var paperCircle = null;
	    if (type == '0' && points.length == 2) {
	        var paperPoint = null;
	        paperPoint = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        paperCircle = new Path.Circle(paperPoint, pointNodeSize);
	        paperCircle.strokeColor = 'black';
	        paperCircle.fillColor = 'black';
	    }else if (type == '1' && points.length == 2) {
	        var paperPoint = null;
	        paperPoint = this.OffsetPnt(new paper.Point(points[0], points[1]));
	        paperCircle = new Path.Circle(paperPoint, pointNodeSize);
	        paperCircle.strokeColor = 'green';
	        paperCircle.fillColor = 'green';
	    }

	    paperCircle.strokeWidth = lineWidth;
	    agvRFID.SetPoint(paperCircle);

	    paperCircle.data = agvRFID;
	    agvRFID.drawData = paperCircle;
	    agvRFID.origColor = paperCircle.strokeColor;

	    paperCircle.onMouseDown = AGV.Model.prototype.onMouseDown;
	    paper.project.activeLayer.addChild(paperCircle);

	    return agvRFID;
	};
	
	var textSize = 3;
	AGV.AGVText = function () {
	    this.type = 'TextItem';
	    
	    this.FontSize = null;
	    this.position = null;

	};
	AGV.AGVText.prototype.SetPoint = function (value) {
	    this.point = value;
	};
	AGV.AGVText.prototype.GetPoint = function () {
	    return this.point;
	};
	AGV.AGVText.prototype.SetName = function (value) {
	    this.name = value;
	};
	AGV.AGVText.prototype.GetName = function () {
	    return this.name;
	};
	//展示地图上的字母和路径标识
	AGV.Model.prototype.SetupAGVText = function (agvItem) {
	    var name = agvItem.attr.Name;
	    var id = agvItem.attr.ID;

	    var position = agvItem.attr.Position;
	    var fontsize = agvItem.attr.FontSize;

	    var points = AGV.Model.prototype.GetRFIDPoints(position);
		
	    var agvText = new AGV.AGVText();

	    agvText.name = name;
	    agvText.id = id;
	    agvText.FontSize = fontsize;
	    agvText.position = position;
		
	    var paperCircle = null;
        var paperPoint = null;
        //需要调整，根据目前的方法只能展示点，不能展示字母
        paperPoint = this.OffsetPnt(new paper.Point(points[0], points[1]));
        paperCircle = new Path.Circle(paperPoint, textSize);//此方法
        paperCircle.strokeColor = 'black';
        paperCircle.fillColor = 'black';
        //paperCircle.dashArray = agvText;
        
	    paperCircle.strokeWidth = lineWidth;
	    agvText.SetPoint(paperCircle);
	    agvText.SetName(name);

	    //paperCircle.data = agvText;
	    agvText.drawData = paperCircle;
	    agvText.origColor = paperCircle.strokeColor;

	    paperCircle.onMouseDown = AGV.Model.prototype.onMouseDown;
	    paper.project.activeLayer.addChild(paperCircle);
	    //paper.project.activeLayer.addChild(paperText);

	    return agvText;
	};
	</script> 

   
    
     <script type="text/javascript" src="../html/js/agv/agv_car_map.js" canvas="myCanvas">
    </script>
    <script type="text/JavaScript">
 	/* function myrefresh() {
		window.location.reload();
	}
	setTimeout('myrefresh()', 10000); //指定10秒刷新一次 */
    </script>
</head>
<body>

	 <canvas id="myCanvas" resize></canvas>
	<button id = "btn_add" type="button" onclick="javascript:zoom(1.25);" >+</button>
	<button id = "btn_reduce" type="button" onclick="javascript:zoom(0.8);"> - </button>
    <button id = "btn_submitRFIDS" type="button" onclick="javascript:submitRFIDS();">提交起点和终点</button>
    <button id = "btn_clearSelectedRFIDS" type="button" onclick="javascript:clearSelectedRFIDS();">清空选择</button>

</body>
</html>
