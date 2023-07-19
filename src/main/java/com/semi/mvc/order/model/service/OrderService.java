package com.semi.mvc.order.model.service;

import static com.semi.mvc.common.JdbcTemplate.close;
import static com.semi.mvc.common.JdbcTemplate.commit;
import static com.semi.mvc.common.JdbcTemplate.getConnection;
import static com.semi.mvc.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;

import com.semi.mvc.cart.model.dao.CartDao;
import com.semi.mvc.cart.model.vo.Cart;
import com.semi.mvc.order.model.dao.OrderDao;
import com.semi.mvc.order.model.vo.Order;


public class OrderService {
	private final OrderDao orderDao = new OrderDao();
	private final CartDao cartDao = new CartDao();

	public List<Order> findAll() {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findAll(conn);
		close(conn);
		return orders;
	}

	public int stateUpdate(int orderNo, String state) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = orderDao.stateUpdate(conn, orderNo, state);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Order> findByDate(Date startDate, Date endDate) {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findByDate(conn, startDate, endDate);
		close(conn);
		return orders;
	}

	public int insertOrder(String memberId) {
		// order_tbl에 추가
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = orderDao.insertOrder(conn, memberId);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	public int insertOrder(int cartNo) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// cart 조회
			Cart cart = cartDao.findByCartNo(conn, cartNo);
			System.out.println(cart);
			
			// 발급된 order_no 조회
			int orderNo = orderDao.getLastOrderNo(conn);
			Order order = new Order();
			order.setOrderNo(orderNo);
			order.setProduct(cart.getProduct());
			order.setCount(cart.getCount());
			order.setPrice(cart.getPrice());
			System.out.println(order);
			
			// order_detail에 추가
			result = orderDao.insertOrderDetail(conn, order);
			
			// cart_tbl에서 삭제
			result = cartDao.deleteCart(conn, cartNo);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Order> findById(String memberId) {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findById(conn, memberId);
		close(conn);
		return orders;
	}

	public List<Order> findByOrderNum(int orderNo) {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findByOrderNum(conn, orderNo);
		close(conn);
		return orders;

	}
}
