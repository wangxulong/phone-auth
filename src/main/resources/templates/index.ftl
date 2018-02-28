<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <#assign base = request.contextPath />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<#include "./base/header.ftl"/>

<div class="container">
    <form class="form-horizontal" method="post" action="${base}/login">
        <div class="form-group">
            <label class="col-sm-2 control-label">手机号</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="手机号">
            </div>
        </div>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">验证码</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="code" name="code" placeholder="验证码">
            </div>
            <div class="col-sm-4" id="codeArea">
                <button type="button" id="getCode" class="btn btn-primary">点击获取验证码</button>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-success">登录</button>
            </div>
        </div>
    </form>
</div>
<#include "./base/footer.ftl"/>
<script>
    $(function () {
        $('#codeArea').on('click','#getCode', function () {
            /**
             * 1.获取手机号
             * 2.验证手机号
             * 3.发送请求
             */
            var phoneNumber = $('#phoneNumber').val();
            var isPhoneNumber = checkPhoneNumber(phoneNumber);
            if (isPhoneNumber) {
                //切换样式
                showWaitPhoneNumber();
                //发送请求
                getPhoneNumberCode();
            } else {
                alert('请输入正确的手机号');
            }

        });
    });

    /**
     * 验证手机号
     * @param phoneNumber
     * @returns {boolean}
     */
    function checkPhoneNumber(phoneNumber) {
        if (!phoneNumber) {
            return false;
        }
        var phoneNumberReg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (!phoneNumberReg.test(phoneNumber)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 切换样式为等待重发
     */
    function showWaitPhoneNumber() {
        var $getCode = $("#codeArea [id='getCode']");
        if ($getCode.length == 1) {
            //wait code
            var inter = 3;
            var waitCodeHtml = ' <button type="button" id="waitCode" class="btn btn-default">' + inter + '秒后重发</button>';
            $("#codeArea").html(waitCodeHtml);
            var showWaitPhoneNumberInter = setInterval(function () {
                inter--;
                if (inter < 0) {
                    clearInterval(showWaitPhoneNumberInter);
                    showGetPhoneNumber();
                    return;
                }
                $("#codeArea").html(' <button type="button" id="waitCode" class="btn btn-default">' + inter + '秒后重发</button>');
            }, 1000);

        }
    }

    /**
     * 恢复获取短信验证码样式
     */
    function showGetPhoneNumber() {
        $("#codeArea").html(' <button type="button" id="getCode" class="btn btn-primary">点击获取验证码</button>');
    }

    /**
     * 获取手机验证码
     */
    function getPhoneNumberCode(){
        var phoneNumber = $('#phoneNumber').val();
        $.get('${base}/getCode/'+phoneNumber,function (data) {
            if(data && data.success){
                //发送成功
                alert(data.msg);
            }else{
                alert("发送失败");
            }
        },"JSON");
    }
</script>
</body>
</html>