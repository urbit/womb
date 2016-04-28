{EventEmitter} = require 'events'

{unpackFrond}  = require './util.coffee'
WombDispatcher = require './Dispatcher.coffee'


_data = {}
_local = {claim:{}, pass: sessionStorage.womb_pass}
_localDefault = claim: "none", pass:""

WombStore = _.extend (new EventEmitter).setMaxListeners(50),{
  emitChange: -> @emit 'change'
  addChangeListener: (cb) -> @on 'change', cb
  removeChangeListener: (cb) -> @removeListener "change", cb
  
  retrieve: (path)->
    if path[0] isnt "_"
      return _data[path]
    [key,path...] = path[1..].split("/")
    res = switch key
      when "pass" then _local.pass
      else _local[key]?[path.join("/")]
    res ? _localDefault[key]
    
  gotData: ({path,data})-> _data[path] = data
  putClaim: ({ship})-> _local.claim[ship] = "wait"
  gotClaim: ({ship,own})->
    _local.claim[ship] = (if own then "own" else "xeno")
  
  setPasscode: (pass)->
    _local.pass = pass
    sessionStorage.womb_pass = pass
}

WombStore.dispatchToken = WombDispatcher.register (action) ->
  [type,arg] = unpackFrond action
  
  if WombStore[type]
    WombStore[type] arg
    WombStore.emitChange()

module.exports = WombStore
