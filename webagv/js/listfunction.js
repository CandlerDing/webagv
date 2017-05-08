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
function selectAll(cbx)
{
    var chks = document.getElementsByName("chk1");
    for (var i = 0; i < chks.length; i ++) {   //当前页面上有多条记录时
        chks[i].checked = cbx.checked;
    }
}
function deleteList(className, url_para)
{
    var chks = document.getElementsByName("chk1");
    if (!url_para)
        url_para = "";
    var chkeds = new Array();
    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
        if (chks[i].checked == true) {
            chkeds.push(chks[i].value);
        }
    }
    if (chkeds.length > 0) {
        if (confirm("确实要删除这些记录吗?")) {
            location = className + "Action.jsp?cmd=deletelist&idlist=" + chkeds.join(',') + ((url_para.length == 0) ? "" : "&" + url_para);
        }
    } else {
        alert("未选择记录！");
    }
}
function addNew(className, url_para)
{
    if (!url_para)
        url_para = "";
    location = className + "Action.jsp?cmd=create" + ((url_para.length == 0) ? "" : "&" + url_para);
}
function importNew(className)
{
    location = className + "Action.jsp?cmd=list";
}
function imp(className)
{
    var chks = document.getElementsByName("chk1");
    var chkeds = new Array();
    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
        if (chks[i].checked == true) {
            chkeds.push(chks[i].value);
        }
    }
    if (chkeds.length > 0) {
        if (confirm("确实要导入这些记录吗?")) {
            location = className + "Action.jsp?cmd=imp&idlist=" + chkeds.join(',');
        }
    } else {
        alert("未选择记录！");
    }
}
function cmd_change_page(url_para, currpage, lastpage)
{
    var page = document.getElementById('changepageinput');
    if (page.value > 0 && page.value <= lastpage )
        self.location = url_para + page.value;
    else
        page.value = currpage;
}
function getIdList(type1)
{
    var chks = document.getElementsByName("chk1");
    var chkeds = new Array();
    var flag=0;
    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
        if (chks[i].checked == true) {
            flag=1;
            chkeds.push(chks[i].value);
        }
    }
    if(flag==0) {
        return "-1";  //没有选择行
    } else {
        if(type1==0)
            return chkeds[0];
        else
            return chkeds.join(',');
    }
}

function getFieldIndex(fstr) {
    for (var i = 0; i < allfields.length; i ++) {
        if (fstr == allfields[i]) {
            return i;
        }
    }
    return 0;
}

var asc_desc = {"asc": "desc", "desc": "asc"};
var curr_orderby;

function setOrderBy(fieldname) {
    if (curr_orderby == undefined) {
        return;
    }
    if (curr_orderby[0] == fieldname) {
        curr_orderby[1] = asc_desc[curr_orderby[1]];
    } else {
        curr_orderby = [fieldname, "asc"];
    }
    var arr = window.location.toString().split('&');
    var hasOrder = false;
    for (var i = 0; i < arr.length; i ++) {
        if (i ==0) continue;
        var subarr = arr[i].split('=');
        if (subarr[0] == 'orderfield') {
            hasOrder = true;
            arr[i] = "orderfield=" + curr_orderby[0];
        }
        if (subarr[0] == 'ordertype') {
            hasOrder = true;
            arr[i] = "ordertype=" + curr_orderby[1];
        }
    }
    if (!hasOrder) {
        arr[arr.length] = "orderfield=" + curr_orderby[0];
        arr[arr.length] = "ordertype=" + curr_orderby[1];
    }
    if (arr[0].indexOf('?') == -1) {
        arr[0] = arr[0] + "?cmd=list";
    }
    window.location = arr.join('&');
}

var order_image = {"asc": GBasePath+"/images/black-down-arrow.gif", "desc": GBasePath+"/images/black-up-arrow.gif"};
var data_align = {"string": "left", "int": "right", "double": "right", "date": "left", "control": "center"};

