package com.amazingfour.crms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by hmaccelerate on 2016/1/4.
 */

@Controller
@RequestMapping("/home")
public class LoginController {

    @RequestMapping("/doLogin.htm")
    public String doLogin(){
        return "/index";
    }
}
