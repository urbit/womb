Claim  = require './Claim.coffee'
Ships  = require './Ships.coffee'

Recycling = require './Recycling.coffee'

rele = React.createElement

NET = true

{div,h3,h4,a} = React.DOM

module.exports = ->
  div {},
    h3 {className:'first-a'}, "Claim an invite"
    rele Claim, {}

    if NET
      div {},
        h4 {}, "Network"
        rele Ships, {}

    div {className:'footer'},
      "Questions?  Email us:"
      (a {href:"mailto:urbit@urbit.org"}, "urbit@urbit.org")
      "."
