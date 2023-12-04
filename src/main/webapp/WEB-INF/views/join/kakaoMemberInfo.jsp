<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header2.jsp"%>
<style>
.id_ok {
	font-size: small;
	color: #008000;
	display: none;
}

.id_already {
	font-size: small;
	color: rgb(201, 0, 0);
	display: none;
}

.userNick_ok {
	font-size: small;
	color: #008000;
	display: none;
}

.userNick_already {
	font-size: small;
	color: rgb(201, 0, 0);
	display: none;
}

.userPwd_ok {
	font-size: small;
	color: #008000;
	display: none;
}

.userPwd_already {
	font-size: small;
	color: rgb(201, 0, 0);
	display: none;
}
</style>

<div class="tm-page-wrap mx-auto">
	<section class="tm-banner">
		<div class="tm-container-outer ">
			<div class="container">
				<!-- <div class="row tm-banner-row" id="tm-section-search"></div> -->
				<!-- row -->
			</div>
			<!-- .container -->
		</div>
		<!-- .tm-container-outer -->
	</section>

	<section class="tm-page-wrap-allwhite">
		<div align="center">
			<div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
				<h2 class="text-uppercase mb-4">추가 정보 입력</h2>
				<h6>카카오 항공의 서비스를 보다 편리하게 이용하기 위하여 추가적인 정보를 입력해주시기 바랍니다.</h6>
				<br> <br>
			</div>
		</div>



		<form action="/join/kakaoMemberInfo" name="frm" method="post"
			style="margin: auto;">
			<!-- class="tm-contact-form" -->

			<table
				style="margin: auto; width: 800px; border-top: 0.1px solid rgb(220, 220, 220); border-bottom: 0.1px solid rgb(220, 220, 220);">


				<tbody>
					<tr>
						<th scope="row" style="padding: 8px;">영문명<span
							class="icon_require" style="color: red; font-size: x-small;">
								*</span></th>
						<td style="padding: 8px"><input type="text" id="userNameE"
							name="userNameE" placeholder="영문 명 입력 (예 : HONGGILDONG)"
							title="영문 명 입력 (예 : HONGGILDONG)"
							style="width: 200px; display: inline; text-transform: uppercase;"
							maxlength="10" class="input_userNameE; form-control"
							oninput="handleOnInputEng(this)" required="required"></td>
					</tr>
					<tr>
						<th scope="row" style="padding: 8px;">주민등록번호<span
							class="icon_require" style="color: red; font-size: x-small;">
								*</span></th>
						<td style="padding: 8px">
							<!-- 						<div class="info" id="info__birth">
						  <select class="box" id="birth-year" name="birthYear">
						    <option disabled selected>출생 연도</option>
						  </select>
						  <select class="box" id="birth-month" name="birthMonth">
						    <option disabled selected>월</option>
						  </select>
						  <select class="box" id="birth-day" name="birthDay"> 
						    <option disabled selected>일</option>
						  </select>
						</div> -->

							<div>
								<input class="form-control" type="text" name="userReginumFirst"
									oninput="handleOnInput(this, 6); this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							</div>


						</td>
						<td>
							<div>
								<input class="form-control" type="password"
									name="userReginumLast"
									oninput="handleOnInput(this, 7); this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" style="padding: 8px;"><label
							for="input_address">주소<span class="icon_require"
								style="color: red; font-size: x-small;"> *</span>
						</label></th>
						<td style="padding: 8px" id="korea_address"><input
							type="text" id="sample6_postcode" name="postCode"
							placeholder="우편번호" class="form-control"
							style="width: 200px; display: inline;"> <input
							type="button" onclick="sample6_execDaumPostcode()"
							id="input_address" value="우편번호 찾기" class="btn btn-primary"
							style="display: inline;"><br> <br> <input
							type="text" name="addressDefault" id="sample6_address"
							placeholder="주소" class="form-control" style="width: 250px"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소"
							class="form-control" name="addressDetail"
							style="display: inline; width: 250px; display: inline;">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목"
							style="width: 250px; display: inline;" class="form-control">


							<p style="color: gray; margin-top: 10px; font-size: 0.8em;">제공해주신
								주소는 이벤트 또는 우수회원 승급 서비스 제공을 위해 이용됩니다.</p>

							<p class="txt_error_Msg" id="error_koreaAddress"
								style="display: none;"></p></td>
						<td id="usa_address" style="display: none;">
							<p>
								<input type="text" id="input_usDefaultAddress"
									placeholder="기본 주소" title="기본 주소" style="width: 400px;">
								<input type="text" id="input_usDetailAddress"
									placeholder="상세 주소" title="상세 주소" style="width: 400px;">
							</p>
							<p class="mar_to15">
								<input type="text" id="input_usCity" placeholder="도시(City)"
									title="도시(City)" style="width: 257px;"> <input
									type="text" id="input_usState" placeholder="주(State)"
									title="주(State)" style="width: 257px;"> <input
									type="text" id="input_usZipCode" placeholder="우편번호(Zip Code)"
									title="우편번호(Zip Code)" style="width: 257px;">
							</p>
							<ul class="list_type3 fsz_14 mar_to10">
								<li>제공해주신 주소는 이벤트 또는 우수회원 승급 서비스 제공을 위해 이용됩니다.</li>

							</ul>
							<p class="txt_error_Msg" id="error_usAddress"
								style="display: none;"></p>
						</td>

					</tr>

				</tbody>
			</table>

			${gender} <br> <br>
			<div align="center">
				<button type="submit" class="btn btn-primary"
					onclick="return formCheck()">확인</button>
			</div>
			<input type="hidden" name="userId" value="${mail}"> <input
				type="hidden" name="userNick" value="${userNick}"> <input
				type="hidden" name="userNameK" value="${userNameK}">

			<c:set var="gender" value="${gender}" />
			<c:choose>
				<c:when test="${gender == 'female'}">
					<c:set var="gender" value="F" />
				</c:when>
				<c:otherwise>
					<c:set var="gender" value="M" />
				</c:otherwise>
			</c:choose>
			<input type="hidden" name="pwd" value="${pwd}"> <input
				type="hidden" name="mail" value="${mail}"> <input
				type="hidden" name="phone" value="${phone}"> <input
				type="hidden" name="birthday" value="${birthday}">
		</form>


	</section>
	<br>

	<script type="text/javascript">
		// '출생 연도' 셀렉트 박스 option 목록 동적 생성
		var birthYearEl = document.querySelector('#birth-year')
		var birthMonthEl = document.querySelector('#birth-month')
		var birthDayEl = document.querySelector('#birth-day')
		// option 목록 생성 여부 확인
		isYearOptionExisted = false;
		isMonthOptionExisted = false;
		isDayOptionExisted = false;

		birthYearEl.addEventListener('focus', function() {
			// year 목록 생성되지 않았을 때 (최초 클릭 시)
			if (!isYearOptionExisted) {
				isYearOptionExisted = true
				for (var i = 1940; i <= 2023; i++) {
					// option element 생성
					const YearOption = document.createElement('option')
					YearOption.setAttribute('value', i)
					YearOption.innerText = i
					// birthYearEl의 자식 요소로 추가
					this.appendChild(YearOption);
				}
			}
		});

		birthMonthEl.addEventListener('focus', function() {
			// year 목록 생성되지 않았을 때 (최초 클릭 시)
			if (!isMonthOptionExisted) {
				isMonthOptionExisted = true
				for (var i = 1; i <= 12; i++) {
					// option element 생성
					const MonthOption = document.createElement('option')
					MonthOption.setAttribute('value', i)
					MonthOption.innerText = i
					// birthYearEl의 자식 요소로 추가
					this.appendChild(MonthOption);
				}
			}
		});

		birthDayEl.addEventListener('focus', function() {
			// year 목록 생성되지 않았을 때 (최초 클릭 시)
			if (!isDayOptionExisted) {
				isDayOptionExisted = true
				for (var i = 1; i <= 31; i++) {
					// option element 생성
					const DayOption = document.createElement('option')
					DayOption.setAttribute('value', i)
					DayOption.innerText = i
					// birthYearEl의 자식 요소로 추가
					this.appendChild(DayOption);
				}
			}
		});
		// Month, Day도 동일한 방식으로 구현

		function handleOnInput(el, maxlength) {
			if (el.value.length > maxlength) {
				el.value = el.value.substr(0, maxlength);
			}
		}
		function handleOnInputEng(e) {
			e.value = e.value.replace(/[^A-Za-z]/ig, '')
		}

		function formCheck() {
			if (document.frm.userNameE.value.length == 0) {
				alert("영문 명을 입력해주세요.");
				return false;
			} else if (document.frm.postcode.value.length == 0) {
				alert("우편번호를 다시 확인해주세요.")
				document.frm.postcode.focus;
				return false;
			} else if (document.frm.addressDefault.value.length == 0) {
				alert("주소를 다시 확인해주세요.")
				document.frm.addressDefault.focus;
				return false;
			} else if (document.frm.birth - year.value.length == 0) {
				alert("출생년도를 다시 확인해주세요.")
				document.frm.birth - year.focus;
				return false;
			} else if (document.frm.birth - month.value.length == 0) {
				alert("출생년도를 다시 확인해주세요.")
				document.frm.birth - month.focus;
				return false;
			} else if (document.frm.birth - day.value.length == 0) {
				alert("출생년도를 다시 확인해주세요.")
				document.frm.birth - day.focus;
				return false;
			}

		}
	</script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("sample6_extraAddress").value = extraAddr;

							} else {
								document.getElementById("sample6_extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample6_postcode').value = data.zonecode;
							document.getElementById("sample6_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample6_detailAddress")
									.focus();
						}
					}).open();
		}
	</script>
	</body>
	</html>