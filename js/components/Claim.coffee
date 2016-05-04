clas = require 'classnames'

Actions = require '../Actions.coffee'

{FromStore} = Scry = require './Scry.coffee'

Label = require './Label.coffee'
InfoBox = require './InfoBox.coffee'

Shop = require './Shop.coffee'
ShipInput = require './ShipInput.coffee'
Recycling = require './Recycling.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{div,b,h6,p,span,code} = React.DOM

Mail = (email)-> code {className:"email"}, email
History = (history)->
  if !history.length
    "purchased directly from Tlon Inc. "
  else
    span {}, "previously owned by ",
      for who, key in history
         span {key}, (Mail who)
      "and Tlon Inc. "

Stars   = Shop "stars", 7
Planets = Shop "planets", 14
  
Balance = Scry "/balance/~:pass", ({balance})->
    if balance.fail
      return div {}, Label "Invalid passcode", "warning"
    {planets,stars,owner,history} = balance
    div {},
      h6 {}, "Balance"
      p {}, "Hello ", (Mail owner)
      p {},
        "This balance was "
        History history
        "It contains "
        (b {}, planets or "no"), " Planets "
        "and ", (b {}, stars or "no"), " Stars."
      if stars then rele Stars
      if planets then rele Planets

module.exports = name "Claim", FromStore "pass", ({pass})->
  div {},
      p {}, "Input a passcode to claim ships: "
      ShipInput {length:28,defaultValue:pass,onInputShip:Actions.setPasscode}
      if pass then rele Balance, {pass}
      else 
        rele InfoBox, {}, "What if I have an old ticket?",
          "Old tickets can be converted to a balance:",
          rele Recycling, {}
