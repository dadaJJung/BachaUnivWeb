<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<table class="table table-sm">
   <thead class="thead-light">
      <tr>
         <th class="text-center" scope="col" style="width: 10%">No</th>
         <th scope="col" style="width: 55%">Title</th>
         <th scope="col" style="width: 5%">File</th>
         <th scope="col" style="width: 10%">Writer</th>
         <th scope="col" style="width: 10%">Date</th>
         <th class="text-center" scope="col" style="width: 10%">VC</th>
      </tr>
   </thead>
   <tbody>
      <!-- Notice -->
      <c:forEach var="board" items="${listNotice}">
         <tr class="table-notice">
            <td class="text-center"><span class="badge badge-info">Notice</span></td>
            <td><a href="board/view/${board.boardId}" class="text-dark">${board.title}
                  <span style="color: rgb(238, 55, 51);" class="font-weight-bold">
                     (${board.replyNum})</span>
            </a></td>
            <td><c:choose>
                  <c:when test="${board.hasAttachment}">
                     <i class="fa fa-file"></i>
                  </c:when>
                  <c:when test="${board.hasAttachment}">
                     <i></i>
                  </c:when>
               </c:choose></td>
            <td>${board.writerName}</td>
            <td><fmt:formatDate value="${board.regDate}"
                  pattern="yyyy-MM-dd" /></td>
            <td class="text-center">${board.readCnt}</td>
         </tr>
      </c:forEach>

      <!-- Not Notice -->
      <c:forEach var="board" items="${list}" varStatus="status">
         <tr>
            <td class="text-center">${board.seq}</td>
            <td><a href="board/view/${board.boardId}" class="text-dark">${board.title}
                  <span style="color: rgb(238, 55, 51);" class="font-weight-bold">
                     (${board.replyNum})</span>
            </a></td>
            <td><c:choose>
                  <c:when test="${board.hasAttachment}">
                     <i class="fa fa-file"></i>
                  </c:when>
                  <c:when test="${board.hasAttachment}">
                     <i></i>
                  </c:when>
               </c:choose></td>
            <td>${board.writerName}</td>
            <td><fmt:formatDate value="${board.regDate}"
                  pattern="yyyy-MM-dd" /></td>
            <td class="text-center">${board.readCnt}</td>
         </tr>
      </c:forEach>
   </tbody>
</table>