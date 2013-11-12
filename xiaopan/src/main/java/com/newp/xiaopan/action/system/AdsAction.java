package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Ads;
import com.newp.xiaopan.bean.system.City;
import com.newp.xiaopan.bean.system.Site;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.common.FileUtil;
import com.newp.xiaopan.service.system.IAdsService;
import com.newp.xiaopan.service.system.ICityService;
import com.newp.xiaopan.service.system.ISiteService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class AdsAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private IAdsService adsService;
	@Autowired
	private ISiteService siteService;
	@Autowired
	private ICityService cityService;

	private Ads ads;
	private List<Ads> adss;
	private List<Site> sites;
	private List<City> citys;

	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;
	private boolean pathStatus;
	private File imgFile2;
	private String imgFile2FileName;
	private String imgFile2ContentType;
	private boolean pathStatus2;
	private String uploadStatus;

	public String toList() {
		adss = this.adsService.queryList(ads);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != ads && StringUtils.isNotEmpty(ads.getId())) {
			ads = this.adsService.query(ads);
		}
//		sites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
		sites = this.siteService.queryList(null);
		citys = this.cityService.queryList(null);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings({ "deprecation" })
	public String doEdit() {
		String oldPath = ads.getImageurl();
		if (StringUtils.isNotBlank(oldPath) && oldPath.indexOf("xiaopan") > -1) {
			oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
		}
		String oldPath2 = ads.getImageurl2();
		if (StringUtils.isNotBlank(oldPath2) && oldPath2.indexOf("xiaopan") > -1) {
			oldPath2 = oldPath2.substring(oldPath2.indexOf("xiaopan") + 7, oldPath2.length());
		}

		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			if (pathStatus) {
				String path = ServletActionContext.getRequest().getRealPath("/upload/ads/images/");
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
				ads.setImageurl(ServletActionContext.getRequest().getContextPath() + "/upload/ads/images/" + filename);
			}

			if (pathStatus2 && null != imgFile2) {
				String path = ServletActionContext.getRequest().getRealPath("/upload/ads/images/");
				File root = new File(path);
				if (!root.isDirectory()) {
					log.info("创建新文件夹成功" + path);
					root.mkdirs();
				}

				fis = new FileInputStream(imgFile2);
				String filename = FileUtil.gainFileName(imgFile2FileName);
				fos = new FileOutputStream(path + "/" + filename);

				byte[] data = new byte[1024];
				while (fis.read(data) != -1) {
					fos.write(data);
				}
				fos.flush();
				ads.setImageurl2(ServletActionContext.getRequest().getContextPath() + "/upload/ads/images/" + filename);
			}

			if (StringUtils.isEmpty(ads.getId())) {
				String id = this.adsService.add(ads);
				ads.setId(id);
			} else {
				this.adsService.update(ads);
				if (pathStatus) {
					FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
				}
				if (pathStatus2 && StringUtils.isNotEmpty(oldPath2)) {
					FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath2);
				}
			}

			pathStatus = false;
			uploadStatus = "success";
//			sites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
			sites = this.siteService.queryList(null);
			citys = this.cityService.queryList(null);
			return Constants.ACTION_TO_EDIT;
		} catch (Exception e) {
			log.error(e);
			pathStatus = false;
			uploadStatus = "error";
//			sites = (List<Site>) MySessionListener.getConfigMap_s().get(Constants.CONFIG_SITE_LIST);
			sites = this.siteService.queryList(null);
			citys = this.cityService.queryList(null);
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
		String oldPath = ads.getImageurl();
		String oldPath2 = ads.getImageurl2();
		this.adsService.delete(ads);
		if (StringUtils.isNotBlank(oldPath)) {
			if (oldPath.indexOf("xiaopan") > -1) {
				oldPath = oldPath.substring(oldPath.indexOf("xiaopan") + 7, oldPath.length());
			}
			FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath);
		}
		if (StringUtils.isNotBlank(oldPath2)) {
			if (oldPath2.indexOf("xiaopan") > -1) {
				oldPath2 = oldPath2.substring(oldPath2.indexOf("xiaopan") + 7, oldPath2.length());
			}
			FileUtil.deleteFile(ServletActionContext.getRequest().getRealPath("/") + oldPath2);
		}
		this.ajax(true);
	}

	/**
	 * @return the adss
	 */
	public List<Ads> getAdss() {
		return adss;
	}

	/**
	 * @param adss
	 *            the adss to set
	 */
	public void setAdss(List<Ads> adss) {
		this.adss = adss;
	}

	/**
	 * @return the ads
	 */
	public Ads getAds() {
		return ads;
	}

	/**
	 * @param ads
	 *            the ads to set
	 */
	public void setAds(Ads ads) {
		this.ads = ads;
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

	public File getImgFile2() {
		return imgFile2;
	}

	public void setImgFile2(File imgFile2) {
		this.imgFile2 = imgFile2;
	}

	public String getImgFile2FileName() {
		return imgFile2FileName;
	}

	public void setImgFile2FileName(String imgFile2FileName) {
		this.imgFile2FileName = imgFile2FileName;
	}

	public String getImgFile2ContentType() {
		return imgFile2ContentType;
	}

	public void setImgFile2ContentType(String imgFile2ContentType) {
		this.imgFile2ContentType = imgFile2ContentType;
	}

	public boolean isPathStatus2() {
		return pathStatus2;
	}

	public void setPathStatus2(boolean pathStatus2) {
		this.pathStatus2 = pathStatus2;
	}

	public String getUploadStatus() {
		return uploadStatus;
	}

	public void setUploadStatus(String uploadStatus) {
		this.uploadStatus = uploadStatus;
	}

	public List<Site> getSites() {
		return sites;
	}

	public void setSites(List<Site> sites) {
		this.sites = sites;
	}

	/**
	 * @return the citys
	 */
	public List<City> getCitys() {
		return citys;
	}

	/**
	 * @param citys the citys to set
	 */
	public void setCitys(List<City> citys) {
		this.citys = citys;
	}
}
