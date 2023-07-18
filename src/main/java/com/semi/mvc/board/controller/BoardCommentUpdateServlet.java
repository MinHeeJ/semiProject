package com.semi.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.board.model.service.BoardService;
import com.semi.mvc.board.model.vo.Board;
import com.semi.mvc.board.model.vo.BoardComment;
import com.semi.mvc.common.util.HelloMvcUtils;

/**
 * Servlet implementation class BoardCommentUpdateServlet
 */
@WebServlet("/board/boardCommentUpdate")
public class BoardCommentUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("update get No = " + no);
		
		Board board = boardService.findById(no); // Board, List<Attachment>
		List<BoardComment> boardComments = boardService.findBoardCommentByBoardNo(no);
		
		String unsecureTitle = board.getTitle();
		String secureTitle = HelloMvcUtils.escapeHtml(unsecureTitle);
		board.setTitle(secureTitle);
		
		// 3. 응답처리
		request.setAttribute("board", board);
		request.setAttribute("boardComments", boardComments);
		request.getRequestDispatcher("/WEB-INF/views/board/boardCommentUpdate.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리		
		int no = Integer.parseInt(request.getParameter("no"));
		System.out.println("update post No = " + no);
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		
		BoardComment bc = new BoardComment();
		bc.setBoardNo(no);
		bc.setWriter(writer);
		bc.setContent(content);
		System.out.println(bc.getContent());
		
		int result = boardService.updateComment(bc); 
		
		response.sendRedirect(request.getContextPath() + "/board/boardDetail?no=" + bc.getBoardNo());
	}

}
