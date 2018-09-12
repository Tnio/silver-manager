package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.BLANK;
import static com.silverfox.finance.util.ConstantUtil.COMMA;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.BonusStrategy;
import com.silverfox.finance.domain.Guarantee;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.ProductCategory;
import com.silverfox.finance.domain.ProductContract;
import com.silverfox.finance.domain.ProductDetail;
import com.silverfox.finance.domain.ProductProtocol;
import com.silverfox.finance.domain.Project;
import com.silverfox.finance.enumeration.AttachmentCategotyEnum;
import com.silverfox.finance.orm.AttachmentDao;
import com.silverfox.finance.orm.BonusStrategyDao;
import com.silverfox.finance.orm.GuaranteeDao;
import com.silverfox.finance.orm.LenderDao;
import com.silverfox.finance.orm.MerchantDao;
import com.silverfox.finance.orm.ProductCategoryDao;
import com.silverfox.finance.orm.ProductContractDao;
import com.silverfox.finance.orm.ProductDao;
import com.silverfox.finance.orm.ProductDetailDao;
import com.silverfox.finance.orm.ProductProtocolDao;
import com.silverfox.finance.orm.ProjectDao;
import com.silverfox.finance.service.ProductService;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;

public class ProductServiceImpl implements ProductService {
	
	private static final String REPORT = "report";
	private static final String PROTOCOL = "protocol";
	private static final String CONTRACT = "contract";
	private static final String FUNDFLOW = "fundFlow";
	private static final String REALSHOT = "realShot";
	private static final String PLEDGE = "pledge";
	private static final String STORAGE = "storage";
	private static final String GUARANTEE = "guarantee";
	private static final String COMMITMENTLETTER = "commitmentLetter";
	
	@Autowired
	private ProductDao productDao;
	@Autowired
	private MerchantDao merchantDao;
	@Autowired
	private ProductDetailDao productDetailDao;
	@Autowired
	private ProductCategoryDao productCategoryDao;
	@Autowired
	private ProductContractDao productContractDao;
	@Autowired
	private ProductProtocolDao productProtocolDao;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private GuaranteeDao guaranteeDao;
	@Autowired
	private ProjectDao projectDao;
	@Autowired
	private LenderDao lenderDao;
	@Autowired
	private BonusStrategyDao bonusStrategyDao;
	

	@Override
	public List<ProductCategory> list(int status) {
		return productCategoryDao.queryForList(status);
	}

	@Override
	public int count(String name, String status, String risk, int periodStart, int periodEnd, int categoryId,
			int merchantId, String systemTime) {
		Map<String, Object> params = this.getProductParam(name, status, risk, periodStart, periodEnd, categoryId,
				merchantId, systemTime);
		return productDao.queryForCount(params);
	}

	@Override
	public List<Product> list(String name, String status, String risk, int periodStart, int periodEnd, int categoryId,
			int merchantId, String systemTime, int offset, int size) {
		Map<String, Object> params = this.getProductParam(name, status, risk, periodStart, periodEnd, categoryId,
				merchantId, systemTime);
		params.put("offset", offset);
		params.put("size", size);
		return productDao.queryForList(params);
	}

	private Map<String, Object> getProductParam(String name, String status, String risk, int periodStart, int periodEnd,
			int categoryId, int merchantId, String systemTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		if (StringUtils.isNotBlank(status)) {
			params.put("status", status);
		}
		if (StringUtils.isNotBlank(risk)) {
			params.put("risk", risk);
		}
		if (categoryId > 0) {
			params.put("categoryId", categoryId);
		}
		if (periodStart > 0) {
			params.put("periodStart", periodStart);
		}
		if (periodEnd > 0) {
			params.put("periodEnd", periodEnd);
		}
		if (merchantId > 0) {
			params.put("merchantId", merchantId);
		}
		if (StringUtils.isNotBlank(systemTime)) {
			params.put("systemTime", systemTime);
		}
		return params;
	}

	@Override
	public int count() {
		return projectDao.queryForCount();
	}

	@Override
	public List<Project> list(int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return projectDao.queryForList(params);
	}

