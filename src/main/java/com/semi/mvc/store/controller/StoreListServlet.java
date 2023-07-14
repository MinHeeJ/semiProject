package com.semi.mvc.store.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;




/**
 * 
 */
@WebServlet("/store/storeList")
public class StoreListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();
	private final int LIMIT = 5;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.입력값처리
		int cpage = 1; // 기본값처리
		try {
			cpage = Integer.parseInt(request.getParameter("cpage")); 			
		} catch (NumberFormatException e) {
			// 예외처리외에 아무것도 하지 않음.
		}
		
		int start = (cpage - 1) * LIMIT + 1;
		int end = cpage * LIMIT;
		
		//2. 업무로직
		List <Store> stores = storeService.findAll(start, end);
		request.setAttribute("stores", stores);
		System.out.println(stores);
		
		for(Store store : stores) {
			store.setStoreName(HelloMvcUtils.escapeHtml(store.getStoreName()));
		}
		// 페이지바영역 처리
				int totalContent = storeService.getTotalContent();
				System.out.println("totalContent = " + totalContent);
				String url = request.getRequestURI(); // /mvc/board/boardList
				String pagebar = HelloMvcUtils.getPagebar(cpage, LIMIT, totalContent, url);
				System.out.println("pagebar = " + pagebar);
				
				request.setAttribute("stores", stores);
				request.setAttribute("pagebar", pagebar);
				
		//3.응답처리
		request.getRequestDispatcher("/WEB-INF/views/store/storeList.jsp")
		 .forward(request, response);
	}

}
