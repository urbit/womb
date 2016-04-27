dup = {}
module.exports =
  get: (path,cb)->
    unless dup[path]
      dup[path] = yes
      urb.bind "/scry/x/womb"+path, {appl:"hood"}, cb
