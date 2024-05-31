package com.example.jenkinstest.demos.web;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class JenkinsTest {
    @RequestMapping("/test")
    @ResponseBody
    public String test() {
        return "Hello vzzz2";
    }
}
