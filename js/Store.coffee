{EventEmitter} = require 'events'

{unpackFrond}  = require './util.coffee'
WombDispatcher = require './Dispatcher.coffee'


_data = {pass: sessionStorage.womb_pass}
_default = claim: "none", pass: ""

WombStore = _.extend (new EventEmitter).setMaxListeners(50),{
  emitChange: -> @emit 'change'
  addChangeListener: (cb) -> @on 'change', cb
  removeChangeListener: (cb) -> @removeListener "change", cb

  retrieve: (path)-> _data[path] ? _default[path.split("/")[0]]

  gotData: ({path,data})-> _data[path] = data

  confirmClaim: ({ship})->
    for k,v of _data
      if k.indexOf('claim/') isnt -1 and v is "confirm"
        _data[k] = "none"
    _data["claim/"+ship] = "confirm"
  putClaim: ({ship})-> _data["claim/"+ship] = "wait"
  gotClaim: ({ship,own})->
    _data["claim/"+ship] = (if own then "own" else "xeno")

  setPasscode: (pass)->
    _data.pass = pass
    sessionStorage.womb_pass = pass ? ""
}

WombStore.dispatchToken = WombDispatcher.register (action) ->
  [type,arg] = unpackFrond action

  if WombStore[type]
    WombStore[type] arg
    WombStore.emitChange()

module.exports = WombStore
