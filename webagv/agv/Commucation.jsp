<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style"/>
</jsp:include>
<script type="text/javascript"> 
function connect()
{
	$.ajax({
        type: "POST",
        url: "connect.jsp",
        data: {ip:$("#ip").val(),port:$("#port").val()},       
        success: function(data){
        	       alert("���ӳɹ�");                 
          }
    });	
}
function SearchA(code)
{
	$.ajax({
        type: "POST",
        url: "connect.jsp",
        data: {code:code},       
        success: function(data){
       // 	alert(data);                 
         }
    });	
}
function Search(code1,code2)
	{
	$.ajax({
        type: "POST",
        url: "getSearch.jsp",
        data: {code1:code1,code2:code2},       
        success: function(data){//alert(data);
                    $('#A1').html(""); 
                    $('#A1').html(data);
                 }
    });
 } 
function SearchB(code1,code2)
{
$.ajax({
    type: "POST",
    url: "http://192.168.1.122:8086/agv/agv/getSearch.jsp",
    data: {code1:code1,code2:code2},       
    success: function(data){//alert(data);
                $('#B1').html(""); 
                $('#B1').html(data);
             }
});
} 
function SearchD(code1,code2,code3)
{
$.ajax({
    type: "POST",
    url: "http://192.168.1.122:8086/agv/agv/getControl.jsp",
    data: {code1:code1,code2:code2,code3:code3},       
    success: function(data){//alert(data);
                $('#D1').html(""); 
                $('#D1').html(data);
             }
});
} 
 </script> 
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>

 <title>My JSP 'index.jsp' starting page</title>
 <meta http-equiv="pragma" content="no-cache">
 <meta http-equiv="cache-control" content="no-cache">
 <meta http-equiv="expires" content="0"> 
 <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
 <meta http-equiv="description" content="This is my page">
 <!--
<link rel="stylesheet" type="text/css" href="styles.css">
 -->
 </head>

 <body>
