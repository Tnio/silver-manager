package com.silverfox.finance.service;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.Attachment;
import com.silverfox.finance.domain.Guarantee;
import com.silverfox.finance.domain.Product;
import com.silverfox.finance.domain.ProductCategory;
import com.silverfox.finance.domain.ProductContract;
import com.silverfox.finance.domain.ProductDetail;
import com.silverfox.finance.domain.ProductProtocol;
import com.silverfox.finance.domain.Project;

public interface ProductService {
	List<ProductCategory> list(int status);
	int count(String name, String status, String risk, int periodStart, int periodEnd, int categoryId, int merchantId, String systemTime);
	List<Product> list(String name, String status, String risk, int periodStart, int periodEnd, int categoryId, int merchantId, String systemTime, int offset, int size);
	int count();
	List<Project> list(int offset, int size);
	List<Guarantee> listGuarantee(int status);
	Project getProject(int projectId);
	boolean audit(int id, int status);
	boolean saveProject(Project project);
	int countContract(String name, int status);
	List<ProductContract> listContract(String name, int status, int offset, int size);
	int countProtocol(int status);
	List<ProductProtocol> listProtocol(int status);
	int countGuarantee(int status);
	int count(String productName, String productStatue, int auditStatue, int merchantId, String systemTime);
	List<Product> list(String productName, String status, int auditStatus, int merchantId, String systemTime, int offset, int pageSize);
	int countCategory(String property);
	boolean enable(int id, int value);
	List<Product> getProductByBonusId(int bonusId);
	boolean duplicate(int id, String name);
	boolean saveProductCategory(ProductCategory productCategory);
	int count(String name);
	ProductContract getContract(int id);
	//ProductContract save(ProductContract productContract);
	ProductProtocol getProtocol(int protocolId); 
	boolean saveProductProtocol(ProductProtocol protocol);
	Guarantee getGuarantee(int guaranteeId);
	boolean saveGuarantee(Guarantee guarantee, Map<String, String> attachmentsMap);
	boolean saveProductContract(ProductContract productContract, Map<String, String> attachmentsMap);
	int saveAttachments(List<Attachment> attachments);
	public boolean removeAttachment(List<Integer> ids);
	boolean save(Product product, Map<String, String> attachmentsMap, int[] lenderIds);
	Product get(int id);
	List<Attachment> listAttachments(int productId);
	boolean fullScale(Product product, Map<String, String> attachmentsMap, int[] lenderIds);
	boolean updateDisplayPlatform(int productId, String displayPlatform);
	boolean removeAttachment(int attachmentId);
	boolean duplicateContract(int id, String name);
	boolean duplicateProtocol(int id, String name);
	boolean auditProduct(Product product, Map<String, String> attachmentsMap, int[] lenderIds);
	boolean duplicateGuarantee(int id, String name);
	int countByCategoryProperty(String property);
	boolean changeSort(List<Product> products);
	Project getProjectData(int projectIdData);
	int getMerchantLoanCount(int merchantIdData);
	int getTotalNumberMark();
	ProductDetail getProductDetail(Integer id);
	ProductCategory getCategory(int parseInt);
	boolean changeProductStatus(int id);
	String queryProductName(int parseInt);
	List<Product> getIntheSaleList();

}