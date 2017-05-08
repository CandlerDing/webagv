<%@page contentType="text/html;charset=gb2312" import="java.io.*" %>     
<html>   
<head>   
<title></title> 
</head>   
<body>    
<%  
//Runtime runtime = Runtime.getRuntime();   
//Process process = null;     
    
try   
{    
Process process=Runtime.getRuntime().exec("cmd /c start C:/Release/AGVMonitor.exe");   
   

}   
catch(IOException e)   
{     
out.println(e.toString());   
}     
%> 
</body>     
</html>
