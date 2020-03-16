package com.metanet.project.service;

import java.util.List;

import com.metanet.project.dto.JournalDTO;

public interface JournalService {

	List<JournalDTO> journalListService(String date) throws Exception;

	JournalDTO journalDetailService(int no) throws Exception;

	int journalInsertService(JournalDTO dto) throws Exception;

	int journalUpdateService(JournalDTO dto) throws Exception;

	int journalDeleteService(int no) throws Exception;

}