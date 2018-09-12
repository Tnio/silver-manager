package com.silverfox.finance;

import javax.servlet.MultipartConfigElement;

import com.silverfox.finance.service.*;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.silverfox.finance.config.AplicationResourceProperties;
import com.silverfox.finance.service.impl.ActivityServiceImpl;
import com.silverfox.finance.service.impl.BonusServiceImpl;
import com.silverfox.finance.service.impl.ChannelServiceImpl;
import com.silverfox.finance.service.impl.ClientServiceImpl;
import com.silverfox.finance.service.impl.CouponServiceImpl;
import com.silverfox.finance.service.impl.LotteryServiceImpl;
import com.silverfox.finance.service.impl.MessageServiceImpl;
import com.silverfox.finance.service.impl.OrderServiceImpl;
import com.silverfox.finance.service.impl.PayBankServiceImpl;
import com.silverfox.finance.service.impl.PictrueLibraryServiceImpl;
import com.silverfox.finance.service.impl.PostmarketingServiceImpl;
import com.silverfox.finance.service.impl.ProductServiceImpl;
import com.silverfox.finance.service.impl.SilverServiceImpl;
import com.silverfox.finance.service.impl.SystemServiceImpl;
import com.silverfox.finance.service.impl.TradeServiceImpl;
import com.silverfox.finance.util.OSSUtil;

@SpringBootApplication
@EnableScheduling
@EnableConfigurationProperties({AplicationResourceProperties.class})
@MapperScan("com.silverfox.finance.orm")
public class Application extends SpringBootServletInitializer implements CommandLineRunner {
	@Autowired
	protected AplicationResourceProperties properties;
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(Application.class);
    }
	
	@Bean
	public SystemService systemService() {
		return new SystemServiceImpl();
	}
	
	@Bean
	public OrderService orderService() {
		return new OrderServiceImpl();
	}
	
	@Bean
	public CouponService couponService() {
		return new CouponServiceImpl();
	}

	@Bean
	public PostmarketingService postmarketingService(){
		return new PostmarketingServiceImpl();
	}
	
	@Bean
	public PictrueLibraryService pictrueLibraryService() {
		return new PictrueLibraryServiceImpl();
	}
	
	@Bean
	public MessageService messageService(){
		return new MessageServiceImpl();
	}

	@Bean
	public BonusService bonusService() {
		return new BonusServiceImpl();
	}

	@Bean
	public LotteryService lotteryService() {
		return new LotteryServiceImpl();
	}

	@Bean
	public ActivityService activityService() {
		return new ActivityServiceImpl();
	}

	@Bean
	public SilverService silverService() {
		return new SilverServiceImpl();
	}

	@Bean
	public ChannelService channelService() {
		return new ChannelServiceImpl();
	}

	@Bean
	public PayBankService payBankService() {
		return new PayBankServiceImpl();
	}

	@Bean
	public ProductService productService() {
		return new ProductServiceImpl();
	}

	@Bean
	public TradeService tradeService() {
		return new TradeServiceImpl();
	}

	@Bean
	public ClientService clientService() {
		return new ClientServiceImpl();
	}

	@Bean
	public FreeMarkerConfigurer FreeMarkerConfigurer(){
		return new FreeMarkerConfigurer();
	}

	@Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize(Integer.parseInt(properties.getMultipartMaxFileSize()));
        factory.setMaxRequestSize(Integer.parseInt(properties.getMultipartMaxRequestSize()));
        return factory.createMultipartConfig();
    }
    
	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new  ReloadableResourceBundleMessageSource();
	    messageSource.setBasename("classpath:messages");
	    messageSource.setCacheSeconds(0);
	    messageSource.setDefaultEncoding("utf-8");
	    return messageSource;
	}
	
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		OSSUtil.init(this.properties.getOssPath());
	}
}
