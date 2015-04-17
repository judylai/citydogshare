$(document).ready(function() {
    $('#calendar').fullCalendar({
        events: '/events.json',
	eventClick: function(event){
	    if (event.url){
		return false;
}	
}
    });
  
});
