package com.metanet.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.omg.CORBA.portable.InputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.service.JournalService;

@Controller
public class JournalController {
	
	private static final Logger logger = LoggerFactory.getLogger(JournalController.class);
    
	@Resource(name="com.metanet.project.service.JournalService")
	JournalService service;

	/* 업무일지 메인 화면 */ 
	@RequestMapping("/main")
    private String Journal(Model model) throws Exception{        
           
        return "main"; //생성한 main.jsp
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
    private Map<String, Object> journalUpdate(@RequestBody JournalDTO dto) throws Exception{
               
        Map<String, Object> result = new HashMap<>();
    	try {
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
    		@RequestParam HashMap<Object, Object> param) throws Exception{
    	
    	JournalDTO dto = new JournalDTO();
    	String no = param.get("no").toString();
    	dto.setNo(Integer.parseInt(no));
    	dto.setDate(param.get("date").toString());
    	dto.setAction(param.get("action").toString());
    	dto.setPlanned(param.get("planned").toString());
    	dto.setDescription(param.get("description").toString());
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
    
    /* 업무일지 작성  */ 
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody 
    private List<JournalDTO> journalInsert(@RequestBody JournalDTO dto) throws Exception{    	
    	dto.setFileyn("N");
    	service.journalInsertService(dto);
    	return service.journalListService(dto.getDate());
    }   
    
    /* 업무일지 작성  */ 
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    private List<JournalDTO> upload(	//requestparam 어노테이션으로 formData의 요소들을 접근한다.  
    		@RequestParam MultipartFile files,
    		@RequestParam HashMap<Object, Object> param
    		) throws Exception{      	    		
    	
    	//기존 게시물의 정보들은 DB에 저장함.
        JournalDTO dto = new JournalDTO();        
    	dto.setDate(param.get("Idatepicker").toString());
        dto.setTitle(param.get("Ititle").toString());
    	dto.setAction(param.get("Iaction").toString());
    	dto.setPlanned(param.get("Iplanned").toString());
    	dto.setDescription(param.get("Idescription").toString());
    	dto.setFileyn("Y");    	
    	
    	service.journalInsertService(dto); 
    	int jno = dto.getNo();       	
        //fdto 객체 db에 저장하기 위해 값 넘겨줌
        service.fileInsertService(jno, files);
    		 		
        return service.journalListService(dto.getDate());
    }      
}