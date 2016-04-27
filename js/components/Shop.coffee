Actions = require '../Actions.coffee'

Scry = require './Scry.coffee'
Label = require './Label.coffee'

{ul,li,div,h6,button,span} = React.DOM

recl = React.createClass
rele = React.createElement

ClaimButton = Scry "_claim", ({data,onClick})->
  switch data
    when "own" then Label "Claimed!", "success"
    when "wait" then Label "Claiming..."
    when "xeno" then Label "Taken", "warning"
    when "none"
      button {onClick}, "Claim"

ShopShips = Scry "/shop", ({data,claimShip})->
  ul {className:"shop"},
    for who in data
      li {className:"option", key:who},
        span {className:"mono"}, "~", who, " "
        rele ClaimButton, {spur:"/#{who}", onClick: (claimShip who)}

Shop = (type)-> recl
  displayName: "Shop-#{type}"
  roll: -> shipSelector: Math.floor(Math.random()*10)
  reroll: -> @setState @roll()
  getInitialState: -> @roll()

  claimShip: (ship)->
    (=> Actions.claimShip @props.pass, ship)
  
  render: ->
    spur = "/#{type}/#{@state.shipSelector}"
    div {},
      h6 {},
        "Avaliable #{type} (random). ",
        button {onClick:@reroll}, "Reroll"
      rele ShopShips, _.extend {}, @props, {spur, @claimShip}

module.exports = Shop
