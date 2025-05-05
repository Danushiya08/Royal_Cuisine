<div class="row" id="openingHoursContainer"></div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 

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
	
	        	    const hoursContainer = $('#openingHoursContainer');
	        	    hoursContainer.empty();
	
	        	    if (data.length === 0) {
	        	        hoursContainer.append('<div class="col-12">No opening hours data available.</div>');
	        	        return;
	        	    }
	
	        	    data.forEach(function(hour) {
	        	        const openingTime = formatTime(hour.opening_time);
	        	        const closingTime = formatTime(hour.closing_time);
	        	        var timeDisplay = '';
	
	        	        if (hour.is_holiday) {
	        	            timeDisplay = 'Closed';
	        	        } else {
	        	            timeDisplay = openingTime + ' - ' + closingTime;
	        	        }
	
	        	        var dayDiv = '<div class="col-6">' + hour.day_of_week + '</div>';
	        	        var timeDiv = '<div class="col-6">' + timeDisplay + '</div>';
	
	        	        hoursContainer.append(dayDiv + timeDiv);
	        	    });
	        	},
	          error: function(xhr, status, error) {
	              console.error('Error fetching opening hours:', error);
	              $('#openingHoursTable tbody').html('<tr><td colspan="4">Failed to load data</td></tr>');
	          }
	      });
  }
	  </script>