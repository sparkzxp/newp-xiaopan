package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

	public String toList() {
		shops = this.shopService.queryList(shop);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		boolean isUpdate = (null != shop && StringUtils.isNotEmpty(shop.getId()));
		if (isUpdate) {
			shop = this.shopService.query(shop);
		}
		initEdit(isUpdate);

		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	private void initEdit(boolean isUpdate) {
		String[] typeIds = null;
		if (isUpdate && StringUtils.isNotEmpty(shop.getTypeIds())) {
			typeIds = shop.getTypeIds().split(",");
		}
		setSites(this.siteService.queryList(null));

		List<Type> allTypes = this.typeService.queryList(null);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject;
		boolean firstOpen = true;
		for (Type t : allTypes) {
			jsonObject = new JSONObject();
			jsonObject.put("id", t.getId());
			if (isUpdate && null != typeIds) {
				for (String s : typeIds) {
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
				jsonObject.put("name", t.getName() + "(" + t.getPrice() + "元)");
			}
			jsonArray.add(jsonObject);
		}
		this.typeJson = jsonArray.toJSONString();
	}

	@SuppressWarnings("deprecation")
	public String doEdit() {
		String oldPath = shop.getImagePath();
		if (StringUtils.isNotBlank(oldPath)) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
		}

		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			if (pathStatus) {
				String path = ServletActionContext.getRequest().getRealPath("/upload/shop/images/");
				File root = new File(path);
				if (!root.isDirectory()) {
					System.out.println("创建新文件夹成功" + path);
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
		this.shopService.delete(shop);
		if (StringUtils.isNotBlank(oldPath)) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
			FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
		}
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
				System.out.println("创建新文件夹成功" + path);
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
}
