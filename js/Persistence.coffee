dup = {}
module.exports =
  put: (mark,data,cb)-> urb.send data, {appl:"hood",mark}, cb
  get: (path,cb)->
    unless dup[path]
      dup[path] = yes
      urb.bind "/scry/x/womb"+path, {appl:"hood"}, cb
