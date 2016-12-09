<html>
    <head>
        % include('anxiety/views/partials/headers.tpl')
    </head>
    <body>
      <div class="container">
        <h4>The stuff I'm looking forward to</h4>
        <ul id="countdowns">
        </ul>
      </div>
      % include('anxiety/views/partials/footer.tpl')

      <script type="text/javascript">

      function addCountdowns(countdowns) {
          var currentCountdowns = document.getElementById('countdowns');

          for (var i = 0; i < countdowns.length; i++) {
            var li = document.getElementById('li');

            li.value = countdowns[i]['id'];
            li.innerHTML = countdowns[i]['name'] + ' - ' + countdowns['end_date'];
            currentCountdowns.appendChild(li);
          }
      }

      function getCountdowns() {
        var countdownTable = document.getElementById('countdowns');

        var countdowns,
            request = new XMLHttpRequest();

        request.open('GET', '/api/countdowns', true);

        request.onload = function() {
          if (request.status >= 200 && request.status < 400) {
            countdowns = JSON.parse(request.responseText);
          } else {
            countdowns = [];
          }

          addCountdowns(countdowns);
        }
      }

      request.send();
      </script>
  </body>
</html>
