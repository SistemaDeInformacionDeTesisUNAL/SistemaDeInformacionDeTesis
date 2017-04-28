# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#calendar').fullCalendar({
    theme: true,
    height: "auto",
    selectable: true,
    selectHelper: true,
    editable:true,
    eventLimit: 3,
    header: {
      left: 'title',
      center: 'prevYear,month,agendaWeek,agendaDay,nextYear',
      right:  'today prev,next'
    },
    views: {
        agendaFourDay: {
            type: 'agenda',
            duration: { days: 4 },
            buttonText: '4 day'
        }
    },
    events: '/events.json'
  });
###
   select: function(start_time,end_time){
      $getScript('/events/new',function(){
        $('#event_date_range').val(moment(start_time)).format("MM/DD/YYYY HH:mm")+
        date_range_picker();
        $('.start_hidden').val(moment(start_time).format('YYYY-MM-DD HH:mm'));
        $('.end_hidden').val(moment(end_time).format('YYYY-MM-DD HH:mm'));
        });
        calendar.fullCalendar('unselect');
    }
###
