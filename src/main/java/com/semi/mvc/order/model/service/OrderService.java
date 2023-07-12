package com.semi.mvc.order.model.service;

import static com.semi.mvc.common.JdbcTemplate.close;
import static com.semi.mvc.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.semi.mvc.order.model.dao.OrderDao;
import com.semi.mvc.order.model.vo.Order;


public class OrderService {
	private final OrderDao orderDao = new OrderDao();

	public List<Order> findAll() {
		Connection conn = getConnection();
		List<Order> orders = orderDao.findAll(conn);
		close(conn);
		return orders;
	}

}
