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
				Order order = handleOrderResultSet(rset);
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new OrderException(e);
		}
		return orders;
	}

	private Order handleOrderResultSet(ResultSet rset) throws SQLException {
		int orderNo = rset.getInt("order_no");
		String memberId = rset.getString("member_id");
		Date orderDate = rset.getDate("order_date");
		String state = rset.getString("state");
		String product = rset.getString("product");
		int count = rset.getInt("count");
		int price = rset.getInt("price");
		Order order = new Order(orderNo, memberId, product, orderDate, state, count, price);
		return order;
	}

	public int stateUpdate(Connection conn, int orderNo, String state) {
		int result = 0;
		String sql = prop.getProperty("stateUpdate");
		// update (select * from order_tbl t left join order_detail d on t.order_no = d.order_no) set state = ? where order_serial_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, state);
			pstmt.setInt(2, orderNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return result;
	}

	public List<Order> findByDate(Connection conn, String startDate, String endDate) {
		List<Order> orders = new ArrayList<>();
		String sql = prop.getProperty("findByDate");
		// select * from (select * from order_tbl t left join order_detail d on t.order_no = d.order_no) 
		// where order_date between ? and ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate+1);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					Order order = handleOrderResultSet(rset);
					orders.add(order);
				}
			}
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return orders;
	}

	public int insertOrder(Connection conn, String memberId) {
		int result = 0;
		String sql = prop.getProperty("insertOrder");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return result;
	}

	public int getLastOrderNo(Connection conn) {
		int orderNo = 0;
		String sql = prop.getProperty("getLastOrderNo");
		
		try (
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		) {
			if(rset.next()) {
				orderNo = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return orderNo;
	}

	public int insertOrderDetail(Connection conn, Order order) {
		int result = 0;
		String sql = prop.getProperty("insertOrderDetail");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, order.getOrderNo());
			pstmt.setString(2, order.getProduct());
			pstmt.setInt(3, order.getCount());
			pstmt.setInt(4, order.getPrice());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return result;
	}

	public List<Order> findById(Connection conn, String memberId) {
		List<Order> orders = new ArrayList<>();
		String sql = prop.getProperty("findById");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					Order order = handleOrderResultSet(rset);
					orders.add(order);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new OrderException(e);
		}
		return orders;
	}


}
