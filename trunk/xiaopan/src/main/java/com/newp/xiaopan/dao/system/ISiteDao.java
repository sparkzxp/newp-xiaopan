/**
 * 
 */
package com.newp.xiaopan.dao.system;

import java.util.List;
import java.util.Map;

import com.newp.xiaopan.bean.system.Site;

/**
 * @author 张霄鹏
 * 
 */
public interface ISiteDao {

	List<Site> query(Map<String, Object> params);

	String add(Site site);

	Integer update(Site site);

	Integer delete(Site site);
}
