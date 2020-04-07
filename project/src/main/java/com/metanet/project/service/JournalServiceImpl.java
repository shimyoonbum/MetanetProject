package com.metanet.project.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.metanet.project.controller.JournalController;
import com.metanet.project.dto.FileDTO;
import com.metanet.project.dto.JournalDTO;
import com.metanet.project.dto.TimeDTO;
import com.metanet.project.mapper.JournalMapper;

@Service("com.metanet.project.service.JournalService")
public class JournalServiceImpl implements JournalService {
	
	private static final Logger logger = LoggerFactory.getLogger(JournalServiceImpl.class);
	
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

	@Override
	public int fileInsertService(int jno, MultipartFile files) throws Exception {
		FileDTO fdto = new FileDTO();
		
		//파일의 실제 이름을 가져온다.
		String sourceFileName = files.getOriginalFilename();    	
		//파일 저장 경로를 설정한다.
		String fileUrl = "C:\\Users\\Metanet\\git\\MetanetProject\\project\\src\\main\\resources\\static\\image";
		//파일 중복시에 업로드 하면 파일을 덮어씌우는 현상을 방지한다.
		UUID uuid = UUID.randomUUID();
		//임의의 값 파일명 앞에 삽입
		String fileName = uuid.toString() + "-" +  sourceFileName;
		//파일 클래스 객체에 파일경로와 파일 이름을 넣는다.
		File saveFile = new File(fileUrl, fileName);
		//객체를 지정 경로에 보낸다.(예외처리 해줘야함)
		files.transferTo(saveFile);
		
		//file 관련 값 세팅
    	fdto.setJno(jno);
    	fdto.setFileName(fileName);
    	fdto.setFileRealName(sourceFileName);
    	fdto.setFileUrl(fileUrl);
    	
		return mapper.fileInsert(fdto);		
	}

	@Override
	public FileDTO fileDetailService(int no) throws Exception {		
		return mapper.fileDetail(no);
	}

	@Override
	public int fileDeleteService(FileDTO dto) throws Exception {
		//file 삭제 로직
		String filename = dto.getFileName();
		String fileUrl = "C:\\Users\\Metanet\\git\\MetanetProject\\project\\src\\main\\resources\\static\\image\\" + filename;
		File file = new File(fileUrl);
		if(file.exists() == true){
			file.delete();
		}
		//db 테이블 정보 삭제
		return mapper.fileDelete(dto);
	}

	@Override
	public void timeService(TimeDTO dto) throws Exception {
		mapper.timeUpdate(dto);		
	}

	@Override
	public void timeInsert(TimeDTO dto) throws Exception {
		mapper.timeInsert(dto);		
	}

	@Override
	public Integer timeSelect() throws Exception {
		// TODO Auto-generated method stub
		return mapper.timeSelect();
	}

	@Override
	public void timeUpdate(TimeDTO dto) throws Exception {
		mapper.timeUpdate(dto);		
	}

	@Override
	public TimeDTO timeInfo() throws Exception {
		// TODO Auto-generated method stub
		return mapper.timeInfo();		
	}

	@Override
	public void timeDelete() throws Exception {
		mapper.timeDelete();		
	}	
}
