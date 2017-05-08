function checkPhone(phoneForm)
{
 var mobile=phoneForm.value;
 var reg0=/^13\d{5,9}$/;   //130--139。至少7位
 var reg1=/^153\d{4,8}$/;  //联通153。至少7位
 var reg1=/^156\d{4,8}$/;  //联通156。至少7位
 var reg2=/^159\d{4,8}$/;  //移动159。至少7位
 var my = false;
 if (reg0.test(mobile))my=true;
 if (reg1.test(mobile))my=true;
 if (reg2.test(mobile))my=true;
 if (!my){
        document.all["jserrorDiv"].innerHTML="您输入的手即号码错误。";
	phoneForm.select();
      }

}
function repeatPhone()
{
  document.all["jserrorDiv"].innerHTML="";
}
function clearForm(formName) {
	     var formObj = window.document.forms[formName];
	     var formEl = formObj.elements;
	     for (var i=0; i<formEl.length; i++)
	     {
	     	var element = formEl[i];
	     	if (element.type == 'submit') { continue; }
	     	if (element.type == 'reset') { continue; }
	     	if (element.type == 'button') { continue; }
	     	if (element.type == 'hidden') { continue; }
	     	if (element.type == 'text') { element.value = ''; }
	     	if (element.type == 'textarea') { element.value = ''; }
	     	if (element.type == 'checkbox') { element.checked = false; }
	     	if (element.type == 'radio') { element.checked = false; }
	     	if (element.type == 'select-multiple') { element.selectedIndex = -1; }
	     	if (element.type == 'select-one') { element.selectedIndex = -1; }
	     }
} //listfunction与formfunction里都有此方法
function renderSelect(list, currkey, name, defaultkey, chgevent)
{
    var rtn = "";
    rtn += "<select name=\"" + name + "\" onChange=\"" + chgevent + "\">";
    rtn += renderSelectOption(list, currkey, defaultkey);
    rtn += "</select>&nbsp;";
    return rtn;
}

function renderSelectOption(list, currkey, defaultkey)
{
    var rtn = "";
    if (currkey == undefined||currkey == ""||currkey == "-1") {
        currkey = defaultkey;
    }
    for (var i = 0; i < list.length; i ++) {
        rtn += "<option value=\"" + list[i][1] + "\"";
        if (currkey == list[i][1])
            rtn += " selected";
        rtn += ">" + list[i][0] + "</option>";
    }
    return rtn;
}

function getFieldIndex(fstr) {
    for (var i = 0; i < allfields.length; i ++) {
        if (fstr == allfields[i]) {
            return i;
        }
    }
    return 0;
}

var data_align = {"string": "left", "int": "right", "double": "right", "date": "left", "control": "center"};

function openshow(link1)
{
    var windowopen = window.open;
	openwin=windowopen(link1 , "link1", "top=58,left=200,width=600,height=500,status=no,toolbar=no,menubar=no,scrollbars=no, resizable=no");

}

function showForm(className, cmd, page, forms) {
    var str = '<form action="' + className + 'Action.jsp" method="post" name="' + className + 'Form" id="' + className + 'Form">';
    str += '<input type="hidden" name="cmd" value="' + cmd + '">';
    str += '<input type="hidden" name="page" value="' + page + '">';
    str += forms;
    str += '<table border="0" width="100%" cellspacing="0">';
    for (var i = 0; i < allfields.length; i ++) {
        var gsname = allfields[i];
        var edit = dic[allfields[i]].edit;
        var width = parseInt(dic[allfields[i]].width);
        if (edit == "none") {
        } else if (edit == "hidden") {
            str += '<input type="hidden" name="' + gsname + '" value="' + form[allfields[i]] + '">';
        } else if (edit == "text" || edit == "readonly") {
            str += '<tr><td>';
            str += '<div align="right">' + dic[allfields[i]].name + '</div>';
            str += '</td><td>';
            var readonly = "";
            if (edit == "readonly") {
                readonly = " readonly";
            }
            if (dic[allfields[i]].type == 'string') {
                if (width > -1 && width <= 80) {
                    str += '<input name="' + gsname + '" size="' + width + '" value="' + form[allfields[i]] + '"' + readonly + '>';
                } else if (width == -1) {
                    str += '<textarea name="' + gsname + '" cols="80" rows="5"' + readonly + '>' + form[allfields[i]] + '</textarea>';
                } else {
                    str += '<textarea name="' + gsname + '" cols="80" rows="' + (width / 80 + 1) + '"' + readonly + '>' + form[allfields[i]] + '</textarea>';
                }
            } else {
                str += '<input name="' + gsname + '" value="' + form[allfields[i]] + '"' + readonly + '>';
            }
            str += '</td></tr>';
        } else {
            str += '<tr><td>';
            str += '<div align="right">' + dic[allfields[i]].name + '</div>';
            str += '</td><td>';
            str += renderSelect(options[edit + "options"], form[allfields[i]], gsname, "", "");
            str += '</td></tr>';
        }
    }
    str += '</table></form>';
    document.getElementById("form").innerHTML = str;
}
//权限判断form
function prepareForm(className, dic, uPower) {
    for (var key in dic) {
        //if (key != "" && dic[key][4] != "") {
           // if (dic[key][4].indexOf(uPower) < 0) {
                document.postForm[key].style.readonly = true;
                //document.getElementById('postForm' + key).style.display = "none";
            //}
        //}
    }
}

