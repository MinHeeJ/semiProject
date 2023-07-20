package com.semi.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.board.model.service.BoardService;
import com.semi.mvc.board.model.vo.Attachment;
import com.semi.mvc.board.model.vo.Board;
import com.semi.mvc.board.model.vo.BoardComment;
import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class BoardDetailServlet
 */
@WebServlet("/board/boardDetail")
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardService boardService = new BoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값 처리 ?no=12
				int no = Integer.parseInt(request.getParameter("no"));
//				System.out.println("no = " + no);
				
				// 2. 업무로직
				Board board = boardService.findById(no); // Board, List<Attachment>
				List<BoardComment> boardComments = boardService.findBoardCommentByBoardNo(no);
//				System.out.println("board = " + board);
//				System.out.println("boardComments = " + boardComments);
				System.out.println("writer = " + board.getWriter());
				
				// secure coding처리 
				String unsecureTitle = board.getTitle();
				String secureTitle = HelloMvcUtils.escapeHtml(unsecureTitle);
				board.setTitle(secureTitle);
				
				// 3. 응답처리 jsp
				request.setAttribute("board", board);
				request.setAttribute("boardComments", boardComments);
				request.getRequestDispatcher("/WEB-INF/views/board/boardDetail.jsp")
					.forward(request, response);
	}


}
