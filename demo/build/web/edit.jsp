<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student Record</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .header-box { background: #f4b400; color: #000; padding: 20px; border-radius: 15px 15px 0 0; font-weight: bold; }
        .form-label { font-weight: 600; font-size: 0.85rem; color: #444; }
    </style>
    <script>
        function calculate() {
            let m = [1,2,3,4,5].map(i => parseFloat(document.getElementById('m'+i).value) || 0);
            let total = m.reduce((a, b) => a + b, 0);
            let per = (total / 500) * 100;
            document.getElementById('total').value = total;
            document.getElementById('percentage').value = per.toFixed(2);
            document.getElementById('grade').value = per >= 70 ? 'Dist' : per >= 60 ? 'First' : per >= 50 ? 'Second' : per >= 35 ? 'Pass' : 'Fail';
        }
    </script>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <%
                    String id = request.getParameter("id");
                    try {
                       Class.forName("com.mysql.cj.jdbc.Driver");
                                    String url = "jdbc:mysql://priteshmysql-pp0777814-eb96.d.aivencloud.com:11538/defaultdb?sslmode=require";
                                    Connection con = DriverManager.getConnection(url, "avnadmin", "AVNS_vQrEOt9YK_pRe1hVEfT");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM students1 WHERE id=?");
                        ps.setInt(1, Integer.parseInt(id));
                        ResultSet rs = ps.executeQuery();
                        if(rs.next()) {
                %>
                <div class="header-box text-center">
                    <h4 class="mb-0">Edit Record for: <%= rs.getString("NAME") %></h4>
                </div>
                <div class="card-body p-4">
                    <form action="insert.jsp" method="POST">
                        <input type="hidden" name="id" value="<%= id %>">
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" value="<%= rs.getString("NAME") %>" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Gender</label>
                                <select name="gender" class="form-select">
                                    <option value="Male" <%= "Male".equals(rs.getString("GENDER"))?"selected":"" %>>Male</option>
                                    <option value="Female" <%= "Female".equals(rs.getString("GENDER"))?"selected":"" %>>Female</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Year</label>
                                <select name="year" class="form-select">
                                    <% String currentYear = rs.getString("YEAR"); 
                                       for(int y=2024; y<=2026; y++) { %>
                                        <option value="<%=y%>" <%= String.valueOf(y).equals(currentYear)?"selected":"" %>><%=y%></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Class</label>
                                <select name="class" class="form-select">
                                    <% String currentClass = rs.getString("CLASS"); %>
                                    <option value="M.Sc. IT Sem-1" <%= "M.Sc. IT Sem-1".equals(currentClass)?"selected":"" %>>M.Sc. IT Sem-1</option>
                                    <option value="M.Sc. IT Sem-2" <%= "M.Sc. IT Sem-2".equals(currentClass)?"selected":"" %>>M.Sc. IT Sem-2</option>
                                    <option value="M.Sc. IT Sem-3" <%= "M.Sc. IT Sem-3".equals(currentClass)?"selected":"" %>>M.Sc. IT Sem-3</option>
                                    <option value="M.Sc. IT Sem-4" <%= "M.Sc. IT Sem-4".equals(currentClass)?"selected":"" %>>M.Sc. IT Sem-4</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Core Subject</label>
                                <select name="subject" class="form-select">
                                    <% String currentSub = rs.getString("SUBJECT"); %>
                                    <option value="Java" <%= "Java".equals(currentSub)?"selected":"" %>>Advanced Java</option>
                                    <option value="IoT" <%= "IoT".equals(currentSub)?"selected":"" %>>IoT Systems</option>
                                    <option value="Forensics" <%= "Forensics".equals(currentSub)?"selected":"" %>>Cyber Forensics</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Address</label>
                                <input type="text" name="address" class="form-control" value="<%= rs.getString("ADDRESS") %>">
                            </div>

                            <div class="col-12 mt-4"><h6>Update Marks</h6></div>
                            <div class="col">
                                <label class="form-label">M1</label>
                                <input type="number" name="m1" id="m1" class="form-control" value="<%= rs.getDouble("M1") %>" oninput="calculate()">
                            </div>
                            <div class="col">
                                <label class="form-label">M2</label>
                                <input type="number" name="m2" id="m2" class="form-control" value="<%= rs.getDouble("M2") %>" oninput="calculate()">
                            </div>
                            <div class="col">
                                <label class="form-label">M3</label>
                                <input type="number" name="m3" id="m3" class="form-control" value="<%= rs.getDouble("M3") %>" oninput="calculate()">
                            </div>
                            <div class="col">
                                <label class="form-label">M4</label>
                                <input type="number" name="m4" id="m4" class="form-control" value="<%= rs.getDouble("M4") %>" oninput="calculate()">
                            </div>
                            <div class="col">
                                <label class="form-label">M5</label>
                                <input type="number" name="m5" id="m5" class="form-control" value="<%= rs.getDouble("M5") %>" oninput="calculate()">
                            </div>

                            <div class="col-md-4 mt-3">
                                <label class="form-label text-primary">Total</label>
                                <input type="text" name="total" id="total" class="form-control fw-bold bg-light" value="<%= rs.getDouble("TOTAL") %>" readonly>
                            </div>
                            <div class="col-md-4 mt-3">
                                <label class="form-label text-primary">Percentage</label>
                                <input type="text" name="percentage" id="percentage" class="form-control fw-bold bg-light" value="<%= rs.getDouble("PERCENTAGE") %>" readonly>
                            </div>
                            <div class="col-md-4 mt-3">
                                <label class="form-label text-primary">Grade</label>
                                <input type="text" name="grade" id="grade" class="form-control fw-bold bg-light" value="<%= rs.getString("GRADE") %>" readonly>
                            </div>

                            <div class="col-12 mt-5 d-flex gap-2">
                                <button type="submit" class="btn btn-primary flex-grow-1">Update Student Record</button>
                                <a href="demosql.jsp" class="btn btn-secondary">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
                <% 
                        } con.close(); 
                    } catch(Exception e) { out.println("<div class='alert alert-danger'>" + e.getMessage() + "</div>"); } 
                %>
            </div>
        </div>
    </div>
</div>

</body>
</html>