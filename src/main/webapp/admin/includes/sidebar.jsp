<%
    String role = (String) session.getAttribute("role");
%>

<div class="sidebar">
    <h2 class="text-gold fw-bold">Admin Panel</h2>
    <a href="admin_dashboard.jsp">Dashboard</a>

    <% if ("admin".equalsIgnoreCase(role)) { %>
        <a href="admin_menu.jsp">Manage Menu</a>
        <a href="admin_users.jsp">Manage Users</a>
        <a href="admin_reservations.jsp">Manage Reservations</a>
        <a href="admin_offers.jsp">Manage Offers</a>
        <a href="admin_feedbacks.jsp">Manage Feedbacks</a>
        <a href="admin_contact.jsp">Manage Inquiries</a>
        <a href="admin_tables.jsp">Manage Tables</a>
        <a href="open_hours.jsp">Open Hours Management</a>

    <% } else if ("manager".equalsIgnoreCase(role)) { %>
        <a href="admin_menu.jsp">Manage Menu</a>
        <a href="admin_reservations.jsp">Manage Reservations</a>
        <a href="admin_offers.jsp">Manage Offers</a>
        <a href="admin_feedbacks.jsp">Manage Feedbacks</a>
        <a href="admin_contact.jsp">Manage Inquiries</a>
        <a href="admin_tables.jsp">Manage Tables</a>

    <% } else if ("staff".equalsIgnoreCase(role)) { %>
        <a href="admin_menu.jsp">Manage Menu</a>
        <a href="admin_tables.jsp">Manage Tables</a>

    <% } else { %>
        <p class="text-danger">Access Denied</p>
    <% } %>
</div>
