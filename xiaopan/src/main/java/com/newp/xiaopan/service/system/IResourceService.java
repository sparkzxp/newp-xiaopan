package com.newp.xiaopan.service.system;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newp.xiaopan.bean.system.Resource;
import com.newp.xiaopan.bean.system.Role;

/**
 * @author 张霄鹏
 */
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public interface IResourceService {

	Resource query(Resource resource);

	List<Resource> queryList(Resource resource);

	List<Resource> queryList(Resource resource, Role role);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	String add(Resource resource);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer update(Resource resource);

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	Integer delete(Resource resource);
}
