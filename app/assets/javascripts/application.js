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
  $("#dropnotice").click(function(){ 
  var board = document.getElementById('dropnotice');

  board.onmousedown = function(e) {

  var coords = getCoords(board);
  var shiftX = e.pageX - coords.left;
  var shiftY = e.pageY - coords.top;

  board.style.position = 'absolute';
  document.body.appendChild(board);
  moveAt(e);

  board.style.zIndex = 1000;

  function moveAt(e) {
    board.style.left = e.pageX - shiftX + 'px';
    board.style.top = e.pageY - shiftY + 'px';
  }

  document.onmousemove = function(e) {
    moveAt(e);
  };

  board.onmouseup = function() {
    document.onmousemove = null;
    board.onmouseup = null;
  };

}

board.ondragstart = function() {
  return false;
};

function getCoords(elem) {
  var box = elem.getBoundingClientRect();
  return {
    top: box.top + pageYOffset,
    left: box.left + pageXOffset
  };
}})
})
//create notice
$(document).on('turbolinks:load', function() {

  $(".sendnotice").click(function(e){
    e.preventDefault();
    var nottitle = document.getElementById("notice_title").value; 
    var nottext = document.getElementById("notice_text").value;
    var containernotice = document.getElementById('noticelist');

    $.ajax({
        url: "/notices",
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "json",
        data: { notice: { text: nottext , title: nottitle}},
        success: function(data) {
          debugger;
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
        $('#notice_title', 'notice_text').each(function(){
          if(!$(this).val() || $(this).val() == ""){
            $(this).css('border-color','red');
            send = false;
            alert('Field is empty!');
            }
        })
    });
  });
});

