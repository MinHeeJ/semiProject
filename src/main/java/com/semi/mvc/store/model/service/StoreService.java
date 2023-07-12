package com.semi.mvc.store.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import com.semi.mvc.store.model.dao.StoreDao;
import com.semi.mvc.store.model.vo.Store;

public class StoreService {
	public final StoreDao storeDao = new StoreDao();
	
	public List<Store> searchStore(String searchStore) {
		Connection conn = getConnection();
		List<Store> stores = storeDao.searchStore(conn, searchStore);
		close(conn);
		return stores;
	}

	public List<Store> findAll(int start, int end) {
		Connection conn = getConnection();
		List<Store> stores = storeDao.findAll(conn, start, end);
		close(conn);
		
		return stores;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = storeDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}
	
}
