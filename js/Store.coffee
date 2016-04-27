{EventEmitter} = require 'events'

{unpackFrond}  = require './util.coffee'
WombDispatcher = require './Dispatcher.coffee'


_data = {}
_local = {claim:{}}
_localDefault = claim: "none"

WombStore = _.extend (new EventEmitter),{
  emitChange: -> @emit 'change'
  addChangeListener: (cb) -> @on 'change', cb
  removeChangeListener: (cb) -> @removeListener "change", cb
  
  retrieve: (path)->
    if path[0] isnt "_"
      return _data[path]
    [key,path...] = path[1..].split("/")
    _local[key]?[path.join("/")] ? _localDefault[key]
    
  gotData: ({path,data})-> _data[path] = data
  putClaim: ({ship})-> _local.claim[ship] = "wait"
  gotClaim: ({ship,own})->
    _local.claim[ship] = (if own then "own" else "xeno")
}

WombStore.dispatchToken = WombDispatcher.register (action) ->
  [type,arg] = unpackFrond action
  
  if WombStore[type]
    WombStore[type] arg
    WombStore.emitChange()

module.exports = WombStore
