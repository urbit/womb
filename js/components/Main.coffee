Claim  = require './Claim.coffee'
Ships  = require './Ships.coffee'

rele = React.createElement

NET = true

{div, h3, h4} = React.DOM

module.exports = ->
  div {},
    h3 {className:'first',style:{lineHeight:'1.5rem'}}, "Check your balance"
    rele Claim, {}
    if NET
      div {},
        h4 {}, "Network"
        rele Ships, {}
