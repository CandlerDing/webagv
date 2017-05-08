<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
    <title>agv</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/html/css/style.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/html/js/core/paper-full.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/html/js/agv/agv.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/html/js/core/sax.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/html/js/core/xmldoc.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/html/js/agv/agvtest.js" canvas="myCanvas"></script>
</head>
<body>
    <canvas id="myCanvas" resize></canvas>
	<button id = "btn_add" type="button" onclick="javascript:zoom(1.25);" >+</button>
	<button id = "btn_reduce" type="button" onclick="javascript:zoom(0.8);"> - </button>
</body>
</html>
