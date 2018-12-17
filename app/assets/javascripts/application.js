// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require Chart.min
//= require twitter/bootstrap
//= require_tree .


//hide selectors
$(document).on('turbolinks:load', function() {
   $("#task_duration").on('change', function() {
    var selectorDuration = document.getElementById('task_duration').value
    if(selectorDuration == "year") {
      document.getElementById('task_year').style.display = 'inline-block';
      document.getElementById('date_end').style.display = 'none';
      document.getElementById('date_field').style.display = 'none';
    } else {
      document.getElementById('task_year').style.display = 'none';
    }
    if(selectorDuration == "month") {
      document.getElementById('date_month').style.display = 'inline-block';
      document.getElementById('task_year').style.display = 'inline-block';
      document.getElementById('date_end').style.display = 'none';
      document.getElementById('date_field').style.display = 'none';
    } else {
      document.getElementById('date_month').style.display = 'none';
    }
    if(selectorDuration == "week") {
      document.getElementById('task_week').style.display = 'inline-block';
      document.getElementById('date_month').style.display = 'inline-block';
      document.getElementById('task_year').style.display = 'inline-block';
      document.getElementById('date_end').style.display = 'none';
      document.getElementById('date_field').style.display = 'none';
    } else {
      document.getElementById('task_week').style.display = 'none';
    }
    if(selectorDuration == "day") {
      document.getElementById('date_field').style.display = 'block';
      document.getElementById('date_end').style.display = 'block';
    }
  })
});
//get value selectors
$(document).on('turbolinks:load', function() {
  $("#sendFormTask").on('click', function() {
    var selectorDuration = document.getElementById('task_duration').value
    if(selectorDuration == "year") {
      var taskYear = new Date(document.getElementById('task_year').value, 11, 31);
      function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
    
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
    
        return [year, month, day].join('-');
    }
      var formatYear = formatDate(taskYear)
      document.getElementById('date_end').value = formatYear;
    }
    if(selectorDuration == "month") {
      var taskMonth = new Date(document.getElementById('task_year').value, document.getElementById('date_month').value, 0);
      function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
    
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
      var formatMonth = formatDate(taskMonth)
      document.getElementById('date_end').value = formatMonth;
    }
    if(selectorDuration == "week") {
      var taskWeek = new Date("Jan 01, " + document.getElementById('task_year').value + " 01:00:00");
      var week = taskWeek.getTime() + 604800000 * (document.getElementById('task_week').value - 1);
      var lastDayWeekTask = new Date(week + 518400000)
      function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
    
        return [year, month, day].join('-');
    }
      var formatWeek = formatDate(lastDayWeekTask)
      document.getElementById('date_end').value = formatWeek;
    }
 })
});
//create task
$(document).on('turbolinks:load', function() {

  $(".sendtask").click(function(){  
    debugger;
    var task = document.getElementById("task").value; 
    var current_day = $(this).parents('.task-container');
    var container = document.getElementById('tasklist');
    var idDay = $(current_day).attr('data-day_id');
    var date_end = document.getElementById("date_end").value;
    var type_task = document.getElementById("task_duration").value
    $.ajax({
        url: "/days/:day_id/tasks".replace(":day_id", idDay),
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "json",
        data: { task: { list: task, date_end: date_end, duration: type_task} },
        success: function(data) {
          addNewTask(data, container);           
        },
        error:  
          notValidTask()
    });
  });
});

