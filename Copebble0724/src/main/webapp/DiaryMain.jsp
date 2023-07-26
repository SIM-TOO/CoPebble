<%@page import="java.util.ArrayList"%>
<%@page import="com.smhrd.model.DiaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="./css/diary_main.css">
<link rel="stylesheet" href="./css/main.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

* {
	font-family: "Noto Sans KR", sans-serif;
}
</style>
</head>
<body>
	<!--헤더-->

	<header class="header_main mt-3 ">
		<div style="width: 20%;"></div>

		<div style="width: 10%; min-width: 150px;">
			<a href="Main.jsp"> <img class="header_logo" src="mainlogo.png"
				alt="">
			</a>


		</div>

		<div style="width: 45%; min-width: 100px;">
			<a href="DiaryMain.jsp" class="baby_diary"> <p1>육아 다이어리</p1>
			</a>
		</div>

		<div style="width: 2%; min-width: 20px;">
			<a href="mypage.html" class="header_icon_mypage"> <i
				class="fa-solid fa-gear" style="font-size: 30px; color: #000000;"></i>
			</a>
		</div>
		<div style="width: 2%; min-width: 20px;">

			<a href="#" class="header_icon_logout"> <i
				class="fa-solid fa-right-from-bracket"
				style="font-size: 30px; color: #000000;"></i>
			</a>
		</div>
		<div style="width: 21%;"></div>
	</header>
	<p></p>
	<c:set var="DIARY_list" value="${DiaryDAO.showDiary()}"></c:set>
	<div class="diary_top_div">

		<!-- 상단바 -->
		<div class="diary_header">
			<img src="./img/baby.png" alt="포대기 아기 사진">
			<div class="diary_baby_div">육아 다이어리</div>
			<div class="diary_icon_div">
				<div>
					오래된순<i class="fa-solid fa-caret-up" onclick="DESC()"></i>
				</div>
				<div class="plus_icon_div" onclick="goToWrite()">
					<i class="fa-solid fa-plus"></i>
				</div>
			</div>
		</div>

		<!-- 아래 큰 div -->
		<div class="diary_main_div">
			<div class="diary_name_div">김민국(만9세)</div>
			<div class="diary_card_container">

				<c:set var="prevDate" value="" />

				<c:forEach items="${DIARY_list}" var="DIARY" varStatus="status">
					<div class="diary_card">
						<c:if test="${DIARY.ALLDATE.substring(0, 10) ne prevDate}">
							<div class="diary_date_div">${DIARY.ALLDATE.substring(0, 10)}</div>
							<c:set var="prevDate" value="${DIARY.ALLDATE.substring(0, 10)}" />
						</c:if>

						<div class="diary_card_item_div"
							onclick="goToDetail('${DIARY.NUM}')"
							ondblclick="showDeleteModal(this)">
							<img src="./img/${DIARY.FILENAME}" alt="아이이미지">
							<div class="diary_card_detail_div">
								<div class="diary_card_detail_title_div">${DIARY.TITLE}</div>
								<div>${DIARY.DIARY}</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- Pagination navigation -->
			<div class="pagination">
				<i class="fa-solid fa-circle-chevron-left fa-2x"
					onclick="prevPage()"></i> <i
					class="fa-solid fa-circle-chevron-right fa-2x" onclick="nextPage()"></i>
			</div>
		</div>

		<script>
    // JavaScript code for pagination
    const diaryCards = document.querySelectorAll('.diary_card');
    const itemsPerPage = 5;
    let currentPage = 0;

    function showPage(page) {
        const startIndex = page * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;

        diaryCards.forEach((card, index) => {
            if (index >= startIndex && index < endIndex) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    function nextPage() {
        currentPage++;
        showPage(currentPage);
    }

    function prevPage() {
        currentPage--;
        if (currentPage < 0) {
            currentPage = 0;
        }
        showPage(currentPage);
    }

    // Show the first page on initial load
    showPage(currentPage);
</script>
		<script>

		function goToDetail(index) {
			console.log(index)
			location.href = 'DiaryDetail.jsp?num='+index
		}
		
		function goToWrite(){
			location.href = 'DiaryWrite.jsp'
		}
		
		function DESC(){
			location.href = 'Diary_DESC.jsp'
		}
		
		

	</script>

		</script>
</body>
</html>