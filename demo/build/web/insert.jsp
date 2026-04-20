<%@ page import="java.sql.*" %>

<%


%>
<%    String id = request.getParameter("id");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://priteshmysql-pp0777814-eb96.d.aivencloud.com:11538/defaultdb?sslmode=require";
        Connection conn = DriverManager.getConnection(url, "avnadmin", "AVNS_vQrEOt9YK_pRe1hVEfT");
        /*Statement setupSt = conn.createStatement();
        String createTableSQL = "CREATE TABLE  students1 ("
                + "ID INT AUTO_INCREMENT PRIMARY KEY, "
                + "NAME VARCHAR(100), "
                + "GENDER VARCHAR(20), "
                + "YEAR INT, "
                + "CLASS VARCHAR(50), "
                + "SUBJECT VARCHAR(50), "
                + "ADDRESS VARCHAR(255), "
                + "M1 DOUBLE, M2 DOUBLE, M3 DOUBLE, M4 DOUBLE, M5 DOUBLE, "
                + "TOTAL DOUBLE, "
                + "PERCENTAGE DOUBLE, "
                + "GRADE VARCHAR(20)"
                + ")";
        setupSt.executeUpdate(createTableSQL);*/

        String sql = (id == null || id.isEmpty())
    ? "INSERT INTO students1 (name, gender, address, class, year, subject, m1, m2, m3, m4, m5, total, percentage, grade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    : "UPDATE students1 SET name=?, gender=?, address=?, class=?, year=?, subject=?, m1=?, m2=?, m3=?, m4=?, m5=?, total=?, percentage=?, grade=? WHERE id=?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, request.getParameter("name"));
        ps.setString(2, request.getParameter("gender"));
        ps.setString(3, request.getParameter("address"));
        ps.setString(4, request.getParameter("class"));
        ps.setString(5, request.getParameter("year"));
        ps.setString(6, request.getParameter("subject"));
        ps.setDouble(7, Double.parseDouble(request.getParameter("m1")));
        ps.setDouble(8, Double.parseDouble(request.getParameter("m2")));
        ps.setDouble(9, Double.parseDouble(request.getParameter("m3")));
        ps.setDouble(10, Double.parseDouble(request.getParameter("m4")));
        ps.setDouble(11, Double.parseDouble(request.getParameter("m5")));
        ps.setDouble(12, Double.parseDouble(request.getParameter("total")));
        ps.setDouble(13, Double.parseDouble(request.getParameter("percentage")));
        ps.setString(14, request.getParameter("grade"));
        if (id != null && !id.isEmpty()) {
            ps.setInt(15, Integer.parseInt(id));
        }

        ps.executeUpdate();
        conn.close();
        response.sendRedirect("demosql.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>