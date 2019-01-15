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
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require Chart.min
//= require twitter/bootstrap
//= require moment
//= require_tree .
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