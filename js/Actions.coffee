Dispatcher    = require './Dispatcher.coffee'
Persistence   = require './Persistence.coffee'

module.exports =
  claimShip: (pass,ship)->
    Dispatcher.dispatch putClaim: {pass, ship}
    Persistence.put "womb-claim",
      {aut:pass,her:ship},
      (err,{data,status})->
        gotClaim = {pass,ship,own:yes}
        if status isnt 200
          gotClaim.own = no   # XX other errors
        Dispatcher.dispatch {gotClaim}
      
  getData: (path)->
    Persistence.get path, (err,{status,data})->
      if err?
        throw new Error "Client error"
      if status isnt 200
        throw new Error "Server error"
      Dispatcher.dispatch gotData: {path,data}
