<!--#include file="inc/conn.asp"--><%host=lcase(request.servervariables("HTTP_HOST"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<title><%=title%></title>
<meta name="author" content="yujianyue, admin@ewuyi.net">
<meta name="copyright" content="www.12391.net">
<script type="text/javascript" src="inc/js/Ajax_Web.js"></script>
<link href="inc/css/New_Web.css" rel="stylesheet" type="text/css" />
<body onLoad="inst();">
<div class="sub_bod"></div>
<div class="sub_top">
 <div class="title"><%=title%></div>
 <!---div class="back" id="pageback"><a href="index.asp" class="d">返回</a></div---> 
 <!---<div class="menu" id="topmenus"><a href="admin/" class="d">后台</a></div>--->
</div><div class="main">
<%
startime=timer()
duansss="请输入你的"&duan
mamasss="请输入4数字验证码"

'#	方案1:直接通过设定的（1-3个）查询条件查询
'#	免费即时开通:http://add.12391.net/ 
'#	视频教程下载:http://pan.baidu.com/s/1eSoDn26 
'#	代码购买:https://item.taobao.com/item.htm?id=528692002051 
'#	整体服务:https://item.taobao.com/item.htm?id=520023732507 

names=""&trim(request("name"))&""
codes=""&trim(request("code"))&""
times=""&trim(request("time"))&""

newtime = DateDiff("s","1970-1-1 0:0:0",Now())
if times="" then
%><form name="queryForm" method="post" class="" action="?a=<%=newtime%>" onsubmit="return startRequest(0);">
<div class="select" id="10">
<select name="time" id="time" onBlur="startRequest(1)" />
<%
'调用函数并输出结果集 
Dim rs 
Set rs = getSortedFiles(Server.MapPath(""&UpDir&"/")) 
While Not rs.EOF
 EditFile=rs("Name") 
if right(EditFile,len(mdbtype))=mdbtype then
 ii=ii+1
 timefile=left(EditFile,len(EditFile)-len(mdbtype))
 response.write "<option value="""&timefile&""">"&timefile&"</option>"&vbcrlf
end if
 rs.MoveNext 
Wend 
if ii<1 then
 response.write "<option value="""">管理员尚未上传数据哦</option>"&vbcrlf
end if
rs.Close 
Set rs = Nothing 
%></select></div>
<div class="so_box" id="11">
<input name="name" type="text" class="txts" id="name" value="<%=duansss%>" placeholder="<%=duansss%>" onfocus="st('name',1)" onBlur="startRequest(2)" />
</div>
<%if yanzhenma="1" then
mamas="+验证码"%>
<div class="so_box" id="33">
<input name="code" type="text" class="txts" id="code" value="<%=mamasss%>" placeholder="<%=mamasss%>" onfocus="this.value=''" onBlur="startRequest(3)" />
<div class="more" id="clearkey">
<img src="inc/Code.asp?t=<%=timer%>" id="Codes" onClick="this.src='inc/Code.asp?t='+new Date();"/>
</div></div><%end if%>
<div class="so_boxes">
<input type="submit" name="button" class="buts" id="sub" value="立即查询" />
</div>
<div class="so_boxex" id="tishi"><strong>相关说明: </strong>
<%=duan%><%=mamas%>都输入正确才显示相应结果。
<!---你的其他说明在这里添加：开始--->
<!---你的其他说明在这里添加：结束--->
</div>
<div id="tishi1" style="display:none;"><%=duansss%></div>
<div id="tishi4" style="display:none;"><%=mamasss%></div>
</form>
<%
else
datas=""&UpDir&"/"&times&""&mdbtype

if yanzhenma="1" then
if len(codes)<>4 or codes<>Session("GetCode") Then
 call AlertBack("请输入正确的验证码哦！") 
End if
end if

if filekey(times)>0 then
 call AlertBack("请检查连接字串！")
end if

