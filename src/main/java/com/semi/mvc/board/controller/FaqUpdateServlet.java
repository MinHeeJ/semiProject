package com.semi.mvc.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.semi.mvc.board.model.service.FaqService;
import com.semi.mvc.board.model.vo.FaqBoard;
import com.semi.mvc.common.HelloMvcFileRenamePolicy;

/**
 * Servlet implementation class FaqUpdateServlet
 */
@WebServlet("/board/faqUpdate")
public class FaqUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FaqService faqService = new FaqService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardNo = Integer.parseInt(request.getParameter("BoardNo"));
		System.out.println("BoardNo = " + boardNo);
		FaqBoard faq = faqService.findByBoardNo(boardNo);
		request.setAttribute("faq", faq);
		request.getRequestDispatcher("/WEB-INF/views/board/faqUpdate.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		ServletContext application = getServletContext();
//		String saveDirectory = application.getRealPath("/upload/faq");
//		System.out.println("saveDirectory = " + saveDirectory);
//		int maxPostSize = 1024 * 1024 * 10; 
//		String encoding = "utf-8";
//		
//		FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
//		
//		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
//		
//		int boardNo = Integer.parseInt(multiReq.getParameter("boardNo"));
//		String title = multiReq.getParameter("title");
//		String writer = multiReq.getParameter("writer");
//		String content = multiReq.getParameter("content");
//		
//		String[] delFiles = multiReq.getParameterValues("delFile");
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		FaqBoard faq = new FaqBoard();
		faq.setBoardNo(boardNo);
		faq.setTitle(title);
		faq.setWriter(writer);
		faq.setContent(content);
		
		// Attachment 작업
//		Enumeration<String> filenames = multiReq.getFileNames(); // upFile1, upFile2
//		while(filenames.hasMoreElements()) {
//			String name = filenames.nextElement(); // input:file[name]
//			File upFile = multiReq.getFile(name);
//			if(upFile != null) {
//				Attachment attach = new Attachment();
//				attach.setOriginalFilename(multiReq.getOriginalFileName(name));
//				attach.setRenamedFilename(multiReq.getFilesystemName(name)); // renamedFilename
//				attach.setBoardNo(no); // fk컬럼 boardNo 바로 설정 가능
//				board.addAttachment(attach);
//			}
//		}
		
		int result = faqService.faqUpdate(faq);
		
		// 
//		if(delFiles != null) {
//			for(String _attachNo : delFiles) {
//				int attachNo = Integer.parseInt(_attachNo);
//				// a. 파일삭제
//				Attachment attach = boardService.findAttachmentById(attachNo);
//				// java.io.File : 실제파일을 가리키는 자바객체
//				File delFile = new File(saveDirectory, attach.getRenamedFilename());
//				if(delFile.exists())
//					delFile.delete();
//				System.out.println(attach.getRenamedFilename() + " : " + delFile.exists());
//				
//				// b. db attachment 행 삭제
//				result = boardService.deleteAttachment(attachNo);
//			}
//		}
		
		response.sendRedirect(request.getContextPath() + "/board/faqList");
	}

}
