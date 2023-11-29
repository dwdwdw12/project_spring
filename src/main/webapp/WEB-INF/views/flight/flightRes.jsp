<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header2.jsp"%>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
<!-- Google web font "Open Sans" -->
<link rel="stylesheet"
	href="../resources/font-awesome-4.7.0/css/font-awesome.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<!-- Bootstrap style -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="../resources/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="../resources/slick/slick-theme.css" />
<link rel="stylesheet" href="../resources/css/templatemo-style.css">
<!-- Templatemo style -->

<script src="../resources/js/vendor/modernizr.custom.min.js"></script>
<link rel="stylesheet" href="../resources/css/normalize.css">

<!-- import import -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<!-- 이미지로더 -->
<script src="http://mattstow.com/experiment/responsive-image-maps/jquery.rwdImageMaps.min.js"></script>
<style>
img{
max-width: 100%;
}

.slideshow {
	height: 465px;
	overflow: hidden; /*높이와 overflow만 잡아주면 이미지 중첩됨*/
	position: relative;
}

.slideshow img {
	position: absolute;
	/*이미지 위치 가운데로 옮기기*/
	left: 50%; /*오른쪽으로 50% 밀고 margin으로 위치 조정*/
	margin-left: -800px;
	display: none;
}
</style>

<div class="tm-page-wrap mx-auto">
	<section class="tm-banner">

		<!-- .tm-container-outer -->
		<div class="inner">
			<div class="slideshow">
				<img src="../resources/img/tm-img-01.jpg" alt="" width="1600"
					height="1000"> <img src="../resources/img/tm-img-02.jpg"
					alt="" width="1600" height="1000"> <img
					src="../resources/img/tm-img-03.jpg" alt="" width="1600"
					height="1000"> <img src="../resources/img/tm-img-04.jpg"
					alt="" width="1600" height="1000">
			</div>
		</div>
	</section>

	<section class="p-5 tm-container-outer tm-bg-gray">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
					<h2 class="text-uppercase mb-4">
						비행기 티켓 결제 정보
					</h2>
					<p class="mb-4">Nullam auctor, sapien sit amet lacinia euismod,
						lorem magna lobortis massa, in tincidunt mi metus quis lectus.
						Duis nec lobortis velit. Vivamus id magna vulputate, tempor ante
						eget, tempus augue. Maecenas ultricies neque magna.</p>
					<!-- 					<a href="#" class="text-uppercase btn-primary tm-btn">Continue
						explore</a> -->
						<div>

						<input type="hidden" id="fno" value="${fno}">
						
						
						</div>
						<div class="card-body bg-white mt-0 shadow">
                <!-- <p style="font-weight: bold">카카오페이 현재 사용가능</p> -->
                	<div class="form-row tm-search-form-row">
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="userid">결제자</label> 
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="userid" type="text" class="form-control" id="userid" value="${userid}" readonly="readonly">
						</div>
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="userid">연락처(이메일)</label> 
						</div>
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="email" type="text" class="form-control" id="email" value="${email}" readonly="readonly">
						</div>
					</div>
					
					<div class="form-row tm-search-form-row"><label for="totalPay"></label></div>
					
					<div class="form-row tm-search-form-row">
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="vo">항공정보</label> 
						</div>
							<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="vo" type="text" class="form-control" id="vo" value="${vo.depName}=> ${vo.arrName} , ${vo.fullDeptime}" readonly="readonly">
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="seat">좌석정보</label> 
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="seat" type="text" class="form-control" id="seat" value="${seat}" readonly="readonly">
						</div>
					</div>

					<div class="form-row tm-search-form-row"><label for="totalPay"></label></div>

					<div class="form-row tm-search-form-row">
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
				            <label class="checkbox-test">
				            <input type="checkbox" class="checkbox-test" id="pointUse1">마일리지 사용</label>
						</div>
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="pointUse2" type="text" class="form-control" id="pointUse2" value="0" readonly="readonly" >
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
				            <label class="checkbox-test">마일리지 금액</label>
						</div>
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="point" type="text" class="form-control" id="point" value="${point}" readonly="readonly">
						</div>
					</div>
					
					<div class="form-row tm-search-form-row"><label for="totalPay"></label></div>
					
					<div class="form-row tm-search-form-row">
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
	                		<label class="checkbox-test">
				            <input type="checkbox" class="checkbox-test" id="kakaoPUse1">카카오페이 사용</label>
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="kakaoPUse2" type="text" class="form-control" id="kakaoPUse2" value="0" readonly="readonly">
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
	                		<label class="checkbox-test">카카오페이 금액</label>
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="kakaoP" type="text" class="form-control" id="kakaoP" value="${kakaoP}" readonly="readonly">
						</div>
					</div>
					
					<div class="form-row tm-search-form-row"><label for="totalPay"></label></div>
					
					<div class="form-row tm-search-form-row">
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="total">총 결제금액</label> 
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="total" type="text" class="form-control" id="total" value="${total}" readonly="readonly">
						</div>
	                	<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<label for="totalPay">최종결제금액</label> 
						</div>
						<div class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
							<input name="totalPay" type="text" class="form-control" id="totalPay" value="${total}" readonly="readonly">
						</div>
					</div>
					<div class="form-row tm-search-form-row"><label for="totalPay"></label></div>
                <button type="button" class="btn btn-primary btn-lg btn-block btn-custom" id="charge_kakao">결 제</button>
 </div>
					
				</div>
			</div>		
					
		</div>
	</section>
	
	
