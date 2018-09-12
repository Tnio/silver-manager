package com.silverfox.finance.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.alibaba.fastjson.JSON;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSException;
import com.silverfox.finance.controller.BaseController;
import com.silverfox.finance.domain.GoodsCouponCode;
import com.silverfox.finance.util.OSSUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.alibaba.fastjson.JSONObject;
import com.silverfox.finance.domain.PictrueLibrary;
import com.silverfox.finance.enumeration.PhotoCategoryEnum;
import com.silverfox.finance.enumeration.PictrueLibraryCategoryEnum;
import com.silverfox.finance.service.PictrueLibraryService;

import static com.silverfox.finance.util.ConstantUtil.*;
import static com.silverfox.finance.util.ConstantUtil.ALIYUN_OSS;
import static com.silverfox.finance.util.ConstantUtil.SLASH;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME;
import static com.silverfox.finance.util.OSSUtil.BUCKETNAME_FILE;

@Controller
@RequestMapping("/")
public class PhotoGalleryController extends BaseController {
    private static final String KEY_540= "540";
    private static final String KEY_720= "720";
    private static final String KEY_1080= "1080";
    private static final String KEY_640= "640";
    private static final String KEY_750= "750";

    @Autowired
    private PictrueLibraryService pictrueLibraryService;

