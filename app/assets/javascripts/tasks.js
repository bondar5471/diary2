$(document).on('turbolinks:load', function() {
  $("#taskButton").click(function(e){
		e.preventDefault();
		$("#taskform").show();
		$("#taskButton").toggle();
  })
  $("#hideform").click(function(){
      $("#taskform").hide();
      $("#taskButton").show();	
  })
  //create task
  $(".sendtask").click(function(){  
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
  })
  })
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
	var accordion = document.getElementsByClassName("accordion");
	var counter;
	
	for (counter = 0; counter < accordion.length; counter++) {
		accordion[counter].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;
			if (panel.style.maxHeight){
				panel.style.maxHeight = null;
			} else {
				panel.style.maxHeight = panel.scrollHeight + "px";
			} 
		});
	}

	//selectors task
	
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
				document.getElementById('date_end').style.display = 'none';
				document.getElementById('date_field').style.display = 'none';
		} else {
				document.getElementById('task_week').style.display = 'none';
		}
		if(selectorDuration == "day") {
				document.getElementById('date_field').style.display = 'block';
				document.getElementById('date_end').style.display = 'block';
				document.getElementById('paragraphDateTask').style.display = 'none';
		}
	})
	$("#sendFormTask").on('click', function() {
		var selectorDuration = document.getElementById('task_duration').value
		if(selectorDuration == "year") {
				debugger;
				var taskYear = new Date(document.getElementById('task_year').value, 11, 31);
				document.getElementById('date_end').value =  moment(taskYear).format('YYYY-M-D');
		}
		if(selectorDuration == "month") {
				var taskMonth = new Date(document.getElementById('task_year').value, document.getElementById('date_month').value, 0);
				document.getElementById('date_end').value = moment(taskMonth).format('YYYY-M-D');
		}
		if(selectorDuration == "week") {
				//calculate last day
				var taskWeek = new Date("Jan 01, " + document.getElementById('task_year').value + " 01:00:00");
				var week = taskWeek.getTime() + 604800000 * (document.getElementById('task_week').value - 1);
				var lastDayWeekTask = new Date(week + 518400000);
				document.getElementById('date_end').value = moment(lastDayWeekTask).format('YYYY-M-D');
			}  
	}),
	$("#task_week").on('change', function() {
		var taskWeek = new Date("Jan 01, " + document.getElementById('task_year').value + " 01:00:00");
		var week = taskWeek.getTime() + 604800000 * (document.getElementById('task_week').value - 1);
		var lastDayWeekTask = new Date(week + 518400000);
		var dateDayWeekTask = document.getElementById('paragraphDateTask');
		dateDayWeekTask.style.display = "block";
		dateDayWeekTask.innerText = moment(lastDayWeekTask).format('MMMM D YYYY');
	})	
});