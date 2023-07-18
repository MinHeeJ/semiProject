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
import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.review.model.service.ReviewService;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;

/**
 * Servlet implementation class ReviewOrderListServlet
 */
@WebServlet("/review/reviewOrderList")
public class ReviewOrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");

		
		// 2. 업무로직
		
		
		int totalContent = reviewService.getTotalContent();
		int limit = 5;
		int totalPage = (int) Math.ceil((double) totalContent / limit); 
		request.setAttribute("totalPage", totalPage);
		List<Order> orders = reviewService.reviewOrderList(" honggd");
		request.setAttribute("orders", orders);
		
		
		int cpage=1;
		
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));			
		} catch (NumberFormatException e) {       
		}
		
		int start = (cpage - 1) * limit + 1; 
		int end = cpage * limit;
		
		// 2. 업무로직
		List<Review> reviews = reviewService.findReview(start, end);
		request.setAttribute("reviews", reviews);
		
		// 3. 응답처리 forward jsp
		request.getRequestDispatcher("/WEB-INF/views/review/review.jsp")
					.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// 업로드파일 저장경로 C:\\Workspaces\\web_server_workspace\\hello-mvc\\src\\main\\webapp\\upload\\board
		ServletContext application = getServletContext();
		String saveDirectory = application.getRealPath("/upload/review");
		
		// 파일하나당 최대크기 10MB 
		int maxPostSize = 1024 * 1024 * 10; 
		// 인코딩
		String encoding = "utf-8";
		
		// 파일명 재지정 정책객체
		FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
		
		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 1. 사용자 입력값 처리
		String writer = multiReq.getParameter("writer");
		String content = multiReq.getParameter("content");
	    String orderSerialNo = multiReq.getParameter("orderSerialNo");
		Review review = new Review();
		review.setContent(content);
		review.setWriter(writer);
		review.setOrderSerialNo(Integer.parseInt(orderSerialNo));
		
		// Attachment객체 생성 
				Enumeration<String> filenames = multiReq.getFileNames(); // upFile1, upFile2
				while(filenames.hasMoreElements()) {
					String name = filenames.nextElement(); // input:file[name]
					File upFile = multiReq.getFile(name);
					
					if(upFile != null) {
						
						System.out.println(upFile.getName());
						AttachmentReview attach = new AttachmentReview();
						attach.setOriginalFilename(multiReq.getOriginalFileName(name));
						attach.setRenamedFilename(multiReq.getFilesystemName(name)); // renamedFilename
						review.addAttachment(attach);
					}
				}
				//2. 업무로직
				int result = reviewService.insertReview(review);
				
				//3. 응답처리
				response.sendRedirect(request.getContextPath() + "/review/reviewCreate" );
	}

}
