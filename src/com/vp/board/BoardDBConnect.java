package com.vp.board;

import java.sql.Connection;
import java.sql.DriverManager;

public class BoardDBConnect {
	public BoardDBConnect() {
	}

	public Connection getConnection() {	// DB ¿¬°á
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
		String user = "dhkang";
		String pw = "ekskdn1";

		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, user, pw);
		} catch (Exception e) {
			System.out.println(e);
		}

		return con;
	}
}
