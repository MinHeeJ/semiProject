/**
 * ws.js
 * 로그인한 사용자용 웹소켓 연결처리
 */
const ws = new WebSocket(`ws://${location.host}/semiProject/helloWebSocket`); // 서버측 endpoint 연결
console.log(location.host);

ws.addEventListener('open', (e) => {
	console.log('open : ', e);
});

ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	
	const {messageType, createdAt, message, sender} = JSON.parse(e.data);
	console.log(messageType, createdAt, message, sender);
	
	const wrapper = document.querySelector("#notification");
	const i = document.createElement("i");
	
	switch(messageType){
		
	
		case 'UPDATE_STATE' : 
			i.classList.add("fa-solid", "fa-bell", "bell");
			alert(message);
			i.onclick = () => {
				alert(message);
				i.remove();
			};
			wrapper.append(i);
			break;
				
			
		case 'NEW_BOARD_COMMENT' :
			
			i.classList.add("fa-solid", "fa-bell", "bell");
			i.onclick = () => {
				alert(message);
				i.remove();
			};
			wrapper.append(i);
			break;
	}
});

ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});

ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});

window.addEventListener('beforeunload', () => {
    ws.close(); // 명시적 웹소켓 닫기
});