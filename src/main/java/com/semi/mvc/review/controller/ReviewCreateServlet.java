package com.semi.mvc.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.semi.mvc.common.HelloMvcFileRenamePolicy;
import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.review.model.service.ReviewService;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;

/**
 * Servlet implementation class ReviewCreateServlet
 */
@WebServlet("/review/reviewCreate")
public class ReviewCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	private final ReviewService reviewService = new ReviewService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자요청
		int totalContent = reviewService.getTotalContent();
		int limit = 5;
		int totalPage = (int) Math.ceil((double) totalContent / limit); 
		request.setAttribute("totalPage", totalPage);
		
		List<Order> orders = reviewService.reviewOrderList("memberId");
		System.out.println("memberId++++++++==orders" + orders);
		request.setAttribute("orders", orders);
		
		int cpage=1;
		
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));			
		} catch (NumberFormatException e) {       
		}
		
		request.setAttribute("cpage", cpage);
		
		int start = (cpage - 1) * limit + 1; 
		int end = cpage * limit;
		
		String memberId =reviewService.findbyId();
		request.setAttribute("memberId", memberId);
		
		
		
		// 2. 업무로직
		List<Review> reviews = reviewService.findReview(start, end);
		request.setAttribute("reviews", reviews);
		for(int i = 0 ; i <reviews.size() ; i++) {
			System.out.println(reviews.get(i).getAttachments());
		}
		
		request.getRequestDispatcher("/WEB-INF/views/review/review.jsp")
			.forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				ServletContext application = getServletContext();
				String saveDirectory = application.getRealPath("/upload/review");
				int maxPostSize = 1024 * 1024 * 10; 
				String encoding = "utf-8";
				
				// 파일명 재지정 정책객체
				FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
				
				MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
				
				// 1. 사용자 입력값 처리
				String title = multiReq.getParameter("title");
				String writer = multiReq.getParameter("writer");
				String content = multiReq.getParameter("content");
				Review review = new Review();
				review.setTitle(title);
				review.setWriter(writer);
				review.setContent(content);
			
				// Attachment객체 생성 (review 추가)
				Enumeration<String> filenames = multiReq.getFileNames(); // upFile1, upFile2
				while(filenames.hasMoreElements()) {
					String name = filenames.nextElement(); // input:file[name]
					File upFile = multiReq.getFile(name);
					if(upFile != null) {
						AttachmentReview attach = new AttachmentReview();
						attach.setOriginalFilename(multiReq.getOriginalFileName(name));
						attach.setRenamedFilename(multiReq.getFilesystemName(name)); // renamedFilename
						review.addAttachment(attach);
					}
				}
				
				// 2. 업무로직
				int result = reviewService.insertReview(review);
				
				// 3. 응답처리 (목록페이지로 redirect) - POST방식 DML처리후 url변경을 위해 redirect처리
				request.getSession().setAttribute("msg", "게시글이 성공적으로 등록되었습니다.");
				response.sendRedirect(request.getContextPath() + "/review/reviewCreate"); 
	}

}
