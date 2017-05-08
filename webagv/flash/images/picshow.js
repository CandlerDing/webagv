	function getid(o){ return (typeof o == "object")?o:document.getElementById(o);}
	function getNames(obj,tij)
	{
		var plist = getid(obj).getElementsByTagName(tij);
		/*var rlist = new Array();
		for(i=0;i<plist.length; ++i){if(plist[i].getAttribute("name") == name){rlist[rlist.length] = plist[i];}}*/
		return plist;
	}

	function fiterplay(obj,num,t,c1,c2)
	{
		var fitlist = getNames(obj,t);
		for(i=0;i<fitlist.length;++i)
		{
			if(i == num)
			{
				fitlist[i].className = c1;
			}
			else
			{
				fitlist[i].className = c2;
			}
		}
	}
	function play(obj,num)
	{
		var s = getid('simg');
		var i = getid('info2');
		var b = getid('bimg');
		try	
		{
			with(b)
			{
				filters[0].Apply();	
				fiterplay(b,num,"div","dis","undis");	
				fiterplay(s,num,"div","","f1");
				fiterplay(i,num,"div","dis","undis");
				filters[0].play();
			}
		}
		catch(e)
		{
				fiterplay(b,num,"div","dis","undis");
				fiterplay(s,num,"div","","f1");	
				fiterplay(i,num,"div","dis","undis");
		}
	}

	var autoStart = 0;
	var n = 0;		var s = getid("simg");
		var x = getNames(s,"div");
	function clearAuto() {clearInterval(autoStart);};
	function setAuto(){autoStart=setInterval("auto(n)", 3000)}
	function auto()	{


		n++  ;
		if(n>(x.length-1))
		{ n = 0;
		//clearAuto();
		 }
		play(x[n],n);
		
	}
	function ppp(){
	setAuto();
	
	}
ppp();