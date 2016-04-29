Dispatcher    = require './Dispatcher.coffee'
Persistence   = require './Persistence.coffee'

module.exports =
  setPasscode: (pass)-> Dispatcher.dispatch setPasscode: pass
  claimShip: (pass,ship)->
    Dispatcher.dispatch putClaim: {pass, ship}
    Persistence.put "womb-claim",
      {aut:pass,her:ship},
      (err,{data,status})=>
        gotClaim = {pass,ship,own:yes}
        if status isnt 200
          gotClaim.own = no   # XX other errors
        Dispatcher.dispatch {gotClaim}
        @getData "/stats", true
        @getData "/balance/~#{pass}", true
      
  getData: (path,fresh=no)->
    Persistence.get {path,fresh}, (err,{status,data})->
      if err?
        throw new Error "Client error"
      # if status isnt 200
      #   Dispatcher.dispatch gotError: {path,status,data}
      else Dispatcher.dispatch gotData: {path,data}
