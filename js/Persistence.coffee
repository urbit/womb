dup = {}
module.exports =
  put: (mark,data,cb)-> urb.send data, {mark,appl:"hood",wall:no}, cb
  get: ({path,fresh},cb)->
    unless dup[path] is "pending" or (!fresh and dup[path] is "got")
      dup[path] = "pending"
      urb.bind "/scry/x/womb"+path,
        {appl:"hood"},
        (err, dat)->
          cb err, dat
          urb.drop "/scry/x/womb"+path, {appl:"hood"}, ->
            dup[path] = "got"
        , (err,nice)->
            unless nice?.data?.ok
              dup[path] = "got"
              cb err, nice
