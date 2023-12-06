package com.airline.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Description;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.airline.mail.MailHandler;
import com.airline.mail.TempKey;
import com.airline.security.CustomLoginSuccessHandler;
import com.airline.service.JoinService;
import com.airline.service.MailSendService;
import com.airline.vo.KakaoUserVO;
import com.airline.vo.TermsVO;
import com.fasterxml.jackson.annotation.JacksonInject.Value;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/join/*")
public class JoinController {
	@Autowired
	private JoinService join;

	@Autowired
	private MailSendService mailSendService;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/joinTerms")
	public void joinTermsGet(Model model) {
		TermsVO terms1 = join.getTerms(1);
		TermsVO terms2 = join.getTerms(2);
		TermsVO terms3 = join.getTerms(3);
		TermsVO terms4 = join.getTerms(4);


		model.addAttribute("terms1", terms1);
		model.addAttribute("terms2", terms2);
		model.addAttribute("terms3", terms3);
		model.addAttribute("terms4", terms4);


		log.info("JoinController >> joinTerms [get]");
	}

	@PostMapping("/joinTerms")
	public String joinTerms(Model model, String terms) {
		log.info("terms 이름에 담아온 값 >> " + terms);
		log.info("JoinController >> joinTerms [post]");

		model.addAttribute("termsAgree", terms);
		
		return "/join/checkMember";
	}

	@GetMapping("/findId")
	public void findId() {
		log.info("JoinController >> findId");
	}

	@PostMapping("/findId") // 여유가 있다면.. 랜덤키생성/메일보내는 메서드를 따로 뺄까 생각중...
	public String findId(String email, Model model, RedirectAttributes attr) {
		String result = join.confirmEmail(email);
		model.addAttribute("email", result); // 필요한가

		log.info("email >> " + email);
		log.info("result >> " + result);

		if (result == null) {
			model.addAttribute("message", "입력하신 정보를 다시 확인해주시기 바랍니다.");
			return "redirect:/join/findId";
		} else {
			try {
				String mail_key = new TempKey().getKey(); // 랜덤키 생성

				Map<String, String> params = new HashMap<String, String>();
				params.put("email", email);
				params.put("mail_key", mail_key);

				mailSendService.updateMailKey(params); // email을 기준으로 컬럼에 랜덤키 저장
				log.info("입력받은 이메일 >> " + email + "생성된 key >> " + mail_key);

				MailHandler sendMail = new MailHandler(mailSender);
				sendMail.setSubject("카카오 항공 인증 메일입니다.");
				sendMail.setText("<h3>카카오 항공을 찾아주셔서 감사합니다.</h3>" + "<br>아래 확인 버튼을 눌러서 인증을 완료해 주시기 바랍니다."
						+ "<br><br><a href='http://localhost:8081/join/getUserId" + "/" + email + "/" + mail_key
						+ "' target='_blank'>이메일 인증 확인</a>");
				sendMail.setFrom("systemlocal99@gmail.com", "카카오 항공");
				sendMail.setTo(email);
				sendMail.send();

				log.info("controller에서 아아디 찾기 메일 보냄 완료");

				return "redirect:/join/mailSended";

			} catch (Exception e) {
				e.printStackTrace();
				return "redirect:/error/accessError";
			}
		}

	}

	@GetMapping("/mailSended")
	public void mailSended() {
		log.info("JoinController >> mailSended");
	}

	@GetMapping("/getUserId/{email}/{mail_key}") // 근데 get이라서 전부 url에 노출됨..
	public String getUserId(@PathVariable("email") String email, @PathVariable("mail_key") String mail_key, Model model)
			throws Exception {
		log.info("JoinController >> getUserId");
		KakaoUserVO vo = join.showUserId(email, mail_key);
		mailSendService.resetMailKey(email);
		model.addAttribute("user", vo);
		return "/join/getUserId"; // 다시 클릭하면 아이디값이 나오지 않음 따라서 다른 페이지로 이동시키는것도 나쁘지 않을 듯..
	}

	@GetMapping("/findPwd")
	public void findPwd() {
		log.info("JoinController >> findPwd");
	}

	@PostMapping("/findPwd") // 여유가 있다면.. 랜덤키생성/메일보내는 메서드를 따로 뺄까 생각중...
	public String findPwd(String userId, String email, Model model, RedirectAttributes attr) {

		String result = join.confirmUserIdAndEmail(userId, email);

		log.info("userId >> " + userId);
		log.info("email >> " + email);
		log.info("result >> " + result);

		if (result == null) {
			model.addAttribute("message", "입력하신 정보를 다시 확인해주시기 바랍니다.");
			return "redirect:/join/findPwd";
		} else {
			try {
				String mail_key = new TempKey().getKey(); // 랜덤키 생성

				Map<String, String> params = new HashMap<String, String>();
				// params.put("userId", userId);
				params.put("email", email);
				params.put("mail_key", mail_key);

				mailSendService.updateMailKey(params); // email을 기준으로 컬럼에 랜덤키 저장
				log.info("입력받은 아이디 >> " + userId + " 입력받은 이메일 >> " + email + " 생성된 key >> " + mail_key);

				MailHandler sendMail = new MailHandler(mailSender);
				sendMail.setSubject("카카오 항공 인증 메일입니다.");
				sendMail.setText("<h3>카카오 항공을 찾아주셔서 감사합니다.</h3>" + "<br>아래의 임시 비밀번호로 로그인 후 비밀번호 변경 부탁드립니다." + "<h3>"
						+ mail_key + "</h3>" + "<br><br><a href='http://localhost:8081/login"
						+ "' target='_blank'>로그인</a>");
				sendMail.setFrom("systemlocal99@gmail.com", "카카오 항공");
				sendMail.setTo(email);
				sendMail.send();

				log.info("controller에서 아아디 찾기 메일 보냄 완료");

				log.info("raw mail_key >> " + mail_key);
				//password 암호화...;
				mail_key = passwordEncoder.encode("mail_key");
				log.info("encoded password >> " + mail_key);
				
				join.modifyPwdByMailKey(userId, mail_key);

				return "redirect:/join/mailSended";

			} catch (Exception e) {
				e.printStackTrace();
				return "redirect:/error/accessError";
			}
		}

	}

	@GetMapping("/checkMember") // 약관동의 후 기존멤버 체크(아직 약관동의 저장, 유효성 구현하지 않음)
	public void checkMember(Model model) {
		log.info("JoinController >> checkMember [get]");
	}

	@PostMapping("/checkMember") // 약관동의 후 기존멤버 체크(아직 약관동의 저장, 유효성 구현하지 않음)
	public String checkMember(Model model, KakaoUserVO vo, String termsAgree) {
		log.info("JoinController >> checkMember [post]");
		log.info(vo);

//		String userYear = Integer.toString(userReginumFirst).substring(0, 2);
//		String userMonth = Integer.toString(userReginumFirst).substring(2, 4);
//		String userDate = Integer.toString(userReginumFirst).substring(4, 6);

		model.addAttribute("userInfo", vo);
		model.addAttribute("termsAgree", termsAgree);
		
		KakaoUserVO result = join.confirmMember(vo);
		log.info(vo);
		if (result == null) {
			return "/join/memberInfo"; // 정보조회가 되지않아야 신규회원이 맞음!
		} else if(termsAgree == null) {
			model.addAttribute("joinMessage", "약관에 동의해주시기 바랍니다.");
			return "/join/joinTerms"; // uri가 http://localhost:8081/join/checkMember인채로 이동함(post라서..)
		} else {
			model.addAttribute("joinMessage", "이미 가입된 회원입니다.");
			return "/login"; // uri가 http://localhost:8081/join/checkMember인채로 이동함(post라서..)
		} 


	}

	@PostMapping("/userIdDuplicateCheck")
	@ResponseBody
	public int memberInfo(@RequestParam("userId") String userId) {
		// ajax 아이디 체크
		int userIdCnt = join.userIdDuplicateCheck(userId);
		return userIdCnt;
	}

	@PostMapping("/userNickDuplicateCheck")
	@ResponseBody
	public int userNickDuplicateCheck(@RequestParam("userNick") String userNick) {
		// ajax 아이디 체크
		int userNickCnt = join.userNickDuplicateCheck(userNick);
		return userNickCnt;
	}

	@PostMapping("/userPwdCheck")
	@ResponseBody
	public int userPwdDuplicateCheck(@RequestParam("pwd") String pwd, @RequestParam("pwd_check") String pwd_check) {
		// ajax 비밀번호 일치 체크
		int userPwdCnt = -1;
		log.info("pwd >> " + pwd);
		log.info("pwd_check >> " + pwd_check);
		// select count(pwd) from kakaouser where pwd = #{pwd_check} => DB에 입력받는 pwd가
		// 없으니 당연함..
		// 1이 안나옴..
		if (pwd.equals(pwd_check)) {
			userPwdCnt = 1;
			log.info("result userPwdCnt >> " + userPwdCnt);
		} else {
			userPwdCnt = 0;
			log.info("result userPwdCnt >> " + userPwdCnt);
		}
		return userPwdCnt;
	}

	@GetMapping("/memberInfo") // 약관동의 후 기존멤버 체크(아직 약관동의 저장, 유효성 구현하지 않음)
	public void memberInfoGet(Model model, KakaoUserVO vo) {
		model.addAttribute("userInfo", vo);
		log.info("JoinController >>  [get]");
	}

	@PostMapping("/memberInfo")
	public String memberInfo(RedirectAttributes attr, String termsAgree, 
			String userId, String userNick, String userNameK,
			String userNameE, String gender, String pwd, int userReginumFirst, int userReginumLast, String phone_first,
			String phone_middle, String phone_last, String email, String mail_Domain, int postCode,
			String addressDefault, String addressDetail) {
		
		// email phone address 합쳐줘야해서.. parameter로 받음....
		
		String phone = phone_first + "-" + phone_middle + "-" + phone_last;
		String mail = email + "@" + mail_Domain;
		String address = addressDefault + addressDetail;
		
		log.info("raw password >> " + pwd);
		//password 암호화...;
		pwd = passwordEncoder.encode(pwd);
		log.info("encoded password >> " + pwd);
		
 
		String[] userTermsAgree =  termsAgree.split(","); //selectall,selectall,selectall,terms4 이런식으로 저장되어 있음
		
//		for (String string : userTermsAgree) {
//			log.info("terms 입력받은거 >> " + string);
//			INFO : com.airline.controller.JoinController - terms 입력받은거 >> selectall
//			INFO : com.airline.controller.JoinController - terms 입력받은거 >> selectall
//			INFO : com.airline.controller.JoinController - terms 입력받은거 >> selectall
//			INFO : com.airline.controller.JoinController - terms 입력받은거 >> terms4
//		}		

		try {
			
			//String mail_key = new TempKey().getKey(); // 랜덤키 생성

			Map<String, String> params = new HashMap<String, String>();
			params.put("email", email);
			//params.put("mail_key", mail_key);

//			mailSendService.updateMailKey(params); // email을 기준으로 컬럼에 랜덤키 저장
			log.info("입력받은 이메일 >> " + mail);


			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("카카오 항공 가입을 환영합니다.");
			sendMail.setText("<h3>카카오 항공을 찾아주셔서 감사합니다.</h3>" + "<br>언제나 회원님을 생각하는 카카오 항공이 되겠습니다." + "<br><br>");
			sendMail.setFrom("systemlocal99@gmail.com", "카카오 항공");
			sendMail.setTo(mail);
			sendMail.send();

			log.info("controller에서 가입완료 메일 보냄 완료");
      
			join.registerMember(userId, userNick, userNameK, userNameK, gender, pwd, userReginumFirst, userReginumLast,
					postCode, phone, mail, address);

			//userTermsAgree가 0 1 2 3으로 들어가서 3번째에 값이 있으면 전체동의, 3번째에 값이 없으면 기본동의 하려고하는데 에러남
			//-> length로 바꿈
			if(userTermsAgree.length == 4) {
				join.registerAllTerms(userId);
			} else {
				join.registerBasicTerms(userId);
			}

			return "redirect:/join/joinSuccess";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error/accessError";
		}

	}

	@GetMapping("/joinSuccess")
	public void joinSuccess() {

	}

	// 카카오 로그인 구현
	// 1번 카카오톡에 사용자 코드 받기(jsp의 a태그 href에 경로 있음)
	// 2번 받은 code를 iKakaoS.getAccessToken로 보냄 ###access_Token###로 찍어서 잘 나오면은 다음단계진행
	// 3번 받은 access_Token를 iKakaoS.getUserInfo로 보냄 userInfo받아옴, userInfo에 nickname,
	// email정보가 담겨있음
	@GetMapping("/kakao")
	@CrossOrigin(origins = "http://localhost:8081/join/kakao")
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model)
			throws Throwable {
		System.out.println("kakao controller타는중~~~(join에서 get)");
		// 1번
		log.info("code:" + code);

		// 2번
		String access_Token = join.getAccessToken(code);
		log.info("###access_Token#### : " + access_Token);
		// 위의 access_Token 받는 걸 확인한 후에 밑에 진행

		// 3번
		HashMap<String, Object> userInfo = join.getUserInfo(access_Token);
		log.info("###nickname#### : " + userInfo.get("nickname"));
		log.info("###email#### : " + userInfo.get("email"));
		log.info("###name### : " + userInfo.get("name"));
		log.info("###gender### : " + userInfo.get("gender"));
		log.info("###age_range_needs_agreement### : " + userInfo.get("age_range_needs_agreement"));
		log.info("###age_range### : " + userInfo.get("age_range"));
		log.info("###birthday### : " + userInfo.get("birthday"));
		log.info("###phone_number### : " + userInfo.get("phone_number"));

		// ModelAndView mv = new ModelAndView();
		// mv.addObject("userInfo", join.)
		// mv.setViewName("/join/memberInfo");
		// return mv;

		// userNameK와 mail로 DB를 조회하여 결과가 있으면 마이페이지(혹은 로그인 선택 전의 페이지)
		// 결과가 없으면 model에 정보를 담아서 추가입력정보 페이지 (kakaoMemberInfo)로 이동
		String email = (String) userInfo.get("email");
		String userNameK = (String) userInfo.get("name");
		KakaoUserVO vo = join.kakaoLoginCheck(email, userNameK);
		
		log.info("vo 결과 >>> " + vo); //authority=null 92INPhy432
		
		if (vo == null) {

			String mail_key = new TempKey().getKey(); // 랜덤키 생성

			// 일단 model에 담아서 값을 이동시킴
			model.addAttribute("userNick", (String) userInfo.get("nickname"));
			model.addAttribute("mail", (String) userInfo.get("email"));
			model.addAttribute("userNameK", (String) userInfo.get("name"));
			model.addAttribute("gender", (String) userInfo.get("gender"));
			model.addAttribute("birthday", (String) userInfo.get("birthday"));
			model.addAttribute("phone", (String) userInfo.get("phone_number"));
			model.addAttribute("pwd", mail_key);
			return "/join/kakaoMemberInfo";
		} else {
//			log.info(vo.getAuthority().toString());
//			String userAuthority = vo.getAuthority().toString();
//			
//			
//			List<GrantedAuthority> authority = AuthorityUtils.createAuthorityList(userAuthority);
//			Authentication authentication = new UsernamePasswordAuthenticationToken(vo.getUserId(), null, authority);
//	        SecurityContextHolder.getContext().setAuthentication(authentication);

	            return "redirect:/home"; //일단 홈으로 보냄
		}
	}
	
	@PostMapping("/kakaoMemberInfo")
	public String kakaoMemberInfo(RedirectAttributes attr, 
			String userId, String userNick, String userNameK,
			String userNameE, String gender_kakao, String pwd, int userReginumFirst, int userReginumLast, 
			String phone_kakao, 
			String mail, int postCode, String addressDefault, String addressDetail) {
		//###gender### : female
		//###phone_number### : +82 10-4784-4991 값 처리해야함....... vo말고 파라미터로 받아야함...
		log.info("기존의 phone >> " + phone_kakao);
		log.info("가공된 gender_kakao >> " + gender_kakao);

		String gender = gender_kakao;
		String phone = "0"+ phone_kakao.substring(4);
		
		log.info("raw password >> " + pwd);
		//password 암호화...;
		pwd = passwordEncoder.encode(pwd);
		log.info("encoded password >> " + pwd);
		
		if(gender_kakao.equals("female")) {
			gender = "W";
		} else {
			gender = "M";
		}
		
		log.info("가공된 phone >> " + phone);
		log.info("가공된 gender >> " + gender);
		
		try {

			//String mail_key = new TempKey().getKey(); // 랜덤키 생성

			Map<String, String> params = new HashMap<String, String>();
			params.put("email", mail);
			//params.put("mail_key", mail_key);

			//mailSendService.updateMailKey(params); // email을 기준으로 컬럼에 랜덤키 저장
			//log.info("입력받은 이메일 >> " + mail + "생성된 key >> " + mail_key);

			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("카카오 항공 가입을 환영합니다.");
			sendMail.setText("<h3>카카오 항공을 찾아주셔서 감사합니다.</h3>" + "<br>언제나 회원님을 생각하는 카카오 항공이 되겠습니다." + "<br><br>");
			sendMail.setFrom("systemlocal99@gmail.com", "카카오 항공");
			sendMail.setTo(mail);
			sendMail.send();

			log.info("controller에서 가입완료 메일 보냄 완료");

			join.registerMember(userId, userNick, userNameK, userNameE, gender, pwd, userReginumFirst, userReginumLast, postCode, phone, mail, addressDetail);
			join.registerAllTerms(userId);
			
			return "redirect:/join/joinSuccess";

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error/accessError";
		}

	}

}
