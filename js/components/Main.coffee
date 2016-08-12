Claim  = require './Claim.coffee'
Ships  = require './Ships.coffee'

rele = React.createElement

NET = false

{div, h3, h4} = React.DOM

module.exports = ->
  div {},
    h3 {className:'first-a'}, "Claim an invite"
    rele Claim, {}
    if NET
      div {},
        h4 {}, "Network"
        rele Ships, {}
