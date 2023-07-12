package com.semi.mvc.store.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.semi.mvc.store.model.vo.Store;

public class StoreService {
	public final StoreDao storeDao = new StoreDao();
	
	public List<Store> searchStore(String searchStore) {
		Connection conn = getConnection();
		List<Store> stores = storeDao.searchStore(conn, searchStore);
	}

	

}
