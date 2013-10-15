package com.newp.xiaopan.service.impl.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.dao.system.ITypeDao;
import com.newp.xiaopan.service.system.ITypeService;

/**
 * @author 张霄鹏
 * 
 */
@Service
public class TypeService extends BaseService implements ITypeService {

	@Autowired
	private ITypeDao typeDao;

	public List<Type> queryList(Type type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		return this.typeDao.query(params);
	}

	public List<Type> queryList(Map<String, Object> params) {
		return this.typeDao.query(params);
	}

	public List<Type> queryDistinctList(Type type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		return this.typeDao.queryDistinct(params);
	}

	public List<Type> queryDistinctList(Map<String, Object> params) {
		return this.typeDao.queryDistinct(params);
	}

	public Type query(Type type) {
		List<Type> list = this.queryList(type);
		if (CollectionUtils.isNotEmpty(list)) {
			return list.get(0);
		}
		return null;
	}

	public String add(Map<String, Object> params) {
		Type type;
		if (params.get("siteId") == null) {
			type = (Type) params.get("type");
			this.typeDao.add(type);

			// add typssite relationship
			String ids = String.valueOf(params.get("siteIds"));
			if (StringUtils.isNotEmpty(ids)) {
				String[] idArr = ids.split(",");
				List<Site> sites = new ArrayList<Site>();
				Site _s;
				for (String s : idArr) {
					_s = new Site();
					_s.setId(s);
					sites.add(_s);
				}
				type.setSites(sites);
				this.typeDao.addSites(type);
			}
		} else {
			Type _t = new Type();
			_t.setName(((Type) params.get("type")).getName());
			_t.setPrice(((Type) params.get("type")).getPrice());
			List<Type> _ts = this.queryList(_t);
			if (CollectionUtils.isNotEmpty(_ts)) {
				type = _ts.get(0);
			} else {
				type = (Type) params.get("type");
				this.typeDao.add(type);
			}

			// add typssite relationship
			List<Site> sites = new ArrayList<Site>();
			Site _s = new Site();
			_s.setId(String.valueOf(params.get("siteId")));
			sites.add(_s);
			type.setSites(sites);
			this.typeDao.addSites(type);
		}
		return type.getId();
	}

	public Integer update(Map<String, Object> params) {
		Type type = (Type) params.get("type");
		Integer ret = this.typeDao.update(type);
		if (params.get("siteId") == null) {
			// add typssite relationship
			String ids = String.valueOf(params.get("siteIds"));
			params.put("siteIds", null);
			this.typeDao.deleteSites(params);
			if (StringUtils.isNotEmpty(ids)) {
				String[] idArr = ids.split(",");
				List<Site> sites = new ArrayList<Site>();
				Site _s;
				for (String s : idArr) {
					_s = new Site();
					_s.setId(s);
					sites.add(_s);
				}
				type.setSites(sites);
				this.typeDao.addSites(type);
			}
		}
		return ret;
	}

	public String delete(Map<String, Object> params) {
		Type type = (Type) params.get("type");
		if (params.get("siteId") == null) {
			this.typeDao.delete(type);
			this.typeDao.deleteSites(params);
		} else {
			Type _t = new Type();
			_t.setId(type.getId());
			_t = this.query(_t);
			if (_t.getSites().size() > 1) {
				params.put("siteIds", params.get("siteId"));
				this.typeDao.deleteSites(params);
			} else {
				this.typeDao.delete(type);
				this.typeDao.deleteSites(params);
			}
		}
		return null;
	}

	public List<Type> queryquerySecondNodes() {
		return this.typeDao.queryquerySecondNodes();
	}

}
