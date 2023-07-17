package com.semi.mvc.review.controller;

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
import com.semi.mvc.common.HelloMvcFileRenamePolicy;
import com.semi.mvc.review.model.service.ReviewService;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/review/reviewUpdate")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();   
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				// 1. 사용자입력값 처리
				int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
				System.out.println("reviewNo = " + reviewNo);
				// 2. 업무로직
				Review review = reviewService.findReviewById(reviewNo);
				request.setAttribute("review", review);
				// 3. 응답처리
				request.getRequestDispatcher("/WEB-INF/views/review/reviewUpdate.jsp")
					.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				ServletContext application = getServletContext();
				String saveDirectory = application.getRealPath("/upload/review");
				System.out.println("saveDirectory = " + saveDirectory);
				// 파일하나당 최대크기 10MB 
				int maxPostSize = 1024 * 1024 * 10; 
				// 인코딩
				String encoding = "utf-8";
				
				// 파일명 재지정 정책객체
				FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
				
				MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
				
				// 1. 사용자 입력값 처리		
				int reviewNo = Integer.parseInt(multiReq.getParameter("reviewNo"));
				String writer = multiReq.getParameter("writer");
				String content = multiReq.getParameter("content");
				
				// db attachment 행삭제, 저장된 파일삭제 
				String[] delFiles = multiReq.getParameterValues("delFile");
				
				Review review = new Review();
				review.setReviewNo(reviewNo);
				review.setWriter(writer);
				review.setContent(content);
			
				System.out.println(review);
				
				
				
				// Attachment객체 생성
				Enumeration<String> filenames = multiReq.getFileNames(); // upFile1, upFile2
				while(filenames.hasMoreElements()) {
					String name = filenames.nextElement(); // input:file[name]
					File upFile = multiReq.getFile(name);
					if(upFile != null) {
						AttachmentReview attach = new AttachmentReview();
						attach.setOriginalFilename(multiReq.getOriginalFileName(name));
						attach.setRenamedFilename(multiReq.getFilesystemName(name)); // renamedFilename
						attach.setReviewNo(reviewNo); 
						review.addAttachment(attach);
					}
				}
				
				// 2. 업무로직
				int result = reviewService.updateReview(review); 
				
				// 첨부파일 삭제 
				if(delFiles != null) {
					for(String _attachNo : delFiles) {
						int attachNo = Integer.parseInt(_attachNo);
						// a. 파일삭제
						AttachmentReview attach = reviewService.findAttachmentReviewById(attachNo);
						// java.io.File : 실제파일을 가리키는 자바객체
						File delFile = new File(saveDirectory, attach.getRenamedFilename());
						if(delFile.exists())
							delFile.delete();
						System.out.println(attach.getRenamedFilename() + " : " + delFile.exists());
						
						// b. db attachment 행 삭제
						result = reviewService.deleteAttachment(attachNo);
					}
				}
				
				
				// 3. 응답처리 (목록페이지로 redirect) - POST방식 DML처리후 url변경을 위해 redirect처리
				response.sendRedirect(request.getContextPath() + "/review/reviewCreate");
	}

}
