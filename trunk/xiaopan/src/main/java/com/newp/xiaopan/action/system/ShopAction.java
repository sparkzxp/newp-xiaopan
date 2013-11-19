package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Shop;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.bean.system.Type;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.FileUtil;
import com.newp.xiaopan.service.system.IShopService;
import com.newp.xiaopan.service.system.ISiteService;
import com.newp.xiaopan.service.system.ITypeService;
import com.opensymphony.xwork2.Action;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class ShopAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private IShopService shopService;
	@Autowired
	private ISiteService siteService;
	@Autowired
	private ITypeService typeService;

	private Shop shop;
	private List<Shop> shops;
	private List<Site> sites;
	private String typeJson;

	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;
	private boolean pathStatus;
	private String uploadStatus;
	private String typeIds;
	private Boolean isAdmin;

	public String toList() {
		Map<String, Object> params = new HashMap<String, Object>();
		if (this.getLoginUser().getRole() != null && this.getLoginUser().getRole().getShop() != null && StringUtils.isNotEmpty(this.getLoginUser().getRole().getShop().getId())) {
			this.getShop().setId(this.getLoginUser().getRole().getShop().getId());
		}
		params.put("shop", this.getShop());
		if (!this.getLoginUser().getRole().getId().equals(Constants.SYS_ADMIN_ID) && this.getLoginUserSite() != null) {
			params.put("siteId", this.getLoginUserSite().getId());
		}
		shops = this.shopService.queryList(params);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		boolean isUpdate = (null != shop && StringUtils.isNotEmpty(shop.getId()));
		if (isUpdate) {
			shop = this.shopService.query(shop);
		} else if (this.getLoginUser().getRole() != null && this.getLoginUser().getRole().getShop() != null && StringUtils.isNotEmpty(this.getLoginUser().getRole().getShop().getId())) {
			return Action.NONE;
		}
		initEdit(isUpdate);

		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void changeTypeTree() {
		JSONObject jsonObject = new JSONObject();
		boolean isUpdate = (null != shop && StringUtils.isNotEmpty(shop.getId()));
		initTypeTree(isUpdate);
		jsonObject.put("result", "success");
		jsonObject.put("typeJson", typeJson);
		this.ajax(jsonObject.toJSONString());
	}

	private void initEdit(boolean isUpdate) {
		// 1
		String[] typeIdArr = null;
		StringBuffer sb = new StringBuffer();
		if (isUpdate && CollectionUtils.isNotEmpty(shop.getTypes())) {
			typeIdArr = new String[shop.getTypes().size()];
			for (int i = 0; i < shop.getTypes().size(); i++) {
				typeIdArr[i] = shop.getTypes().get(i).getId();
				if (i == 0) {
					sb.append(typeIdArr[i]);
				} else {
					sb.append(",").append(typeIdArr[i]);
				}
			}
			typeIds = sb.toString();
		}

		// 2
		isAdmin = this.getLoginUser().getRole().getId().equals(Constants.SYS_ADMIN_ID);

		// 3
		if (!isAdmin && this.getLoginUserSite() != null) {
			Site _site = new Site();
			_site.setCity(this.getLoginUserSite().getCity());
			setSites(this.siteService.queryList(_site));
		} else {
			setSites(this.siteService.queryList(null));
		}

		// 4
		initTypeTree(isUpdate);
	}

	@SuppressWarnings("unchecked")
	private void initTypeTree(boolean isUpdate) {
		String[] typeIdArr = null;
		if (StringUtils.isNotEmpty(typeIds)) {
			typeIdArr = typeIds.split(",");
		}

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", new Type());

		if (this.getLoginUser().getRole().getId().equals(Constants.SYS_ADMIN_ID)) {
			// 系统管理员
			if (null != shop && StringUtils.isNotEmpty(this.shop.getSiteId())) {
				// 修改
				params.put("siteId", this.shop.getSiteId());
			} else {
				params.put("siteId", "-1");
			}
		} else {
			// 站点管理员
			if (isUpdate) {
				params.put("siteId", shop.getSiteId());
			} else {
				params.put("siteId", this.getLoginUserSite().getId());
			}
		}

		// if (!this.getLoginUser().getRole().getId().equals(Constants.SYS_ADMIN_ID) && this.getLoginUserSite() != null) {
		// params.put("siteId", this.getLoginUserSite().getId());
		// }
		List<Type> allTypes = this.typeService.queryList(params);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		boolean firstOpen = true;
		for (Type t : allTypes) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			if (isUpdate && null != typeIdArr) {
				for (String s : typeIdArr) {
					if (t.getId().equals(s)) {
						jsonObject.put("checked", true);
						break;
					}
				}
			}
			jsonObject.put("pId", t.getTopid());
			if (null != t.getTopid() && t.getTopid() == 0) {
				jsonObject.put("name", t.getName());
				if (firstOpen) {
					jsonObject.put("open", true);
					firstOpen = false;
				}
				jsonObject.put("nocheck", true);
			} else {
				jsonObject.put("name", t.getName() + "(" + t.getPrice() + ")");
			}
			jsonArray.add(jsonObject);
		}
		this.typeJson = jsonArray.toJSONString();
	}

	@SuppressWarnings("deprecation")
	public String doEdit() {
		if (!this.getLoginUser().getRole().getId().equals(Constants.SYS_ADMIN_ID)) {
			shop.setSiteId(this.getLoginUserSite().getId());
		}

		String oldPath = shop.getImagePath();
		if (StringUtils.isNotBlank(oldPath) && oldPath.indexOf("xiaopan") > -1) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
		}

		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			if (pathStatus) {
				String path = ServletActionContext.getRequest().getRealPath("/upload/shop/images/");
				File root = new File(path);
				if (!root.isDirectory()) {
					log.info("创建新文件夹成功" + path);
					root.mkdirs();
				}

				fis = new FileInputStream(imgFile);
				String filename = FileUtil.gainFileName(imgFileFileName);
				fos = new FileOutputStream(path + "/" + filename);

				byte[] data = new byte[1024];
				while (fis.read(data) != -1) {
					fos.write(data);
				}
				fos.flush();
				shop.setImagePath(ServletActionContext.getRequest().getContextPath() + "/upload/shop/images/" + filename);
			}

			if (StringUtils.isNotEmpty(typeIds)) {
				List<Type> tmpTypes = new ArrayList<Type>();
				String[] arr = typeIds.split(",");
				Type t;
				for (String s : arr) {
					t = new Type();
					t.setId(s);
					tmpTypes.add(t);
				}
				shop.setTypes(tmpTypes);
			}
			if (StringUtils.isEmpty(shop.getId())) {
				String id = this.shopService.add(shop);
				shop.setId(id);
			} else {
				this.shopService.update(shop);
				if (pathStatus) {
					FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
				}
			}

			pathStatus = false;
			uploadStatus = "success";
			initEdit(true);
			return Constants.ACTION_TO_EDIT;
		} catch (Exception e) {
			log.error(e);
			pathStatus = false;
			uploadStatus = "error";
			initEdit(true);
			return Constants.ACTION_TO_EDIT;
		} finally {
			try {
				if (null != fis) {
					fis.close();
				}
				if (null != fos) {
					fos.close();
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
	}

	@SuppressWarnings("deprecation")
	public void doDelete() {
		String oldPath = shop.getImagePath();
		log.info("------------------del shop start----------------");
		log.info("id:" + shop.getId() + " imagePath:" + oldPath);
		this.shopService.delete(shop);
		if (StringUtils.isNotBlank(oldPath)) {
			if (oldPath.indexOf("xiaopan") > -1) {
				oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
			}
			log.info("del imagePath:" + oldPath);
			FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
		}
		log.info("------------------del shop end----------------");
		this.ajax(true);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public void uploadKindEditorImg() {
		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd/");
			String base = "/upload/shop/contents/" + sdf.format(new Date());
			String path = ServletActionContext.getRequest().getRealPath(base);
			File root = new File(path);
			if (!root.isDirectory()) {
				log.info("创建新文件夹成功" + path);
				root.mkdirs();
			}

			fis = new FileInputStream(imgFile);
			String filename = FileUtil.gainFileName(imgFileFileName);
			fos = new FileOutputStream(path + "/" + filename);

			byte[] data = new byte[1024];
			while (fis.read(data) != -1) {
				fos.write(data);
			}
			fos.flush();
			msg.put("error", 0);
			msg.put("url", ServletActionContext.getRequest().getContextPath() + base + filename);
			makeSuccessRespForKE(ServletActionContext.getResponse());
		} catch (Exception e) {
			log.error(e);
			getError("上传失败");
		} finally {
			try {
				if (null != fis) {
					fis.close();
				}
				if (null != fos) {
					fos.close();
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void getSelShop() {
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		List<Shop> tmpShops = this.shopService.queryList(shop);
		if (CollectionUtils.isNotEmpty(tmpShops)) {
			for (Shop t : tmpShops) {
				jsonObject = new JSONObject();
				jsonObject.put("id", t.getId());
				jsonObject.put("name", t.getTitle());

				jsonArray.add(jsonObject);
			}
		}
		this.ajax(jsonArray.toJSONString());
	}

	/**
	 * @return the shops
	 */
	public List<Shop> getShops() {
		return shops;
	}

	/**
	 * @param shops
	 *            the shops to set
	 */
	public void setShops(List<Shop> shops) {
		this.shops = shops;
	}

	/**
	 * @return the shop
	 */
	public Shop getShop() {
		if (shop == null) {
			shop = new Shop();
		}
		return shop;
	}

	/**
	 * @param shop
	 *            the shop to set
	 */
	public void setShop(Shop shop) {
		this.shop = shop;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	public String getTypeJson() {
		if (StringUtils.isEmpty(typeJson)) {
			return "[]";
		}
		return typeJson;
	}

	public void setTypeJson(String typeJson) {
		this.typeJson = typeJson;
	}

	public File getImgFile() {
		return imgFile;
	}

	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	public String getImgFileFileName() {
		return imgFileFileName;
	}

	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	public String getImgFileContentType() {
		return imgFileContentType;
	}

	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}

	public boolean isPathStatus() {
		return pathStatus;
	}

	public void setPathStatus(boolean pathStatus) {
		this.pathStatus = pathStatus;
	}

	public String getUploadStatus() {
		return uploadStatus;
	}

	public void setUploadStatus(String uploadStatus) {
		this.uploadStatus = uploadStatus;
	}

	public String getTypeIds() {
		return typeIds;
	}

	public void setTypeIds(String typeIds) {
		this.typeIds = typeIds;
	}

	/**
	 * @return the isAdmin
	 */
	public Boolean getIsAdmin() {
		return isAdmin;
	}

	/**
	 * @param isAdmin
	 *            the isAdmin to set
	 */
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
}
