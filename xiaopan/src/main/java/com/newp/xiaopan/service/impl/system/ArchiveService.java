/**
 * 
 */
package com.newp.xiaopan.service.impl.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Archive;
import com.newp.xiaopan.dao.system.IArchiveDao;
import com.newp.xiaopan.service.system.IArchiveService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class ArchiveService extends BaseService implements IArchiveService {

	@Autowired
	private IArchiveDao archiveDao;

	public List<Archive> queryList(Archive archive) {
		return this.queryTopList(archive, null);
	}

	public List<Archive> queryTopList(Archive archive, Integer top) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("archive", archive);
		params.put("top", top);
		return this.archiveDao.query(params);
	}

	public Archive query(Archive archive) {
		List<Archive> list = this.queryList(archive);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Archive archive) {
		return this.archiveDao.add(archive);
	}

	public Integer update(Archive archive) {
		return this.archiveDao.update(archive);
	}

	public Integer delete(Archive archive) {
		return this.archiveDao.delete(archive);
	}

}
