Claim  = require './Claim.coffee'
Ships  = require './Ships.coffee'

rele = React.createElement

NET = false

{div, h4} = React.DOM

module.exports = ->
  div {},
    h4 {}, "Claims"
    rele Claim, {}
    if NET
      div {},
        h4 {}, "Network"
        rele Ships, {}
