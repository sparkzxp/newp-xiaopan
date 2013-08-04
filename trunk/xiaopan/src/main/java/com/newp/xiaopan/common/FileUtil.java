/**
 * 
 */
package com.newp.xiaopan.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * @author 张霄鹏
 * 
 */
public class FileUtil {

	public static final int ARCTYPE_IMAGE_PATH_NUM = 1;
	public static final String ARCTYPE_IMAGE_PATH = "arctype/images/";

	public static String getFilePath(int filePath) {
		String ret;
		switch (filePath) {
		case ARCTYPE_IMAGE_PATH_NUM:
			ret = ARCTYPE_IMAGE_PATH;
			break;
		default:
			ret = "";
			break;
		}
		return ret;
	}

	/**
	 * 把一个文件转化为字节
	 * 
	 * @param file
	 * @return byte[]
	 * @throws Exception
	 */
	public static byte[] getByte(File file) throws Exception {
		byte[] bytes = null;
		if (file != null) {
			InputStream is = new FileInputStream(file);
			int length = (int) file.length();
			if (length > Integer.MAX_VALUE) {
				// 当文件的长度超过了int的最大值
				System.out.println("this file is max ");
				return null;
			}
			bytes = new byte[length];
			int offset = 0;
			int numRead = 0;
			while (offset < bytes.length
					&& (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
				offset += numRead;
			}
			// 如果得到的字节长度和file实际的长度不一致就可能出错了
			if (offset < bytes.length) {
				System.out.println("file length is error");
				return null;
			}
			is.close();
		}
		return bytes;
	}
}
