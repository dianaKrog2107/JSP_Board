<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<script type="text/javascript">
	<%
	System.out.println("왜 두 번 실행??");
		int boardIdx = 0;
		String type = null;
		if(request.getParameter("boardIdx") != null){
			boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		}
		if(request.getParameter("type") != null){
			type = request.getParameter("type");
		}
		
		/* type에 따라 기능 실행 */
		if(type.equals("delete")){	/* 글 삭제 */
			dao.deleteWrite(boardIdx);
	%>
	alert("글이 삭제되었습니다");
	location.href="ShowList.jsp";		
	<%
		}else if(type.equals("write")){	/* 글 작성 */
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.insertWrite(vo);
	%>
	alert("글이 등록되었습니다");
	location.href="ShowList.jsp?pg=1";
	<%
		}else if(type.equals("pwd")){
			String pwd = null;
			String next = null;			
			if(request.getParameter("password") != null){
				pwd = request.getParameter("password");
			}
			if(request.getParameter("next") != null){
				next = request.getParameter("next");
			}
			System.out.println("실행합니다");
			/* 비밀번호 맞는지 확인*/
			boolean chk = dao.checkPassword(boardIdx, pwd);
			System.out.println(chk);
			if(chk == true){
			}else{%>
				self.window.alert("비밀번호를 틀렸습니다.");
				location.href="javascript:history.back()";
			<%}
		}%>
</script>