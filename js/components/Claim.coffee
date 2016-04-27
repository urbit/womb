clas = require 'classnames'
{shipShape} = require '../util.coffee'

Scry = require './Scry.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{div,h6,input,p,span,pre,code} = React.DOM

Mail = (email)-> code {className:"email"}, email
History = (history)->
  if !history.length
    "purchased directly from Tlon Inc. "
  else
    span {}, "previously owned by ",
      for who, key in history
         span {key}, (Mail who)
      "and Tlon Inc. "

Balance = Scry "/balance", ({data:{planets,stars,owner,history}})->
    div {},
      h6 {}, "Balance"
      p {}, "Hello ", (Mail owner)
      p {},
        "This balance was "
        History history
        "It contains "
        (planets or "no"), " Planets "
        "and ", (stars or "no"), " Stars."
      p {className:"red inverse block error"}, "Stub: issuing"

module.exports = recl
  displayName: "Claim"
  getInitialState: -> passcode: "~waclev-nornex-bornec-fitfed--librys-tapsut-docrus-fittel"
  onChange: ({target})->
    pass = target.value.trim()
    if pass[0] isnt '~'
      pass = "~" + pass
    @setState passcode:
      if (shipShape pass) and pass.length is 57
        pass
    
  render: ->
    div {},
      p {}, "Input a passcode to claim ships: "
      input {@onChange,defaultValue:""}
      if @state.passcode
        rele Balance, subPath: "/"+@state.passcode
