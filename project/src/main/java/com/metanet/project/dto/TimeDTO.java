package com.metanet.project.dto;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@Data
@XmlRootElement
public class TimeDTO {
	private Integer hour;
	private Integer minute;
}
