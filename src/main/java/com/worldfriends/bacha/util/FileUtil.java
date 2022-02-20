package com.worldfriends.bacha.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Path;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;

public class FileUtil {
   // 지정한 파일을 브라우저로 전송
   public static void copy(String path, HttpServletResponse response) throws IOException {
      S3Util s3Util = new S3Util();
      AmazonS3 s3 = new AmazonS3Client(s3Util.credentials);
      S3Object s3object = s3.getObject(new GetObjectRequest("upload-attachment", path));
      S3ObjectInputStream stream = s3object.getObjectContent();
      response.setContentLength((int)s3object.getObjectMetadata().getContentLength());
      try (InputStream in = new BufferedInputStream(stream);
          OutputStream out = new BufferedOutputStream(response.getOutputStream());) {

         int data;
         while ((data = in.read()) != -1) {
            out.write(data);
         }

      } catch (Exception e) {
         e.printStackTrace();
      }
   }
}