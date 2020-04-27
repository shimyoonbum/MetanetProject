package com.metanet.project.util;

import java.io.FileInputStream;
import java.util.List;

import org.springframework.stereotype.Component;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.AndroidConfig;
import com.google.firebase.messaging.AndroidNotification;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;

@Component
public class FCMUtil {
	public void send_FCM(List<String> tokenlist, String title, String content) throws Exception {
		//firebase sdk settings
		FileInputStream refresh = new FileInputStream("C:\\Users\\Metanet\\git\\MetanetProject\\project\\src\\main\\resources\\static\\fcm\\metanetproject-firebase-adminsdk-35idi-36a69e0c15.json");
		
		FirebaseOptions options = new FirebaseOptions.Builder()
			    .setCredentials(GoogleCredentials.fromStream(refresh))
			    .setDatabaseUrl("https://metanetproject.firebaseio.com")
			    .build();
		
		if(FirebaseApp.getApps().isEmpty()) {
			FirebaseApp.initializeApp(options);
		}
		
		for(String token : tokenlist) {		
			// See documentation on defining a message payload.
			Message message = Message.builder()
					.setAndroidConfig(AndroidConfig.builder()
							.setPriority(AndroidConfig.Priority.NORMAL)
							.setNotification(AndroidNotification.builder().setTitle(title)
									.setBody(content)
									.build())
							.build())
					.setToken(token)
					.build();
	
			// Send a message to the devices subscribed to the provided topic.
			String response = FirebaseMessaging.getInstance().send(message);
			// Response is a message ID string.
			System.out.println("Successfully sent message: " + response);
		}
	}
}
