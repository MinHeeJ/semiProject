package com.semi.mvc.common;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JdbcTemplate {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/hellooracle");
			conn.setAutoCommit(false);
		} catch (SQLException | NamingException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
