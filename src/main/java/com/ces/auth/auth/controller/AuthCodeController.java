package com.ces.auth.auth.controller;

import com.ces.auth.auth.dto.AjaxResult;
import com.ces.auth.auth.dto.PhoneNumberResult;
import com.ces.auth.auth.service.AuthCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

/**
 * Created by wxl on 2018/2/26.
 *
 * @author wxl
 */
@RestController
public class AuthCodeController {
    @Autowired
    private AuthCodeService authCodeService;

    @GetMapping(value = "getCode/{phoneNumber}")
    public AjaxResult getCode(@PathVariable String phoneNumber, HttpSession session) {
        //TODO 检查手机号 && 调用短信接口
        PhoneNumberResult getCodeResult = authCodeService.getPhoneNumberCode(phoneNumber);
        AjaxResult result = new AjaxResult();
        if (getCodeResult != null) {
            result.setSuccess(true);
            session.setAttribute("code",getCodeResult.getCode());
            result.setMsg("获取验证码成功");
        } else {
            result.setSuccess(false);
        }

        return result;
    }
}
