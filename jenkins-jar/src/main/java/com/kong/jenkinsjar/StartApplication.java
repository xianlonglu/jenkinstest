package com.kong.jenkinsjar;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

/**
 * <dl>
 * <dd>Description: 项目启动类</dd>
 * <dd>Company: 黑科技</dd>
 * <dd>@date：2017/7/27 14:48</dd>
 * <dd>@author：Kong</dd>
 * </dl>
 */
@SpringBootApplication
public class StartApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {

        SpringApplication.run(StartApplication.class);

    }

    public SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(StartApplication.class);
    }
}
