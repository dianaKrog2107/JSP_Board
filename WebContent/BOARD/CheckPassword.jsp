<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	int boardIdx = 0;
	String next = null;
	if(request.getParameter("boardIdx") != null){
		boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
	}
	if(request.getParameter("type") != null){
		next = request.getParameter("type");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비밀번호 체크</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script type="text/javascript">
 $(function() {
		$("#sendPassword").click(function(e){
	        e.preventDefault();
			var pwd = document.getElementById('pwd').value;
			var next = "<%=next%>";
		    var url = 'Controller.jsp?boardIdx=' + <%=boardIdx%> + '&type=pwd';		    
		    $.ajax({
				url: url,
	            type: "POST",
	            datatype:"HTML",
	            data: {password: pwd, boardIdx: <%=boardIdx%>},
				success: function(args) {
					var num = $.trim(args).charAt(164);
					if(num == 0){
						if(next === "modify"){
							location.href="write.jsp?boardIdx=" + <%=boardIdx%>;
						}
						if(next === "delete"){
							alert("게시물을 삭제합니다");
							location.href='Controller.jsp?boardIdx=' + <%=boardIdx%> + '&type=delete';
						}
					}else if(num ==1){
						alert("비밀번호가 틀렸습니다.");
					}
				},
				error: function(){
					console.log("Connection Failed");
				}
			});
		});
	});
</script>
</head>
<body>
<!-- input type="hidden"으로 수정하기 -->
	<h4 style="padding-left:180px">비밀번호</h4>
	<table>
		<tr>
			<td><input type="password" id="pwd" size="50" maxlength="50"></td>
		</tr>
		<tr>
			<td><input type="button" value="확인" id="sendPassword"></td>
		</tr>
	</table>
</body>
</html>