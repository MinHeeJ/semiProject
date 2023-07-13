package com.semi.mvc.order.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.member.model.dao.MemberDao;
import com.semi.mvc.order.model.exception.OrderException;
import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.order.model.vo.State;


public class OrderDao {
	private Properties prop = new Properties();
	
	public OrderDao() {
		String filename = MemberDao.class.getResource("/sql/order/order-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Order> findAll(Connection conn) {
		List<Order> orders = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try (
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		) {
			while(rset.next()) {
				int orderNo = rset.getInt("order_no");
				String memberId = rset.getString("member_id");
				Date orderDate = rset.getDate("order_date");
				String state = rset.getString("state");
				int cartNo = rset.getInt("cart_no");
				int orderSerialNo = rset.getInt("order_serial_no");
				String product = rset.getString("product");
				int count = rset.getInt("count");
				int price = rset.getInt("price");
				Order order = new Order(orderSerialNo, orderNo, memberId, cartNo, product, orderDate, state, count, price);
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new OrderException(e);
		}
		return orders;
	}

	public int stateUpdate(Connection conn, int orderSerialNo, String state) {
		int result = 0;
		String sql = prop.getProperty("stateUpdate");
		// update (select * from order_tbl t left join order_detail d on t.order_no = d.order_no) set state = ? where order_serial_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, state);
			pstmt.setInt(2, orderSerialNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return result;
	}

}
