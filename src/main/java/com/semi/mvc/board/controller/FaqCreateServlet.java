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
import com.semi.mvc.board.model.vo.Attachment;
import com.semi.mvc.board.model.vo.FaqBoard;
import com.semi.mvc.common.HelloMvcFileRenamePolicy;



/**
 * Servlet implementation class FaqCreateServlet
 */
@WebServlet("/board/faqCreate")
public class FaqCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final FaqService faqService = new FaqService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/board/faqCreate.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 업로드파일 저장경로 C:\\Workspaces\\web_server_workspace\\hello-mvc\\src\\main\\webapp\\upload\\board
		ServletContext application = getServletContext();
		String saveDirectory = application.getRealPath("/upload/board");
		System.out.println("saveDirectory = " + saveDirectory);
		// 파일하나당 최대크기 10MB 
		int maxPostSize = 1024 * 1024 * 10; 
		// 인코딩
		String encoding = "utf-8";
		
		// 파일명 재지정 정책객체
		// 한글.txt --> 20230629_160430123_999.txt
//		FileRenamePolicy policy = new DefaultFileRenamePolicy(); // a.txt, a1.txt, a2.txt, ...
		FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
		
		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		String title = multiReq.getParameter("title");
		String writer = multiReq.getParameter("writer");
		String content = multiReq.getParameter("content");
		FaqBoard faq = new FaqBoard();
		faq.setTitle(title);
		faq.setWriter(writer);
		faq.setContent(content);
		
		Enumeration<String> filenames = multiReq.getFileNames(); // upFile1, upFile2
		while(filenames.hasMoreElements()) {
			String name = filenames.nextElement(); // input:file[name]
			File upFile = multiReq.getFile(name);
			if(upFile != null) {
				Attachment attach = new Attachment();
				attach.setOriginalFilename(multiReq.getOriginalFileName(name));
				attach.setRenamedFilename(multiReq.getFilesystemName(name)); // renamedFilename
				faq.addAttachment(attach);
			}
		}
		
//		int result = faqService.insertFaq(faq);
		
		response.sendRedirect(request.getContextPath() + "/board/faqList");
	}

}
