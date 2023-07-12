package com.semi.mvc.store.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.member.model.dao.MemberDao;
import com.semi.mvc.store.model.exception.StoreException;
import com.semi.mvc.store.model.vo.Store;

public class StoreDao {
	private Properties prop = new Properties();
	
	public StoreDao() {
		String filename = StoreDao.class.getResource("/sql/store/store-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private Store handleStoreResultSet(ResultSet rset) throws SQLException {
		int storeNo = rset.getInt("store_no");
		String storeName = rset.getString("store_name");
		String address = rset.getString("address");
		String phone = rset.getString("phone");
		return new Store(storeNo, storeName, address, phone);
	}

	public List<Store> searchStore(Connection conn, String searchStore) {
		List<Store> stores = new ArrayList<>();
		String sql = prop.getProperty("searchStore");

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, "%" + searchStore + "%");
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next()) {
					Store store = handleStoreResultSet(rset);
					stores.add(store);
				}
			}
		} catch (SQLException e) {
			throw new StoreException(e);

		}
		return stores;
	}

	public List<Store> findAll(Connection conn,int start, int end) {
		List<Store> stores = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					Store store = handleStoreResultSet(rset);
					stores.add(store);
				}
			}
			} catch (SQLException e) {
				e.printStackTrace();
				throw new StoreException(e);
			}
			return stores;
	}

	public int getTotalContent(Connection conn) {
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent"); // select count(*) from store
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next())
					totalContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new StoreException(e);
		}
		return totalContent;
	}

	public int insertMember(Connection conn, Store newStore) {
		int result = 0;
		String sql = prop.getProperty("insertStore");
		//insert into store values( seq_store_no.nextval, ?,?,?)
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, newStore.getStoreName());
			pstmt.setString(2, newStore.getAddress());
			pstmt.setString(3, newStore.getPhone());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new StoreException(e);
		}
		return result;
	}
}