    @RequestMapping(value="photo/list/{page:\\d+}")
    public String list(@PathVariable("page") int page, Integer size, HttpServletRequest request){
        int total = pictrueLibraryService.count(PictrueLibraryCategoryEnum.ALBUM.value(), -1, -1);

        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("photos",pictrueLibraryService.list(PictrueLibraryCategoryEnum.ALBUM.value(), -1, -1, this.getOffset(page, size), this.getPageSize(size)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("messages", new PictrueLibrary[0]);
        }
        request.setAttribute("size", this.getPageSize(size));
        request.setAttribute("page", this.getPage(page));
        return "photo/list";
    }

    @RequestMapping(value="/web/image/list")
    public String listwebphoto(HttpServletRequest request){
        int total = pictrueLibraryService.count(PictrueLibraryCategoryEnum.WEBPHOTO.value(), -1, -1);
        if(total > 0) {
            request.setAttribute("total", total);
            request.setAttribute("photos",pictrueLibraryService.list(PictrueLibraryCategoryEnum.WEBPHOTO.value(), -1, -1, this.getOffset(0, 0), this.getPageSize(0)));
        } else {
            request.setAttribute("total", 0);
            request.setAttribute("photos", new PictrueLibrary[0]);
        }

        return "image/photogallery/list";
    }

    @RequestMapping(value="photo/save", method=RequestMethod.POST)
    public String save(@Valid PictrueLibrary photoAlbum, BindingResult validResult, int page, int size, HttpServletRequest request) {
        if(!validResult.hasErrors()){
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if (StringUtils.isNotBlank(url)) {
                photoAlbum.setUrl(url);
            }
            photoAlbum.setContent("");
            pictrueLibraryService.save(photoAlbum);
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/photo/list/"+this.getPage(page);
    }

    @RequestMapping(value="photo/add/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String add(@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        return "photo/add";
    }

    @RequestMapping(value="photo/edit/{id:\\d+}/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String edit(@PathVariable("id")int id,@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("photo", pictrueLibraryService.get(id));
        request.setAttribute("operation",EDIT);
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        return "photo/edit";
    }

    @RequestMapping(value="photo/detail/{id:\\d+}/{page:\\d+}/{size:\\d+}",method=RequestMethod.GET)
    public String detail(@PathVariable("id")int id,@PathVariable("page")int page,@PathVariable("size")int size, HttpServletRequest request){
        request.setAttribute("photo", pictrueLibraryService.get(id));
        request.setAttribute("operation",DETAIL);
        request.setAttribute("page", page);
        request.setAttribute("size", size);
        return "photo/edit";
    }

    @RequestMapping(value="photo/enable/{id:\\d+}/{status:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean enable(@PathVariable("id")int id, @PathVariable("status")int status) {
        return pictrueLibraryService.enables(id, status);
    }

    @RequestMapping(value="photo/remove/{id:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean remove(@PathVariable("id")int id) {
        return pictrueLibraryService.remove(id);
    }

    @RequestMapping(value="photo/exist/title", method=RequestMethod.GET)
    @ResponseBody
    public boolean isExists(int id, String name) {
        if(StringUtils.isNotBlank(name)) {
            return pictrueLibraryService.duplicate(id, name, PictrueLibraryCategoryEnum.ALBUM.value());
        }
        return false;
    }

    @RequestMapping(value="/chart/add", method=RequestMethod.GET)
    public String forwardToCreation() {
        return "image/chart/add";
    }

    @RequestMapping(value="/chart/edit/{id:\\d+}", method=RequestMethod.GET)
    public String forwardToModification(@PathVariable("id")int id, HttpServletRequest request) {
        request.setAttribute("operation",EDIT);
        request.setAttribute("chart", pictrueLibraryService.get(id));
        return "image/chart/edit";
    }

    @RequestMapping(value="/chart/detail/{id:\\d+}", method=RequestMethod.GET)
    public String forwardToDetail(@PathVariable("id")int id, HttpServletRequest request) {
        request.setAttribute("operation",DETAIL);
        request.setAttribute("chart", pictrueLibraryService.get(id));
        return "image/chart/edit";
    }
    @RequestMapping(value="chart/enable/{id:\\d+}/{status:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean enablechart(@PathVariable("id")int id, @PathVariable("status")short status) {
        return pictrueLibraryService.enableChart(id, status);
    }

    @RequestMapping("/chart/list")
    public String listChart(HttpServletRequest request) {
        request.setAttribute("charts", pictrueLibraryService.list(PictrueLibraryCategoryEnum.START.value(), -1, -1, 0, 0));
        request.setAttribute("silverMarket", pictrueLibraryService.list(PictrueLibraryCategoryEnum.SILVER_MARKET.value(), -1, -1, 0, 0));
        request.setAttribute("productAds",pictrueLibraryService.list(PictrueLibraryCategoryEnum.PRODUCTAD.value(), -1, -1, 0, 0));
        request.setAttribute("vipPicture",pictrueLibraryService.list(PictrueLibraryCategoryEnum.VIPPICTURE.value(), -1, -1, 0, 0));
        return "image/chart/list";
    }

    @RequestMapping(value="/app/image/edit/{id:\\d+}",method=RequestMethod.GET)
    public String editAppImage(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", EDIT);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/silver-market/edit";
    }

    @RequestMapping(value="/app/image/detail/{id:\\d+}",method=RequestMethod.GET)
    public String appImageDetail(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", DETAIL);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/silver-market/edit";
    }

    @RequestMapping(value="/activity/image/edit/{id:\\d+}",method=RequestMethod.GET)
    public String editActivityImage(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", EDIT);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/activity/edit";
    }

    @RequestMapping(value="/activity/image/detail/{id:\\d+}",method=RequestMethod.GET)
    public String activityImageDetail(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", DETAIL);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/activity/edit";
    }
    @RequestMapping(value="/activity/vip/image/edit/{id:\\d+}",method=RequestMethod.GET)
    public String editActivityVipImage(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", EDIT);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/vipActivity/edit";
    }

    @RequestMapping(value="/activity/vip/image/detail/{id:\\d+}",method=RequestMethod.GET)
    public String activityVipImageDetail(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation", DETAIL);
        PictrueLibrary library = pictrueLibraryService.get(id);
        if (library != null) {
            library.setContent(htmlToCode(library.getContent()));
            request.setAttribute("photo", library);
        } else {
            request.setAttribute("photo", new PictrueLibrary());
        }
        return "image/vipActivity/edit";
    }
    public static final String htmlToCode(String s) {
        if(s == null) {
            return "";
        } else{
            s = s.replace("\n\r", "<br>&nbsp;&nbsp;");
            s = s.replace("\r\n", "<br>&nbsp;&nbsp;");
            s= s.replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
            s =s.replace(" ", "&nbsp;");
            s=s.replace("\"", "\\"+"\"");
            return s;
        }
    }

    @RequestMapping(value="/app/image/save", method=RequestMethod.POST)
    public String saveAppPhotoGallery(PictrueLibrary photoGallery,HttpServletRequest request) {
        if (photoGallery != null) {
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if(StringUtils.isNotBlank(url)){
                photoGallery.setUrl(url);
            }
            pictrueLibraryService.save(photoGallery);
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/chart/list";
    }

    @RequestMapping(value="/chart/save", method=RequestMethod.POST)
    public String save(PictrueLibrary startChart, HttpServletRequest request) {
        JSONObject urlJson = new JSONObject();
        Map<String, String> result =upload(request);
        if (startChart != null && startChart.getId() > 0) {
            PictrueLibrary chart = pictrueLibraryService.get(startChart.getId());
            if (chart != null && StringUtils.isNotBlank(chart.getUrl())) {
                urlJson = JSONObject.parseObject(chart.getUrl());
            }
        }
        for(String key : result.keySet()) {
            if (StringUtils.equals(key, "chartOne")) {
                urlJson.put(KEY_540, result.get(key));
            }
            if (StringUtils.equals(key, "chartTwo")) {
                urlJson.put(KEY_720, result.get(key));
            }
            if (StringUtils.equals(key, "chartThree")) {
                urlJson.put(KEY_1080, result.get(key));
            }
            if (StringUtils.equals(key, "chartFour")) {
                urlJson.put(KEY_640, result.get(key));
            }
            if (StringUtils.equals(key, "chartFive")) {
                urlJson.put(KEY_750, result.get(key));
            }
        }
        if (urlJson.size() == 5) {
            startChart.setUrl(urlJson.toJSONString());
        }
        pictrueLibraryService.savePictrueLibrary(startChart);
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/chart/list";
    }
    @RequestMapping(value="/web/image/detail/{id:\\d+}",method=RequestMethod.GET)
    public String detailweb(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation",DETAIL);
        request.setAttribute("photo", pictrueLibraryService.get(id));
        return "image/photogallery/edit";
    }

    @RequestMapping(value="/web/image/edit/{id:\\d+}",method=RequestMethod.GET)
    public String edit(@PathVariable("id")int id, HttpServletRequest request){
        request.setAttribute("operation",EDIT);
        request.setAttribute("photo", pictrueLibraryService.get(id));
        return "image/photogallery/edit";
    }

    @RequestMapping(value="/web/image/save", method=RequestMethod.POST)
    public String savePhotoGallery(PictrueLibrary photoGallery,HttpServletRequest request) {
        if (photoGallery != null) {
            Map<String, String> result =upload(request);
            String url = StringUtils.substring(result.values().toString(), 1, result.values().toString().length() - 1);
            if(url!=null&!"".equals(url)){
                photoGallery.setUrl(url);
            }
            if(photoGallery.getCategory() == PhotoCategoryEnum.LOGIN.value()){
                photoGallery.setName("登录页");
            }else if(photoGallery.getCategory() == PhotoCategoryEnum.VIPPICTURE.value()){
                photoGallery.setName("vip专属");
            }else{
            	photoGallery.setName("导航栏");
            }
            pictrueLibraryService.savePhotoGallery(photoGallery);
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/web/image/list";
    }

    @RequestMapping(value="/web/image/add/{para}",method=RequestMethod.GET)
    public String add(@PathVariable("para")int para, HttpServletRequest request){
        request.setAttribute("ALBUM",PhotoCategoryEnum.ALBUM.value());
        request.setAttribute("LOGIN",PhotoCategoryEnum.LOGIN.value());
        request.setAttribute("NAVIGATION",PhotoCategoryEnum.NAVIGATION.value());
        return "image/photogallery/add";
    }

    @RequestMapping(value="productad/enable/{id:\\d+}/{status:\\d+}", method=RequestMethod.GET)
    @ResponseBody
    public boolean enableProductAd(@PathVariable("id")int id, @PathVariable("status") int status) {
        return pictrueLibraryService.enable(id, status);
    }

    @RequestMapping(value="/productad/edit/{id:\\d+}", method=RequestMethod.GET)
    public String editProductAd(@PathVariable("id")int id, HttpServletRequest request) {
        request.setAttribute("operation",EDIT);
        request.setAttribute("productAd", pictrueLibraryService.get(id));
        return "image/productad/edit";
    }

    @RequestMapping(value="/productad/detail/{id:\\d+}", method=RequestMethod.GET)
    public String detail(@PathVariable("id")int id, HttpServletRequest request) {
        request.setAttribute("operation",DETAIL);
        request.setAttribute("productAd", pictrueLibraryService.get(id));
        return "image/productad/edit";
    }

    @RequestMapping(value="/productad/save", method=RequestMethod.POST)
    public String saveProductAd(PictrueLibrary productAd, HttpServletRequest request) {
        if (productAd != null) {
            productAd.setStatus(0);
            if(StringUtils.isBlank(productAd.getContent())){
                productAd.setContent("");
            }
            if(StringUtils.isBlank(productAd.getUrl())){
                productAd.setUrl("");
            }
            pictrueLibraryService.save(productAd);
        }
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/chart/list";
    }

    @RequestMapping(value="/productad/add",method=RequestMethod.GET)
    public String addProductAd(HttpServletRequest request){
        return "image/productad/add";
    }

    protected LinkedHashMap<String, String> upload(HttpServletRequest request) {
        SimpleDateFormat sdf = new SimpleDateFormat(NUMBER_MONTH_FORMAT);
        LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
        CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
        if(multipartResolver.isMultipart(request)){
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
            Iterator<String> iterator = multiRequest.getFileNames();
            while(iterator.hasNext()){
                MultipartFile file = multiRequest.getFile(iterator.next());
                String originalFilename = file.getOriginalFilename();
                if(file != null && StringUtils.isNotBlank(originalFilename)){
                    try (InputStream stream = file.getInputStream()) {
                        String uuid = UUID.randomUUID().toString();
                        uuid = StringUtils.replace(uuid, MINUS, BLANK);
                        String suffix = StringUtils.substring(originalFilename, StringUtils.lastIndexOf(originalFilename, DOT));
                        String name = file.getName();
                        String fileName = sdf.format(new Date())+SLASH+uuid+suffix;
                        if (suffix.toLowerCase().equals(FILE_SUFFIX_PDF) || suffix.toLowerCase().equals(FILE_SUFFIX_APK) || suffix.toLowerCase().equals(FILE_SUFFIX_IPA) ||suffix.toLowerCase().equals(FILE_SUFFIX_APATCH)) {
                            fileName = sdf.format(new Date())+SLASH+ originalFilename;
                            putOSSObject(fileName, BUCKETNAME_FILE,	stream);
                            result.put(name, ALIYUN_OSS+BUCKETNAME_FILE+SLASH + fileName);
                        } else if(suffix.toLowerCase().equals(FILE_SUFFIX_CSV)){
                            result.put(name, JSON.toJSONString(this.readCsv(file.getInputStream())));
                        }else {
                            putOSSObject(fileName, BUCKETNAME, stream);
                            result.put(name, ALIYUN_OSS+BUCKETNAME+SLASH+fileName);
                        }
                    } catch (IOException e) {
                        LOGGER.error("upload file to oss error: "+e.getMessage());
                    }
                }
            }
        }
        return result;
    }

    protected void putOSSObject(String key, String bucketName, InputStream stream) {
        try {
            OSSUtil.ensureBucket( bucketName);
            OSSUtil.setBucketPublicReadable(bucketName);
            OSSUtil.uploadFile(bucketName, key, stream);
        } catch (OSSException | ClientException | IOException e) {
            LOGGER.error("put oss object to aliyun error: "+e.getMessage());
        }
    }

    protected List<GoodsCouponCode> readCsv(InputStream in){
        List<GoodsCouponCode> codes = new ArrayList<GoodsCouponCode>();
        BufferedReader br=null;
        try {
            InputStreamReader isr = new InputStreamReader(in,GBK);
            br = new BufferedReader(isr);
            String line = "";
            int index = 0;
            int row = 0;
            while ((line = br.readLine()) != null) {
                index ++;
                if(index == 1){
                    continue;
                }
                if(StringUtils.isNotBlank(line)){
                    if(line.length() > 0 && line.length() <= 20){
                        GoodsCouponCode code = new GoodsCouponCode();
                        code.setCode(line);
                        code.setUsed(0);
                        codes.add(code);
                        row ++;
                        if(row > 999){
                            break;
                        }
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.info(e.getMessage());
        }finally{
            if(br!=null){
                try{
                    br.close();
                    br=null;
                }catch(IOException e){
                    LOGGER.info(e.getMessage());
                }
            }
        }
        return codes;
    }
}
