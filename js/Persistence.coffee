module.exports =
  get: (path,cb)->
    urb.bind "/scry/x/womb"+path, {appl:"hood"}, cb
