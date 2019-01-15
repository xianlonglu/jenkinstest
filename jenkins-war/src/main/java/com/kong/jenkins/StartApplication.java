package com.kong.jenkins;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

/**
 * <dl>
 * <dd>Description: jenkins war 启动类</dd>
 * <dd>Company: 大诚若谷信息技术有限公司</dd>
 * <dd>@date：2017/7/26 14:07</dd>
 * <dd>@author：Kong</dd>
 * </dl>
 */
@SpringBootApplication
public class StartApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(StartApplication.class);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(StartApplication.class);
    }

}
