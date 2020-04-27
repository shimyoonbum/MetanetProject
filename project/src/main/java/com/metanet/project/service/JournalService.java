package com.metanet.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.dto.ListDTO;
import com.metanet.project.dto.NumDTO;
import com.metanet.project.dto.TimeDTO;
import com.metanet.project.dto.TokenDTO;

public interface JournalService {
	
	List<ListDTO> journalSearchService() throws Exception;

	List<JournalDTO> journalListService(String date) throws Exception;	

	JournalDTO journalDetailService(int no) throws Exception;
	
	FileDTO fileDetailService(int no) throws Exception;

	int journalInsertService(JournalDTO dto) throws Exception;
	
	int fileInsertService(int jno, MultipartFile files) throws Exception;	

	int journalUpdateService(JournalDTO dto) throws Exception;	
	
	int journalDeleteService(int no) throws Exception;

	int fileDeleteService(FileDTO dto) throws Exception;

	void timeService(TimeDTO dto) throws Exception;

	void timeInsert(TimeDTO dto) throws Exception;

	Integer timeSelect() throws Exception;

	void timeUpdate(TimeDTO dto) throws Exception;

	TimeDTO timeInfo() throws Exception;

	void timeDelete() throws Exception;

	void tokenUpdate(TokenDTO dto) throws Exception;

	List<Map<String, Object>> tokenSelect() throws Exception;

	List<Map<String, Object>> tokenSelectById(TokenDTO dto) throws Exception;

	List<ListDTO> journalNextService(NumDTO dto) throws Exception;

}