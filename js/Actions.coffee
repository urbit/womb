Dispatcher    = require './Dispatcher.coffee'
Persistence   = require './Persistence.coffee'

module.exports =
  getData: (path)->
    Persistence.get path, (err,{data})->
      if err?
        throw new "Server error"
      Dispatcher.dispatch gotData: {path,data}