function deleteThis(className, id, url_para)
{
    if (!url_para)
        url_para = "";
    if (confirm("确实要删除记录吗?")) {
        location = className + "Action.jsp?cmd=delete&" + keyfield + "=" + id + ((url_para.length == 0) ? "" : "&" + url_para);
    }
}
//some form has new record button
function addNew(className, url_para)
{
    if (!url_para)
        url_para = "";
    location = className + "Action.jsp?cmd=create" + ((url_para.length == 0) ? "" : "&" + url_para);
}


//让form的readonly属性的表单项 不显示边框
function   UnableForms()
  {
  var   myForm=document.forms;
  var   i,j
  var   objForm;
  //偏历form集合
  for(j=0;j<myForm.length;j++)
  {
  objForm   =   myForm[j];
  for   (i   =   0;i   <   objForm.elements.length   ;   i++   )
  {
  switch   (objForm.elements(i).tagName)
  {
  case   "TEXTAREA"   :
  	if(objForm.elements(i).readOnly==true)
  	{
  		objForm.elements(i).style.color="#666666";
  		objForm.elements(i).style.border="0px";//不显示边框
  	}
  break;
  case   "INPUT"   :
  	if(objForm.elements(i).readOnly==true)
  	{
  		objForm.elements(i).style.color="#666666";//字的color变灰
  		objForm.elements(i).style.border="0px";//不显示边框
  	}
  break;
  default   :
  	objForm.elements(i).disabled=false;
  break;
  }
  }
  }
  }
//////////////////////////
function getCurrentDirectory(){
	var locArray=location.pathname.split("/")
	locArray.pop()
  delete locArray[locArray.length-1];
  var dirTxt = locArray.join("/");
  return dirTxt;
}

function winSize(){
        var a=new Array();
        a.st = document.body.scrollTop?document.body.scrollTop:document.documentElement.scrollTop;
        a.sl = document.body.scrollLeft?document.body.scrollLeft:document.documentElement.scrollLeft;
        a.sw = document.documentElement.clientWidth || window.document.body.clientWidth;
        a.sh = document.documentElement.clientHeight || window.document.body.clientHeight;
        
        a.wp = document.documentElement.scrollWidth || document.body.scrollWidth || 0;
        a.hp =  document.documentElement.scrollHeight || document.body.scrollHeight || 0;

        return a;
}
function centerDiv(obj){
        var s = winSize();        
        var w = $(obj).css("width");
        var h = $(obj).css("height");

        var yh = parseInt((s.sh - h.substring(0,h.length-2))/2) + s.st + 'px';
        var xh = parseInt((s.sw - w.substring(0,w.length-2))/2) + s.sl + 'px';
        $(obj).css({top:yh,left:xh});  
}
function showBOX(str)
{
	//位置
	   centerDiv(document.getElementById("boxnote"));
  //将弹窗show
    document.getElementById("boxnote").style.display='';
    document.getElementById("boxnote").style.zIndex='1000';
    if( document.getElementById("showErrorInfo") )
    {
    document.getElementById("showErrorInfo").innerHTML=str;
    }
    if( document.getElementById("tishiyuyan") )
    {
    document.getElementById("tishiyuyan").innerHTML=str;
    }
    document.getElementById("black").style.display='';
    document.getElementById("black").style.zIndex='999';
     
}

