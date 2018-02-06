<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<!-- class 작업 -->
<%
	/* 게시판 목록과 전체 개수 파악 */ 
	String keyField = null;
	String keyWord = null;
	if(request.getParameter("keyWord") != null){
		keyField = request.getParameter("keyField");
	    keyWord = request.getParameter("keyWord");
	}
	ArrayList<BoardVO> list = dao.getList(keyField, keyWord);
	int listCnt = dao.countPost();
	int size = list.size();
	int listSize = size;

	/* TODO : 페이징 작업 > 수정하기 */
	final int ROWSIZE = 5;
	final int BLOCK = 5;
	int pg = 1;
	
	if (request.getParameter("pg") != null) {	// 클릭한 페이지에 대한 정보, null이 아닌지 체크하고 시작
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	int end = (pg * ROWSIZE);
	int allPage = 0;
	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;
	allPage = (int) Math.ceil(listCnt / (double) ROWSIZE);	// Math.ceil 반올림 함수

	if (endPage > allPage) {
		endPage = allPage;
	}
	listSize -= end;
	if (listSize < 0) {
		end = size;
	}
%>
<!-- html 작업 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<script>
	function searchKeyword(){
		var form = document.writeform;
		if (!form.keyWord.value) {
			alert("검색할 내용을 적어주세요");
			form.keyWord.focus();
			return;
		}
		var selected = document.getElementsByName("keyField");
		console.log(selected[0].value);
		/* form.action="CheckPassword.jsp?type=" + selected[0].value; */
		form.submit();
	}
</script>
</head>
<body>
	<br>
	<h3 align="center">게시판</h3>
	<br>
		<!-- 글쓰기 버튼 -->
		<div align="right" style="padding-right:100px;"><input type=button value="글쓰기" OnClick="window.location='Write.jsp'"></div>
	<br>
	<!-- 게시글 보여주는 게시판 설정 -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="6">
			<td width="5"></td>
		</tr>
		<!-- TODO :테이블 설정 잘하기 -->
		<tr align="center">
			<td width="5" height="30" /></td>
			<td width="70">번호</td>
			<td width="300">제목</td>
			<td width="73">작성자</td>
			<td width="164">작성일</td>
			<td width="58">조회수</td>
			<td width="7"><img width="5" height="30" /></td>
		</tr>
		<!-- DB에 게시글 데이터가 없는 경우 -->
		<%
			if (listCnt == 0) {
		%>
		<tr align="center" bgcolor="#FFFFFF" height="60">
			<td colspan="6">게시판에 등록된 글이 없습니다</td>
		</tr>
		<!-- DB에 게시글 데이터가 있는 경우 -->
		<%
			} else {
				for (int i = ROWSIZE * (pg - 1); i < end; i++) {
					BoardVO vo = list.get(i); // 순서대로 VO 정보 받아오기
					int boardIdx = vo.getBoardIdx(); // 글번호
		%>
		<!-- 게시글 정보 출력하기 -->
		<tr height="30" align="center">
			<td align="center">&nbsp;</td>
			<td align="center"><%=boardIdx%></td>
			<td align="left">
				<a href="ShowWriting.jsp?boardIdx=<%=boardIdx%>&pg=<%=pg%>">
					<%=vo.getTitle()%>
				</a>
			</td>
			<td align="center"><%=vo.getUserName()%></td>
			<td align="center"><%=vo.getCreateAt()%></td>
			<td align="center"><%=vo.getHit()%></td>
			<td align="center">&nbsp;</td>
		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>
		<%
				}	// for문
			}	// if문
		%>
		<tr height="1" bgcolor="#82B5DF"> <!-- 테이블 밑선 -->
			<td colspan="6" width="752"></td>
		</tr>
	</table>

<!-- 페이지 넘버 설정 -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		<tr>
			<td align="center">
			<%
				if (pg > BLOCK) {
			%>
			<a href="ShowList.jsp?pg=1">◀◀</a>
			<a href="ShowList.jsp?pg=<%=startPage - 1%>">◀</a>
			<%
				}
			%>
			<%
 				for (int i = startPage; i <= endPage; i++) {
 					if (i == pg) {
 			%>
 			<b><%=i%></b>
			<%
 					} else {
 			%>
 			<a href="ShowList.jsp?pg=<%=i%>"><%=i%></a>
 			<%
				 	}
 				}
			%>
			<%
 				if (endPage < allPage) {
 			%>
 			<a href="ShowList.jsp?pg=<%=endPage + 1%>">▶</a>
 			<a href="ShowList.jsp?pg=<%=allPage%>">▶▶</a>
 			<%
			 	}
 			%>
			</td>
		</tr>
		<!-- 검색창 -->
	</table>
	<br>
	<form name=writeform method=post>
	<div align="right">
				<select name="keyField">
  					<option value="TITLE">제목</option>
  					<option value="MEMO">내용</option>
  					<option value="USERNAME">작성자</option>  					
				</select>
				<input type="text" name="keyWord"/>
				<input type="button" value="검색" onClick="javascript:searchKeyword()"/>
	</div>
	</form>
</body>
</html>