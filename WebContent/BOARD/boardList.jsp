<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<!-- class 작업 -->
<%
	/* 게시판 목록 불러오기 */ 
	String keyField = null;	// <select>, 검색 기준
	String keyWord = null; // 검색 키워드
	if(request.getParameter("keyWord") != null){ // 데이터 null 여부 확인
		keyField = request.getParameter("keyField");
	    keyWord = request.getParameter("keyWord");
	}	
	ArrayList<BoardVO> arrList = dao.getList(keyField, keyWord);
	int postCnt = dao.countPost();
	int size = arrList.size();
	int listSize = size;

	/* TODO : 페이징 수정하기 */
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
	allPage = (int) Math.ceil(postCnt / (double) ROWSIZE);	// Math.ceil() 반올림

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
		var form = document.searchform;
		if (!form.keyWord.value) {
			alert("검색할 내용을 적어주세요");
			form.keyWord.focus();
			return;
		}
		var selectedItem = document.getElementsByName("keyField");
		console.log(selectedItem[0].value);
		form.submit();
	}
</script>
</head>
<body>
	<br>
	<h3 align="center">게시판</h3>
	<br>
		<!-- 글쓰기 버튼 -->
		<div align="right" style="padding-right:100px;">
			<input type=button value="글쓰기" OnClick="window.location='write.jsp'">
		</div>
	<br>
	<!-- 게시판 설정 -->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="6">
			<td width="5"></td>
		</tr>
		<tr align="center">
			<td width="5"/></td>
			<td width="70">번호</td>
			<td width="300">제목</td>
			<td width="73">작성자</td>
			<td width="164">작성일</td>
			<td width="58">조회수</td>
			<td width="7"/></td>
		</tr>
		<%
			// 카운팅된 게시글 데이터 수가 0인 경우
			if (postCnt == 0) {
		%>
				<tr align="center" bgcolor="#FFFFFF" height="60">
				<td colspan="6">게시판에 등록된 글이 없습니다</td>
			</tr>
		<%
			} else { // DB에 게시글 데이터가 있는 경우
				for (int i = ROWSIZE * (pg - 1); i < end; i++) {
					BoardVO vo = arrList.get(i); // 순서대로 VO 정보 받아오기
		%>
		<!-- 게시글 정보 출력하기 -->
		<tr height="30" align="center">
			<td align="center">&nbsp;</td>
			<td align="center"><%=vo.getBoardIdx()%></td>
			<td align="left">
				<a href="selectedPost.jsp?idx=<%=vo.getBoardIdx()%>&pg=<%=pg%>">
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
				}	// for문 : 게시글 데이터 뿌리기
			}	// if문
		%>
		<tr height="1" bgcolor="#82B5DF">
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
			<a href="boardList.jsp?pg=1">◀◀</a>
			<a href="boardList.jsp?pg=<%=startPage - 1%>">◀</a>
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
 			<a href="boardList.jsp?pg=<%=i%>"><%=i%></a>
 			<%
				 	}
 				}
			%>
			<%
 				if (endPage < allPage) {
 			%>
 			<a href="boardList.jsp?pg=<%=endPage + 1%>">▶</a>
 			<a href="boardList.jsp?pg=<%=allPage%>">▶▶</a>
 			<%
			 	}
 			%>
			</td>
		</tr>
		<!-- 검색창 -->
	</table>
	<br>
	<form name=searchform method=post>
	<!-- 검색창 -->
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