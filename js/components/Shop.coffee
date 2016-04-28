Actions = require '../Actions.coffee'

{FromStore} = Scry = require './Scry.coffee'
Label = require './Label.coffee'
ShipInput = require './ShipInput.coffee'

{ul,li,div,h6,button,span} = React.DOM

recl = React.createClass
rele = React.createElement

ClaimButton = FromStore "pass", ({pass,who})-> 
  if not who
    return button {disabled:yes}, "Claim (invalid)" # XX CSS
  rele _ClaimButton, {pass,who}
  
_ClaimButton = FromStore "claim/:who", ({pass,claim,who})->
 switch claim
    when "own" then Label "Claimed!", "success"
    when "wait" then Label "Claiming..."
    when "xeno" then Label "Taken", "warning"
    when "none"
      onClick = -> Actions.claimShip pass,who
      button {onClick}, "Claim"
    else throw new Error "Bad claim type: #{claim}"

ShopShips = Scry "/shop/:type/:nth", ({shop})->
  ul {className:"shop"},
    for who in shop
      li {className:"option", key:who},
        span {className:"mono"}, "~", who, " "
        rele ClaimButton, {who}

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
        rele ClaimButton, {who: (@state.customShip ? "")}

module.exports = Shop
