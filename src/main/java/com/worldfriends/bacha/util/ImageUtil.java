package com.worldfriends.bacha.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

//아바타 크기 조정용
public class ImageUtil {
	public static byte[] makeThumb(byte[] data) throws Exception {
		return makeThumb(data, 150, 150); //사용자가 올린 이미지 크기를 강제로 줄인다.
	}

	public static byte[] makeThumb(byte[] data, int width, int height) throws Exception {
		try (ByteArrayInputStream in = new ByteArrayInputStream(data); //byte 배열을 대상으로 함
			 ByteArrayOutputStream out = new ByteArrayOutputStream(); //byte 배열로 출력
		){ 
			Thumbnails.of(in)
					.size(width, height)
					.crop(Positions.CENTER)
					.toOutputStream(out);
			return out.toByteArray();
		}
	}
}