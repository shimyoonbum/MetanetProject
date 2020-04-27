package com.metanet.project.dto;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class ListDTO {	
	private String date;	//작성일시
	
	private String title;   //업무일지 제목
	
	private String action;	//수행업무
	
	private String location;	//작성위치
	
	private String writer;	//작성자
	
	private String fileyn;	//첨부파일 유무 
    
    private String fileUrl;		//파일 경로
    
    private String fileName;	//파일명
}
