package com.worldfriends.bacha.view;

import java.io.File;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.amazonaws.util.IOUtils;
import com.worldfriends.bacha.util.FileUtil;
import com.worldfriends.bacha.util.S3Util;

@Component("download")
public class DownloadView extends AbstractView {
	
	S3Util s3 = new S3Util();
	String bucketName = "upload-attachment";

   @Override
   protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
	   
      String path = (String)model.get("path");
      String type = (String)model.get("type");
      String fileName = (String)model.get("fileName");
      fileName = URLEncoder.encode(fileName, "utf-8"); //한글을 위한 url 인코딩
      

      File file = new File(path);
      
      
      //응답 헤더 설정
      response.setContentType(type);
      response.setContentLength((int)file.length());
      response.setHeader("Content-Disposition", 
            "attachment; filename=\""+fileName+"\";");
      response.setHeader("Content-Transfer-Encoding", "binary");
      
      FileUtil.copy(path, response);
   }
   
   

}