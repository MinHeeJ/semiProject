package com.semi.mvc.order.model.dao;

import java.awt.Taskbar.State;
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
				String _state = rset.getString("state");
				State state = State.valueOf(_state);
				int orderSerialNo = rset.getInt("order_serial_no");
				int cartNo = rset.getInt("cart_no");
				String product = rset.getString("product");
				int count = rset.getInt("count");
				int price = rset.getInt("price");
				Order order = new Order(cartNo, product, memberId, count, price, orderNo, orderDate, null, orderSerialNo);
				orders.add(order);
			}
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return orders;
	}

}
