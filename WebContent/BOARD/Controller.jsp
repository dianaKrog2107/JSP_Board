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
		
		if(command.equals("delete")){
			dao.deletePost(idx);
			%>
			location.href="boardList.jsp";
			<%
		}
		
		/* command에 따라 기능 실행 */
		if(command.equals("write")){	/* 글 작성 */
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
		}else if(command.equals("modify")){
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
		}else if(command.equals("pwd")){	/* 비밀번호 확인*/			
			String pwd = null;
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			boolean chk = dao.checkPassword(idx, pwd);
			if(chk == true){
				out.print(0);
			}else{
				out.print(1);
			}
		}
		%>
</script>