if len(names)<1 and len(names)>18 Then
 call AlertBack("请输入"&duan&"！") 
End if

if IsFile(datas)=True then
else
 call AlertBack("数据暂时没有上传或者不存在哦！") 
end if

nameses="<ha>" & names & "</ha>"
if IsFile(datas)=True then
 Response.Write ""&vbcrlf
else
 call AlertBack("数据暂时没有上传或者不存在哦！"&datas) 
end if

Dim Fso2
Dim myFile2
Set Fso2 = Server.CreateObject("Scripting.FileSystemObject")
Set myFile2 = Fso2.OpenTextFile(Server.MapPath(datas),1,True)
Response.Write "<!--startprint--><table cellspacing=""0"">"&vbcrlf
 Response.Write "<caption align='center'>查询结果</caption>"&vbcrlf
While Not myFile2.AtEndOfStream
 shuju = myFile2.ReadLine
 zhide=split(shuju,VbTab)
 numde=Ubound(zhide)
iii=iii+1
if iii=1 then '找到第一列的标题
	line1=shuju
  Response.Write "<tr class=""tt"">"&vbcrlf
 For xW2T=0 To numde
  Response.Write "<td>" & zhide(xW2T) & "</td>"&vbcrlf
 if tiaojian1=zhide(xW2T) and len(tiaojian1)>0 then
 dian=xW2T '查找列数
 end if
 Next
  Response.Write "</tr>"&vbcrlf
if len(dian)=0 and len(duan)>0 then
 call AlertBack("请检查你设置的字段["&duan&"]是否存在！")
end if

else
sssss="<ha>"&zhide(dian)&"</ha>"
if instr(sssss,nameses)>0 then 
yyy=yyy+1
      Response.Write "<tr>"&vbcrlf
 For xW2T=0 To numde
 curValue = trim(zhide(xW2T))
 If IsNull(curValue) or len(curValue)<1 Then
  curValue="-"
 End If
 curValue = CStr(curValue)
Response.Write "<td >" & curValue & "</td>"&vbcrlf
Next
 Response.Write "</tr>"&vbcrlf
end if
end if 
Wend
'#############################################################
'#作者邮箱: admin@ewuyi.net                                  #
'#作者主页: http://buy.ewuyi.net/                            #
'#系统定制：http://aiyaha.taobao.com			     #
'#############################################################
myFile2.Close
Set myFile2 = Nothing
Set Fso2 = Nothing
if yyy<1 then

 Response.Write "<tr>"&vbcrlf
 Response.Write "<td colspan="""&xW2T+1&""" align=""center"">"&vbcrlf
 Response.Write "<span>查询结果不存在！请核实你的输入是否正确。</span></td>"&vbcrlf
 Response.Write "</tr>"&vbcrlf

end if
Response.Write "</table><!--endprint-->"&vbcrlf
%><div class="so_boxexe">
<input type="button" name="print" value="预览并打印" onclick="preview()" class="buts">
<input type="button" value="返 回" class="buts" onclick="location.href='index.asp';" id="reset"></div>
<%end if
endtime=timer()%></div>
<div class="foot">
 <div class="title">
 <span>&copy;<%=year(now)%>&nbsp; <a href="<%=copysu%>" target="_blank"><%=copysr%></a>
 <!---更多版本请看:http://test.96448.cn/--->
 <a href="http://aiyaha.taobao.com/" target="_blank">技术支持</a></span>
<!---

页面执行时间：<%=FormatNumber((endtime-startime)*1000,3)%>毫秒

务必保留以下信息：

免费开通：http://add.12391.net [个人小用户免费]
无偿赞助：yujianyue@126.com (支付宝账号)
商用付费：https://aiyaha.taobao.com
应急联系：15058593138 （故障报修+快速提问）

--->
 </div>
</div>
</body>
</html><script type="text/javascript" src="../index_cha.js?v=ADA_W3T"></script>