function showList(className, currpage, url_para) {
    var getRow = function (str, dalign) {
        if (str == "" || str == "null") str = "&nbsp;";
        if (dalign == "" || dalign == "null") dalign = "control";
        return "<td align='" + data_align[dalign] + "'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr class=title_bgcolor>\n";
    str = str + "<td align='center' width=\"16\"><input type=\"checkbox\" onclick=\"selectAll(this);\" onchange=\"selectAll(this);\"></td>\n";
    for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td align='center' onclick=\"javascript:setOrderBy('" + fields[i] + "')\" class=\"button\">" + dic[fields[i]][1];
        if (curr_orderby != undefined) {
            if (curr_orderby[0] == fields[i]) {
                str = str + "<img src=\"" + order_image[curr_orderby[1]] + "\">";
            }
        }
        str = str + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
    str = str + "<td align='left' width=\"16\"><img src=\""+GBasePath+"/images/default/edit.gif\" id=\"icon_edit\"></td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
            }
            str = str + getRow("<img class=\"button\" src=\""+GBasePath+"/images/default/edit.gif\" onclick=\"javascript:window.location='" + className + "Action.jsp?cmd=modify&Id=" + rows[i][keyindex] + "&page=" + currpage + ((url_para.length == 0) ? "" : "&" + url_para) + "'\">", color);
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}
function showList1(className, currpage, url_para) {
    var getRow = function (str, dalign) {
        if (str == "" || str == "null") str = "&nbsp;";
        if (dalign == "" || dalign == "null") dalign = "control";
      //  return "<td width=\"75\" align='center'><a title=\"点开察看详细内容\" style=\"text-overflow:ellipsis; \" href = \"XinFangAction.jsp?cmd=modify&Id="+ rows[i][keyindex] +"\">" + str + "</a></td>\n";
        return "<td width=\"70\" align='center'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table id=\"tb\" border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr  class=title_bgcolor>\n";
   // str = str + "<td align='center' width=\"16\"><input type=\"checkbox\" onclick=\"selectAll(this);\" onchange=\"selectAll(this);\"></td>\n";
    for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td width=\"70\" align='center' onclick=\"javascript:setOrderBy('" + fields[i] + "')\" class=\"button\">" + dic[fields[i]][1];
        if (curr_orderby != undefined) {
            if (curr_orderby[0] == fields[i]) {
                str = str + "<img src=\"" + order_image[curr_orderby[1]] + "\">";
            }
        }
        str = str + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
   // str = str + "<td align='left' width=\"16\"><img src=\""+GBasePath+"/images/default/edit.gif\" id=\"icon_edit\"></td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
//             str = str + "<a href = \"XinFangAction.jsp?cmd=jiefang&Id="+ rows[i][keyindex] +"\"><tr   class=" + color + ">\n";
   str = str + "<a href = \"XinFangAction.jsp?cmd=modify2&Id="+ rows[i][keyindex] +"\"><tr class=" + color + " onMouseOver=\"$(this).removeClass('"+ color +"');$(this).addClass('title_bgcolor');\" onMouseOut=\"$(this).removeClass('title_bgcolor');$(this).addClass('"+ color +"')\">\n";

            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
            }
            str = str + "</tr></a>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}
function showListReport(className, currpage, url_para) {
    var getRow = function (str, dalign) {
        if (str == "" || str == "null") str = "&nbsp;";
        if (dalign == "" || dalign == "null") dalign = "control";
        return "<td align='" + data_align[dalign] + "'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr class=title_bgcolor>\n";
    str = str + "<td align='center' width=\"16\"><input type=\"checkbox\" onclick=\"selectAll(this);\" onchange=\"selectAll(this);\"></td>\n";
    for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td align='center' onclick=\"javascript:setOrderBy('" + fields[i] + "')\" class=\"button\">" + dic[fields[i]][1];
        if (curr_orderby != undefined) {
            if (curr_orderby[0] == fields[i]) {
                str = str + "<img src=\"" + order_image[curr_orderby[1]] + "\">";
            }
        }
        str = str + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                if(j>4){
                str = str + getRow(rows[i][k], 'control');
                }
                else{
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
                 }
            }
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}
function showListReport2(className, currpage, url_para) {
    var getRow = function (str, dalign) {
        if (str == "" || str == "null") str = "&nbsp;";
        if (dalign == "" || dalign == "null") dalign = "control";
        return "<td align='" + data_align[dalign] + "'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n";
   
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            //str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                if(j>4){
                str = str + getRow(rows[i][k], 'control');
                }
                else{
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
                 }
            }
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
   // alert(str);
    document.getElementById("list").innerHTML = str;
}
//显示公告列表
function showBroadList(className, currpage, url_para ,view){
    var getRow = function (str) {
        if (str == "" || str == "null") str = "&nbsp;";
        return "<td align='center'>" + str + "</td>\n";
    };
    var showfields = new Array();
//    var keyindex = getFieldIndex(keyfield); 20080814
    var keyindex = getFieldIndex(fields);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr class=title_bgcolor>\n";
    str = str + "<td align='center' width=\"16\"><input type=\"checkbox\" onclick=\"selectAll(this);\" onchange=\"selectAll(this);\"></td>\n";
    for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td align='center'>" + dic[fields[i]][1] + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
    str = str + "<td align='center' width=\"16\"><img src=\""+GBasePath+"/images/default/edit.gif\"></td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />", color);
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k]);
            }
            if(view=="false")
            	str = str + getRow("<img class=\"button\" src=\""+GBasePath+"/images/default/edit.gif\" onclick=\"javascript:window.location='" + className + "Action.jsp?cmd=modify&Id=" + rows[i][keyindex] + "&page=" + currpage + ((url_para.length == 0) ? "" : "&" + url_para) + "'\" title='修改'>", color);
            else
            	str = str + getRow("-", color);
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}
//打开窗口2005.7.7.add by xxy
function openshow(link1)
{

    openwin=window.open(link1 , "link1", "top=58,left=200,width=600,height=500,status=no,toolbar=no,menubar=no,scrollbars=yes, resizable=yes");

}
function openListAttach(link1)
{

    openwin=window.open(link1 , "link2", "top=58,left=200,width=460,height=260,status=no,toolbar=no,menubar=no,scrollbars=yes, resizable=yes");

}

