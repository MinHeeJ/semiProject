package com.semi.mvc.order.model.service;

import static com.semi.mvc.common.JdbcTemplate.close;
import static com.semi.mvc.common.JdbcTemplate.commit;
import static com.semi.mvc.common.JdbcTemplate.getConnection;
import static com.semi.mvc.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.semi.mvc.order.model.dao.OrderDao;
import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.order.model.vo.State;


public class OrderService {
	private final OrderDao orderDao = new OrderDao();

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

	public List<Order> findByDate(String startDate, String endDate) {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findByDate(conn, startDate, endDate);
		close(conn);
		return orders;
	}

}
