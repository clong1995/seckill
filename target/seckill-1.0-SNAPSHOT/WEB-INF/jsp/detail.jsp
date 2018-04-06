<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<html>
<head>
    <title>详情页</title>
    <%@include file="common/head.jsp"%>
</head>
<body>
<h1>${seckill.name}</h1>
<div id="killPhoneModal" style="display: none">
输入手机号:<input id="killPhoneKey" type="text"/>
    <input id="killPhoneBtn" type="button" value="提交"/>
    <div id="killPhoneMessage"></div>
</div>
<div id="seckill-box"></div>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script src="https://cdn.bootcss.com/jquery.countdown/2.2.0/jquery.countdown.min.js"></script>
<script src="/resources/script/seckill.js" type="text/javascript"></script>
<script type="text/javascript">
    seckill.detail.init({
        seckillId:${seckill.seckillId},
        startTime:${seckill.startTime.time},
        endTime:${seckill.endTime.time}
    })
</script>
</body>
</html>
