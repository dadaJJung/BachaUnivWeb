
var replyTempl = {
      replyAddTempl:`
      <div class="card card-body p-2">
         <label for="reply-content">comment</label>
         <textarea id="reply-content" class="card-text" rows=4 placeholder="Write something here..." maxlength="140"></textarea>
         <div class="flex-row text-right">
            <span class="counter">0 / 140</span>
            <a id="reply-add" class="card-link btn btn-primary btn-sm">
               REPLY
            </a>
         </div>
      </div>`,
      
      //한 개의 Reply에 대응하는 Media Object 생성
      mediaObjectTempl: function(reply, writer){
         var obj = $(`<hr>
         <div class="media d-block d-md-flex mt-3"
            data-reply-id="${reply.replyId}"
            data-reply-level="${reply.replyLevel}">
            
            <img class="d-flex mb-3 mx-auto avatar rounded-circle" 
               width="80" src="/Bacha/student/avatar?studentNumber=${reply.writer}">
            <div class="media-body text-center text-md-left ml-md-3 ml-0">
               <div style="overflow:hidden">
                  <p class="mt-0 mb-2 font-weight-bold float-left">
                     ${reply.writerName} (${reply.writerMajor})
                  </p>
                  <div class="buttons float-right ml-3"></div>
               </div>
               <div class="reply-content">${reply.content}</div>
               <div class="reply-date">${reply.regDate}</div>
               <div class="work" style="display:none;">
                  <hr>
                  <div class="card card-body p-2">
                     <label for="rereply-content">comment</label>
                     <textarea class="rereply-content card-text" rows=4 placeholder="Write something here..." maxlength="140"></textarea>
                     <div class="flex-row text-right">
                        <span class="counter">0 / 140</span>
                        <a class="reply-add card-link btn btn-primary btn-sm">
                           REPLY
                        </a>
                     </div>
                  </div>
               </div>
               <div class="children"></div>
            </div>
         </div>`);
         //로그인 사용자에 따라 버튼의 종류 구분하여 추가
         this.buttonsTempl(obj, reply, writer);
         return obj;
      },
      
      buttonsTempl: function(item, reply, writer){
/*         if(reply.rereplyNum>0){*/
            item.find('.buttons').append(`<a class="reply-expand btn1"><span class="reNum">${reply.rereplyNum}</span> REPLIES&nbsp;&nbsp;</a>`);
/*         }*/
         
         //삭제글이 아닌 경우
         if(!reply.deleted){
/*            //로그인 사용자인 경우 댓글 버튼 추가
            if(writer!=''){
               item.find('.buttons').append('<a class="reply-add-show btn1">&nbsp;&nbsp;REPLY&nbsp;&nbsp;</a>');
            }*/
            //자신이 작성한 댓글인 경우 수정 버튼과 삭제 버튼 추가
            if(reply.deleted==0 && reply.writer==writer){
               item.find('.buttons').append(
                  '<a class="reply-edit-show btn1">&nbsp;&nbsp;EDIT&nbsp;&nbsp;</a>'+
                  '<a class="reply-delete btn1">&nbsp;DELETE</a>');
            }
         }else{
            item.addClass('deleted-reply');
         }
      }/*,
      
      //하위 댓글 추가 템플릿
      addTempl: `
         <textarea></textarea>
         <button class="reply-add">
            <i class="fa fa-share-square"></i></button>
         <button class="reply-cancel">
            <i class="fa fa-undo"></i></button>`,
   
      editTempl: `
         <textarea></textarea>
         <button class="reply-edit">
            <i class="fa fa-share-square"></i></button>
         <button class="reply-edit-cancel">
            <i class="fa fa-undo"></i></button>`
            */
      ,
      editTempl: `
      <div class="card card-body p-2">
         <textarea class="reply-edit-content card-text" rows=4 maxlength="140"></textarea>
         <div class="flex-row text-right">
            <span class="counter">0 / 140</span>
            <a class="reply-edit card-link btn btn-pink btn-sm mx-1">
               EDIT
            </a>
            <a class="reply-edit-cancel card-link btn btn-pink btn-sm mx-1">
               CANCEL
            </a>
         </div>
      </div>`

}