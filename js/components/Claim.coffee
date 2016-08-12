clas = require 'classnames'

Actions = require '../Actions.coffee'

{FromStore} = Scry = require './Scry.coffee'

Label = require './Label.coffee'
InfoBox = require './InfoBox.coffee'

Shop = require './Shop.coffee'
PassInput = require './PassInput.coffee'
Recycling = require './Recycling.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{div,b,h3,h6,p,span,code} = React.DOM

SHOP = true # enable ship shop

unless SHOP
  Shop = (type,length)->
    ({})-> h6 {}, "Distribution of ",type," not yet live."

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

Balance = Scry "/balance/:pass", ({balance})->
    if balance.fail
      return div {style:{marginTop:'1rem'}}, Label "Invalid passcode", "warning"
    {planets,stars,owner,history} = balance
    div {},
      h3 {}, "Balance"
      p {}, "Hello ", (Mail owner), ", "
      p {},
        "This balance was "
        History history
      p {},
        "You currently hold "
        (b {}, planets or "no"), " Planets "
        "and ", (b {}, stars or "no"), " Stars."
      if stars then rele Stars
      if planets then rele Planets

module.exports = name "Claim", FromStore "pass", ({pass})->
  div {},
      p {}, "To view your ships, input your passcode."
      PassInput {minLength:32,defaultValue:pass,onInputPass:Actions.setPasscode}
      if pass then rele Balance, {pass}
      else
        p {},
          h3 {}, "Convert an old ticket"
          rele Recycling, {}
