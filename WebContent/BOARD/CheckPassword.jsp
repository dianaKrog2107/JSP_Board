<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	int boardIdx = 0;
	String type = null;
	if(request.getParameter("boardIdx") != null){
		boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
	}
	if(request.getParameter("type") != null){
		type = request.getParameter("type");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비밀번호 체크</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script type="text/javascript">
    function sendPassword() {
        var pwd = document.getElementById('pwd').value;
        var url = window.location='Controller.jsp?boardIdx=' + <%=boardIdx%> + '&type=pwd';
        var type = "<%=type%>";
        var boardIdx = "<%=boardIdx%>";
        $.ajax({
            url: url,
            type: "POST",
            data: {password: pwd, next: type, boardIdx : boardIdx},
            success: function (data) {
            	 console.log(data);
            }
        });
    }
</script>
</head>
<body>
	<h4 style="padding-left:180px">비밀번호</h4>
	<table>
		<tr>
			<td><input type="password" id="pwd" size="50" maxlength="50"></td>
		</tr>
		<tr>
			<td><input type="button" value="확인" OnClick="sendPassword()">
		</td>
		</tr>
	</table>
</body>
</html>