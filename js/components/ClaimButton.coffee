Actions = require '../Actions.coffee'

{FromStore} = require './Scry.coffee'
Label = require './Label.coffee'
ShipInput = require './ShipInput.coffee'

{button} = React.DOM

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

ClaimButton = FromStore "pass", ({pass,ship})->
  if not ship
    return button {disabled:yes,className:'claim invalid'}, "Invalid" # XX CSS
  rele _ClaimButton, {pass,ship}

_ClaimButton = FromStore "claim/:ship", ({claim,pass,ship})->
 switch claim
    when "own" then Label "Claimed!", "success"
    when "wait" then Label "Claiming..."
    when "xeno" then Label "Not available", "warning"
    when "none" then button {onClick:->
        Actions.confirmShip pass, ship
      }, "Claim"
    when "confirm" then button {onClick: ->
        Actions.claimShip pass, ship
      }, "Click again to confirm."
    else throw new Error "Bad claim type: #{claim}"

module.exports = name "ClaimButton", ClaimButton
