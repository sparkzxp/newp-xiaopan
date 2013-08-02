package com.newp.xiaopan.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 获取properties文件
 * 
 * @author 张霄鹏
 *
 */
public class PropertiesUtil {

	/**
	 * 
	 * @param propertiesConfigName
	 * @return Properties 对象
	 */
	public static Properties getProperties(String propertiesConfigName) throws IOException{
		Properties properties = new Properties();		
		InputStream inputStream = PropertiesUtil.class.getClassLoader().getResourceAsStream(propertiesConfigName);
		properties.load(inputStream);
		
		return properties;
	}
}
