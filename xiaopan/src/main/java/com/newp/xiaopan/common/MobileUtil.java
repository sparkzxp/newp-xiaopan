package com.newp.xiaopan.common;

/**
 * @author 张霄鹏
 * 
 */
public class MobileUtil {
	public static Boolean CheckAgent(String agent) {
		boolean flag = false;

		String[] keywords = { "Android", "iPhone", "iPod", "iPad", "Windows Phone", "MQQBrowser" };

		// 排除 Windows 桌面系统
		if (!agent.contains("Windows NT") || (agent.contains("Windows NT") && agent.contains("compatible; MSIE 9.0;"))) {
			// 排除 苹果桌面系统
			if (!agent.contains("Windows NT") && !agent.contains("Macintosh")) {
				for (String item : keywords) {
					if (agent.contains(item)) {
						flag = true;
						break;
					}
				}
			}
		}

		return flag;
	}
}
