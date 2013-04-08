<%@ page language="java" contentType="text/html;"
    pageEncoding="utf-8"%>  
 <%@page language="java" import="com.boryou.entity.*"%>   
  <%@page language="java" import="com.boryou.util.*"%>  
<%@ page isELIgnored="false"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
BOrderUser user=(BOrderUser)request.getSession().getAttribute(Constant4Web.USER);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/global.css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/boryou/css/boryou.css" />
<script type="text/javascript" src="<%=path %>/boryou/js/AjaxObject.js"></script>
<title>ifan</title>
<script type="text/javascript">

</script>

<script type="text/javascript">

 function isOldPwdTrue(userName,oldPwd){
            var isExists = false;
			var url = "<%=path%>/boryou/user_checkOldPwd.action";
			var info = "userName="+userName;
			info+="&oldPwd="+oldPwd;
			// 进行 Ajax 请求
			var ajax = new Ajax(url, "POST", false, info);
			ajax.dealResult = function(result) {
				//alert("result=" + result);
				if (result) {
					if (result.indexOf("true") != -1) {
						isExists = true;
					} else {
						isExists = false;
					}
				}
			};
			ajax.executeRequest();
			return isExists;
   }


var regexUserPs = /^[A-Za-z0-9]{6,10}$/;
function updatePwd(){
    var oldPwd=document.getElementById("oldPwd").value;
    var newPwd=document.getElementById("newPwd").value;
    var userName=document.getElementById("userName").value;
    var checkTips=document.getElementById("checkTips");
    if(!regexUserPs.exec(oldPwd)){
        checkTips.innerHTML="原密码格式不正确";
        return false;
    }else if(oldPwd==newPwd){
        checkTips.innerHTML="新密码与原密码不能一致";
        return false;
    }else if(!isOldPwdTrue(userName,oldPwd)){
        checkTips.innerHTML="原密码不正确";
        return false;
    }else if(!regexUserPs.exec(newPwd)){
        checkTips.innerHTML="新密码只能输入6-10个字母、数字";
        return false;
    }else{
        if(isUpdateSuccess(userName,newPwd)){
            alert("修改成功,请重新登录");
            window.top.location.href="<%=path%>/boryou/login.jsp";
        }else{
           alert("修改失败,重新登录后再试");
        }
    }
}

 function isUpdateSuccess(userName,newPwd){
            var isExists = false;
			var url = "<%=path%>/boryou/user_updatePwd.action";
			var info = "userName="+userName;
			info+="&newPwd="+newPwd;
			// 进行 Ajax 请求
			var ajax = new Ajax(url, "POST", false, info);
			ajax.dealResult = function(result) {
				//alert("result=" + result);
				if (result) {
					if (result.indexOf("true") != -1) {
						isExists = true;
					} else {
						isExists = false;
					}
				}
			};
			ajax.executeRequest();
			return isExists;
   }
   
var regexEmail = /^[\w-]+@[\w-]+(\.[\w-]+)+$/;
function updateEmail(){
   var newEmail = document.getElementById("newEmail").value;
   var checkTips=document.getElementById("checkTips");
   if(!regexEmail.exec(newEmail)){
	    checkTips.innerHTML="*邮箱格式不正确";
	    return false;
   }else if(isExistsEmail(newEmail)){
        checkTips.innerHTML="*该邮箱已被注册";
	    return false;
   }else{
        document.forms["updatePwdForm"].action="<%=path%>/boryou/user_updateEmail.action";
        document.forms["updatePwdForm"].submit();
   }
}

function isExistsEmail(userEmail){
            var isExists = true;
			var url = "<%=path%>/boryou/user_isExistEmail.action";
			var info = "userEmail="+userEmail;
			// 进行 Ajax 请求
			var ajax = new Ajax(url, "POST", false, info);
			ajax.dealResult = function(result) {
				if (result) {
					if (result.indexOf("true") != -1) {
						isExists = true;
					} else {
						isExists = false;
					}
				}
			};
			ajax.executeRequest();
			return isExists;
   }
   
var user_name=/^[a-zA-Z]{2,15}$/; 

function accessUser(){
   var checkTips=document.getElementById("checkTips");
   var userName = document.getElementById("user4update").value;
   if(!user_name.exec(userName)){
       checkTips.innerHTML = "用户名不合法";
       return false;
   }
   else if(!isExistsUserName(userName)){
       checkTips.innerHTML = "用户名不存在";
       return false;
   }
   else{
       document.forms["updatePwdForm"].action="<%=path%>/boryou/user_access.action";
       document.forms["updatePwdForm"].submit();
   }
}

function isExistsUserName(userName){
            var isExists = true;
			var url = "<%=path%>/isExistsServlet";
			var info = "userName="+userName;
			// 进行 Ajax 请求
			var ajax = new Ajax(url, "POST", false, info);
			ajax.dealResult = function(result) {
				if (result) {
					if (result.indexOf("true") != -1) {
						isExists = true;
					} else {
						isExists = false;
					}
				}
			};
			ajax.executeRequest();
			return isExists;
   }
   

</script>
</head>
<body>
<div class="oarcont">
<div class="oartop">用户管理</div>
<table border="0" cellspacing="0" cellpadding="0" class="rtable2" width="100%">
<tr>
	<td valign="top">
	
	<div class="rnavtable6" style="margin-top:0px;">
	<div class="rtabcont2">
	<form id="updatePwdForm" method="post">
	<div><font id="checkTips" color="red">*</font>
	<font color="red">${requestScope.message }</font>
	
	</div>
		<table width="80%" border="1" cellspacing="0" cellpadding="0" >
		 <input type="hidden" id="userName" name="userName" value="${sessionScope.USER.userName }" />
		   <tr class="tt">
		    <td class="f14" colspan="2">个人设置:</td>
		  </tr>
		  <tr>
		    <td width="22%" class="f14">原密码：</td>
		    <td  width="50%">
		    <input type="password" id="oldPwd" name="oldPwd" />
		     
		    </td>
		    </tr>
		    <tr>
		    <td class="f14">新密码：</td>
		    <td>
		     <input type="password" id="newPwd" name="newPwd" />
		    </td>
		  </tr>
		  <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		      <input type="button" value="修改密码" onclick="updatePwd()" />　
		    </td>
		  </tr>
		  <tr><td colspan="2"></td></tr>
		  <tr>
		    <td class="f14">邮箱：</td>
		    <td>
		     <input type="text" id="newEmail" name="newEmail" value="${requestScope.oldEmail }" />
		    </td>
		  </tr>
		    <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		      <input type="button" value="修改邮箱" onclick="updateEmail()" />　
		    </td>
		  </tr>
		  <%if(user != null && user.getTypeId() < 3){ %>
		  <tr><td colspan="2"></td></tr>
		  <tr>
		    <td class="f14">授权用户：</td>
		    <td>
		     <input type="text" id="user4update" name="user4update" />
		    </td>
		  </tr>
		  <tr>
		    <td class="f14">授权为：</td>
		    <td>
		     <select name="accessTypeId" >
		     <option value = "2">管理员</option>
		     <option value = "3">普通用户</option>
		     </select>
		    </td>
		  </tr>
		    <tr>
		    <td class="f14">&nbsp;</td>
		    <td>
		      <input type="button" value="授权" onclick="accessUser()" />　
		    </td>
		  </tr>
		  <%} %>
		</table>
		</form>
	</div>
	</td>
	</tr></table>
	</div>
</body>
</html>