	@Override
	public List<Guarantee> listGuarantee(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return guaranteeDao.queryForList(params);
	}

	@Override
	public Project getProject(int projectId) {
		Project project = projectDao.selectById(projectId);
		if (project != null) {
			/* if (StringUtils.isNotBlank(project.getBuyBackAttachment())) { */
			if (project.getMerchant() != null && project.getMerchant().getId() > 0) {
				Merchant merchant = merchantDao.selectById(project.getMerchant().getId());
				project.setMerchant(merchant);
			}
			if (StringUtils.isNotBlank(project.getOtherData())) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				String[] infos = StringUtils.split(project.getOtherData(), COMMA);
				if (infos != null && infos.length > 0) {
					for (String info : infos) {
						if (StringUtils.isNotBlank(info)) {
							attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
						}
					}
					project.setAttachments(attachmentDao.selectByIds(attachmentIds));
				}
			}
			if (StringUtils.isNotBlank(project.getGuaranteeAttachment())) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				String[] infos = StringUtils.split(project.getGuaranteeAttachment(), COMMA);
				if (infos != null && infos.length > 0) {
					for (String info : infos) {
						if (StringUtils.isNotBlank(info)) {
							attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
						}
					}
					project.setGuaranteeAttachments(attachmentDao.selectByIds(attachmentIds));
				}
			}
			return project;
		}
		return null;
	}

	@Override
	@LogRecord(module = LogRecord.Module.PROJECT_MANAGEMENT, operation = LogRecord.Operation.AUDIT, id = "${id}", name = "")
	public boolean audit(int id, int status) {
		return projectDao.updateStatus(id, status) > 0 ? true : false;
	}

	@Override
	@LogRecord(module = LogRecord.Module.PROJECT_MANAGEMENT, operation = LogRecord.Operation.PROJECTMANAGEMENTOPERATION, id = "${project.id}", name = "${project.name}")
	public boolean saveProject(Project project) {
		if (project != null) {
			if (project.getType() > 0) {
				if (project.getMerchant() != null && project.getMerchant().getId() > 0) {
					Merchant merchant = merchantDao.selectById(project.getMerchant().getId());
					if (merchant == null || merchant.getId() == null) {
						merchant.setId(0);
					}
					merchant.setAccountId(project.getMerchant().getAccountId());
					merchant.setCardNO(project.getMerchant().getCardNO());
					merchant.setCellphone(project.getMerchant().getCellphone());
					merchant.setBankNO(project.getMerchant().getBankNO());
					merchant.setPayVoucher(project.getMerchant().getPayVoucher());
					merchant.setProvinceCode(project.getMerchant().getProvinceCode());
					merchant.setCityCode(project.getMerchant().getCityCode());
					merchant.setLegalPerson(project.getMerchant().getName());
					merchant.setName(project.getMerchant().getName());
					merchant.setLegalPersonIdcard(project.getMerchant().getLicenseNO());
					merchant.setLinkman(project.getMerchant().getName());
					merchant.setLicenseNO(project.getMerchant().getLicenseNO());
					// merchant.setAddress(project.getMerchant().getAddress());
					merchant.setStatus(1);
					merchant.setType(project.getType());
					merchantDao.insert(merchant);
					project.setMerchant(merchant);
				} else {
					Merchant merchant = new Merchant();
					merchant.setId(0);
					merchant.setAccountId(project.getMerchant().getAccountId());
					merchant.setCardNO(project.getMerchant().getCardNO());
					merchant.setCellphone(project.getMerchant().getCellphone());
					merchant.setBankNO(project.getMerchant().getBankNO());
					merchant.setPayVoucher(project.getMerchant().getPayVoucher());
					merchant.setProvinceCode(project.getMerchant().getProvinceCode());
					merchant.setCityCode(project.getMerchant().getCityCode());
					merchant.setLegalPerson(project.getMerchant().getName());
					merchant.setName(project.getMerchant().getName());
					merchant.setLinkman(project.getMerchant().getName());
					merchant.setLegalPersonIdcard(project.getMerchant().getLicenseNO());
					merchant.setLicenseNO(project.getMerchant().getLicenseNO());
					// merchant.setAddress(project.getMerchant().getAddress());
					merchant.setStatus(1);
					merchant.setType(project.getType());
					merchantDao.insert(merchant);
					project.setMerchant(merchant);
				}
			} else {
				Merchant merchant = new Merchant();
				merchant.setId(0);
				project.setMerchant(merchant);
			}
			if (project.getId() > 0) {
				List<Integer> attachmentIds = new ArrayList<Integer>();
				/*
				 * if (StringUtils.isNotBlank(project.getBuyBackAttachment())) {
				 */
				if (StringUtils.isNotBlank(project.getOtherData())) {
					String[] infos = StringUtils.split(project.getOtherData(), COMMA);
					if (infos != null && infos.length > 0) {
						for (String info : infos) {
							if (StringUtils.isNotBlank(info)) {
								attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
							}
						}
					}
				}
				if (project.getAttachments() != null && project.getAttachments().size() > 0) {
					String attachmentId = null;
					for (Attachment attachment : project.getAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							attachmentIds.add(attachment.getId());
						}
					}
					if (attachmentIds != null && attachmentIds.size() > 0) {
						attachmentId = Arrays.toString(attachmentIds.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId) - 1);
						// project.setBuyBackAttachment(StringUtils.trim(attachmentId));
						project.setOtherData(StringUtils.trim(attachmentId));
					}
				}
				List<Integer> guaranteeAttachmentIds = new ArrayList<Integer>();
				if (StringUtils.isNotBlank(project.getGuaranteeAttachment())) {
					String[] infos = StringUtils.split(project.getGuaranteeAttachment(), COMMA);
					if (infos != null && infos.length > 0) {
						for (String info : infos) {
							if (StringUtils.isNotBlank(info)) {
								guaranteeAttachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
							}
						}
					}
				}
				if (project.getGuaranteeAttachments() != null && project.getGuaranteeAttachments().size() > 0) {
					String attachmentId = null;
					for (Attachment attachment : project.getGuaranteeAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							guaranteeAttachmentIds.add(attachment.getId());
						}
					}
					if (guaranteeAttachmentIds != null && guaranteeAttachmentIds.size() > 0) {
						attachmentId = Arrays.toString(guaranteeAttachmentIds.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId) - 1);
						project.setGuaranteeAttachment(StringUtils.trim(attachmentId));
					}
				}
				return projectDao.update(project) > 0 ? true : false;
			} else {
				if (project.getAttachments() != null && project.getAttachments().size() > 0) {
					List<Integer> ids = new ArrayList<Integer>();
					String attachmentId = null;
					for (Attachment attachment : project.getAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							ids.add(attachment.getId());
						}
					}
					if (ids != null && ids.size() > 0) {
						attachmentId = Arrays.toString(ids.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId) - 1);
						// project.setBuyBackAttachment(StringUtils.trim(attachmentId));
						project.setOtherData(StringUtils.trim(attachmentId));
					}
				}
				if (project.getGuaranteeAttachments() != null && project.getGuaranteeAttachments().size() > 0) {
					List<Integer> ids = new ArrayList<Integer>();
					String attachmentId = null;
					for (Attachment attachment : project.getGuaranteeAttachments()) {
						if (attachmentDao.insertSingle(attachment) > 0) {
							ids.add(attachment.getId());
						}
					}
					if (ids != null && ids.size() > 0) {
						attachmentId = Arrays.toString(ids.toArray());
						attachmentId = StringUtils.substring(attachmentId, 1, StringUtils.length(attachmentId) - 1);
						project.setGuaranteeAttachment(StringUtils.trim(attachmentId));
					}
				}
				return projectDao.insert(project) > 0 ? true : false;
			}
		}
		return false;
	}

	@Override
	public int countContract(String name, int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		params.put("status", status);
		return productContractDao.queryForCount(params);
	}

	@Override
	public List<ProductContract> listContract(String name, int status, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(name)) {
			params.put("name", name);
		}
		params.put("status", status);
		params.put("offset", offset);
		params.put("size", size);
		return productContractDao.queryForList(params);
	}

	@Override
	public int countProtocol(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return productProtocolDao.queryForCount(params);
	}

	@Override
	public List<ProductProtocol> listProtocol(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return productProtocolDao.queryForList(params);
	}

	@Override
	public int countGuarantee(int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		return guaranteeDao.queryForCount(params);
	}

	@Override
	public int count(String productName, String status, int auditStatus, int merchantId, String systemTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(productName)) {
			params.put("name", productName);
		}
		if (StringUtils.isNotBlank(status)) {
			params.put("status", status);
		}

		if (auditStatus >= 0) {
			params.put("auditStatus", auditStatus);
		}
		if (merchantId > 0) {
			params.put("merchantId", merchantId);
		}
		if (StringUtils.isNotBlank(systemTime)) {
			params.put("systemTime", systemTime);
		}
		return productDao.queryForCountTreasure(params);
	}

	@Override
	public List<Product> list(String productName, String status, int auditStatus, int merchantId, String systemTime,
			int offset, int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(productName)) {
			params.put("name", productName);
		}

		if (StringUtils.isNotBlank(status)) {
			params.put("status", status);
		}
		if (auditStatus >= 0) {
			params.put("auditStatus", auditStatus);
		}
		if (merchantId > 0) {
			params.put("merchantId", merchantId);
		}
		if (StringUtils.isNotBlank(systemTime)) {
			params.put("systemTime", systemTime);
		}
		params.put("offset", offset);
		params.put("size", pageSize);
		return productDao.queryForListTreasure(params);
	}

	@Override
	public int countCategory(String property) {
		return productCategoryDao.queryForCountByProperty(property);
	}

	@Override
	@LogRecord(module=LogRecord.Module.PRODUCTCATEGORY, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
	public boolean enable(int id, int value) {
		return productCategoryDao.enable(id, value) > 0 ? true : false;
	}

	@Override
	public List<Product> getProductByBonusId(int bonusId) {
		return productDao.selectProductByBonusId(bonusId);
	}

	@Override
	public boolean duplicate(int id, String name) {
		return productCategoryDao.duplicate(id, name) < 1 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.PRODUCTCATEGORY, operation=LogRecord.Operation.PRODUCTCATEGORYSAVE, id="", name="${productCategory.name}")
	public boolean saveProductCategory(ProductCategory productCategory) {
		boolean checkResult = checkedParam(productCategory);
		if (checkResult) {
			return productCategoryDao.insert(productCategory) > 0 ? true : false;
		} else {
			return false;
		}
	}

	private boolean checkedParam(ProductCategory category) {
		if (category != null) {
			if (!ValidatorUtil.StrNotNullAndMinAndMax(category.getName(), 2, 20)) {
				return false;
			}
			if (ValidatorUtil.StrNotNullAndMinAndMax(category.getName(), 31, 3000)) {
				return false;
			}
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int count(String name) {
		return productDao.selectAllByName(name);
	}

	@Override
	public ProductContract getContract(int id) {
		return productContractDao.selectById(id);
	}
    
	@Override
	@LogRecord(module=LogRecord.Module.PRODUCTCONTRACT, operation=LogRecord.Operation.PRODUCTCONTRACTSAVE, id="", name="${productContract.name}")
	public boolean saveProductContract(ProductContract productContract, Map<String, String> attachmentsMap) {
		if (productContract != null) {
			ProductContract result=saveProductContract(productContract);
			//redisMapService.del(PRODUCT_WEB_LIST);
			//redisListService.del(PRODUCT_WEB_RECOMMEND);
			if(attachmentsMap != null){
				List<Attachment> attachments = new ArrayList<Attachment>();
				if (result != null && result.getId() > 0) {
					for (String key : attachmentsMap.keySet()) {
						if (StringUtils.contains(key, REPORT)) {
							Attachment attachment = new Attachment();
							attachment.setContract(result);
							attachment.setCategory(AttachmentCategotyEnum.REPORT.getCategory());
							attachment.setUrl(attachmentsMap.get(key));
							attachments.add(attachment);
						} else if (StringUtils.contains(key, PROTOCOL)) {
							Attachment attachment = new Attachment();
							attachment.setContract(result);
							attachment.setCategory(AttachmentCategotyEnum.PROTOCOL.getCategory());
							attachment.setUrl(attachmentsMap.get(key));
							attachments.add(attachment);
						} else if (StringUtils.contains(key, CONTRACT)) {
							Attachment attachment = new Attachment();
							attachment.setContract(result);
							attachment.setCategory(AttachmentCategotyEnum.CONTRACT.getCategory());
							attachment.setUrl(attachmentsMap.get(key));
							attachments.add(attachment);
						} else {
							// do nothing
						}
					}
				}
				
				if (attachments.size() > 0) {
					return saveAttachments(attachments)>0?true:false;
				}else{
					if(result != null){
						return true;
					}else{
						return false;
					}
				}
			}
		}
		return false;
	}
	
	@Override
	public int saveAttachments(List<Attachment> attachments) {
		return attachmentDao.insert(attachments);
	}
	
	public ProductContract saveProductContract(ProductContract productContract) {
		int result = 0;
		if (productContract.getId() > 0) {
			result = productContractDao.update(productContract);
		} else {
			result = productContractDao.insert(productContract);
		}
		if (result > 0) {
			return productContract;
		}
		return null;
	}
	
	

	@Override
	public ProductProtocol getProtocol(int protocolId) {
		return productProtocolDao.selectById(protocolId);
	}

	@Override
	public boolean saveProductProtocol(ProductProtocol protocol) {
		if (protocol != null) {
			if (protocol.getId() > 0) {
				return productProtocolDao.update(protocol) > 0 ? true : false;
			} else {
				return productProtocolDao.insert(protocol) > 0 ? true : false;
			}
		}
		return false;
	}

	@Override
	public Guarantee getGuarantee(int guaranteeId) {
		return guaranteeDao.selectById(guaranteeId);
	}
    
	@Override
	public boolean saveGuarantee(Guarantee guarantee, Map<String, String> attachmentsMap) {
		if (guarantee != null) {
			Guarantee result = saveGuarantee(guarantee);
			if(attachmentsMap != null){
				List<Attachment> attachments = new ArrayList<Attachment>();
				if (result != null && result.getId() > 0) {
					for (String key : attachmentsMap.keySet()) {
						if (StringUtils.contains(key, GUARANTEE)) {
							Attachment attachment = new Attachment();
							attachment.setCategory(5);
							attachment.setProductId(0);
							attachment.setGuaranteeId(result.getId());
							attachment.setUrl(attachmentsMap.get(key));
							attachments.add(attachment);
						}else {
							// do nothing
						}
					}
				}
				
				if (attachments.size() > 0) {
					return saveAttachments(attachments)>0?true:false;
				}else{
					if(result != null){
						return true;
					}else{
						return false;
					}
				}
			}
		}
		return false;
	}
	
	public Guarantee saveGuarantee(Guarantee guarantee) {
		int result = 0;
		if (guarantee.getId() > 0) {
			result = guaranteeDao.update(guarantee);
		} else {
			result = guaranteeDao.insert(guarantee);
		}
		if (result > 0) {
			return guarantee;
		}
		return null;
	}
	
	  @Override
	    public boolean removeAttachment(List<Integer> ids) {
	    	return attachmentDao.deleteMore(ids) > 0 ? true : false;
	    }
	  
	  @Override
		@LogRecord(module=LogRecord.Module.PRODUCT, operation=LogRecord.Operation.PRODUCTSAVE, id="${product.id}", name="${product.name}", remark="${product.category.property}")
		public boolean save(Product product, Map<String, String> attachmentsMap, int[] lenderIds) {
			return saveProduct(product, attachmentsMap, lenderIds);
		}
	  private boolean saveProduct(Product product, Map<String, String> attachmentsMap, int[] lenderIds){
			if (product != null) {
				Product result = save(product);
				if (result != null) {
					if(result.getId() > 0 && attachmentsMap != null && attachmentsMap.size() > 0){
						List<Attachment> attachments = new ArrayList<Attachment>();
						if (result != null && result.getId() > 0) {
							for (String key : attachmentsMap.keySet()) {
								if (StringUtils.contains(key, FUNDFLOW)) {
									Attachment attachment = new Attachment();
									attachment.setCategory(1);
									attachment.setProductId(result.getId());
									attachment.setUrl(attachmentsMap.get(key));
									attachments.add(attachment);
								} else if (StringUtils.contains(key, REALSHOT)) {
									Attachment attachment = new Attachment();
									attachment.setCategory(2);
									attachment.setProductId(result.getId());
									attachment.setUrl(attachmentsMap.get(key));
									attachments.add(attachment);
								} else if (StringUtils.contains(key, PLEDGE)) {
									Attachment attachment = new Attachment();
									attachment.setCategory(3);
									attachment.setProductId(result.getId());
									attachment.setUrl(attachmentsMap.get(key));
									attachments.add(attachment);
								} else if(StringUtils.contains(key, COMMITMENTLETTER)){
									Attachment attachment = new Attachment();
									attachment.setCategory(4);
									attachment.setProductId(result.getId());
									attachment.setUrl(attachmentsMap.get(key));
									attachments.add(attachment);
								} else if(StringUtils.contains(key, STORAGE)){
									Attachment attachment = new Attachment();
									attachment.setCategory(6);
									attachment.setProductId(result.getId());
									attachment.setUrl(attachmentsMap.get(key));
									attachments.add(attachment);
								}else {
									// do nothing
								}
								
								
							}
						}
						
						if (attachments.size() > 0) {
							saveAttachments(attachments);
						}
					}
					if(lenderIds != null && lenderIds.length > 0){
						lenderDao.updateProductId(result.getId());
						return lenderDao.update(result.getId(), lenderIds) > 0 ? true : false;
					}
				}
				return true;
			}
			return false;
		}
	  
	 
		public Product save(Product product) {
			int result = 0;
			if(product.getProductDetail() != null && product.getProductDetail().getProject() != null){
				Project project = projectDao.selectById(product.getProductDetail().getProject().getId());
				if(project != null && project.getType() > 0){
					product.setMerchant(project.getMerchant());
				}
			}
			if(product.getId() > 0) {
				result = productDao.update(product);
				if(result > 0){
					if(product.getProductDetail() != null){
						ProductDetail detail = product.getProductDetail();
						detail.setId(product.getId());
						detail.setInstitutionDesc(BLANK);
						detail.setServiceProtocol(BLANK);
						detail.setObligatoryRight(BLANK);
						productDetailDao.update(detail);
					}
				}
			} else {
				result = productDao.insert(product);
				if(result > 0){
					if(product.getProductDetail() != null){
						ProductDetail detail = product.getProductDetail();
						detail.setId(product.getId());
						detail.setInstitutionDesc(BLANK);
						detail.setServiceProtocol(BLANK);
						detail.setObligatoryRight(BLANK);
						productDetailDao.insert(detail);
					}
				}
			}
			if(result > 0) {
				return product;
			}
			return null;
		}
		
		@Override
		public Product get(int id) {
			//return productDao.selectById(id);
			Product product = productDao.selectById(id);
			if (product != null) {
				ProductDetail productDetail = getProductDetail(id);
				if (productDetail != null) {
					if(productDetail.getContract() != null && productDetail.getContract().getId() > 0){
						ProductContract contract = productContractDao.selectById(productDetail.getContract().getId());
						if(contract != null){
							productDetail.setContract(contract);
						}
					}
					product.setProductDetail(productDetail);
				}
				
				if(product.getBonus() != null && product.getBonus().getId() > 0){
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("bonusId", product.getBonus().getId());
					List<BonusStrategy> bonusStrategy = bonusStrategyDao.queryForList(params);
					Bonus bonus = product.getBonus();
					bonus.setBonusStrategy(bonusStrategy);
					product.setBonus(bonus);
				}
			}
			return product;
			
		}
		
		@Override
		public List<Attachment> listAttachments(int productId) {
			return attachmentDao.selectByProductId(productId);
		}
		
		@Override
		@LogRecord(module=LogRecord.Module.PRODUCT, operation=LogRecord.Operation.FULL_SCALE, id="${product.id}", name="${product.name}", remark="${product.category.property}")
		public boolean fullScale(Product product, Map<String, String> attachmentsMap, int[] lenderIds) {
			return saveProduct(product, attachmentsMap, lenderIds);
		}
		
		@Override
		public boolean updateDisplayPlatform(int productId, String displayPlatform) {
			
			boolean result = productDao.updateDisplayPlatform(productId,displayPlatform);
			if (result) {
				//redisMapService.del(PRODUCT_WEB_LIST);
				//redisListService.del(PRODUCT_WEB_RECOMMEND);
				return true;
			}
			return false;
		}
		
		@Override
		public boolean removeAttachment(int attachmentId) {
			return attachmentDao.delete(attachmentId) > 0 ? true : false;
		}
		
		@Override
		public boolean duplicateContract(int id, String name) {
			return productContractDao.duplicate(id, name) < 1 ? true : false;
		}
		
		@Override
		public boolean duplicateProtocol(int id, String name) {
			return productProtocolDao.duplicate(id, name) < 1 ? true : false;
		}
		
		@Override
		@LogRecord(module=LogRecord.Module.PRODUCT, operation=LogRecord.Operation.AUDIT, id="${product.id}", name="${product.name}", remark="${product.category.property}")
		public boolean auditProduct(Product product, Map<String, String> attachmentsMap, int[] lenderIds) {
			return saveProduct(product, attachmentsMap, lenderIds);
		}
		
		@Override
		public boolean duplicateGuarantee(int id, String name) {
			return guaranteeDao.duplicate(id, name) < 1 ? true : false;
		}
		
		@Override
		public int countByCategoryProperty(String property) {
			return productDao.queryForCountByCategoryProperty(property);
		}
		
		@Override
		public boolean changeSort(List<Product> products) {
			return productDao.updateSort(products) > 0 ? true : false;
		}
		
		public ProductDetail getProductDetail(Integer id) {
			ProductDetail detail = productDetailDao.selectById(id);
			if (detail != null && detail.getProject() != null) {
	    		if (StringUtils.isNotBlank(detail.getProject().getBuyBackAttachment())) {
	    			List<Integer> attachmentIds = new ArrayList<Integer>();
	    			String[] infos = StringUtils.split(detail.getProject().getBuyBackAttachment(), COMMA);
	    			if (infos != null && infos.length > 0) {
	    				for (String info : infos) {
	    					if (StringUtils.isNotBlank(info)) {
	    						attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
	    					}
	    				}
	    				detail.getProject().setAttachments(attachmentDao.selectByIds(attachmentIds));
	    			}
	    		}
	    		if (StringUtils.isNotBlank(detail.getProject().getGuaranteeAttachment())) {
	    			List<Integer> attachmentIds = new ArrayList<Integer>();
	    			String[] infos = StringUtils.split(detail.getProject().getGuaranteeAttachment(), COMMA);
	    			if (infos != null && infos.length > 0) {
	    				for (String info : infos) {
	    					if (StringUtils.isNotBlank(info)) {
	    						attachmentIds.add(Integer.parseInt(StringUtils.trim(info)));
	    					}
	    				}
	    				detail.getProject().setGuaranteeAttachments(attachmentDao.selectByIds(attachmentIds));
	    			}
	    		}
	    	}
			return detail;
		}

		@Override
		public Project getProjectData(int projectIdData) {
			
			return projectDao.selectById(projectIdData);
		}

		@Override
		public int getMerchantLoanCount(int merchantIdData) {
			
			return productDao.queryForMerchantLoanCount(merchantIdData);
		}

		@Override
		public int getTotalNumberMark() {
			
			return productDao.queryTotalNumberMark();
		}

		@Override
		public ProductCategory getCategory(int parseInt) {
			return  productCategoryDao.selectById(parseInt);
		}

		@Override
		@LogRecord(module=LogRecord.Module.PRODUCT, operation=LogRecord.Operation.RECALL, id="${id}", name="", remark="")
		public boolean changeProductStatus(int id) {
			
			return productDao.changeProductStatus(id) > 0 ? true : false;
		}

		@Override
		public String queryProductName(int id) {
			
			return productDao.queryProductName(id);
		}

		@Override
		public List<Product> getIntheSaleList() {
			return  productDao.queryInTheSale();
		}

}