Dispatcher    = require './Dispatcher.coffee'
Persistence   = require './Persistence.coffee'

module.exports =
  claimShip: ({code,ship})->
    Persistence.put "womb-claim", {code,ship}, (err,{data})->
      gotClaim = {ship,own:yes}
      if err?
        gotClaim.own = no   # XX other errors
      Dispatcher.dispatch {gotClaim}
      
  getData: (path)->
    Persistence.get path, (err,{data})->
      if err?
        throw new Error "Server error"
      Dispatcher.dispatch gotData: {path,data}
