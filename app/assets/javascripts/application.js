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



//create task
$(document).on('turbolinks:load', function() {

  $(".sendtask").click(function(){  
    var task = document.getElementById("task").value; 
    var current_day = $(this).parents('.task-container');
    var container = document.getElementById('tasklist');
    var idDay = $(current_day).attr('data-day_id');
    var date_begin = document.getElementById("date_begin").value;
    var date_end = document.getElementById("date_end").value;
    var type_task = document.getElementById("task_duration").value
    $.ajax({
        url: "/days/:day_id/tasks".replace(":day_id", idDay),
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "json",
        data: { task: { list: task, date_begin: date_begin, date_end: date_end, duration: type_task} },
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
  $('#date_begin').css('border-color','seagreen');
  $('#date_end').css('border-color','seagreen');
  var link = document.createElement('a');
  link.className = "glyphicon glyphicon-trash"
  link.setAttribute ("data-method", "delete");
  link.href = ("/days/:day_id/tasks/".replace(":day_id", task.day_id) + task.id);
  link.setAttribute("data-remote", "true");
  
  var checkbox = document.createElement("input")
  checkbox.type="checkbox";
  checkbox.className = "check";
  checkbox.style.display = "inline-block";

  var paragraph = document.createElement('p')
  paragraph.innerText = task.list;
  paragraph.style.fontWeight = "bold";
  paragraph.style.display = "inline-block";
  
  var onetask = document.createElement('div')
  onetask.className = "onetask";
  onetask.className = "bluetask";
  onetask.style.borderRadius = "5px";
  onetask.style.marginTop = "4px";
 
  onetask.appendChild(checkbox);
  onetask.appendChild(paragraph);
  onetask.appendChild(link);

  tasksListDiv.appendChild(onetask);

  $('#task').val('');
  $('#date_begin').val('');
  $('#date_end').val('');
}
function notValidTask() {
  $('#task').each(function(){
    if(!$(this).val() || $(this).val() === ""){
      $(this).css('border-color','red');
      send = false;
      }
    })
    $('#date_begin').each(function(){
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
      $('#date_end').each(function(){
        if($('#date_begin').val() > $(this).val()){
          $('#date_end').css('border-color','red');
          send = false;
          alert("End date less than start date")
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
//create notice
$(document).on('turbolinks:load', function() {
  $("#sendnotice").click(function(e){
    e.preventDefault();
    var nottitle = document.getElementById("notice_title").value; 
    var nottext = document.getElementById("notice_text").value;
    var containernotice = document.getElementById('noticelist');

    $.ajax({
        url: "/notices",
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "json",
        data: { notice: { title: nottitle, text: nottext}},
        success: function(data) {
          $('#notice_text').css('border-color','seagreen');
          $('#notice_title').css('border-color','seagreen');
          var noticetitle = document.createElement('p');
          noticetitle.innerText = data.title;

          var noticetext = document.createElement('p');
          noticetext.innerText = data.text;

          var link = document.createElement('a');
          link.innerHTML = "Destroy";
          link.href = ("/notices/:id".replace(":id", data.id));
          link.setAttribute ("data-method", "delete");
          link.setAttribute("data-remote", "true");

          containernotice.appendChild(noticetitle);
          containernotice.appendChild(noticetext);
          containernotice.appendChild(link);
          $('#notice_title').val('');
          $('#notice_text').val('');
                    
        },
        error: 
        $('#notice_title').each(function(){
          if(!$('#notice_title').val() === "" || $('#notice_text').val() === ""){
            $(this).css('border-color','red');
            $('#notice_text').css('border-color','red');
            send = false;
            }
        })
    });
  });
});
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

// window.onload = function(){ 
//   $(document).on('turbolinks:load', function() {
//     document.getElementById('container_report').onclick = function(event) {
//       var span, input, text;
//    
//       var containerReport = document.getElementById('container_report');
//       event = event || window.event;
//       span = event.target || event.srcElement;
//       if (span && span.tagName.toUpperCase() === "SPAN") {
//           span.style.display = "none";
//           text = span.innerHTML;
//           input = document.createElement("input");
//           input.type = "text";
//           input.value = text;
//           input.name = "day[report]";
//           input.size = Math.max(text.length + text.length*0.5);
//           span.parentNode.insertBefore(input, span);

//           var btnedit  = document.createElement("BUTTON"); 
//           btnedit.innerHTML = "Save";
//           btnedit.type = "submit";
//           btnedit.className = "btn btn-success";
//           btnedit.name = "commit";
//           btnedit.setAttribute ("data-disable-with", "Edit")


//           containerReport.appendChild(btnedit);
//           input.focus();
//           input.onblur = function() {
//               span.parentNode.removeChild(input);
//               span.innerHTML = input.value === "" ? "&nbsp;" : input.value;
//               span.style.display = "";
          

//         };
//       }
//   };
// });
// };