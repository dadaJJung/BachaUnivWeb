//date format 함수
function time_format(d) {
   year = d.getFullYear();
   month = format_two_digits(d.getMonth());
   day = format_two_digits(d.getDay());
    hours = format_two_digits(d.getHours());
    minutes = format_two_digits(d.getMinutes());
    seconds = format_two_digits(d.getSeconds());
    return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
}

function format_two_digits(n) {
    return n < 10 ? '0' + n : n;
}

//jquery 객체에 사용자 정의 메소드 추가
$.fn.replyBoard = function(opt, replyList){ 
   var templ = $(replyTempl.replyAddTempl);
   var content = templ.find('#reply-content');
   templ.find('#reply-add').click(function(e){
      var reply = {
         boardId: opt.boardId,
         writer: opt.writer,
         parent: 0,
         replyLevel: 0,
         content: content.val()
      };
      
      if(reply.content.length==0){
         return;
      }
      if(reply.writer==''){
         $('#modal').modal('show');
         return;
      }
      
      api.create(reply, function(data){
         data.regDate = time_format(new Date(data.regDate)); //문자열->Date 변환
         content.val(''); //<textarea> 내용 지우기
         templ.find('.counter').text('0 / 140');
         //댓글 리스트에 추가
         opt.replyList.prepend(
               replyTempl.mediaObjectTempl(data, opt.writer));
         //댓글 카운트 증가
         $('.children').find('.reply-expand').hide();
         var totalNum = $('html').find('#total-reNum').text();
         $('html').find('#total-reNum').text(parseInt(totalNum)+1);
      });
   });
   
   this.append(templ);
   return this;
}

//1차원 배열을 트리 구조로 변경
function makeDom(datas){
   var dom = []; //새로 정렬될 데이터 배열
   var objects = {}; //replyId를 키로, reply를 값으로 하는 맵
   datas.forEach(data=>{
      data.regDate = time_format(new Date(data.regDate));
      data.children = []; //하위 댓글을 위한 배열
      objects[data.replyId] = data; //맵 등록
      if(data.parent == 0){ //최상위 댓글
         dom.push(data); //dom 배열에 추가
      }else{
         //하위 댓글인 경우 부모의 children 배열에 추가
         objects[data.parent].children.push(data);
      }
      
   });
   return dom;
}

//트리 구조를 탐색할 Media Object 구조 생성 - 재귀호출
function makeMediaObject(writer, item){
   //단말(leaf) reply (자식이 없는 reply)
   if(item.children.length == 0){
      return replyTempl.mediaObjectTempl(item, writer);
   }
   
   //중간 reply
   var self = replyTempl.mediaObjectTempl(item, writer);
   
   //자식 reply에 대해서 재귀 호출
   item.children.forEach(child=>{
      var child = makeMediaObject(writer, child); //1레벨만 할거면 재귀 필요없으
      self.find('.children').append(child);
   });
   return self;
}

$.fn.replyList = function(opt){
   var self = this;
   //초기 목록 구성
   opt.api.list(function(datas){
      //레벨순, 등록역순 배열을 트리구조 배열로 변환
      makeDom(datas).forEach(
            item=> self.append(makeMediaObject(opt.writer, item))
      );
      //대댓글에는 댓글 등록불가(2레벨까지 운영)
      $('.children').find('.reply-expand').hide();
      //처음엔 대댓글 숨김
      $('.children').hide();
      $('.work').hide();

   });
   
   //대댓글 펼치기, this는 expand 버튼
   function showRereply(e){
      if($(this).closest('.media-body').children('.children').css ('display') == 'none'){
         $(this).closest('.media-body').children('.children').show();
         $(this).closest('.media-body').children('.work').show();
      }else{
         $(this).closest('.media-body').children('.children').hide();
         $(this).closest('.media-body').children('.work').hide();
      }
      
   }
   
   //댓글 등록, this는 하위댓글 등록 버튼
   function createReply(){
      var obj = $(this).closest('.media');
      var reply = {
         boardId: opt.boardId,
         writer: opt.writer,
         parent: parseInt(obj.data('reply-id')),
         replyLevel: parseInt(obj.data('reply-level'))+1,
         content: obj.find('textarea').val()
      }
      
      if(reply.content.length==0){
         return;
      }
      if(reply.writer==''){
         $('#modal').modal('show');
         return;
      }
      
      opt.api.create(reply, function(result){
         if(result){
            result.regDate = new Date(result.regDate);
            obj.find('.children:first').prepend(replyTempl.mediaObjectTempl(result, reply.writer));
            obj.find('.rereply-content').val('');
            $('.children').find('.reply-expand').hide();
            var num = obj.find('.reNum:first').text(); //해당 부모 댓글에 댓글수 증가
            obj.find('.reNum').text(parseInt(num)+1);
            var totalNum = $('html').find('#total-reNum').text(); //전체 댓글수 증가
            $('html').find('#total-reNum').text(parseInt(totalNum)+1);
            obj.find('.counter').text('0 / 140');
         }else{
            alert('댓글 쓰기 실패')
         }
      });
   }
   function countReplyLength(){
       var length = $(this).val().length;
        $(this).parent().find('.counter').html(length + " / 140");
   }
   
   //댓글 수정 창 보이기, this는 수정 버튼
   function showEditPanel(){
      var content = $(this).closest('.media-body').children('.reply-content');
      if(content.find('textarea').length>0)return; //중복 클릭 방지
      var text = content.text(); //현재 내용 추출
      content.empty()
         .data('old', text)   //취소시 복원용 이전 데이터
         .append(replyTempl.editTempl); //수정창 추가
      content.find('textarea').val(text); //수정창에 데이터 설정
      var length = text.length;
      content.find('.counter').html(length + " / 140"); //현재 글자수 표시
   }
   
   //댓글 수정창 제거, this는 취소 버튼
   function hideEditPanel(){
      var text = $(this).parents('.reply-content').data('old'); //이전 데이터 추출
      console.log(text);
      $(this).parents('.reply-content')
         .empty() //현재 내용 제거
         .text(text); //이전 데이터로 복원
   }
   
   //댓글 수정 등록, this는 등록 버튼
   function editReply(){
      var obj = $(this).parents('.reply-content');
      var reply = {
         replyId: $(this).closest('.media').data('reply-id'),
         content: obj.find('textarea').val()
      };
      
      api.update(reply, function(result){
         if(result){
            result.regDate = new Date(result.regDate);
            obj.empty().text(reply.content);
         }else{
            alert('수정 실패');
         }
      });
   }
   
   //댓글 삭제 이벤트 핸들러, this는 삭제 버튼
   function deleteConfirm(){
      var self = $(this);
      var media = $(this).closest('.media');
      $('#modal2').data('reply-id', media.data('reply-id')).modal('show');
   }
   
   //대댓글 펼치기
   this.on('click', '.reply-expand', showRereply);
   
   //하위 댓글 추가 관련
   this.on('click', '.reply-add', createReply);
   this.on('keyup', '.rereply-content', countReplyLength);
   
   //댓글 수정 관련 이벤트 핸들러 등록
   this.on('click', '.reply-edit-show', showEditPanel);
   this.on('click', '.reply-edit-cancel', hideEditPanel);
   this.on('click', '.reply-edit', editReply);
   this.on('keyup', '.reply-edit-content', countReplyLength);
   
   //댓글 삭제 이벤트 핸들러
   this.on('click', '.reply-delete', deleteConfirm);
   
   return this;
}
