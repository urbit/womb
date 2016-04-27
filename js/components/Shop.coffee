Actions = require '../Actions.coffee'

Scry = require './Scry.coffee'

{ul,li,div,h6,button,span} = React.DOM

recl = React.createClass
rele = React.createElement
  
ShopShips = Scry "/shop", ({data,claimShip})->
  ul {className:"shop"},
    for who in data
      li {className:"option", key:who},
        span {className:"mono"}, who, " "
        button {onClick: -> (claimShip who)}, "Claim"

Shop = (type)-> recl
  displayName: "Shop-#{type}"
  roll: -> shipSelector: Math.floor(Math.random()*10)
  reroll: -> @setState @roll()
  getInitialState: -> @roll()

  claimShip: (ship)-> Actions.claimShip {ship,code:@props.pass}
  
  render: ->
    spur = "/#{type}/#{@state.shipSelector}"
    div {},
      h6 {},
        "Avaliable #{type} (random). ",
        button {onClick:@reroll}, "Reroll"
      rele ShopShips, _.extend {}, @props, {spur, @claimShip}

module.exports = Shop
