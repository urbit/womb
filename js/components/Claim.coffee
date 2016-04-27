clas = require 'classnames'
{shipShape} = require '../util.coffee'

Scry = require './Scry.coffee'
Shop = require './Shop.coffee'

recl = React.createClass
rele = React.createElement

{div,b,h6,input,p,span,code} = React.DOM

Mail = (email)-> code {className:"email"}, email
History = (history)->
  if !history.length
    "purchased directly from Tlon Inc. "
  else
    span {}, "previously owned by ",
      for who, key in history
         span {key}, (Mail who)
      "and Tlon Inc. "

Stars   = Shop "stars"
Planets = Shop "planets"
  
Balance = Scry "/balance", ({pass,data:{planets,stars,owner,history}})->
    div {},
      h6 {}, "Balance"
      p {}, "Hello ", (Mail owner)
      p {},
        "This balance was "
        History history
        "It contains "
        (b {}, planets or "no"), " Planets "
        "and ", (b {}, stars or "no"), " Stars."
      if stars then rele Stars, {pass}
      if planets then rele Planets, {pass}

module.exports = recl
  displayName: "Claim"
  getInitialState: -> passcode: (localStorage.womb_claim ? "")
      
  setPasscode: (passcode)->
    localStorage.womb_claim = passcode ? ""
    @setState {passcode}
  
  onChange: ({target})->
    pass = target.value.trim()
    if pass[0] isnt '~'
      pass = "~" + pass
    @setPasscode (
      if (shipShape pass) and pass.length is 57
        pass.slice(1)
    )
    
  render: ->
    div {},
      p {}, "Input a passcode to claim ships: "
      input {@onChange,defaultValue:@state.passcode}
      if @state.passcode
        rele Balance, {pass:@state.passcode,spur: "/~"+@state.passcode}
