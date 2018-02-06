<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
		int boardIdx = 0;
		String type = null;
		if(request.getParameter("boardIdx") != null){
			boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		}
		if(request.getParameter("type") != null){
			type = request.getParameter("type");
		}
		
		if(type.equals("delete")){
			dao.deletePost(boardIdx);
			%>
			location.href="ShowList.jsp";
			<%
		}
		
		/* type에 따라 기능 실행 */
		if(type.equals("write")){	/* 글 작성 */
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.writePost(vo);
	%>
		alert("글이 등록되었습니다");
		location.href="ShowList.jsp?pg=1";
	<%
		}else if(type.equals("modify")){
			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.modifyPost(vo, boardIdx);
	%>
		alert("글이 수정되었습니다");
		location.href="ShowWriting.jsp?boardIdx=<%=boardIdx%>";
	<%
		}else if(type.equals("pwd")){	/* 비밀번호 확인*/			
			String pwd = null;
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			boolean chk = dao.checkPassword(boardIdx, pwd);
			if(chk == true){
				out.print(0);
			}else{
				out.print(1);
			}
		}
		%>
</script>