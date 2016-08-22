Scry = require './Scry.coffee'
ShipInput = require './ShipInput.coffee'
ClaimButton = require './ClaimButton.coffee'

{ul,li,div,h6,button,span,code} = React.DOM

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
      h6 {}, "Available #{type} — "
      rele ShopShips, _.extend {}, @props, {type,nth:@state.shipSelector}
      button {onClick:@reroll,className:'reroll'}, "Get a new set"
      h6 {}, "Custom #{type} — "
      div {},
        div {style:{marginBottom:".3rem"}},
          "If you understand how to pick a "
          (code {}, "@p")
          " for #{type}, feel free:",
        div {style:{marginBottom:"1rem"}},
          rele ShipInput, {length,@onInputShip}
          rele ClaimButton, {ship: (@state.customShip ? "")}

module.exports = Shop
