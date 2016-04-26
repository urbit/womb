Ships      = require './Ships.coffee'

rele = React.createElement

{div} = React.DOM

module.exports = ->
  div {},
    rele Ships, {}
