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


//create task
$(document).on('turbolinks:load', function() {

  $(".sendtask").click(function(){  
    var task = document.getElementById("task").value; 
    var current_day = $(this).parents('.task-container');
    var container = document.getElementById('tasklist');
    var idDay = $(current_day).attr('data-day_id');

    $.ajax({
        url: "/days/:day_id/tasks".replace(":day_id", idDay),
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "json",
        data: ({ task: { list: task } }),
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
  var link = document.createElement('a');
  link.innerHTML = "delete task";
  link.setAttribute ("data-method", "delete");
  link.href = ("/days/:day_id/tasks/".replace(":day_id", task.day_id) + task.id);
  link.setAttribute("data-remote", "true");

  var paragraph = document.createElement('p')
  paragraph.innerText = task.list;

  tasksListDiv.appendChild(paragraph);
  tasksListDiv.appendChild(link);
  $('#task').val('');
}
function notValidTask () {
  $('#task').each(function(){
    if(!$(this).val() || $(this).val() == ""){
      $(this).css('border-color','red');
      send = false;
      alert('Task field is empty!');
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
      // конец переноса, перейти от fixed к absolute-координатам
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
          debugger;
          if(!$('#notice_title').val() == "" || $('#notice_text').val() == ""){
            $(this).css('border-color','red');
            $('#notice_text').css('border-color','red');
            send = false;
            }
        })
    });
  });
});
//click p on input text
$(document).on('turbolinks:load', function() {
  document.getElementById('container_report').onclick = function(event) {
      var span, input, text;
      var containerReport = document.getElementById('container_report');
      event = event || window.event;
      span = event.target || event.srcElement;
      if (span && span.tagName.toUpperCase() === "SPAN") {
        debugger;
          span.style.display = "none";
          text = span.innerHTML;
          input = document.createElement("input");
          input.type = "text";
          input.value = text;
          input.name = "day[report]";
          input.size = Math.max(text.length + text.length*0.5);
          span.parentNode.insertBefore(input, span);

          var btnedit  = document.createElement("BUTTON"); 
          btnedit.innerHTML = "Save";
          btnedit.type = "submit";
          btnedit.className = "btn btn-success";
          btnedit.name = "commit";
          btnedit.setAttribute ("data-disable-with", "Edit")


          containerReport.appendChild(btnedit);
          input.focus();
          input.onblur = function() {
              span.parentNode.removeChild(input);
              span.innerHTML = input.value == "" ? "&nbsp;" : input.value;
              span.style.display = "";
          

          };
      }
  };
});
//drop doard trello
$(document).on('turbolinks:load', function() {
function dragStart(event) {
  debugger;
	event.dataTransfer.setData("Text", event.target.id);
};

function dragEnter(event) {
	event.preventDefault();
	if (event.target.className == "taskColumn") {
		event.target.style.border = "1px dotted rgb(255,0,0)";
	} else if (event.target.className == "taskDiv") {
		event.target.style.backgroundColor = "grey";
	}
};

function dragLeave(event) {
	event.preventDefault();
	event.target.style.border = "";
	event.target.style.backgroundColor = "";
};

function dragOver(event) {
	event.preventDefault();
};

function swapTasks(node1, node2) {
	node1.parentNode.replaceChild(node1, node2);
	node1.parentNode.insertBefore(node2, node1);
}

function drop(event) {
	event.preventDefault();
	if (event.target.className == "taskColumn") {
		var data = event.dataTransfer.getData("Text");
		event.target.appendChild(document.getElementById(data));

		event.target.style.border = "";
	} else if (event.target.className == "taskDiv") {
		var data = event.dataTransfer.getData("Text");
		swapTasks(document.getElementById(data), document.getElementById(event.target.id));
		var curDateTime = new Date();
		console.log("Task: " + data + " " + curDateTime.getHours() + ":" + curDateTime.getMinutes() + ":" + curDateTime.getSeconds());
		event.target.style.border = "";
		event.target.style.backgroundColor = "";
	} else {
		console.log('Not a drop target');
	}
};

var taskDivs = document.querySelectorAll('.taskDiv');
[].forEach.call(taskDivs, function(divs) {
	divs.addEventListener('dragstart', dragStart, false);
});

var targetDivs = document.querySelectorAll('.taskColumn');
[].forEach.call(targetDivs, function(columns) {
	columns.addEventListener('dragenter', dragEnter, false);
	columns.addEventListener('dragleave', dragLeave, false);
	columns.addEventListener('dragover', dragOver, false);
	columns.addEventListener('drop', drop, false);
})
});