package com.metanet.project.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.metanet.project.dto.JournalDTO;
import com.metanet.project.mapper.JournalMapper;

@Service("com.metanet.project.service.JournalService")
public class JournalServiceImpl implements JournalService {
	
	@Resource(name="com.metanet.project.mapper.JournalMapper")
	JournalMapper mapper;
	
	@Override
	public List<JournalDTO> journalListService(String date) throws Exception {		
		return mapper.journalList(date);
	}
	
    @Override
	public JournalDTO journalDetailService(int no) throws Exception{        
        return mapper.detail(no);
    }
    
    @Override
	public int journalInsertService(JournalDTO dto) throws Exception{        
        return mapper.journalInsert(dto);
    }
    
    @Override
	public int journalUpdateService(JournalDTO dto) throws Exception{        
        return mapper.journalUpdate(dto);
    }
    
    @Override
	public int journalDeleteService(int no) throws Exception{        
        return mapper.journalDelete(no);
    }	
}
