package com.kong.jenkinsjar.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <dl>
 * <dd>Description: 测试项目是否启动成功的接口</dd>
 * <dd>Company: 黑科技</dd>
 * <dd>@date：2017/7/26 14:09</dd>
 * <dd>@author：Kong</dd>
 * </dl>
 */
@RestController
@RequestMapping("")
public class TestRestController {

    @GetMapping
    public String test() {
        return "ok";
    }
}
