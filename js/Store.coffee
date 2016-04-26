{EventEmitter} = require 'events'

{unpackFrond}  = require './util.coffee'
WombDispatcher = require './Dispatcher.coffee'


_data = {}

WombStore = _.extend (new EventEmitter),{
  emitChange: -> @emit 'change'
  addChangeListener: (cb) -> @on 'change', cb
  
  retrieve: (path)-> _data[path]
  gotData: ({path,data})-> _data[path] = data
}

WombStore.dispatchToken = WombDispatcher.register (action) ->
  [type,arg] = unpackFrond action
  
  if WombStore[type]
    WombStore[type] arg
    WombStore.emitChange()

module.exports = WombStore
