package com.metanet.project.service;

import java.util.HashMap;

public interface KakaoService {

	String getAccessToken(String authorize_code) throws Exception;

	HashMap<String, Object> getUserInfo(String access_Token) throws Exception;

	void kakaoLogout(String attribute) throws Exception;
}