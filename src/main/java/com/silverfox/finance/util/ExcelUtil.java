package com.silverfox.finance.util;

import static com.silverfox.finance.util.ConstantUtil.DECIMAL_FORMAT;
import static com.silverfox.finance.util.ConstantUtil.DOT;
import static com.silverfox.finance.util.ConstantUtil.NORMAL_DATETIME_FORMAT;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.silverfox.finance.domain.BaobaoOrder;
import com.silverfox.finance.domain.CustomerGoodsOrder;
import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.entity.LostUserEntity;
import com.silverfox.finance.entity.UninvestEntity;
import com.silverfox.finance.entity.UserEntity;
import com.silverfox.finance.enumeration.PlatformEnum;
import com.silverfox.finance.enumeration.TradeResultEnum;
import com.silverfox.finance.enumeration.TypeEnum;

public class ExcelUtil {
	private static final Log LOGGER = LogFactory.getLog(ExcelUtil.class);
	private static final DecimalFormat df = new DecimalFormat(DECIMAL_FORMAT);

	public static String writeToExcel(List<Serializable> list, String excelHeader, String savePath, String tempFileName,TypeEnum orderType) {
		String result = null;
		if (list != null && list.size() > 0) {
			SimpleDateFormat dateFormat = new SimpleDateFormat(NORMAL_DATETIME_FORMAT);
			HSSFWorkbook workBook = new HSSFWorkbook();
			HSSFSheet sheet = workBook.createSheet();
			HSSFDataFormat format = workBook.createDataFormat();
			HSSFCellStyle style = workBook.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			style.setWrapText(true);
			style.setBorderBottom((short) 1);
			style.setBorderLeft((short) 1);
			style.setBorderRight((short) 1);
			style.setBorderTop((short) 1);
			int rowNum = 0;
			try {
				for (Serializable serialize : list) {
					try {
						if (serialize instanceof UserEntity) {
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addCustomerHeader(sheet, style, excelHeader);
							}
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							ExcelUtil.addCustomerContent(sheet, style, format, (UserEntity) serialize, dateFormat,
									rowNum);
						} else if (serialize instanceof CustomerOrder && orderType != null) {
							CustomerOrder order = (CustomerOrder) serialize;
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							if (TypeEnum.OUT.compareTo(orderType) == 0) {
								if (rowNum == 0) {
									style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
									ExcelUtil.addCustomerOrderOutHeader(sheet, style, excelHeader);
								}
								ExcelUtil.addCustomerOrderOutContent(sheet, style, format, order, dateFormat, rowNum);
							} else {
								if (rowNum == 0) {
									style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
									ExcelUtil.addCustomerOrderInHeader(sheet, style, excelHeader);
								}
								ExcelUtil.addCustomerOrderInContent(sheet, style, format, order, dateFormat, rowNum);
							}
						} else if (serialize instanceof BaobaoOrder && orderType != null) {
							BaobaoOrder order = (BaobaoOrder) serialize;
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addBaobaoOrderHeader(sheet, style, excelHeader, orderType);
							}

							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							if (TypeEnum.OUT.compareTo(orderType) == 0 || TypeEnum.HANDING.compareTo(orderType) == 0) {
								ExcelUtil.addBaobaoOrderOutContent(sheet, style, format, order, dateFormat, rowNum);
							} else if (TypeEnum.IN.compareTo(orderType) == 0) {
								ExcelUtil.addBaobaoOrderInContent(sheet, style, format, order, dateFormat, rowNum);
							}
						} else if (serialize instanceof CustomerGoodsOrder) {
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addGoodsOrderHeader(sheet, style, excelHeader);
							}
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							ExcelUtil.addGoodsOrderContent(sheet, style, format, (CustomerGoodsOrder) serialize,
									dateFormat, rowNum);
						} else if (serialize instanceof GoodsCouponCode) {
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addCouponCodeHeader(sheet, style, excelHeader);
							}
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							ExcelUtil.addCouponCodeContent(sheet, style, format, (GoodsCouponCode) serialize,
									dateFormat, rowNum);
						} else if(serialize instanceof UninvestEntity){
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addUninvestEntityHeader(sheet, style, excelHeader);
							}
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							ExcelUtil.addUninvestEntityContent(sheet, style, format, (UninvestEntity) serialize,
									dateFormat, rowNum);
						}else if(serialize instanceof LostUserEntity){
							if (rowNum == 0) {
								style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
								ExcelUtil.addLostUserEntityHeader(sheet, style, excelHeader);
							}
							style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
							ExcelUtil.addLostUserEntityContent(sheet, style, format, (LostUserEntity) serialize,
									dateFormat, rowNum);
						}else {
							break;
						}
					} catch (Exception e) {
						LOGGER.error(e.getMessage());
						continue;
					}
					rowNum++;
				}

				File path = new File(savePath);
				if (!path.exists() && !path.isDirectory()) {
					try {
						path.mkdir();
					} catch (Exception e) {
						LOGGER.error(e.getMessage());
					}
				}

				File file = new File(savePath + tempFileName);
				if (!file.exists()) {
					try {
						file.createNewFile();
					} catch (IOException e) {
						LOGGER.error(e.getMessage());
					}
				}

				try (FileOutputStream outputStream = new FileOutputStream(savePath + tempFileName)) {
					workBook.write(outputStream);
				} catch (IOException e) {
					LOGGER.error(e.getMessage());
				}
				result = savePath + tempFileName;
			} finally {
				if (workBook != null) {
					try {
						workBook.close();
						workBook = null;
					} catch (IOException e) {
						// do nothing.
					}
				}
			}
		}

		return result;
	}

	private static void addLostUserEntityHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 6) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);
			}
		}
		
	}

	private static void addUninvestEntityHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 5) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);
			}
		}
		
	}

	private static void addLostUserEntityContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,LostUserEntity lostUserEntity, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(lostUserEntity.getUserId());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(lostUserEntity.getCellphone());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(lostUserEntity.getName());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(lostUserEntity.getInvestAmount());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(lostUserEntity.getChannelName());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (lostUserEntity.getLastPaybackTime() != null) {
			cell.setCellValue(dateFormat.format(lostUserEntity.getLastPaybackTime()));
		} else {
			cell.setCellValue("");
		}
		
		
	}

	private static void addUninvestEntityContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,UninvestEntity uninvestEntity, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(uninvestEntity.getUserId());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(uninvestEntity.getCellphone());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(uninvestEntity.getName());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(uninvestEntity.getChannelName());
		
		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (uninvestEntity.getRegisterTime() != null) {
			cell.setCellValue(dateFormat.format(uninvestEntity.getRegisterTime()));
		} else {
			cell.setCellValue("");
		}
	}

	private static void addCustomerContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format, UserEntity user,
			SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(user.getName());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(Integer.valueOf(user.getSilverNumber()));

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(user.getTotalTradeMoney());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(user.getTotalTradeIncome());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (user.getLatestSignTime() != null) {
			cell.setCellValue(dateFormat.format(user.getLatestSignTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (user.getRegisterTime() != null) {
			cell.setCellValue(dateFormat.format(user.getRegisterTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (user.getFirstTradeTime() != null) {
			cell.setCellValue(dateFormat.format(user.getFirstTradeTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (user.getChannel() != null && user.getChannel().getName() != null) {
			cell.setCellValue(user.getChannel().getName());
		} else {
			cell.setCellValue("");
		}
	}

	private static void addGoodsOrderContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			CustomerGoodsOrder goodsOrder, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (goodsOrder.getCustomer() != null) {
			cell.setCellValue(goodsOrder.getCustomer().getCellphone());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (goodsOrder.getGoods() != null) {
			cell.setCellValue(goodsOrder.getGoods().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (goodsOrder.getGoods() != null) {
			cell.setCellValue(goodsOrder.getGoods().getConsumeSilver());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(goodsOrder.getName());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(goodsOrder.getCellphone());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(goodsOrder.getAddress());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (goodsOrder.getExchangeTime() != null) {
			cell.setCellValue(dateFormat.format(goodsOrder.getExchangeTime()));
		} else {
			cell.setCellValue("");
		}
	}

	private static void addCustomerOrderInContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			CustomerOrder order, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getOrderTime() != null) {
			cell.setCellValue(dateFormat.format(order.getOrderTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(order.getOrderNO());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getProduct() != null) {
			cell.setCellValue(order.getProduct().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomer() != null) {
			cell.setCellValue(order.getCustomer().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(order.getPrincipal());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		if (order.getInterestPeriod() > 0) {
			cell.setCellValue(order.getCouponAmount() + "%");
		} else {
			cell.setCellValue("¥" + order.getCouponAmount());
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		if (order.getInterestPeriod() > 0) {
			cell.setCellValue(order.getInterestPeriod());
		} else {
			cell.setCellValue(0);
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomer() != null && order.getCustomer().getChannel() != null) {
			cell.setCellValue(order.getCustomer().getChannel().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (PlatformEnum.ANDROID.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.ANDROID.name());
		} else if (PlatformEnum.IOS.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.IOS.name());
		} else if (PlatformEnum.WAP.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.WAP.name());
		} else {
			cell.setCellValue(PlatformEnum.WEB.name());
		}
	}

	private static void addCustomerOrderOutContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			CustomerOrder order, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getPaybackTime() != null) {
			cell.setCellValue(dateFormat.format(order.getPaybackTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(order.getOrderNO());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getProduct() != null) {
			cell.setCellValue(order.getProduct().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomer() != null) {
			cell.setCellValue(order.getCustomer().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(df.format(order.getPrincipal()));

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(df.format(order.getPaybackAmount() - order.getPrincipal() - order.getFee()));

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomer() != null && order.getCustomer().getChannel() != null) {
			cell.setCellValue(order.getCustomer().getChannel().getName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(df.format(order.getPaybackAmount()));
	}

	private static void addCustomerHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 9) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[6]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[7]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[8]);
			}
		}
	}

	private static void addGoodsOrderHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 8) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 150);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 200);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				sheet.setColumnWidth(column, 20 * 150);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 20 * 150);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);

				sheet.setColumnWidth(column, 20 * 356);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[6]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[7]);
			}
		}
	}

	private static void addCustomerOrderOutHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 9) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 30 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[6]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[7]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[8]);
			}
		}
	}

	private static void addCustomerOrderInHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 10) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 30 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[6]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[7]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[8]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[9]);
			}
		}
	}

	private static void addBaobaoOrderOutContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			BaobaoOrder order, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getOrderTime() != null) {
			cell.setCellValue(dateFormat.format(order.getOrderTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(order.getOrderNO());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getProductName() != null) {
			cell.setCellValue(order.getProductName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomerName() != null) {
			cell.setCellValue(order.getCustomerName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(order.getPrincipal());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(order.getFee());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(order.getPrincipal() - order.getFee());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getStatus() == 1) {
			cell.setCellValue(TradeResultEnum.HANDING.toString());
		} else if (order.getStatus() == 2) {
			cell.setCellValue(TradeResultEnum.SUCCESS.toString());
		} else if (order.getStatus() == 3) {
			cell.setCellValue(TradeResultEnum.FAILURE.toString());
		} else {
			cell.setCellValue("");
		}
	}

	private static void addBaobaoOrderInContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			BaobaoOrder order, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(rowNum);

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getOrderTime() != null) {
			cell.setCellValue(dateFormat.format(order.getOrderTime()));
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellValue(order.getOrderNO());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getProductName() != null) {
			cell.setCellValue(order.getProductName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getCustomerName() != null) {
			cell.setCellValue(order.getCustomerName());
		} else {
			cell.setCellValue("");
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		cell.setCellType(format.getFormat(DECIMAL_FORMAT));
		cell.setCellValue(order.getPrincipal());

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (PlatformEnum.ANDROID.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.ANDROID.name());
		} else if (PlatformEnum.IOS.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.IOS.name());
		} else if (PlatformEnum.WAP.value() == order.getPayType()) {
			cell.setCellValue(PlatformEnum.WAP.name());
		} else {
			cell.setCellValue(PlatformEnum.WEB.name());
		}

		cell = row.createCell(column++);
		cell.setCellStyle(style);
		if (order.getChannelName() != null) {
			cell.setCellValue(order.getChannelName());
		} else {
			cell.setCellValue("");
		}
	}

	private static void addBaobaoOrderHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader, TypeEnum type) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[1]);

				sheet.setColumnWidth(column, 30 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[2]);

				sheet.setColumnWidth(column, 20 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[3]);

				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[4]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[5]);

				sheet.setColumnWidth(column, 15 * 256);
				cell = header.createCell(column++);
				cell.setCellStyle(style);
				cell.setCellValue(headers[6]);
				if (TypeEnum.IN.compareTo(type) == 0) {
					sheet.setColumnWidth(column, 15 * 256);
					cell = header.createCell(column++);
					cell.setCellStyle(style);
					cell.setCellValue(headers[7]);
				}

				if (TypeEnum.OUT.compareTo(type) == 0 || TypeEnum.HANDING.compareTo(type) == 0) {
					sheet.setColumnWidth(column, 15 * 256);
					cell = header.createCell(column++);
					cell.setCellStyle(style);
					cell.setCellValue(headers[7]);

					sheet.setColumnWidth(column, 15 * 256);
					cell = header.createCell(column++);
					cell.setCellStyle(style);
					cell.setCellValue(headers[8]);
				}
			}
		}
	}

	private static void addCouponCodeHeader(HSSFSheet sheet, HSSFCellStyle style, String excelHeader) {
		if (StringUtils.isNotBlank(excelHeader)) {
			String[] headers = StringUtils.split(excelHeader, DOT);
			if (headers != null && headers.length == 1) {
				int column = 0;
				HSSFRow header = sheet.createRow(0);
				HSSFCell cell = header.createCell(column);
				sheet.setColumnWidth(column, 20 * 256);
				cell.setCellStyle(style);
				cell.setCellValue(headers[0]);
			}
		}
	}

	private static void addCouponCodeContent(HSSFSheet sheet, HSSFCellStyle style, HSSFDataFormat format,
			GoodsCouponCode couponCode, SimpleDateFormat dateFormat, int rowNum) {
		int column = 0;
		HSSFRow row = sheet.createRow(++rowNum);
		HSSFCell cell = row.createCell(column);
		sheet.setColumnWidth(column, 20 * 256);
		cell.setCellStyle(style);
		if (couponCode != null && couponCode.getCode() != null) {
			cell.setCellValue(couponCode.getCode());
		} else {
			cell.setCellValue("");
		}

	}
}