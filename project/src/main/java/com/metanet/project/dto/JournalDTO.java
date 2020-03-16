package com.metanet.project.dto;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class JournalDTO {	
		
	private Integer no;	//작성글번호
	
	private Date date;	//작성일시
	
	private String Title;   //업무일지 제목
	
	private String action;	//수행업무
	
	private String planned;		//예정업무
	
	private String description;		//비고
}
