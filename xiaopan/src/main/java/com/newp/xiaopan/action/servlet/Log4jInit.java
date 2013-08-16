package com.newp.xiaopan.action.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * @author 张霄鹏
 */
public class Log4jInit extends HttpServlet {
	private static final long serialVersionUID = -6464445420487503020L;
	static Logger logger = Logger.getLogger(Log4jInit.class);

	public Log4jInit() {
	}

	public void init(ServletConfig config) throws ServletException {
		String prefix = config.getServletContext().getRealPath("/");
		String file = config.getInitParameter("log4j");
		String filePath = prefix + file;
//		toPrint("---------------log4j start----------------");
//		toPrint("prefix:" + prefix);
//		toPrint("file:" + file);
//		toPrint("filePath:" + filePath);
		Properties props = new Properties();
		try {
			FileInputStream istream = new FileInputStream(filePath);
			props.load(istream);
			istream.close();
//			toPrint("R:" + props.getProperty("log4j.appender.R.File"));
			String logFile = prefix + props.getProperty("log4j.appender.R.File");// 设置路径
//			toPrint("logFile:" + logFile);
			props.setProperty("log4j.appender.R.File", logFile);
			PropertyConfigurator.configure(props);// 装入log4j配置信息
		} catch (IOException e) {
			toPrint("Could not read configuration file [" + filePath + "].");
			toPrint("Ignoring configuration file [" + filePath + "].");
			return;
		}
//		toPrint("---------------log4j end----------------");
	}

	public static void toPrint(String content) {
		System.out.println(content);
	}

}
