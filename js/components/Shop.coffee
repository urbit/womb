Actions = require '../Actions.coffee'

Scry = require './Scry.coffee'
Label = require './Label.coffee'
ShipInput = require './ShipInput.coffee'

{ul,li,div,h6,button,span} = React.DOM

recl = React.createClass
rele = React.createElement

ClaimButton = ({who,pass})-> 
  if not who
    return button {disabled:yes}, "Claim (invalid)" # XX CSS
  rele _ClaimButton,
    {spur:"/#{who}", onClick: -> Actions.claimShip pass,who}
  
_ClaimButton = Scry "_claim", ({data,onClick})->
  switch data
    when "own" then Label "Claimed!", "success"
    when "wait" then Label "Claiming..."
    when "xeno" then Label "Taken", "warning"
    when "none"
      button {onClick}, "Claim"

ShopShips = Scry "/shop", ({pass,data})->
  ul {className:"shop"},
    for who in data
      li {className:"option", key:who},
        span {className:"mono"}, "~", who, " "
        rele ClaimButton, {pass,who}

Shop = (type,length)-> recl
  displayName: "Shop-#{type}"
  roll: -> shipSelector: Math.floor(Math.random()*10)
  reroll: -> @setState @roll()
  getInitialState: -> @roll()
  
  onInputShip: (customShip)-> @setState {customShip}
  
  render: ->
    spur = "/#{type}/#{@state.shipSelector}"
    {pass} = @props
    div {},
      h6 {},
        "Avaliable #{type} (random). ",
        button {onClick:@reroll}, "Reroll"
      rele ShopShips, _.extend {}, @props, {spur, pass}
      h6 {}, "Custom"
      div {}, "Specific #{type}: ", 
        rele ShipInput, {length,@onInputShip}
        ClaimButton {pass,who:@state.customShip ? ""}

module.exports = Shop
