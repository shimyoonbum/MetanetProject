package com.metanet.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
		Date date = dto.getDate();
		SimpleDateFormat searchDate = new SimpleDateFormat("yyyy-MM-dd");
		//logger.info(searchDate.format(date));
		List<JournalDTO> list = service.journalListService(searchDate.format(date).toString());
		return list; 		
    }	
    
	/* 업무일지 상세내역 볼 수 있는 화면 호출   */
    @RequestMapping(value = "/detail", method = RequestMethod.POST) 
    @ResponseBody
    private JournalDTO journalDetail(@RequestBody JournalDTO dto) throws Exception{
    	int no = dto.getNo();
    	JournalDTO list = service.journalDetailService(no);        
        return list;
    } 
    
    /* 업무일지 삭제   */ 
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> journalDelete(@RequestBody JournalDTO dto) throws Exception{
    	Map<String, Object> result = new HashMap<>();
    	try {
    		service.journalDeleteService(dto.getNo());
    		result.put("result", "Success");
    	}
    	catch(Exception e) {
    		result.put("result", "Fail");
    	}
    	
		return result;
    } 
    
    /* 업무일지 수정  */ 
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
    
    /* 업무일지 작성  */ 
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody 
    private Map<String, Object> journalInsert(@RequestBody JournalDTO dto){        
    	Map<String, Object> result = new HashMap<>();
    	try {
    		service.journalInsertService(dto);
    		result.put("result", "Success");
    	}
    	catch(Exception e) {
    		result.put("result", "Fail");
    	}
    	
		return result;
    }   
    
    /* 데이터를 넣는 부분. 넣고 나서 list 화면으로 return 시킨다. 
    @RequestMapping("/insertProc")
    private String journalInsertProc(HttpServletRequest request) throws Exception{
        
    	JournalDTO journal = new JournalDTO();
    	
    	journal.setTitle(request.getParameter("title"));    	
    	journal.setAction(request.getParameter("action"));
    	journal.setPlanned(request.getParameter("planned"));
    	journal.setDescription(request.getParameter("description"));
        
        service.journalInsertService(journal);
        
        return "redirect:/main";
    } */
    
    /* 업무일지 수정하는 함수  
    @RequestMapping("/updateProc")
    private String journalUpdateProc(HttpServletRequest request) throws Exception{
        
    	JournalDTO journal = new JournalDTO();
    	
    	journal.setAction(request.getParameter("action"));
    	journal.setPlanned(request.getParameter("planned"));
    	journal.setDescription(request.getParameter("description"));
    	journal.setNo(Integer.parseInt(request.getParameter("no")));
        
    	service.journalUpdateService(journal);
        
    	
        return "redirect:/detail/" + request.getParameter("no"); 
    } */
    
    /* 업무일지 삭제  
    @RequestMapping("/delete")
    private String journalDelete(@PathVariable int no) throws Exception{
        
    	service.journalDeleteService(no);
        
        return "redirect:/main";
    }     */ 
}