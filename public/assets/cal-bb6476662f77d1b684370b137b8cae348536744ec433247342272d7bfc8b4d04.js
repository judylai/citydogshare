$(document).ready(function() {
    $('#calendar').fullCalendar({
        events: 
	{
	    url: '/events.json'
         
	},
	eventClick: function(event){
	    window.location.replace("/dogs/1");
	}
	
    });
  
});