function addNewTask(task, tasksListDiv) {
  $('#task').css('border-color','seagreen');
  $('#date_end').css('border-color','seagreen');
  var link = document.createElement('a');
  link.className = "glyphicon glyphicon-trash"
  link.setAttribute ("data-method", "delete");
  link.href = ("/days/:day_id/tasks/".replace(":day_id", task.day_id) + task.id);
  link.setAttribute("data-remote", "true");
  
  var paragraph = document.createElement('p')
  paragraph.innerText = task.list;
  paragraph.style.fontWeight = "bold";
  paragraph.style.display = "inline-block";
  
  var onetask = document.createElement('div')
  onetask.className = "onetask";
  onetask.className = "bluetask";
  onetask.style.borderRadius = "5px";
  onetask.style.marginTop = "2px";
  onetask.style.paddingLeft = "6px";
 
  onetask.appendChild(paragraph);
  onetask.appendChild(link);

  tasksListDiv.appendChild(onetask);

  $('#task').val('');

}
function notValidTask() {
  $('#task').each(function(){
    if(!$(this).val() || $(this).val() === ""){
      $(this).css('border-color','red');
      send = false;
      }
    })
    $('#date_end').each(function(){
      if(!$(this).val() || $(this).val() === ""){
        $(this).css('border-color','red');
        send = false;
        }
      }) 
  }
//drag and drop  
$(document).on('turbolinks:load', function() {
  document.onmousedown = function(e) {

    var dragElement = e.target;  
    if (!dragElement.classList.contains('draggable')) return;  
    var shiftX, shiftY;
    startDrag(e.clientX, e.clientY);
    document.onmousemove = function(e) {
      moveAt(e.clientX, e.clientY);
    };
    dragElement.onmouseup = function() {
      finishDrag();
    };
    function startDrag(clientX, clientY) {
      shiftX = clientX - dragElement.getBoundingClientRect().left;
      shiftY = clientY - dragElement.getBoundingClientRect().top;
      dragElement.style.position = 'fixed';
      document.body.appendChild(dragElement);
      moveAt(clientX, clientY);
    };
  
    function finishDrag() {
      dragElement.style.top = parseInt(dragElement.style.top) + pageYOffset + 'px';
      dragElement.style.position = 'absolute';
      document.onmousemove = null;
      dragElement.onmouseup = null;
    }
  
    function moveAt(clientX, clientY) {
      var newX = clientX - shiftX;
      var newY = clientY - shiftY;
      var newBottom = newY + dragElement.offsetHeight;
      if (newBottom > document.documentElement.clientHeight) {
        var docBottom = document.documentElement.getBoundingClientRect().bottom;
        var scrollY = Math.min(docBottom - newBottom, 10);
        if (scrollY < 0) scrollY = 0;
        window.scrollBy(0, scrollY);
        newY = Math.min(newY, document.documentElement.clientHeight - dragElement.offsetHeight);
      }
  
      if (newY < 0) {
        var scrollY = Math.min(-newY, 10);
        if (scrollY < 0) scrollY = 0;
        window.scrollBy(0, -scrollY);
        newY = Math.max(newY, 0);
      }

      if (newX < 0) newX = 0;
      if (newX > document.documentElement.clientWidth - dragElement.offsetWidth) {
        newX = document.documentElement.clientWidth - dragElement.offsetWidth;
      }
  
      dragElement.style.left = newX + 'px';
      dragElement.style.top = newY + 'px';
    }
    return false;
  }})

//vicible form task
$(document).on('turbolinks:load', function() {
$("#taskButton").click(function(e){
  e.preventDefault();
  $("#taskform").show();
  $("#taskButton").toggle();
});
});
$(document).on('turbolinks:load', function() {
  $("#hideform").click(function(){
    $("#taskform").hide();
    $("#taskButton").show();
    
  });
  });
  $(document).on('turbolinks:load', function() {
    var ctx = document.getElementById("myChart").getContext('2d');
    var success = document.getElementById("success").innerText;
    var notsuccess = document.getElementById("notsuccess").innerText;
    var notset = document.getElementById("notset").innerText;
    var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ["Not Success", "Success", "Not set"],
            datasets: [{
                data: [notsuccess, success, notset],
                backgroundColor: [
                    'rgb(212, 63, 58)',
                    'rgb(76, 174, 76)',
                    'rgba(135, 204, 250)'
    
                ],
                borderColor: [
                    'rgb(150, 57, 57)',
                    'rgb(57, 150, 59)',
                    'rgb(57, 113, 150)'
                ],
                borderWidth: 2
            }]
        },
        options: {
          title: {
            display: true,
            text: 'Success of the year',
            fontSize: 20
          }
        }
    })
  });