<table align="center" width="100%" border="0">
<tr>
<td>����IP:
</td>
<td>
<input  class="easyui-textbox" name="ip" id="ip" size="15" maxlength="20" value="192.168.1.2">
<input  class="easyui-textbox" name="port" id="port" size="5" maxlength="5" value="4001">&nbsp;&nbsp;
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:80px" onClick="connect();">����</a>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">��ѯ����������</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
�����Ƿ����:
</td><td align="left">
<a href="#" class="easyui-linkbutton"   onClick="SearchA('getDetailDebug')">��ѯ������ϸ������ϢA1.00</a>
<a href="#" class="easyui-linkbutton"   onClick="SearchA('getAllDebug')">��ѯ�����ܹ��ϱ�ʶA1.01</a>
<a href="#" class="easyui-linkbutton"   onClick="SearchA('getSelfDebug')">��ѯ���������屾����ϱ�ʶA1.02</a>
<a href="#" class="easyui-linkbutton"   onClick="getOutDebug();">��ѯ������������Χ���ϱ�ʶָ��A1.03</a>
<a href="#" class="easyui-linkbutton"   onClick="getFrontUsDebug();">��ѯ����������ǰ�೬�������״���ϱ�ʶA1.04</a>
<a href="#" class="easyui-linkbutton"   onClick="getBackUsDebug();">��ѯ�����������೬�������״���ϱ�ʶA1.05</a>
<a href="#" class="easyui-linkbutton"   onClick="getLeftRightUsDebug();">��ѯ��������������Ҳ೬�������״���ϱ�ʶA1.06</a>
<a href="#" class="easyui-linkbutton"   onClick="getControlDebug();">��ѯ�����������೬�������״���ϱ�ʶA1.07</a>
<a href="#" class="easyui-linkbutton"   onClick="getGoodsDebug();">��ѯ������ư������ϱ�ʶA1.08</a>
<a href="#" class="easyui-linkbutton"   onClick="etRealtimeState();">��ѯ������ϸʵʱ״̬��ϢA2.00</a>
<a href="#" class="easyui-linkbutton"   onClick="getCellVoltage();">��ѯ�����ص�ѹA2.01</a>
<a href="#" class="easyui-linkbutton"   onClick="getTravelDirection();">��ѯ������ʻ����A2.02</a>
<a href="#" class="easyui-linkbutton"   onClick="getTravelSpeed();">��ѯ������ʻ�ٶ�A2.03</a>
<a href="#" class="easyui-linkbutton"   onClick="getCarAddress();">��ѯ����λ����ϢA2.04</a>
<a href="#" class="easyui-linkbutton"   onClick="getChannelLoading();">��ѯ����ͨ���ػ�״̬A2.05</a>
<a href="#" class="easyui-linkbutton"   onClick="getOnthenext();">��ѯ�������»�����״̬A2.06</a>
<a href="#" class="easyui-linkbutton"   onClick="getGeneralState();">��ѯ��������״̬A2.07</a>
<a href="#" class="easyui-linkbutton"   onClick="SearchA('getSearchControl')">��ѯ��������ȨA2.08</a>
<a href="#" class="easyui-linkbutton"   onClick="getOperationMode();">��ѯ��������ģʽA2.09</a>
<a href="#" class="easyui-linkbutton"   onClick="getBatteryPower();">��ѯ�����ص���A2.10</a>
<a href="#" class="easyui-linkbutton"   onClick="getSearchTime();">��ѯ��������+ʱ����ϢA3.00</a>
<a href="#" class="easyui-linkbutton"   onClick="getSearchCarTime();">��ѯ����ʱ����ϢA3.01</a>
<a href="#" class="easyui-linkbutton"   onClick="getPathStateALL();">��ѯ·��״̬��Ϣ�ܱ�ʶB1.01</a>
<a href="#" class="easyui-linkbutton"   onClick="PathLost();">��ѯ·��������ʧB1.02</a>
<a href="#" class="easyui-linkbutton"   onClick="PathRFIDLost();">��ѯ·���ر�RFIDB1.03</a>
<a href="#" class="easyui-linkbutton"   onClick="ControlCar();">�����������C1.00</a>
<a href="#" class="easyui-linkbutton"   onClick="getModiControl();">ǿ���޸��ͷų�������ȨD1.00</a>
<a href="#" class="easyui-linkbutton"   onClick="ForceOnOff();">ǿ�Ƴ�����ͣD1.01</a>
<a href="#" class="easyui-linkbutton"   onClick="CancelTask();">ǿ��ȡ����������D1.02</a>
<a href="#" class="easyui-linkbutton"   onClick="ModiTime();">ǿ���޸ĳ�������+ʱ��D1.03</a>
<a href="#" class="easyui-linkbutton"   onClick="ModiRunModel();">����ģʽ����D2.00</a>
<a href="#" class="easyui-linkbutton"   onClick="TestDrive();">����ģʽD2.01</a>
<a href="#" class="easyui-linkbutton"   onClick="SportDrive();">�㶯ģʽD2.02</a>
<a href="#" class="easyui-linkbutton"   onClick="OnUnload();">�㶯ģʽ�������»�D2.03</a>
<a href="#" class="easyui-linkbutton"   onClick="getSearchCarTime();">��ѯ����ʱ����ϢD2.04</a>
<a href="#" class="easyui-linkbutton"   onClick="getSearchCarTime();">��ѯ����ʱ����ϢD2.05</a>


