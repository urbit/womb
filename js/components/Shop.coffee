Scry = require './Scry.coffee'
ShipInput = require './ShipInput.coffee'
ClaimButton = require './ClaimButton.coffee'

{ul,li,div,h6,button,span} = React.DOM

recl = React.createClass
rele = React.createElement

ShopShips = Scry "/shop/:type/:nth", ({shop})->
  ul {className:"shop"},
    for ship in shop
      li {className:"option", key:ship},
        span {className:"mono"}, "~", ship, " "
        rele ClaimButton, {ship}

Shop = (type,length)-> recl
  displayName: "Shop-#{type}"
  roll: -> shipSelector: Math.floor(Math.random()*10)
  reroll: -> @setState @roll()
  getInitialState: -> @roll()

  onInputShip: (customShip)-> @setState {customShip}

  render: ->
    div {},
      h6 {},
        "Avaliable #{type} (random). ",
        button {onClick:@reroll}, "Reroll"
      rele ShopShips, _.extend {}, @props, {type,nth:@state.shipSelector}
      h6 {}, "Custom"
      div {}, "Specific #{type}: ",
        rele ShipInput, {length,@onInputShip}
        rele ClaimButton, {ship: (@state.customShip ? "")}

module.exports = Shop
