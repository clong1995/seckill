<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/4
  Time: 1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<html>
<head>
    <title>秒杀列表页</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<table>
    <thead>
    <tr>
        <th>名称</th>
        <th>库存</th>
        <th>开始</th>
        <th>结束</th>
        <th>创建</th>
        <th>详情</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="sk" items="${list}">
        <tr>
            <td>${sk.name}</td>
            <td>${sk.number}</td>
            <td><fmt:formatDate value="${sk.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${sk.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${sk.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><a href="/seckill/${sk.seckillId}/detail">link</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