/**
*add by wyp
*/
function showListFilenoCode(className, currpage, url){
    var getRow = function (str) {
        if (str == "" || str == "null") str = "&nbsp;";
        return "<td align='center'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr class=title_bgcolor>\n";
     for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td align='center'>" + dic[fields[i]][1] + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
    str = str + "<td align='center' width=\"16\">选择</td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + showfields.length + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k]);
            }
            str = str + getRow("<img class=\"button\" src=\""+GBasePath+"/images/default/edit.gif\" onclick=\"javascript:selectFilenoCode('"+ rows[i][2] + "')\">", color);//传递参数
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}

//解决cell控件因XP升级产生的激活问题
function insertCell(elm,base, w, h)
{
 if (!document.getElementById(elm)) return;
 var str = '';
 str += '<object id=cell width="'+ w +'" height="'+ h +'" classid="CLSID:3F166327-8030-4881-8BD2-EA25350E574A" codebase="'+base+'">';
 str += '</object>';
 document.getElementById(elm).innerHTML = str;
}
function insertCell1(elm,base, w, h,name)
{
 if (!document.getElementById(elm)) return;
 var str = '';
 str += '<object id=';
 str += name+' width="'+ w +'" height="'+ h +'" classid="CLSID:3F166327-8030-4881-8BD2-EA25350E574A" codebase="'+base+'">';
 str += '</object>';
 document.getElementById(elm).innerHTML = str;
}


function setCookie(name,value,expiry,path,domain,secure)
{
    var nameString = name + "=" + value;
    var expiryString = (expiry == null) ? "" : " ;expires = "+ expiry.toGMTString();
    var pathString = (path == null) ? "" : " ;path = "+ path;
    var domainString = (path == null) ? "" : " ;domain = "+ domain;
    var secureString = (secure) ?";secure" :"";
    //alert(nameString + expiryString + pathString + domainString + secureString);
    document.cookie = nameString + expiryString + pathString + domainString + secureString;
}

function getCookie (name)
 {
   var CookieFound = false;
   var start = 0;
   var end = 0;
   var CookieString = documents.cookie;
   var i = 0;
   while (i <= CookieString.length)
   {
     start = i ;
     end = start + name.length;
     if (CookieString.substring(start, end) == name)
     {
       CookieFound = true;
       break;
     }
     i++;
    }

   if (CookieFound)
   {
     start = end + 1;
     end = CookieString.indexOf(";",start);
     if (end < start)
       end = CookieString.length;
     return unescape(CookieString.substring(start, end));
   }
     return "";
}

