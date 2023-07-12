package com.semi.mvc.cart.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.cart.model.exception.CartException;
import com.semi.mvc.cart.model.vo.Ingredient;
import com.semi.mvc.cart.model.vo.SelectedOption;

public class CartDao {
	
private Properties prop = new Properties();
	
	public CartDao() {
		String filename = CartDao.class.getResource("/sql/cart/cart-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Ingredient> findAll(Connection conn) {
		List<Ingredient> ingredients = new ArrayList<>();
		String sql = prop.getProperty("findAllIngredient");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()) {
				
				while(rset.next()) {				
					Ingredient ingredient = new Ingredient();
					ingredient.setIngredientNo(rset.getInt("ingredient_no"));
					ingredient.setCategoryNo(rset.getInt("category_no"));
					ingredient.setIngredientName(rset.getString("ingredient_name"));
					ingredient.setCalorie(rset.getInt("calorie"));
					ingredient.setPrice(rset.getInt("price"));			
					ingredients.add(ingredient);
				}
		
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CartException(e);
		}
				
		return ingredients;
	}

	public int insertSelectedOption(Connection conn, SelectedOption selected) {
		int result = 0;
		String sql = prop.getProperty("insertSelectedOption");
		// insert into selected_option values (seq_option_no.nextval, ?, ?, ?, ?, ?)
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, selected.getMemberId());
			pstmt.setInt(2, selected.getIngredientNo());
			pstmt.setInt(3, selected.getCount());
			pstmt.setInt(4, selected.getCalorie());
			pstmt.setInt(5, selected.getPrice());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new CartException(e);
		}
		return result;
	}
	
	

}