

function isIdCardNo() 
{   var num = document.getElementById("XFRSFZH").value;
          num = num.toUpperCase();  
         //���֤����Ϊ15λ����18λ��15λʱȫΪ���֣�18λǰ17λΪ���֣����һλ��У��λ������Ϊ���ֻ��ַ�X��   
          if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num)))   
          { 
               alert('��������֤�ų��Ȳ��ԣ����ߺ��벻���Ϲ涨��\n15λ����ӦȫΪ���֣�18λ����ĩλ����Ϊ���ֻ�X��'); 
              return false; 
         } 
//У��λ����ISO 7064:1983.MOD 11-2�Ĺ涨���ɣ�X������Ϊ������10�� 
//����ֱ�����������ں�У��λ 
var len, re; 
len = num.length; 
if (len == 15) 
{ 
re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/); 
var arrSplit = num.match(re); 
 
//������������Ƿ���ȷ 
var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]); 
var bGoodDay; 
bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
if (!bGoodDay) 
{ 
          alert('��������֤����������ڲ��ԣ�');   
           return false; 
} 
else 
{ 
//��15λ���֤ת��18λ 
//У��λ����ISO 7064:1983.MOD 11-2�Ĺ涨���ɣ�X������Ϊ������10�� 
          var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
           var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
           var nTemp = 0, i;   
            num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6); 
           for(i = 0; i < 17; i ++) 
          { 
                nTemp += num.substr(i, 1) * arrInt[i]; 
           } 
           num += arrCh[nTemp % 11];   
            return num;   
}   
} 
if (len == 18) 
{ 
re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/); 
var arrSplit = num.match(re); 
 
//������������Ƿ���ȷ 
var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]); 
var bGoodDay; 
bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
if (!bGoodDay) 
{ 

alert('��������֤����������ڲ��ԣ�'); 
return false; 
} 
else 
{ 
//����18λ���֤��У�����Ƿ���ȷ�� 
//У��λ����ISO 7064:1983.MOD 11-2�Ĺ涨���ɣ�X������Ϊ������10�� 
var valnum; 
var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
var nTemp = 0, i; 
for(i = 0; i < 17; i ++) 
{ 
nTemp += num.substr(i, 1) * arrInt[i]; 
} 
valnum = arrCh[nTemp % 11]; 
if (valnum != num.substr(17, 1)) 
{ 
alert('18λ���֤��У���벻��ȷ��Ӧ��Ϊ��' + valnum); 
return false; 
} 
return num; 
} 
} 
return false; 
}
