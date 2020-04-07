package com.metanet.project.dto;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class UserDTO {
	
	private String name;	//이름
	
	private String email;	//이메일
	
	private String thumbnail;   //프로필
}
