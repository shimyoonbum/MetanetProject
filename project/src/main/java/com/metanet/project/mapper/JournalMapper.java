package com.metanet.project.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.dto.TimeDTO;

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
    public int journalDelete(int no) throws Exception;
    
    /* 파일 추가 */
	public int fileInsert(FileDTO fdto) throws Exception;
	
	/* 파일 상세보기 */
	public FileDTO fileDetail(int jno) throws Exception;

	/* file 삭제 */  
	public int fileDelete(FileDTO dto) throws Exception;
	
	/* 시간 수정 */
	public void timeUpdate(TimeDTO dto) throws Exception;
	
	/* 시간 설정 */
	public void timeInsert(TimeDTO dto) throws Exception;
	
	/* 시간 테이블 조사 */
	public Integer timeSelect() throws Exception;
	
	/* 시간 삭제 */
	public void timeDelete() throws Exception;

	public TimeDTO timeInfo() throws Exception;
}
