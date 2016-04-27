dup = {}
module.exports =
  put: (mark,data,cb)-> urb.send data, {mark,appl:"hood",wall:no}, cb
  get: ({path,fresh},cb)->
    if fresh or !dup[path]
      dup[path] = yes
      urb.bind "/scry/x/womb"+path, {appl:"hood"}, ->
        urb.drop "/scry/x/womb"+path, {appl:"hood"}, -> #handle drop?
        cb.apply this, arguments
