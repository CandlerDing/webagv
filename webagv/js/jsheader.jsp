<script>
var ClsScreen = {
	getPageWidth: function()
	{
		return document.documentElement.scrollWidth || document.body.scrollWidth || 0;
	},

	getPageHeight: function()
	{
		return document.documentElement.scrollHeight || document.body.scrollHeight || 0;
	},

	getBodyWidth: function()
	{
		return document.documentElement.clientWidth || document.body.clientWidth || 0;
	},

	getBodyHeight: function()
	{
		return document.documentElement.clientHeight || document.body.clientHeight || 0;
	},

	getBodyLeft: function()
	{
		return window.pageXOffset || document.documentElement.scrollLeft || document.body.scrollLeft || 0;
	},

	getBodyTop: function()
	{
		return window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
	},

	getBody: function()
	{
		return {
			width	: this.getBodyWidth(),
			height	: this.getBodyHeight(),
			left	: this.getBodyLeft(),
			top	: this.getBodyTop()
		};
	},

	getScreenWidth: function()
	{
		return window.screen.width;
	},

	getScreenHeight: function()
	{
		return window.screen.height;
	}
};
 function getCurrentDirectory(){
	var locArray=location.pathname.split("/")
	locArray.pop()
  delete locArray[locArray.length-1];
  var dirTxt = locArray.join("/");
  return dirTxt;
}
var CurrentDirectory = getCurrentDirectory();
var GBasePath = "<%=com.software.common.HeadConst.root_url_path%>";
var GResPath = "<%=com.software.common.HeadConst.apache_url%>";
var GImagePath = "<%=com.software.common.HeadConst.apache_url%>/images/default";</script>
<iframe  width="0" height="0"></iframe>
