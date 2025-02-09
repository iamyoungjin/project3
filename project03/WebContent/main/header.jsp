<%@page import="test.web.project03.MemberDAO"%>
<%@page import="java.net.CookieStore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펜션에 오신걸 환영합니다.</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>

<!-- 헤더페이지 -->
<%	//test develop 
	String boardType = "main";
	MemberDAO memdao = MemberDAO.getInstance();
	String sId = (String)session.getAttribute("sId");
	String sAdmin = (String)session.getAttribute("sAdmin");
	if(session.getAttribute("sId") == null && session.getAttribute("sAdmin") == null ){
		String id = null, pw = null, auto = null;
		Cookie [] coo = request.getCookies();
		if(coo!=null){
			for(Cookie ck : coo){
				if(ck.getName().equals("cId")) id= ck.getValue();
				if(ck.getName().equals("cPw")) pw= ck.getValue();
				if(ck.getName().equals("cAuto")) auto= ck.getValue();
			}
		}
		if(id!=null && pw!=null && auto!=null){
			response.sendRedirect("../login/loginPro/jsp");
		}
	}else if(session.getAttribute("sId")!=null){
		if(memdao.chkInfoSnsLogin(sId)){%>
			<script>
				alert("개인 정보를 입력해주세요!");
				window.location.href="../mypage/modifyForm.jsp";
			</script>
		<%}
	}

%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">호리네 민박</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="../main/main.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <%if(sId == null && sAdmin == null){ %>
      <li class="nav-item">
        <a class="nav-link" href="../sign/signUpMain.jsp?boardType=<%=boardType%>">회원가입</a>
      </li>
      <%}else if(sId != null & sAdmin == null){ %>
      <li class="nav-item">
        <a class="nav-link" href="../mypage/mypage.jsp">마이페이지</a>
      </li>
      <%}else if(sId == null & sAdmin != null){ %>
      <li class="nav-item">
        <a class="nav-link" href="../adminpage/adminpage.jsp">관리자페이지</a>
      </li>
      <%} %>
      
<%		if(sId==null && sAdmin==null){ %>
      <li class="nav-item">
        <a class="nav-link" href="../login/loginForm.jsp">로그인</a>
      </li>
<%		}else{ %>
      <li class="nav-item">
        <a class="nav-link" href="../login/logout.jsp?boardType=<%=boardType%>">로그아웃</a>
      </li>
<%		}%>
      
      <li class="nav-item">
        <a class="nav-link" href="../reservation/reservationCalendar.jsp">예약하기</a>
      </li>
      
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         게시판 
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="../qnaboard/qnaboardlist.jsp">문의 게시판</a>
          <a class="dropdown-item" href="../board/boardList.jsp">자유 게시판</a>
        </div>
      </li>
      
      
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         About호리네민박
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="../introduce/roomIntro.jsp">방 소개</a>
          <a class="dropdown-item" href="../etc/directions.jsp">찾아오시는 길</a>
        </div>
      </li>
      <%
      if(sId == null && sAdmin != null){
    	  sId = sAdmin;
      }
      
      if(sId != null){%>
      <li class="nav-item">
      		<a class="nav-link"><%= memdao.searchName(sId) %>님 환영합니다.</a>
      </li>
      <%} %>

      
    </ul>

  </div>
</nav>

</body>
</html>