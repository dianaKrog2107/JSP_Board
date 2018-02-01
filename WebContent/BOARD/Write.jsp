<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<jsp:useBean id="vo" class="com.vp.board.BoardVO" />
<%
	// [글쓰기]
	// [글쓰기]
	// 이전 페이지에서 정보가 넘어오지 않으면 글쓰기
	// insertWrite() 실행하고 알림창 뜬 후에 ShowWriting.jsp로 이동
	// [수정할 때]
	// 이전 페이지에서 정보가 넘어오면 수정하기
	// 비밀번호가 동일하면 수정됨
	// modifyWrite() 실행하고 알림창 뜬 후에 ShowWriting.jsp로 이동
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- <script language="javascript">  -->
<html>
<head>
<title>글작성</title>
<script type="text/javascript">
	function writeCheck() {
		var form = document.writeform;
		if (!form.name.value) {
			alert("이름을 적어주세요");
			form.name.focus();
			return;
		}
		if (!form.password.value) {
			alert("비밀번호를 적어주세요"); form.password.focus(); return;
		}
		if (!form.title.value) {
			alert("제목을 적어주세요"); form.title.focus(); return;
		}
		if (!form.memo.value) {
			alert("내용을 적어주세요"); form.memo.focus(); return;
		}
		form.submit();
	}
</script>
</head>
<body>
	<table>
		<form name=writeform method=post action="Controller.jsp?type=write">
			<tr>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr
							style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
							<td width="5"><img src="img/table_left.gif" width="5"
								height="30" /></td>
							<td>글쓰기</td>
							<td width="5"><img src="img/table_right.gif" width="5"
								height="30" /></td>
						</tr>
					</table>
					<table>
						<tr>
							<td>&nbsp;</td>
							<td align="center">제목</td>
							<td><input name="title" size="50" maxlength="100"></td>
							<td>&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="center">이름</td>
							<td><input name="name" size="50" maxlength="50"></td>
							<td>&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="center">비밀번호</td>
							<td><input type="password" name="password" size="50"
								maxlength="50"></td>
							<td>&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="center">내용</td>
							<td><textarea name="memo" cols="50" rows="13"></textarea></td>
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
							<td colspan="2"><input type=button value="등록"
								OnClick="javascript:writeCheck();"> <input type=button
								value="취소" OnClick="window.location='ShowList.jsp?pg=1'">
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>
