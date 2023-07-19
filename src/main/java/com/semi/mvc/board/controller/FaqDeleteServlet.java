package com.semi.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.board.model.service.FaqService;

/**
 * Servlet implementation class FaqDeleteServlet
 */
@WebServlet("/board/faqDelete")
public class FaqDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FaqService faqService = new FaqService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
//		System.out.println("boardNo = " + boardNo);
		
		int result = faqService.faqDelete(boardNo);
		
		response.sendRedirect(request.getContextPath() + "/board/faqList");
	}

}
