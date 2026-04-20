<%@ page import="java.sql.*" %>
<%
    String singleId = request.getParameter("id");
    String[] multiIds = request.getParameterValues("deleteIds");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
                                    String url = "jdbc:mysql://priteshmysql-pp0777814-eb96.d.aivencloud.com:11538/defaultdb?sslmode=require";
                                    Connection con = DriverManager.getConnection(url, "avnadmin", "AVNS_vQrEOt9YK_pRe1hVEfT");
        PreparedStatement ps = con.prepareStatement("DELETE FROM students1 WHERE id=?");
        
        if(singleId != null) {
            ps.setInt(1, Integer.parseInt(singleId));
            ps.executeUpdate();
        } else if(multiIds != null) {
            for(String s : multiIds) {
                ps.setInt(1, Integer.parseInt(s));
                ps.executeUpdate();
            }
        }
        con.close();
        response.sendRedirect("demosql.jsp");
    } catch(Exception e) { out.println(e); }
%>