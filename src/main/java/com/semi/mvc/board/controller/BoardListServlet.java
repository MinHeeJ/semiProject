package com.semi.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.board.model.service.BoardService;
import com.semi.mvc.board.model.vo.Board;
import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class BoardListServlet
 */
@WebServlet("/board/boardList")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BoardService boardService = new BoardService();
	private final int LIMIT = 10;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
		
		int start = (cpage - 1) * LIMIT + 1;
		int end = cpage * LIMIT;
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		List<Board> boards = boardService.findBoardsByWriter(memberId, start, end);
//		System.out.println("boards = " + boards);
		
		for(Board board : boards) {
			board.setTitle(HelloMvcUtils.escapeHtml(board.getTitle()));
		}
		
		int totalContent = boardService.getTotalContentByWriter(memberId);
//		System.out.println("totalContent = " + totalContent);
		String url = request.getRequestURI(); // /mvc/board/boardList
		String pagebar = HelloMvcUtils.getPagebar(cpage, LIMIT, totalContent, url);
//		System.out.println("pagebar = " + pagebar);
		
		request.setAttribute("totalContent", totalContent);
		request.setAttribute("boards", boards); 
		request.setAttribute("pagebar", pagebar);
		
		request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp")
		.forward(request, response);
	}

}
