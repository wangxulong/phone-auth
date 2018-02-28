package com.ces.auth.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Created by wxl on 2018/2/26.
 *
 * @author wxl
 */
@Controller
public class LoginController {

    @GetMapping(value = "index")
    public String index() {
        return "index";
    }

    @GetMapping(value = "login")
    public String login(){
        return "login";
    }

    @PostMapping(value = "login")
    @ResponseBody
    public String doLogin(String phoneNumber, String code, HttpSession session){
        Object sessionCode = session.getAttribute("code");
        if(null != sessionCode && ((String)sessionCode).equals(code)){
            //验证码相等
            /**
             * 1.清除session中的code
             */
            session.removeAttribute("code");
            return "登录成功";
        }

        //TODO 其他验证逻辑


        return "登录失败";
    }
}
