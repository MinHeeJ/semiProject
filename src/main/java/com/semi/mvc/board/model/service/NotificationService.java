package com.semi.mvc.board.model.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;

import com.google.gson.Gson;
import com.semi.mvc.board.model.vo.Board;
import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.ws.HelloWebSocket;
import com.semi.mvc.ws.MessageType;

/**
 * 
 * 알림 요청이 있을때마다 
 * - 1. db notification테이블 저장 (생략)
 * - 2. HelloWebSocket.clientMap에서 해당 사용자를 찾아서 실시간 알림처리
 *
 * honggd 게시글 작성 - sinsa 해당게시글에 댓글 작성 - honggd 게시글댓글 알림 
 */
public class NotificationService {

	/**
	 * 1. db저장
	 * 2. 실시간알림
	 * 
	 * @param board
	 * @return
	 */
	public int notifyNewBoardComment(Board board) {
		// 1. 저장
//		int result = notificationDao.insertNotification(conn, notification);
		
		// 2.실시간 알림
		// WebSocket Session 가져오기
		Session wsSession = HelloWebSocket.clientMap.get(board.getWriter());
		if(wsSession != null) {
			Basic basic = wsSession.getBasicRemote();
			try {
				Map<String, Object> payload = new HashMap<>();
				payload.put("messageType", MessageType.NEW_BOARD_COMMENT);
				payload.put("receiver", board.getWriter());
				payload.put("createdAt", System.currentTimeMillis());
				payload.put("message", board.getTitle() + "(" + board.getBoardNo() + ") 게시글에 댓글이 달렸습니다.");
				basic.sendText(new Gson().toJson(payload));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}

	public int notifyNewBoardComment(List<Order> orderList) {
		
		String orderMember = "";
		int orderNum = 0;
		String orderState = "";
		for(Order order : orderList) {
			orderMember = order.getMemberId();
			orderNum = order.getOrderNo();
			orderState = order.getState();
		}
		
		Session wsSession = HelloWebSocket.clientMap.get(orderMember);
		if(wsSession != null) {
			Basic basic = wsSession.getBasicRemote();
			try {
				Map<String, Object> payload = new HashMap<>();
				payload.put("messageType", MessageType.UPDATE_STATE);
				payload.put("receiver", orderMember);
				payload.put("createdAt", System.currentTimeMillis());
				payload.put("message", "주문번호 " + orderNum + "의 주문 처리상태가 " + orderState + "로 변경되었습니다.");
				basic.sendText(new Gson().toJson(payload));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
	
}