</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ������������Χ���ϱ�ʶָ��A1.03" onclick="Search('00010001','000100010009');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010009');"/>
<input type="button"  value="��ѯ����������ǰ�೬�������״���ϱ�ʶָ��A1.04" onclick="Search('00010001','000100010004');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010004');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ�����೬�������״���ϱ�ʶA1.05" onclick="Search('00010001','000100010005');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010005');"/>
<input type="button"  value="��ѯ��������Ҳ೬�������״���ϱ�ʶA1.06" onclick="Search('00010001','000100010006');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010006');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ������Χ���ϱ�ʶA1.07" onclick="Search('00010001','000100010007');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010007');"/>
<input type="button"  value="��ѯ������Χ��������ϱ�ʶA1.08" onclick="Search('00010001','000100010008');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010008');"/>
</td>
</tr>
<tr>
<td align="left"  width="10%">
����ʵʱ״̬:
</td><td align="left">
<input type="button"  value="��ѯ������ϸʵʱ״̬��Ϣָ��A2.00" onclick="Search('00010001','000100020001');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020001');"/>
<input type="button"  value="��ѯ�����ص�ѹָ��A2.01" onclick="Search('00010001','000100020002');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020002');"/>
<input type="button"  value="��ѯ������ʻ����ָ��A2.02" onclick="Search('00010001','000100020003');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020003');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ������ʻ�ٶ�ָ��A2.03" onclick="Search('00010001','000100020004');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020004');"/>
<input type="button"  value="��ѯ����λ����Ϣָ��A2.04" onclick="Search('00010001','000100020005');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020005');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ����ͨ���ػ�״ָ̬�� A2.05" onclick="Search('00010001','000100020006');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020006');"/>
<input type="button"  value="��ѯ�������»�����״ָ̬�� A2.06" onclick="Search('00010001','000100020007');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020007');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ��������״ָ̬��A2.07" onclick="Search('00010001','000100020008');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100010007');"/>
<input type="button"  value=" ��ѯ��������Ȩָ�� A2.08" onclick="Search('00010001','000100020009');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020009');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="��ѯ��������ģʽָ��A2.09" onclick="Search('00010001','000100020010');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020010');"/>
<input type="button"  value="��ѯ�����ص���ָ�� A2.10" onclick="Search('00010001','000100020011');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100020011');"/>
</td>
</tr>
<tr>
<td align="left"  width="10%">
������ǰʱ��:
</td><td align="left">
<input type="button"  value="��ѯ��������+ʱ����Ϣָ��A3.00" onclick="Search('00010001','000100030001');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100030001');"/>
<input type="button"  value="��ѯ����ʱ����Ϣָ��A3.01" onclick="Search('00010001','000100030002');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000100030002');"/>
</td>
</tr>
<tr>
<td>
��ѯ�������
</td>
<td>
<div id=A1></div>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">��ѯ·��������</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
</td><td align="left">
<input type="button"  value="��ѯ��ϸ·��״̬��Ϣָ��B1.00" onclick="SearchB('00010001','00020001');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00020001');"/>
<input type="button"  value="��ѯ·��״̬��Ϣ�ܱ�ʶָ��B1.01" onclick="SearchB('00010001','00020002');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00020002');"/>
<input type="button"  value="��ѯ·��������ʧָ��B1.02" onclick="SearchB('00010001','00020003');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00020003');"/>
<input type="button"  value=" ��ѯ·���ر�RFID�㶪ʧָ�� B1.03" onclick="SearchB('00010001','00020004');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00020004');"/>
</td>
</tr>
<tr>
<td>
��ѯ·�����
</td>
<td>
<div id=B1></div>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">ǿ�ƿ��Ƴ�����ָ��</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
</td><td align="left">
<input type="button"  value="ǿ���޸��ͷų�������Ȩָ��(��̨�޸�Ϊ�ֻ�)D1.00" onclick="SearchD('00010001','00040001','00040003');"/>
<input type="button"  value="ǿ���޸��ͷų�������Ȩָ��(�ֻ��޸�Ϊ�ֻ�)D1.00" onclick="SearchD('00010003','00040001','00040003');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00040001');"/>
<input type="button"  value="ǿ�Ƴ�����ָͣ��D1.01" onclick="SearchD('00010001','00040002');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00040002');"/>
<input type="button"  value="ǿ��ȡ����������ָ��D1.02" onclick="SearchD('00010001','00040003');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','00040003');"/>
<input type="button"  value="ǿ���޸ĳ�������+ʱ��ָ��D1.03" onclick="SearchD('00010001','000D0004');"/>
<input type="button"  value="����" onclick="SearchandSend('00010001','000D0004');"/>
</td>
</tr>
<tr>
<td>
ǿ�ƿ��Ƴ������
</td>
<td>
<div id=D1></div>
</td>
</tr>
</table> </body>
</html>
