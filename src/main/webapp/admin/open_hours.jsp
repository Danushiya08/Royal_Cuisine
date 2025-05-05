<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Open Hours - Royal Cuisine</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../css/styles.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
  <style>
    .sidebar {
      height: 100%;
      width: 250px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: #000;
      color: white;
      padding-top: 20px;
      padding-left: 20px;
    }

    .sidebar a {
      color: white;
      text-decoration: none;
      display: block;
      padding: 10px 20px;
      margin-bottom: 10px;
      border-radius: 5px;
    }

    .sidebar a:hover {
      background-color: #f1c40f;
    }

    .content {
      margin-left: 250px;
      padding: 20px;
    }

    .topbar {
      background-color: #000;
      color: white;
      padding: 10px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .topbar .user-icon {
      cursor: pointer;
    }
  </style>
</head>
<body class="bg-black text-white">
<jsp:include page="includes/sidebar.jsp" />

  <div class="topbar">
    <div class="topbar-left">
      <h4>Royal Cuisine Admin</h4>
    </div>
    <div class="topbar-right">
      <div class="dropdown">
        <a href="admin_message.jsp" class="btn text-white user-icon">
          <i class="bi bi-chat"></i> 
        </a>

        <a href="admin_profile.jsp" class="btn text-white user-icon">
          <i class="bi bi-person"></i> 
        </a>
        <ul class="dropdown-menu" aria-labelledby="userDropdown">
          <li><a class="dropdown-item" href="#">Email: <%= session.getAttribute("email") %></a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item" href="../login.jsp">Logout</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  <div class="content">

<h3>Restaurant Opening Hours</h3>
<table id="openingHoursTable" class="table table-dark table-striped">
  <thead>
    <tr>
      <th>Day</th>
      <th>Opening Time</th>
      <th>Closing Time</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>

  </tbody>
</table>



    <h3 class="mt-4">Update Opening Hours</h3>
    <form id="updateHoursForm" class="p-4 border rounded shadow-sm bg-dark" style="width: 100%; margin: auto;">
     <div class="d-flex gap-4">
     <div class="mb-3 w-100">
        <label for="dayOfWeek" class="form-label">Day of the Week</label>
        <select id="dayOfWeek" class="form-select">
            <option value="Monday">Monday</option>
            <option value="Tuesday">Tuesday</option>
            <option value="Wednesday">Wednesday</option>
            <option value="Thursday">Thursday</option>
            <option value="Friday">Friday</option>
            <option value="Saturday">Saturday</option>
            <option value="Sunday">Sunday</option>
        </select>
    </div>

    <div class="mb-3 w-100">
        <label for="openingTime" class="form-label">Opening Time</label>
        <input type="time" id="openingTime" class="form-control" required>
    </div>

    <div class="mb-3 w-100">
        <label for="closingTime" class="form-label">Closing Time</label>
        <input type="time" id="closingTime" class="form-control" required>
    </div>
    </div>
    

    <div class="form-check mb-3">
        <input type="checkbox" id="isHoliday" class="form-check-input">
        <label class="form-check-label" for="isHoliday">Closed (Holiday)</label>
    </div>

    <button type="submit" class="btn btn-gold w-100">Update Hours</button>
</form>

    <script>
 
        $(document).ready(function() {
            fetchOpeningHours();

            $("#updateHoursForm").submit(function(e) {
                e.preventDefault();
                updateOpeningHours();
            });
        });



        function formatTime(timeString) {
  
            const timeParts = timeString.split(':');
            
            return timeParts[0] + ':' + timeParts[1];
        }

        function fetchOpeningHours() {
            $.ajax({
                url: '/royal_cuisine/opening-hours-servlet',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log(data); 

                    const tableBody = $('#openingHoursTable tbody');
                    tableBody.empty(); 

                    if (data.length === 0) {
                        tableBody.append('<tr><td colspan="4">No opening hours data available.</td></tr>');
                        return;
                    }

     
                    data.forEach(function(hour) {
                        const openingTime = formatTime(hour.opening_time);
                        const closingTime = formatTime(hour.closing_time); 
                        const row = '<tr>' +
                            '<td>' + hour.day_of_week + '</td>' +
                            '<td>' + openingTime + '</td>' +
                            '<td>' + closingTime + '</td>' +
                            '<td>' + (hour.is_holiday ? 'Closed' : 'Open') + '</td>' +
                            '</tr>';
                        tableBody.append(row);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching opening hours:', error);
                    $('#openingHoursTable tbody').html('<tr><td colspan="4">Failed to load data</td></tr>');
                }
            });
        }



        function updateOpeningHours() {
            const dayOfWeek = $('#dayOfWeek').val();
            const openingTime = $('#openingTime').val();
            const closingTime = $('#closingTime').val();
            const isHoliday = $('#isHoliday').prop('checked');

            $.ajax({
                url: '/royal_cuisine/opening-hours-servlet', 
                type: 'POST',
                data: {
                    day_of_week: dayOfWeek,
                    opening_time: openingTime,
                    closing_time: closingTime,
                    is_holiday: isHoliday
                },
                success: function(response) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Updated',
                        text: response
                    });

     
                    fetchOpeningHours();
                },
                error: function(xhr, status, error) {
                    console.error('Error updating opening hours:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update opening hours'
                    });
                }
            });
        }
    </script>
</div>
</body>
</html>