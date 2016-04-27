Claim  = require './Claim.coffee'
Ships  = require './Ships.coffee'

rele = React.createElement

{div, h4} = React.DOM

module.exports = ->
  div {},
    h4 {}, "Claims"
    rele Claim, {}
    h4 {}, "Network"
    rele Ships, {}