</div>
<!-- .tm-container-outer -->
<%@ include file="../includes/footer.jsp"%>
 <script>
 window.onload = function () {
    $("#pointUse1").click(function(){
        var chk = $(this).is(":checked");
        
        if(chk == true){
        	$("#pointUse2").removeAttr("readonly");
        	var pointVal = $("#pointUse2").val();
        }else{
        	$("#pointUse2").val("0");
        	$("#pointUse2").attr("readonly","readonly");
        }
        updatePayment();
    });
    
    $("#kakaoPUse1").click(function(){
        var chk = $(this).is(":checked");
        
        if(chk == true){
        	$("#kakaoPUse2").removeAttr("readonly");
        	var kpoint = $("#kakaoPUse2").val();
        }else{
        	console.log("fff");
        	$("#kakaoPUse2").val("0");
        	$("#kakaoPUse2").attr("readonly","readonly");
        	
        }
        updatePayment();
    }); 
    
    function updatePayment(){
    	var total = parseInt($("#total").val()) || 0; // 총 결제금액 가져오기
        // 카카오페이 사용 체크 여부 확인
        if ($("#kakaoPUse1").is(":checked")) {
            var kakaoP = parseInt($("#kakaoPUse2").val()) || 0; // 카카오페이 금액 가져오기
            total -= kakaoP; // 카카오페이 금액 빼기
        }
    	
        // 포인트 사용 체크 여부 확인
        if ($("#pointUse1").is(":checked")) {
            var mileage = parseInt($("#pointUse2").val()) || 0; // 마일리지 금액 가져오기
            total -= mileage; // 마일리지 금액 빼기
        }
        
        // 최종결제금액 표시
        $("#totalPay").val(total);
    }
 }

</script>
<script>

    $('#charge_kakao').click(function () {
        // getter
        var IMP = window.IMP;
        IMP.init('imp80062786');
       // var money = $('input[name="cp_item"]:checked').val();
       // console.log(money);
        var pointVal = $("#pointUse2").val();
        var kpoint = $("#kakaoPUse2").val();
        var name = $("#userid").val();
        var total = $("#total").val();
        var seat = $("#seat").val();
        var fno = $("#fno").val();
        var mail = $("#email").val();
        
        if(pointVal.length == 0){pointVal = 0};
        if(kpoint.length == 0){kpoint = 0};

        IMP.request_pay({
            pg : 'danal_tpay',
            pay_method : 'card',
            merchant_uid: 'merchant_' + new Date().getTime(), //상점에서 생성한 고유 주문번호
            name : '주문명:결제테스트',
            amount : 100,
            buyer_email : mail,
            buyer_name : name,
            buyer_tel : '010-1234-5678',
            buyer_addr : mail,
            buyer_postcode : '123-456',
            biz_num : '9810030929'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                $.ajax({
                    type: "POST", 
                    url: "/flight/rescomplete",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                    	//imp_uid : rsp.imp_uid,
                        //"amount" : 100,
                        point : pointVal,
                        kakao : kpoint,
                        total : total,
                        fno : fno,
                        seat : seat,
                        userid : name
                    })
                }).done(function(data){
                	if ( everythings_fine ) {
            			var msg = '결제가 완료되었습니다.';
            			msg += '\n고유ID : ' + rsp.imp_uid;
            			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
            			msg += '\결제 금액 : ' + rsp.paid_amount;
            			msg += '카드 승인번호 : ' + rsp.apply_num;
            			
            			alert(msg);
            		} else {
            			document.location.href="/flight/reservation";
            		}
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            document.location.href="/flight/rescompleteMeg?userid="+name; //alert창 확인 후 이동할 url 설정 
        });
    });
</script>


<script type="text/javascript">
	$(function() {
		$('.slideshow').each(function() {
			// each : 앞에 선택된 내용의 개수만큼 반복하도록 하는 메서드
			let $slides = $(this).find("img");
			let slideCount = $slides.length;
			let currentIndex = 0;
			$slides.eq(currentIndex).fadeIn();
			// 첫 이미지를 나타나게 함

			// 다음이미지가 나타나게 끔->현재 이미지를 페이드아웃하고 다음이미지를 나타나게 하고 현재이미지값으로 변경시켜서 로테이션돌게 함
			let showNextSlide = function() {
				let nextIndex = (currentIndex + 1) % slideCount;
				// 다음이미지의 인덱스 값을 구하는데 이미지가 4개이므로 최대값이 3이되어야 함 따라서 나머지 연산자를 통해 반복하도록 함(1~4의 값을 4로 나누므로 0~3을 반복시킴-어차피 0은 위에서 표시되도록 했으니까.....?)
				$slides.eq(currentIndex).fadeOut();
				// 현재 이미지를 사라지게 하고
				$slides.eq(nextIndex).fadeIn();
				// 위에서 구한 다음 이미지를 나타나게 함
				currentIndex = nextIndex;
				// 다음 이미지의 값을 현재로 
			}

			let timer = setInterval(showNextSlide, 1000);
			$(this).on('mouseover', function() {
				//타이머 취소
				clearInterval(timer);
			}).on('mouseout', function() {
				//타이머 시작
				timer = setInterval(showNextSlide, 1000);
			})
		})
	});

	// Slick Carousel
	$('.tm-slideshow').slick({
		infinite : true,
		arrows : true,
		slidesToShow : 1,
		slidesToScroll : 1
	});
</script>