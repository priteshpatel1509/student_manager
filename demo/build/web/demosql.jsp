<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Analytics Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .navbar {
                background-color: #1a73e8;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            /* 1. This ensures the table container allows horizontal scrolling on mobile */
            .table-responsive {
                border-radius: 12px;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            /* 2. Forces columns to stay in a single line to trigger the scrollbar */
            .text-nowrap {
                white-space: nowrap !important;
            }

            .form-label {
                font-weight: 600;
                font-size: 0.9rem;
                color: #555;
            }
            .btn-save {
                background-color: #28a745;
                color: white;
                transition: 0.3s;
                border: none;
                padding: 10px 25px;
                border-radius: 8px;
            }
            .btn-save:hover {
                background-color: #218838;
                transform: translateY(-1px);
            }

            /* Custom Scrollbar for a better UI */
            .table-responsive::-webkit-scrollbar {
                height: 6px;
            }
            .table-responsive::-webkit-scrollbar-thumb {
                background: #cbd5e0;
                border-radius: 10px;
            }
        </style>
        <script>
            function calculate() {
                let m = [1, 2, 3, 4, 5].map(i => parseFloat(document.getElementById('m' + i).value) || 0);
                let total = m.reduce((a, b) => a + b, 0);
                let per = (total / 500) * 100;
                document.getElementById('total').value = total;
                document.getElementById('percentage').value = per.toFixed(2);
                document.getElementById('grade').value = per >= 70 ? 'Dist' : per >= 60 ? 'First' : per >= 50 ? 'Second' : per >= 35 ? 'Pass' : 'Fail';
            }
        </script>
    </head>
    <body>

        <nav class="navbar navbar-dark mb-4">
            <div class="container">
                <span class="navbar-brand mb-0 h1">🎓 Student Portal</span>
            </div>
        </nav>

        <div class="container">
            <div class="card p-4 mb-4">
                <h5 class="mb-3 text-primary">Add New Student Record</h5>
                <form action="insert.jsp" method="POST">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-control" placeholder="Pritesh Patel" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Year</label>
                            <select name="year" class="form-select">
                                <% for (int y = 2024; y <= 2026; y++) {%>
                                <option value="<%=y%>"><%=y%></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Class</label>
                            <select name="class" class="form-select">
                                <option value="M.Sc. IT Sem-1">M.Sc. IT Sem-1</option>
                                <option value="M.Sc. IT Sem-2">M.Sc. IT Sem-2</option>
                                <option value="M.Sc. IT Sem-3">M.Sc. IT Sem-3</option>
                                <option value="M.Sc. IT Sem-4">M.Sc. IT Sem-4</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Core Subject</label>
                            <select name="subject" class="form-select">
                                <option value="Java">Advanced Java</option>
                                <option value="IoT">IoT Systems</option>
                                <option value="Forensics">Cyber Forensics</option>
                                <option value="Networking">Networking</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control">
                        </div>

                        <div class="col-12 mt-4"><h6>Subject Marks</h6></div>
                        <div class="d-flex gap-2">
                            <% for (int i = 1; i <= 5; i++) {%>
                            <input type="number" name="m<%=i%>" id="m<%=i%>" class="form-control" placeholder="M<%=i%>" oninput="calculate()">
                            <% } %>
                        </div>

                        <div class="col-md-4 mt-3">
                            <label class="form-label">Total</label>
                            <input type="text" name="total" id="total" class="form-control bg-light" readonly>
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">Percentage (%)</label>
                            <input type="text" name="percentage" id="percentage" class="form-control bg-light" readonly>
                        </div>
                        <div class="col-md-4 mt-3">
                            <label class="form-label">Grade</label>
                            <input type="text" name="grade" id="grade" class="form-control bg-light" readonly>
                        </div>

                        <div class="col-12 text-end mt-4">
                            <button type="submit" class="btn btn-save">Save Student Record</button>
                        </div>
                    </div>
                </form>
            </div>

            <form action="delete.jsp" method="POST">
                <div class="d-flex justify-content-between align-items-center mb-3 px-1">
                    <h5 class="text-secondary">Student Directory</h5>
                    <button type="submit" class="btn btn-outline-danger btn-sm">Delete Selected</button>
                </div>

                <div class="table-responsive bg-white border shadow-sm">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr class="text-nowrap">
                                <th><input type="checkbox" onclick="let cbs = document.getElementsByName('deleteIds'); for (let i = 0; i < cbs.length; i++)
                                    cbs[i].checked = this.checked;"></th>
                                <th>ID</th><th>Name</th><th>Class</th><th>Subject</th><th>Marks</th><th>Total</th><th>%</th><th>Grade</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    String url = "jdbc:mysql://priteshmysql-pp0777814-eb96.d.aivencloud.com:11538/defaultdb?sslmode=require";
                                    Connection con = DriverManager.getConnection(url, "avnadmin", "AVNS_vQrEOt9YK_pRe1hVEfT");
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery("SELECT * FROM students1 ORDER BY ID DESC");
                                    while (rs.next()) {
                            %>
                            <tr class="text-nowrap">
                                <td><input type="checkbox" name="deleteIds" value="<%= rs.getInt("ID")%>"></td>
                                <td><%= rs.getInt("ID")%></td>
                                <td class="fw-bold"><%= rs.getString("NAME")%></td>
                                <td><span class="badge bg-info text-dark"><%= rs.getString("CLASS")%></span></td>
                                <td><%= rs.getString("SUBJECT")%></td>
                                <td class="small text-muted"><%= (int) rs.getDouble("M1")%>, <%= (int) rs.getDouble("M2")%>, <%= (int) rs.getDouble("M3")%>, <%= (int) rs.getDouble("M4")%>, <%= (int) rs.getDouble("M5")%></td>
                                <td class="text-primary fw-bold"><%= rs.getDouble("TOTAL")%></td>
                                <td><%= rs.getDouble("PERCENTAGE")%>%</td>
                                <td><span class="badge bg-success"><%= rs.getString("GRADE")%></span></td>
                                <td>
                                    <a href="edit.jsp?id=<%= rs.getInt("ID")%>" class="btn btn-sm btn-warning">Edit</a>
                                </td>
                            </tr>
                            <% }
                                    con.close();
                                } catch (Exception e) {
                                    // Proper error message within the table
                                    out.println("<tr><td colspan='10' class='text-center text-danger p-4'>Error: " + e.getMessage() + "</td></tr>");
                        }%>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </body>
</html>