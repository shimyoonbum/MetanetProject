package com.metanet.project.dto;

import javax.xml.bind.annotation.XmlRootElement;
import lombok.Data;

@Data
@XmlRootElement
public class FileDTO {
	
	private int fno;	//파일 번호
	
    private int jno;	//업무일지 번호
    
    private String fileName;     //저장할 파일
    
    private String fileRealName;  //실제 파일
    
    private String fileUrl;		//파일 경로
}
