package com.semi.mvc.cart.model.service;

import static com.semi.mvc.common.JdbcTemplate.close;
import static com.semi.mvc.common.JdbcTemplate.getConnection;
import static com.semi.mvc.common.JdbcTemplate.rollback;
import static com.semi.mvc.common.JdbcTemplate.commit;


import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.semi.mvc.cart.model.dao.CartDao;
import com.semi.mvc.cart.model.vo.Cart;
import com.semi.mvc.cart.model.vo.Ingredient;
import com.semi.mvc.cart.model.vo.SelectedOption;


public class CartService {

	
	private final CartDao cartDao = new CartDao();
	
	public List<Ingredient> findAll() {
		List<Ingredient> ingredients = new ArrayList<>();
		
		Connection conn = getConnection();
		
		ingredients = cartDao.findAll(conn);
		
		close(conn);
		
		return ingredients;
	}

	public int insertSelectedOption(SelectedOption selected) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = cartDao.insertSelectedOption(conn, selected);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int insertCart(String confirmOptions, String totalPrice, String memberId) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = cartDao.insertCart(conn, confirmOptions, totalPrice, memberId);
			result = cartDao.deleteSelectedOption(conn, memberId);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Cart> findAllCart(String memberId) {
		List<Cart> carts = new ArrayList<>();
		
		Connection conn = getConnection();
		
		carts = cartDao.findAllCart(conn, memberId);
		
		close(conn);
		
		return carts;
	}

}
