package com.metanet.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.dto.TimeDTO;
import com.metanet.project.dto.UserDTO;
import com.metanet.project.service.JournalService;
import com.metanet.project.service.KakaoService;

@Controller
public class JournalController {
	
	private static final Logger logger = LoggerFactory.getLogger(JournalController.class);
    
	@Resource(name="com.metanet.project.service.JournalService")
	JournalService service;
	
	@Resource(name="com.metanet.project.service.KakaoService")
    KakaoService kakao;
	
	/* 업무일지 login 화면 */ 
    @RequestMapping("/")
    public String index(Model model) {
        return "index"; //생성한 detail.jsp
    }
    
    /* 업무일지 login 관련 처리 */ 
    @RequestMapping(value="/oauth")
    public String login(@RequestParam("code") String code, HttpSession session) throws Exception{
    	String access_Token = kakao.getAccessToken(code);
    	HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
    	
    	System.out.println("login Controller : " + userInfo);
    	
    	//클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
    	if (userInfo.get("email") != null) {
    		session.setAttribute("name", userInfo.get("nickname"));
    		session.setAttribute("email", userInfo.get("email"));
    		session.setAttribute("thumbnail", userInfo.get("thumbnail"));
    		session.setAttribute("access_Token", access_Token);
    	}
		return "index";
    }
    
    @RequestMapping(value="/logout")
    public String logout(HttpSession session) throws Exception {
        kakao.kakaoLogout((String)session.getAttribute("access_Token"));
        session.removeAttribute("access_Token");
        session.removeAttribute("email");
        session.removeAttribute("name");
        session.removeAttribute("thumbnail");
        return "index";
    }
    
	/* 업무일지 메인 화면 */ 
	@RequestMapping("/main")
	private ModelAndView Journal(ModelAndView model, HttpSession session) throws Exception{
		UserDTO user = new UserDTO();
		user.setEmail((String) session.getAttribute("email"));
		user.setName((String) session.getAttribute("name"));
		user.setThumbnail((String) session.getAttribute("thumbnail"));
		model.addObject("UserDTO", user);
		model.setViewName("main");		
        return model; //생성한 main.jsp
    }	
	
	/*업무일지 리스트 화면 호출  */
	@RequestMapping(value= "/search", method = RequestMethod.POST)
	@ResponseBody
    private List<JournalDTO> searchJournal(@RequestBody JournalDTO dto) throws Exception{		
		String date = dto.getDate();
		List<JournalDTO> list = service.journalListService(date);		
		return list; 		
    }	
    
	/* 업무일지 상세내역 볼 수 있는 화면 호출   */
    @RequestMapping(value = "/detail", method = RequestMethod.POST) 
    @ResponseBody
    private Map<String, Object> journalDetail(@RequestBody JournalDTO dto) throws Exception{    	
    	Map<String, Object> result = new HashMap<>();
    	int no = dto.getNo();
    	JournalDTO list = service.journalDetailService(no);
    	String s = list.getFileyn();
    	if(s.equalsIgnoreCase("Y")) {
    		FileDTO list2 = service.fileDetailService(no);
    		result.put("journal", list);
    		result.put("file", list2);
    	}else {
    		result.put("journal", list);
    	}      	  	
        return result;
    } 
    
    /* 업무일지 완전 삭제   */ 
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    private List<JournalDTO> journalDelete(@RequestBody JournalDTO dto) throws Exception{   
    	logger.info(dto.toString());
    	service.journalDeleteService(dto.getNo()); 
    	if(dto.getFileyn().equalsIgnoreCase("Y")) {
        	FileDTO file = service.fileDetailService(dto.getNo());    		
        	service.fileDeleteService(file); 
    	}   		
    	return service.journalListService(dto.getDate()); 
    } 
    
