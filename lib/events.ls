@Events = 
  wait: (time, callback) ->
    set-timeout callback, time
