<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.vp.board.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="dao" class="com.vp.board.BoardDAO" />
<!-- 삭제되었다는 알림창 띄우기 -->
<script type="text/javascript">
	<%
		int boardIdx = 0;
		if(request.getParameter("boardIdx") != null){
			boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		}
		String type = request.getParameter("type");
		if(type.equals("delete")){
			dao.deleteWrite(boardIdx);	
	%>
	location.href="ShowList.jsp";
	<%
		}else if(type.equals("write")){
			System.out.println(dao.encodeData(request.getParameter("name")));
 			BoardVO vo = new BoardVO();
 			vo.setUserName(request.getParameter("name"));
			vo.setPassword(request.getParameter("password"));
			vo.setTitle(request.getParameter("title"));
			vo.setMemo(request.getParameter("memo"));
			dao.insertWrite(vo);
	%>
	location.href="ShowList.jsp?pg=1";
	<%
		}
	%>
</script>