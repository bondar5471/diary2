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
		const task = document.getElementById("task").value; 
		const current_day = $(this).parents('.task-container');
		const container = document.getElementById('tasklist');
		const idDay = $(current_day).attr('data-day_id');
		const date_end = document.getElementById("date_end").value;
		const type_task = document.getElementById("task_duration").value;
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
  function addNewTask(task, tasksListDiv) {
      $('#task').css('border-color','seagreen');
			$('#date_end').css('border-color','seagreen');
      let spanTrash = document.createElement("SPAN");
			spanTrash.className = "glyphicon glyphicon-trash";
			spanTrash.onclick = function() {  
				var current_day = $(this).parents('.task-container');
				var idDay = $(current_day).attr('data-day_id');
				var current_task = $(this).parents('.onetask');
				var idTask =  $(current_task).attr('data-task-id');
				if(confirm("Deleted ?")) {
					$.ajax({
						url: "/days/:day_id/tasks/".replace(":day_id", idDay)+(idTask),
						type: 'POST',
						beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
						data: {_method: 'DELETE'},
						success: function(result) {
							$(current_task).fadeOut(200);
							console.log(result);
						}
					});
				};
			};

      let paragraph = document.createElement('p')
      paragraph.innerText = task.list;
      paragraph.style.fontWeight = "bold";
      paragraph.style.display = "inline-block";
      
			let onetask = document.createElement('div');
			onetask.setAttribute("data-task-id", task.id);
			onetask.className = "onetask greentask";
      onetask.style.borderRadius = "5px";
      onetask.style.marginTop = "2px";
			onetask.style.paddingLeft = "6px";
			onetask.style.height = "20px";
			onetask.style.marginTop = "10px";
			
			let selectorDuration = document.getElementById('task_duration').value;
			let tasksOnDay = document.getElementById('tasksOnDay');
			let tasksOnWeek = document.getElementById('tasksOnWeek');
			let tasksOnMonth = document.getElementById('tasksOnMonth');
			let tasksOnYear = document.getElementById('tasksOnYear');

      onetask.appendChild(paragraph);
			onetask.appendChild(spanTrash);

			if(selectorDuration == "day") 
			{
				tasksOnDay.appendChild(onetask)
				tasksOnDay.style.maxHeight = "none";
				tasksOnDay.style.height = "auto";		
			}
			if(selectorDuration == "week") 
			{
				tasksOnWeek.appendChild(onetask)	
				tasksOnWeek.style.maxHeight = "none";
				tasksOnWeek.style.height = "auto";		
			}
			if(selectorDuration == "month") 
			{
				tasksOnMonth.appendChild(onetask)
				tasksOnMonth.style.maxHeight = "none";
				tasksOnMonth.style.height = "auto";			
			}
			if(selectorDuration == "year") 
			{ 
				tasksOnYear.appendChild(onetask)
				tasksOnYear.style.maxHeight = "none";
				tasksOnYear.style.height = "auto";		
			}
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
		//delete task 
		$(".glyphicon-trash").click(function() {  
			var current_day = $(this).parents('.task-container');
			var idDay = $(current_day).attr('data-day_id');
			var current_task = $(this).parents('.onetask');
			var idTask =  $(current_task).attr('data-task-id');
			if(confirm("Deleted ?")) {
				$.ajax({
					url: "/days/:day_id/tasks/".replace(":day_id", idDay)+(idTask),
					type: 'POST',
					beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
					data: {_method: 'DELETE'},
					success: function(result) {
						$(current_task).fadeOut(200);
						console.log(result);
					}
				});
			};
		});
	//accordion			
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
				document.getElementById('paragraphDateTask').style.display = 'none';
		} else {
				document.getElementById('task_year').style.display = 'none';
		}
		if(selectorDuration == "month") {
				document.getElementById('date_month').style.display = 'inline-block';
				document.getElementById('task_year').style.display = 'inline-block';
				document.getElementById('date_end').style.display = 'none';
				document.getElementById('date_field').style.display = 'none';
				document.getElementById('paragraphDateTask').style.display = 'none';
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
