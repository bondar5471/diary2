// $(document).on('turbolinks:load', function() {
//     var ctx = document.getElementById("myChart").getContext('2d');
//     var success = document.getElementById("success").innerText;
//     var notsuccess = document.getElementById("notsuccess").innerText;
//     var notset = document.getElementById("notset").innerText;
//     var myChart = new Chart(ctx, {
//         type: 'doughnut',
//         data: {
//             labels: ["Not Success", "Success", "Not set"],
//             datasets: [{
//                 data: [notsuccess, success, notset],
//                 backgroundColor: [
//                     'rgb(212, 63, 58)',
//                     'rgb(76, 174, 76)',
//                     'rgba(135, 204, 250)'
    
//                 ],
//                 borderColor: [
//                     'rgb(150, 57, 57)',
//                     'rgb(57, 150, 59)',
//                     'rgb(57, 113, 150)'
//                 ],
//                 borderWidth: 2
//             }]
//         },
//         options: {
//           title: {
//             display: true,
//             text: 'Success of the year',
//             fontSize: 20
//           }
//         }
//     })

// //clock
//   function update() {
//   var clock = document.getElementById('clock');
//   clock.innerHTML = moment().format('MMMM D YYYY, HH:mm:ss');
//   }
//   setInterval(update, 1000);
// });
