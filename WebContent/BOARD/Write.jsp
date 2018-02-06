<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*" %>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<%
	int idx = 0; // = 0이면 글쓰기, != 0이면 수정하기
	BoardVO vo = new BoardVO();
	if (request.getParameter("idx") != null) {
		idx = Integer.parseInt(request.getParameter("idx"));
	}
	if (idx != 0) { // 수정하기인 경우 해당 idx의 내용 받아오기
		vo = dao.loadSelectedPost(idx);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>
	<% if (idx == 0) { %> 글쓰기
	<% } else { %> 수정하기
	<% } %>
</title>
<script type="text/javascript">
	function checkBlank() {
		var form = document.writeform;
		if (!form.title.value) {
			alert("제목을 적어주세요");
			form.title.focus();
			return;
		}
		if (!form.name.value) {
			alert("이름을 적어주세요");
			form.name.focus();
			return;
		}
		if (!form.password.value) {
			alert("비밀번호를 적어주세요");
			form.password.focus();
			return;
		}
		if (!form.memo.value) {
			alert("내용을 적어주세요");
			form.memo.focus();
			return;
		}
		form.submit();
	}
</script>
</head>
<body>
	<form name=writeform method=post
		<% if (idx != 0) { %>
			action="controller.jsp?command=modify&idx=<%=idx%>"
		<%} else {%>
			action="controller.jsp?command=write&idx=<%=idx%>"
		<% } %>>
		<h4 style="padding-left: 180px">
			<% if (idx == 0) { %> 글쓰기
			<% } else { %> 수정하기
			<% } %>
		</h4>
		<table>
			<tr>
				<td>&nbsp;</td>
				<td align="center">제목</td>
				<td>
					<input name="title" size="50" maxlength="100"
						<%if (idx != 0) { %>
							value="<%= vo.getTitle() %>"
						<% } %>>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">이름</td>
				<td>
					<input name="name" size="50" maxlength="50"
						<% if (idx != 0) { %>
							value="<%= vo.getUserName() %>"
						<% } %>>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">비밀번호</td>
				<td>
					<input type="password" name="password" size="50" maxlength="50">
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="center">내용</td>
				<td>
					<textarea name="memo" cols="50" rows="13">
						<% if (idx != 0) { %>
							<%=vo.getMemo()%>
						<% } %>
					</textarea>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr height="1" bgcolor="#dddddd">
				<td colspan="4"></td>
			</tr>
			<tr height="1" bgcolor="#82B5DF">
				<td colspan="4"></td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
				<td colspan="2">
					<input type=button
						<% if (idx != 0) { %>
								value="수정"
						<% } else { %>
								value="등록"
						<% } %>
						OnClick="javascript:checkBlank();">
					<input type=button value="취소"
						<% if (idx != 0) { %>
							OnClick="window.location='selectedPost.jsp?idx=<%=idx%>'"
						<% } else { %>
							OnClick="window.location='boardList.jsp?pg=1'"
					<% } %>>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
</body>
</html>
