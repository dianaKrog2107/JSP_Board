package com.vp.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private BoardDBConnect dbconnect = null;
	private String sql = "";

	public BoardDAO() {
		dbconnect = new BoardDBConnect();
	}

	/* 데이터 인코딩 */
	public String encodeData(String data) {
		try {
			data = new String(data.getBytes("8859_1"), "euc-kr");
		} catch (Exception e) {
		}
		return data;
	}

	/* TODO : 카운팅 방식 수정*/
	/* 게시물 개수 카운팅 */
	public int countPost() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null; // 컴파일된 sql문을 DBMS에 전달
		ResultSet rs = null;
		int cnt = 0;
		try {
			sql = "select count(*) from BOARD_TB";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return cnt;
	}

	/* 게시판 목록 보기 */
	public ArrayList<BoardVO> getList(String keyField, String keyWord) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardVO> arrList = new ArrayList<BoardVO>();
		try {
			sql = "select BOARDIDX,USERNAME,TITLE,HIT,CREATEAT from BOARD_TB ";			
			if(keyWord != null && !keyWord.equals("") ){ // 검색어 기준 게시글 받아오기
				String str = new String(keyWord.trim().getBytes("iso-8859-1"), "euc-kr");
                sql +="where "+keyField.trim()+" like '%"+ str +"%' ";
            }
			sql += "order by BOARDIDX desc"; // 게시판 번호로 정렬
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 게시글이 있을 때까지 while문 반복
				BoardVO vo = new BoardVO();
				vo.setBoardIdx(rs.getInt(1));
				vo.setUserName(rs.getString(2));
				vo.setTitle(rs.getString(3));
				vo.setHit(rs.getInt(4));
				vo.setCreateAt(rs.getString(5));
				arrList.add(vo);
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return arrList;
	}

	/* 게시글 조회수 갱신 */
	public void updateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "update BOARD_TB set HIT=HIT+1 where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* 선택한 글 불러오기 */
	public BoardVO loadSelectedPost(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO vo = null;

		try {
			sql = "select USERNAME,TITLE,MEMO,HIT,CREATEAT from BOARD_TB where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 선택한 게시물이 DB에 있다면 정보 받아오기
				vo = new BoardVO();
				vo.setUserName(rs.getString(1));
				vo.setTitle(rs.getString(2));
				vo.setMemo(rs.getString(3));
				vo.setHit(rs.getInt(4));
				vo.setCreateAt(rs.getString(5));
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return vo;
	}

	/* 게시글 작성하기 */
	public void writePost(BoardVO vo) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			// 시퀀스를 설정하여 자동으로 BOARDIDX(글번호, PK) 컬럼을 순차적으로 증가 
			sql = "insert into BOARD_TB(BOARDIDX,USERNAME,PASSWORD,TITLE,MEMO) values(BOARDIDX_SEQ.NEXTVAL,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, encodeData(vo.getUserName()));
			pstmt.setString(2, encodeData(vo.getPassword()));
			pstmt.setString(3, encodeData(vo.getTitle()));
			pstmt.setString(4, encodeData(vo.getMemo()));
			pstmt.execute();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* 게시글 수정하기 */
	public void modifyPost(BoardVO vo, int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			// 글이 수정되면 수정 시간까지 갱신
			sql = "update BOARD_TB set TITLE=?,USERNAME=?,PASSWORD=?,MEMO=?,UPDATEAT=sysdate where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, encodeData(vo.getTitle()));
			pstmt.setString(2, encodeData(vo.getUserName()));
			pstmt.setString(3, encodeData(vo.getPassword()));
			pstmt.setString(4, encodeData(vo.getMemo()));			
			pstmt.setInt(5, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}
	
	/* 게시글 삭제하기 */
	public void deletePost(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "delete from BOARD_TB where BOARDIDX=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt);
		}
	}

	/* 게시글 비밀번호 확인 */
	public boolean checkPassword(int idx, String pwd) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean chk = false;
		try {
			sql = "select BOARDIDX FROM BOARD_TB where BOARDIDX=? and PASSWORD=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 결과값이 나오면 비밀번호 맞는 경우
				chk = true;
			} else { // 비밀번호 틀린 경우
				chk = false;
			}
		} catch (Exception e) {
		} finally {
			BoardDBClose.close(con, pstmt, rs);
		}
		return chk;
	}
}