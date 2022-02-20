//Date 객체에 날짜 출력 문자열 포맷팅 prototype 메서드 정의
Date.prototype.toString = function() {
	var year = this.getFullYear();
	var month = this.getMonth() + 1;
	month = month < 10 ? '0' + month : month;
	var date = this.getDate();
	date = date < 10 ? '0' + date : date;
	return year + '-' + month + '-' + date;
}
Date.prototype.toDatetime = function() {
	var hour = this.getHours();
	hour = hour < 10 ? '0' + hour : hour;
	var minute = this.getMinutes();
	minute = minute < 10 ? '0' + minute : minute;
	var second = this.getSeconds();
	second = second < 10 ? '0' + second : second;
	return this.toString() + ' ' + hour + ':' + minute + ':' + second;
}