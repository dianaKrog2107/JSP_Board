package com.vp.board;

public class BoardVO {	// 
	private int boardIdx;
	private String userName;
	private String title;
	private String memo;
	private int hit;
	private String createAt;	// TODO : Date로 데이터타입 변경
	private String updateAt;	// TODO : Date로 데이터타입 변경
	private String password;

	public BoardVO() {

	}

	public BoardVO(int boardIdx, String userName, String title, String memo, int hit, String createAt, String updateAt,
			String password) {
		this.boardIdx = boardIdx;
		this.userName = userName;
		this.title = title;
		this.memo = memo;
		this.hit = hit;
		this.createAt = createAt;
		this.updateAt = updateAt;
		this.password = password;
	}

	public int getBoardIdx() {
		return boardIdx;
	}

	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
