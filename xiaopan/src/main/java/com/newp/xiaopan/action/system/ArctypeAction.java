package com.newp.xiaopan.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.newp.xiaopan.bean.system.Arctype;
import com.newp.xiaopan.common.Constants;
import com.newp.xiaopan.service.system.IArctypeService;

/**
 * @author 张霄鹏
 * 
 */
@Controller
@Scope(value = "prototype")
public class ArctypeAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	private IArctypeService arctypeService;

	private Arctype arctype;
	private List<Arctype> arctypes;

	private File imgFile;
	private String imgFileFileName;
	private String imgFileContentType;
	JSONObject msg = new JSONObject();

	public String toList() {
		arctypes = this.arctypeService.queryList(arctype);
		return Constants.ACTION_TO_LIST;
	}

	public String toEdit() {
		if (null != arctype && StringUtils.isNotEmpty(arctype.getId())) {
			arctype = this.arctypeService.query(arctype);
		}
		Arctype tmp = new Arctype();
		tmp.setTopid(0);
		arctypes = this.arctypeService.queryList(tmp);
		return Constants.ACTION_TO_EDIT;
	}

	@SuppressWarnings("unchecked")
	public void uploadKindEditorImg() {
		InputStream fis = null;
		FileOutputStream fos = null;
		try {
			String path = gainSavePath();
			File root = new File(path);
			// 应保证在根目录中有此目录的存在
			// 如果没有，下面则上创建新的文件夹
			if (!root.isDirectory()) {
				System.out.println("创建新文件夹成功" + path);
				root.mkdirs();
			}

			fis = new FileInputStream(imgFile);
			String filename = gainFileName();
			fos = new FileOutputStream(path + "/" + filename);

			byte[] data = new byte[1024];
			while (fis.read(data) != -1) {
				fos.write(data);
			}
			fos.flush();
			msg.put("error", 0);
			// 上传成功返回文件url地址 。
			msg.put("url", ServletActionContext.getRequest().getContextPath() + "/upload/arctype/images/" + filename);
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
	public void doEdit() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isEmpty(arctype.getId())) {
			String id = this.arctypeService.add(arctype);
			jsonObject.put("result", "success");
			jsonObject.put("id", id);
		} else {
			this.arctypeService.update(arctype);
			jsonObject.put("result", "success");
			jsonObject.put("id", arctype.getId());
		}
		this.ajax(jsonObject.toJSONString());
	}

	public void doDelete() {
		this.arctypeService.delete(arctype);
		this.ajax(true);
	}

	/**
	 * 获取图片储存路径 根目录 + upload/arctype/images
	 */
	@SuppressWarnings("deprecation")
	private String gainSavePath() {
		return ServletActionContext.getRequest().getRealPath("/upload/arctype/images/"); // 服务器上面的真实路径
	}

	/**
	 * 获取图片储存名称
	 */
	private String gainFileName() {
		String fileName = "";
		fileName += new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 以yyyyMMdd的方式生成时间
		fileName += new Random().nextInt(10000); // 时间文件名称生成随机数
		fileName += "." + gainExt(); // 连接上后缀名
		return fileName;
	}

	/**
	 * 获取文件的后缀名 转小写
	 */
	private String gainExt() {
		return imgFileFileName.substring(imgFileFileName.lastIndexOf(".") + 1).toLowerCase();
	}

	/**
	 * 返回Json
	 * 
	 * @param message
	 * @return
	 */
	// 这里封装好json数据error 1 表示错误，message 表示错误信息。
	@SuppressWarnings("unchecked")
	private void getError(String message) {
		msg.put("error", 1);
		msg.put("message", message);
	}

	/**
	 * 成功的时候回写KindEditor。
	 */
	public boolean makeSuccessRespForKE(HttpServletResponse resp) {
		// resp.setContentType("text/xml;charset=UTF-8");去除 否则会在谷歌火狐下上传失败
		PrintWriter out = null;
		try {
			out = resp.getWriter();
			out.write(msg.toJSONString());
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} finally {
			if (out != null) {
				out.close();
			}
		}
		return true;
	}

	/**
	 * @return the arctypes
	 */
	public List<Arctype> getArctypes() {
		return arctypes;
	}

	/**
	 * @param arctypes
	 *            the arctypes to set
	 */
	public void setArctypes(List<Arctype> arctypes) {
		this.arctypes = arctypes;
	}

	/**
	 * @return the arctype
	 */
	public Arctype getArctype() {
		return arctype;
	}

	/**
	 * @param arctype
	 *            the arctype to set
	 */
	public void setArctype(Arctype arctype) {
		this.arctype = arctype;
	}

	/**
	 * @return the imgFile
	 */
	public File getImgFile() {
		return imgFile;
	}

	/**
	 * @param imgFile
	 *            the imgFile to set
	 */
	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	/**
	 * @return the imgFileFileName
	 */
	public String getImgFileFileName() {
		return imgFileFileName;
	}

	/**
	 * @param imgFileFileName
	 *            the imgFileFileName to set
	 */
	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	/**
	 * @return the imgFileContentType
	 */
	public String getImgFileContentType() {
		return imgFileContentType;
	}

	/**
	 * @param imgFileContentType
	 *            the imgFileContentType to set
	 */
	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}

	/**
	 * @return the msg
	 */
	public JSONObject getMsg() {
		return msg;
	}

	/**
	 * @param msg
	 *            the msg to set
	 */
	public void setMsg(JSONObject msg) {
		this.msg = msg;
	}
}