function deleteCookie(name)
{
  //document.cookie = name + "=" + escape("-") + "; expires=Fri, 31 Dec 1999 23:59:59 GMT;";

  /*
  var expires = new Date();
  expires.setTime (expires.getTime() - 2);
  setCookie( name , "Delete Cookie", expires,null,null,false);
  */
}


	function   lib_bwcheck(){
  this.ver=navigator.appVersion;
  this.agent=navigator.userAgent
  this.dom=document.getElementById?1:0
  this.win   =   (navigator.appVersion.indexOf("Win")>0);
                  this.xwin   =   (navigator.appVersion.indexOf("X11")>0);
  this.ie5=(this.ver.indexOf("MSIE   5")>-1   &&   this.dom)?1:0;
  this.ie6=(this.ver.indexOf("MSIE   6")>-1   &&   this.dom)?1:0;
  this.ie4=(document.all   &&   !this.dom)?1:0;
  this.ie=this.ie4||this.ie5||this.ie6
  this.mac=this.agent.indexOf("Mac")>-1
  this.opera5=this.agent.indexOf("Opera   5")>-1
  this.ns6=(this.dom   &&   parseInt(this.ver)   >=   5)   ?1:0;
  this.ns4=(document.layers   &&   !this.dom)?1:0;
  this.bw=(this.ie6   ||   this.ie5   ||   this.ie4   ||   this.ns4   ||   this.ns6   ||   this.opera5   ||   this.dom||false);
                  this.width   =   null;
                  this.height   =   null;
  return   this
  }
  function   getObjectById(   ID   )   {
                                  var   bw   =   new   lib_bwcheck();
  if   (bw.ns6)   return   document.getElementById(ID);
  else   if   (bw.ns)   return   document.layers[ID];
  else   return   document.all[ID];
  }
function showhidden(s)
{
  if($(s).style.display=='none')
 { $(s).style.display='';
 }
 else
{ $(s).style.display='none';}
}


function openWait(undixLayer)
{
	$('rShowContent').style.top  = ClsScreen.getBodyTop() + 120;
	$('rShowContent').style.left = document.documentElement.scrollLeft + (document.documentElement.scrollWidth - 600)/2;
	$('rLayer').style.height = document.documentElement.scrollHeight+'px';
	$('rLayer').oncontextmenu = function(){return false};
	$('rLayer').className = 'dis';
	$('rShowContent').className= 'dis';
        if(undixLayer.length>0)
        {
        var lays = undixLayer.split(",") ;

        for(var i=0;i<lays.length;i++)
        $(lays[i]).style.display= 'none';
        }
}

function closeWait(undixLayer)
{
	if (!$('rLayer')){ return;}
	$('rLayer').oncontextmenu = function(){ return true };
	$('rLayer').className = 'undis';
	$('rShowContent').className = 'undis';
        $('sCont').innerHTML="";
        if(undixLayer.length>0)
        {
        var lays = undixLayer.split(",") ;
        for(var i=0;i<lays.length;i++)
        $(lays[i]).style.display= 'block';
        }
}
//
//javascript版本的FormatNumber函数/
//第一个参数是待格式化的数值，第二个是保留小数位数
function adv_format(value,num) //四舍五入
{
var a_str = formatnumber(value,num);
var a_int = parseFloat(a_str);
if (value.toString().length>a_str.length)
{
var b_str = value.toString().substring(a_str.length,a_str.length+1)
var b_int = parseFloat(b_str);
if (b_int<5)
{
return a_str
}
else
{
var bonus_str,bonus_int;
if (num==0)
{
bonus_int = 1;
}
else
{
bonus_str = "0."
for (var i=1; i<num; i++)
bonus_str+="0";
bonus_str+="1";
bonus_int = parseFloat(bonus_str);
}
a_str = formatnumber(a_int + bonus_int, num)
}
}
return a_str
}

function formatnumber(value,num) //直接去尾
{
var a,b,c,i
a = value.toString();
b = a.indexOf('.');
c = a.length;
if (num==0)
{
if (b!=-1)
a = a.substring(0,b);
}
else
{
if (b==-1)
{
a = a + ".";
for (i=1;i<=num;i++)
a = a + "0";
}
else
{
a = a.substring(0,b+num+1);
for (i=c;i<=b+num;i++)
a = a + "0";
}
}
return a
}

