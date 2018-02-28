package com.ces.auth.auth.service;

import com.ces.auth.auth.dto.PhoneNumberResult;
import org.springframework.stereotype.Service;

/**
 * Created by wxl on 2018/2/26.
 *
 * @author wxl
 */
@Service
public class AuthCodeService {

    /**
     * 根据手机号发送验证码
     *
     * @param phoneNumber
     * @return
     */
    public PhoneNumberResult getPhoneNumberCode(String phoneNumber) {
        //TODO 调用短信平台接口
        PhoneNumberResult result = new PhoneNumberResult();
        result.setCode("123");
        return result;
    }
}
