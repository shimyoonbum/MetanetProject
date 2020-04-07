package com.metanet.project.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.dto.TimeDTO;

public interface JournalService {

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

	

}