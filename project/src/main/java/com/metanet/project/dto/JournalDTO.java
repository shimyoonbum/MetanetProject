package com.metanet.project.dto;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class JournalDTO {	
		
	private Integer no;	//작성글번호
	
	private String date;	//작성일시
	
	private String title;   //업무일지 제목
	
	private String action;	//수행업무
	
	private String planned;		//예정업무
	
	private String description;		//비고
	
	private String fileyn;	//첨부파일 유무 
}
