# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#calendar').fullCalendar({
    theme: true,
    height: "auto",
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
    }
    });
