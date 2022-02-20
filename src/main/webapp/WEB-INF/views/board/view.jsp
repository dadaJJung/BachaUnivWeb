<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url value="/api/reply/${board.boardId}" var="apiUrl" />
<script src="<c:url value="/resources/js/rest.js"/>"></script>
<script src="<c:url value="/resources/js/reply.templ.js"/>"></script>
<script src="<c:url value="/resources/js/reply.js"/>"></script>
<script>
   var api = new Rest('${apiUrl}');
   $(function() {
      var opt = {
         api : api, //Ajax 통신 지원 객체
         boardId : '${board.boardId}', //현재 게시글
         writer : '${USER.studentNumber}',//신규 댓글 작성자 ID
         replyList : $('#reply-list')
      //댓글 목록 엘리먼트
      };

      //전체 댓글 펼치기 접기
      $('#total-reply-cnt').click(function() {
         if ($('#reply-list').css('display') == 'none') {
            $('#reply-list').show();
            $('#reply-board').show();
         } else {
            $('#reply-list').hide();
            $('#reply-board').hide();
         }
      });

      $('#reply-board').replyBoard(opt);
      $('#reply-list').replyList(opt);

      //맨 위 게시물 댓글 등록창(글자수 세기)
      $('#reply-content').keyup(function() {
         var length = $(this).val().length;
         $(this).parent().find('.counter').html(length + " / 140");
      });
      
      //modal 댓글 삭제 확인
      $('#btnYes').click(function() {
          // handle deletion here
           var id = $('#modal2').data('reply-id');
           var media = $('.media[data-reply-id='+id+']');
           opt.api.remove(id, function(result){ //replyId 추출
            if(result){
               media.find('.reply-content').eq(0).text('This comment has been deleted');
               media.find('.reply-edit-show').remove(); 
               media.find('.reply-delete').remove(); 
            }else{
               alert('삭제 실패');
            }
         });
           $('#modal2').modal('hide');
      });
      
      $('#board-delete').click(function(e) {
         e.preventDefault();
         $('#modal3').modal('show');
      });
      
      //modal 게시물 삭제 확인
      $('#btnYes2').click(function() {
         window.location.href = "../delete/${board.boardId}";
           $('#modal3').modal('hide');
      });
      
   });
</script>

<div class="container">
   <div class="py-5 px-5">
      <h4>Board</h4>
      <hr class="style10" style="width: 100%">

      <div class="bbs-table-view">

         <table class="info-box">
            <col style="width: 13%;">
            <col style="width: auto;">
            <thead>
               <tr>
                  <th><div>TITLE</div></th>
                  <td><div>${board.title}</div></td>
               </tr>
               <tr>
                  <th><div>WRITER</div></th>
                  <td><div>dahye ( ${board.writer} )</div></td>
               </tr>

               <tr>
                  <th><div>ATTACHMENTS</div></th>
                  <td><div>
                        <c:forEach var="file" items="${board.attachments}">
                           <div>
                              <a href="../download/${file.attachmentId}"> <i
                                 class="fa fa-download"></i> ${file.fileName}
                              </a>
                           </div>
                        </c:forEach>
                     </div></td>
               </tr>

               <tr>
                  <th><div>UPDATE / REGISTER</div></th>
                  <td><div>
                        <fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd" />
                        /
                        <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />

                     </div></td>
               </tr>

               <tr>
                  <th><div>VC</div></th>
                  <td><div>${board.readCnt}</div></td>
               </tr>
            </thead>
         </table>
      </div>

      <div class="board_content">${board.content}</div>

      <div class="row justify-content-end mx-auto">
         <div class="board_button">
            <c:if test="${USER.studentNumber==board.writer}">
               <span><a href="../edit/${board.boardId}" class="mr-3"> <i
                     class="fa fa-edit mr-2"></i>EDIT
               </a></span>
               <span><a href="#" id="board-delete" class="mr-3"><i
                     class="fa fa-trash mr-2"></i>DELETE</a></span>
            </c:if>
            <span><a href="../list" class="mr-2"> <i
                  class="fa fa-undo mr-2"></i>LIST
            </a></span>
         </div>
      </div>


      <!-- 전체 댓글수 -->
      <a id="total-reply-cnt"><span id="total-reNum">${board.replyNum}</span>
         REPLIES <i class="fa fa-angle-down"></i></a>
      <hr>
      <!-- 댓글 쓰기 영역 -->
      <div id="reply-board"></div>
      <!-- 댓글 목록 영역 -->
      <div id="reply-list"></div>
   </div>
   
   <!-- Modal -->
   <div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-exclamation-triangle"></i> Warning</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
           You are not logged in. Please log in and try again.
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           <a href="${root}login" type="button" class="btn btn-primary">Login</a>
         </div>
       </div>
     </div>
   </div>
   
   <!-- Modal2 -->
   <div id="modal2" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-exclamation-triangle"></i> Warning</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
            Are you sure you want to delete?
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
           <button id="btnYes" type="button" class="btn btn-danger">Delete</button>
         </div>
       </div>
     </div>
   </div>
   
   <!-- Modal3 -->
   <div id="modal3" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-exclamation-triangle"></i> Warning</h5>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
            Are you sure you want to delete?
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
           <button id="btnYes2" type="button" class="btn btn-danger">Delete</button>
         </div>
       </div>
     </div>
   </div>
</div>