function showBOXAndFocus(str,divid)
{
   var bt = '<img src="'+getCurrentDirectory()+'images/boxnote-ok01.png" name="boxnoteok" id="boxnoteok" onmouseover="boxnoteok.src=\''+getCurrentDirectory()+'/images/boxnote-ok02.png\'" onmouseout="boxnoteok.src=\''+getCurrentDirectory()+'images/boxnote-ok01.png\'" onClick="hiddenBOXAndFocus(\''+ divid +'\')" style="cursor:pointer"/>';
   document.getElementById("errDiv_bt").innerHTML= bt ;

    //位置

    var widthPage = document.documentElement.scrollWidth || document.body.scrollWidth || 0;

    document.getElementById("black").style.width = widthPage + "px";
    var heightPage =  document.documentElement.scrollHeight || document.body.scrollHeight || 0;
    document.getElementById("black").style.height = heightPage + "px";

   document.getElementById("boxnote").style.left = errorLeft+"px";;
   document.getElementById("boxnote").style.top = errorBottom+"px";
  //将弹窗show
    document.getElementById("boxnote").style.display='';
    document.getElementById("showErrorInfo").innerHTML=str;
    document.getElementById("black").style.display='';
    document.getElementById("black").style.zIndex='999';
    document.getElementById("boxnote").style.zIndex='1000';
      //位置
   centerDiv(document.getElementById("boxnote"));
}
function hiddenBOXAndFocus(divid)
{
  //将弹窗hidden
    document.getElementById("boxnote").style.display='none';
    document.getElementById("showErrorInfo").innerHTML='';
    document.getElementById("black").style.display='none';
    document.getElementById("black").style.zIndex='-1';
    document.getElementById("boxnote").style.zIndex='-1';
    document.getElementById(divid).focus();
    var bt = '<img src="'+getCurrentDirectory()+'images/boxnote-ok01.png" name="boxnoteok" id="boxnoteok" onmouseover="boxnoteok.src=\''+getCurrentDirectory()+'/images/boxnote-ok02.png\'" onmouseout="boxnoteok.src=\''+getCurrentDirectory()+'images/boxnote-ok01.png\'" onClick="hiddenBOXAndFocus(\''+ divid +'\')" style="cursor:pointer"/>';
    document.getElementById("errDiv_bt").innerHTML= bt ;
}

//关闭弹窗并跳转
function hiddenBOXAndLocation(url)
{
  //将弹窗hidden
    document.getElementById("boxnote").style.display='none';
    document.getElementById("showErrorInfo").innerHTML='';
    document.getElementById("black").style.display='none';
    document.getElementById("black").style.zIndex='-1';
    document.getElementById("boxnote").style.zIndex='-1';
    var bt = '<img src="'+getCurrentDirectory()+'images/boxnote-ok01.png" name="boxrightfinish" id="boxrightfinish" onmouseover="boxrightfinish.src=\''+getCurrentDirectory()+'images/boxnote-ok02.png\'" onmouseout="boxrightfinish.src=\''+getCurrentDirectory()+'images/boxnote-ok01.png\'" onClick="hiddenBOX()" style="cursor:pointer"/>';
    document.getElementById("errDiv_bt").innerHTML= bt ;
    location=url;
}

function showBlack(str)
{
  //将弹窗hidden
    document.getElementById("black").style.display='';
    document.getElementById("black").style.zIndex='999';
}
function hiddenBOX()
{
  //将弹窗hidden
    document.getElementById("boxnote").style.display='none';
     if( document.getElementById("showErrorInfo") )
    {
    document.getElementById("showErrorInfo").innerHTML='';
    }
    if( document.getElementById("tishiyuyan") )
    {
    document.getElementById("tishiyuyan").innerHTML='';
    }

    document.getElementById("black").style.display='none';
    document.getElementById("black").style.zIndex='-1';
    document.getElementById("boxnote").style.zIndex='-1';

  var bt = '<img src="'+getCurrentDirectory()+'images/boxnote-ok01.png" name="boxrightfinish" id="boxrightfinish" onmouseover="boxrightfinish.src=\''+getCurrentDirectory()+'images/boxnote-ok02.png\'" onmouseout="boxrightfinish.src=\''+getCurrentDirectory()+'images/boxnote-ok01.png\'" onClick="hiddenBOX()" style="cursor:pointer"/>';
  document.getElementById("errDiv_bt").innerHTML= bt ;
}

function getSelect_Value(obj_id)
{
var obj = document.getElementById(obj_id); //selectid
var index = obj.selectedIndex; // 选中索引
if(index>=0)
{
  var value = obj.options[index].value; // 选中值
  return(value);
}else
{
  return "";
}
}

function getSelect_Text(obj_id)
{
var obj = document.getElementById(obj_id); //selectid
var index = obj.selectedIndex; // 选中索引
if(index>=0)
{
  var value = obj.options[index].text; // 选中值
  return(value);
}else
{
  return "";
}
}

function getRadioValue(radioname)
{
  var obj = document.getElementsByName(radioname);
  for(var i=0;i<obj.length;i++)
  {
    if (obj[i].checked)
    {
      return obj[i].value;
    }
  }
  return "";
}
function setRadioValue(radioname,radiovalue)
{
  var obj = document.getElementsByName(radioname);
  for(var i=0;i<obj.length;i++)
  {
      if( obj[i].value == radiovalue)
      {
      obj[i].checked = true;
      }

  }
  return "";
}