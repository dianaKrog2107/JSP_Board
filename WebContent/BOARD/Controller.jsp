<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*" %>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		/* GET/POST 통신 데이터 처리 */
		int idx = 0; // 게시글 번호
		String command = null; // 실행 기능 유형
		if(request.getParameter("idx") != null){
			idx = Integer.parseInt(request.getParameter("idx"));
		}
		if(request.getParameter("command") != null){
			command = request.getParameter("command");
		}
		
		/* command 값에 따라 기능 실행 */
		if(command.equals("write")){ // 기능(1) 게시글 작성
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
		%>		
			alert("글이 등록되었습니다");
			location.href="boardList.jsp?pg=1"; <!-- 글 등록 후 게시판 첫 페이지로 이동 -->
		<%
		}else if(command.equals("modify")){ // 기능(2) 게시글 수정
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, idx);
	%>
		alert("글이 수정되었습니다");
		location.href="selectedPost.jsp?idx=<%= idx %>"; <!-- 글 수정 후 해당 글 페이지로 이동 -->
	<%
		}else if(command.equals("check")){ // 기능(3) 비밀번호 확인	
			String pwd = null;
			String role = null; // 비밀번호 확인 요청의 목적 : 글 수정(modify), 글 삭제(delete)
			if(request.getParameter("pwd") != null){
				pwd = request.getParameter("pwd");
			}
			if(request.getParameter("role") != null){
				role = request.getParameter("role");
			}
			
			boolean chk = dao.checkPassword(idx, pwd);
			if(chk == true){ // 비밀번호 성공
				if(role.equals("modify")){ // 해당 게시글 수정인 경우
					%>
					location.href="write.jsp?idx=" + <%= idx %>;
					<%
				}else if(role.equals("delete")){ // 해당 게시글 삭제인 경우
					dao.deletePost(idx);
					%>
					alert("게시물을 삭제합니다");
					location.href="boardList.jsp?pg=1";
					<%
				}
			}else if(chk == false){ // 비밀번호 실패
				%>
				alert("비밀번호가 틀렸습니다.");
				location.href="selectedPost.jsp?idx=" + <%= idx %>; // 해당 게시글로 이동
				<%
			}
		}
		%>
</script>