    /* 파일 삭제   */ 
    @RequestMapping(value = "/filedelete", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> fileDelete(@RequestBody FileDTO dto) throws Exception{
    	Map<String, Object> result = new HashMap<>();
    	try {    		
    		service.fileDeleteService(dto);
    		JournalDTO list = service.journalDetailService(dto.getJno());
    		list.setFileyn("N"); 
    		service.journalUpdateService(list);
    		result.put("result", "Success");
    	}
    	catch(Exception e) {
    		result.put("result", "Fail");
    	}
    	
		return result;
    } 
    
    /* 업무일지 파일 정보 없이 수정  */ 
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> journalUpdate(@RequestBody JournalDTO dto, HttpSession session) throws Exception{
               
        Map<String, Object> result = new HashMap<>();
    	try {
    		dto.setWriter((String) session.getAttribute("name"));
    		service.journalUpdateService(dto);
    		result.put("result", "Success");
    	}
    	catch(Exception e) {
    		result.put("result", "Fail");
    	}
    	
		return result;
    }
    
    /* 업무일지 파일 정보 포함해서 수정  */ 
    @RequestMapping(value = "/updateWithFile", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> journalUpdateWithFile(
    		@RequestParam MultipartFile fileupdate,
    		@RequestParam HashMap<Object, Object> param, HttpSession session) throws Exception{
    	
    	JournalDTO dto = new JournalDTO();
    	String no = param.get("no").toString();
    	dto.setNo(Integer.parseInt(no));
    	dto.setDate(param.get("date").toString());
    	dto.setAction(param.get("action").toString());
    	dto.setPlanned(param.get("planned").toString());
    	dto.setDescription(param.get("description").toString());
    	dto.setLocation(param.get("location").toString());
    	dto.setWriter((String) session.getAttribute("name"));
    	dto.setFileyn("Y");
               
        Map<String, Object> result = new HashMap<>();
    	try {
    		service.journalUpdateService(dto); 
    		int jno = dto.getNo();       	
            //fdto 객체 db에 저장하기 위해 값 넘겨줌
            service.fileInsertService(jno, fileupdate);
    		result.put("result", "Success");
    	}
    	catch(Exception e) {
    		result.put("result", "Fail");
    	}
    	
		return result;
    }
    
    /* 시간 설정  */ 
    @RequestMapping(value = "/timesetup", method = RequestMethod.POST)
    @ResponseBody 
    private void timeSetup(@RequestBody TimeDTO dto) throws Exception{
    	int no = service.timeSelect();
    	if(no == 0) {
    		service.timeInsert(dto);
    	}else {
    		service.timeUpdate(dto);
    	}    	
    }       
    
    /* 시간 값 안드로이드에 전송 */ 
    @RequestMapping(value = "/timeinfo", method = RequestMethod.GET)
    @ResponseBody 
    private Map<String, Integer> timeInfo() throws Exception{
    	TimeDTO t = service.timeInfo();

    	Map<String, Integer> result = new HashMap<>();
    	result.put("hour", t.getHour());
    	result.put("minute", t.getMinute());
    	
    	return result;
    }   
    
    /* 업무일지 작성  */ 
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody 
    private List<JournalDTO> journalInsert(@RequestBody JournalDTO dto, HttpSession session) throws Exception{    	
    	dto.setFileyn("N");
    	dto.setWriter((String) session.getAttribute("name"));
    	service.journalInsertService(dto);
    	return service.journalListService(dto.getDate());
    }   
    
    /* 업무일지 작성  */ 
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    private List<JournalDTO> upload(	//requestparam 어노테이션으로 formData의 요소들을 접근한다.  
    		@RequestParam MultipartFile files,
    		@RequestParam HashMap<Object, Object> param, HttpSession session
    		) throws Exception{      	    		
    	
    	//기존 게시물의 정보들은 DB에 저장함.
        JournalDTO dto = new JournalDTO();        
    	dto.setDate(param.get("Idatepicker").toString());
        dto.setTitle(param.get("Ititle").toString());
    	dto.setAction(param.get("Iaction").toString());
    	dto.setPlanned(param.get("Iplanned").toString());
    	dto.setDescription(param.get("Idescription").toString());
    	dto.setLocation(param.get("location").toString());
    	dto.setWriter((String) session.getAttribute("name"));
    	dto.setFileyn("Y");    	
    	
    	service.journalInsertService(dto); 
    	int jno = dto.getNo();       	
        //fdto 객체 db에 저장하기 위해 값 넘겨줌
        service.fileInsertService(jno, files);
    		 		
        return service.journalListService(dto.getDate());
    }      
}