<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Tự động chuyển hướng về Controller /login
    response.sendRedirect(request.getContextPath() + "/login");
%>
