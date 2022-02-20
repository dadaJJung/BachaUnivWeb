class Rest{
   constructor(url){
      this.url = url; //api URL
   }
   
   //목록 얻기
   list(callback){
      $.get(this.url, callback);
   }
   
   //항목 하나 얻기
   get(id, callback){
      $.get(this.url + '/' + id, callback);
   }

   create(data, callback){
      $.ajax({
         url: this.url,
         type: 'post',
         contentType: 'application/json',
         data: JSON.stringify(data),
         success: callback
      });
   }
   
   update(data, callback){
      return $.ajax({
         url: this.url,
         type: 'put',
         contentType: 'application/json',
         data: JSON.stringify(data),
         success: callback
      });
   }
   
   remove(id, callback){
      return $.ajax({
         url: this.url + '/' + id,
         type: 'delete',
         success: callback
      });
   }
}