package com.metanet.project.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.metanet.project.dto.JournalDTO;

@Repository("com.metanet.project.mapper.JournalMapper")
public interface JournalMapper {
		
	/* 업무일지 목록 조회 */
	public List<JournalDTO> journalList(String date) throws Exception;
	
	/* 업무일지 상세 조회 */
	public JournalDTO detail(int no) throws Exception;
	
	/* 업무일지 입력 */
	public int journalInsert(JournalDTO dto) throws Exception;
	
	/* 업무일지 수정 */ 
    public int journalUpdate(JournalDTO board) throws Exception;
    
    /* 업무일지 삭제 */  
    public int journalDelete(int bno) throws Exception;
}
