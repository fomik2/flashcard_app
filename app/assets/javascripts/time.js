var counter = 0;
var timer = setInterval(function() 
            { $("#timer_value").val(++counter);
              if (counter >= 60) {clearInterval(timer); }
            }, 1000);
