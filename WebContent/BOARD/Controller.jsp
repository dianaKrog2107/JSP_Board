<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		/* 받아오는 값 설정 */
		int idx = 0;
		String command = null;
		if(request.getParameter("idx") != null){
			idx = Integer.parseInt(request.getParameter("idx"));
		}
		if(request.getParameter("command") != null){
			command = request.getParameter("command");
		}
		
		/* command 값에 따라 기능 실행 */
		if(command.equals("delete")){ // 게시글 삭제
			dao.deletePost(idx);
		%>
			alert("게시물을 삭제합니다");
			location.href="boardList.jsp";			
		<%
		}else if(command.equals("write")){ // 게시글 작성
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
		%>		
			alert("글이 등록되었습니다");
			location.href="boardList.jsp?pg=1";
		<%
		}else if(command.equals("modify")){ // 게시글 수정
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, idx);
	%>
		alert("글이 수정되었습니다");
		location.href="selectedPost.jsp?idx=<%=idx%>";
	<%
		}else if(command.equals("check")){ // 비밀번호 확인	
			String pwd = null;
			String role = null;
			if(request.getParameter("pwd") != null){
				pwd = request.getParameter("pwd");
			}
			if(request.getParameter("role") != null){
				role = request.getParameter("role");
			}
			
			boolean chk = dao.checkPassword(idx, pwd);
			System.out.println(chk);
			if(chk == true){
				if(role.equals("modify")){
					%>
					location.href="write.jsp?idx=" + <%= idx %>;
					<%
				}else if(role.equals("delete")){
					dao.deletePost(idx);
					%>
					alert("게시물을 삭제합니다");
					location.href="boardList.jsp";
					<%
				}
			}else if(chk == false){
				%>
				alert("비밀번호가 틀렸습니다.");
				location.href="selectedPost.jsp?idx=" + <%=idx%>;
				<%
			}
		}
		%>
</script>