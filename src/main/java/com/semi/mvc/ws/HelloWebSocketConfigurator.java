package com.semi.mvc.ws;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import com.semi.mvc.member.model.vo.Member;

public class HelloWebSocketConfigurator extends Configurator {
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		System.out.println("HelloWebSocketConfigurator#modifyHandshake 실행");
		HttpSession httpSession = (HttpSession) request.getHttpSession();
		
		// memberId 관리
		Member loginMember = (Member) httpSession.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		Map<String, Object> configProperties = sec.getUserProperties();
		configProperties.put("memberId", memberId);
		
		// 채팅방 접속시 chatroomId 관리
		String chatroomId = (String) httpSession.getAttribute("chatroomId");
		if(chatroomId != null) {
			configProperties.put("chatroomId", chatroomId);
			// 채팅방을 벗어나는 경우
			httpSession.removeAttribute("chatroomId");
		}
		
		
	}
}





