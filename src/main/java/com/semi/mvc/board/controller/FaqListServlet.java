package com.semi.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.board.model.service.FaqService;
import com.semi.mvc.board.model.vo.FaqBoard;
import com.semi.mvc.common.util.HelloMvcUtils;

/**
 * Servlet implementation class FaqCreateServlet
 */
@WebServlet("/board/faqList")
public class FaqListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FaqService faqService = new FaqService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<FaqBoard> faqs = faqService.findFaqBoard();
		
		for(FaqBoard faq : faqs) {
			faq.setTitle(HelloMvcUtils.escapeHtml(faq.getTitle()));
			faq.setContent(HelloMvcUtils.escapeHtml(faq.getContent()));
		}
		
		request.setAttribute("faqs", faqs);
		
		request.getRequestDispatcher("/WEB-INF/views/board/faqList.jsp")
		.forward(request, response);
	}

}
