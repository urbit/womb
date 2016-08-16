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
    return button {disabled:yes,className:'claim'}, "Claim (invalid)" # XX CSS
  rele _ClaimButton, {ship, onClick: -> Actions.claimShip pass, ship}

_ClaimButton = FromStore "claim/:ship", ({claim,onClick})->
 switch claim
    when "own" then Label "Claimed!", "success"
    when "wait" then Label "Claiming..."
    when "xeno" then Label "Taken", "warning"
    when "none" then button {onClick}, "Claim"
    else throw new Error "Bad claim type: #{claim}"

module.exports = name "ClaimButton", ClaimButton
