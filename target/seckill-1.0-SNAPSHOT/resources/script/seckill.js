var seckill = {
    URL: {
        now: function () {
            return '/seckill/time/now';
        },
        exposer: function (seckillId) {
            return '/seckill/' + seckillId + '/exposer';
        },
        execution: function (seckillId, md5) {
            return '/seckill/' + seckillId + '/' + md5 + '/execution';
        }
    },
    validatePhone: function (phone) {
        if (phone && phone.length === 11 && !isNaN(phone)) {
            return true;
        } else {
            return false;
        }
    },
    handleSeckillKill: function (seckillId, node) {
        node.hide().html('<input id="killBtn" type="button" value="秒杀" />');
        $.post(seckill.URL.exposer(seckillId), {}, function (result) {
            if (result && result.success) {
                var exposer = result.data;
                if (exposer.exposed) {
                    var md5 = exposer.md5;
                    var killUrl = seckill.URL.execution(seckillId, md5);
                    console.log(killUrl);
                    $("#killBtn").one('click',function () {
                        $.post(killUrl,{},function(result){
                            if (result && result.success) {
                                var killResult = result.data;
                                var state = killResult.state;
                                var stateInfo = killResult.stateInfo;
                                node.html(stateInfo)
                            }
                        });
                    });
                    node.show();
                } else {
                    var now = exposer.now;
                    var start = exposer.start;
                    var end = exposer.end;
                    seckill.countDown(seckillId, now, start, end);
                }
            } else {
                console.error(result)
            }
        })
    },
    countDown: function (seckillId, nowTime, startTime, endTime) {
        var seckillBox = $("#seckill-box");
        var siv = null;
        if (nowTime > endTime) {
            seckillBox.html('秒杀结束');
        } else if (nowTime >= startTime) {
            //获取秒杀地址
            seckill.handleSeckillKill(seckillId, seckillBox);
        } else {
            siv = window.setInterval(function () {
                seckillBox.html(nowTime += 1000);
                if (nowTime > startTime) {
                    //获取秒杀地址
                    window.clearInterval(siv);
                    seckill.handleSeckillKill(seckillId, seckillBox);
                }
            }, 1000)
        }
    },
    detail: {
        init: function (params) {
            //在cookie中查找手机号
            var killPhone = $.cookie('killPhone');
            if (!seckill.validatePhone(killPhone)) {
                //绑定手机号
                $("#killPhoneModal").show();
                $("#killPhoneBtn").click(function () {
                    var inputPhone = $("#killPhoneKey").val();
                    if (seckill.validatePhone(inputPhone)) {
                        //写入cookie
                        $.cookie('killPhone', inputPhone, {
                            expires: 7,
                            path: '/seckill'
                        });
                        window.location.reload();
                    } else {
                        $("#killPhoneMessage").hide().html('手机号错误！').show(300);
                    }
                });
            }
            var startTime = params['startTime'];
            var endTime = params['endTime'];
            var seckillId = params['seckillId'];
            $.get(seckill.URL.now(), {}, function (result) {
                if (result && result.success) {
                    var timeNow = result.data;
                    seckill.countDown(seckillId, timeNow, startTime, endTime);
                } else {
                    console.log(result);
                }
            })
        }
    }
};