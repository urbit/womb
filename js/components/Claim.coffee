clas = require 'classnames'
{shipShape} = require '../util.coffee'

Scry = require './Scry.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{ul,li,div,b,h6,input,button,p,span,pre,code} = React.DOM

Mail = (email)-> code {className:"email"}, email
History = (history)->
  if !history.length
    "purchased directly from Tlon Inc. "
  else
    span {}, "previously owned by ",
      for who, key in history
         span {key}, (Mail who)
      "and Tlon Inc. "
          
_Options = (type)->
  Shop = Scry "/shop/#{type}", ({data})->
    ul {className:"options options-#{type}"},
      for who in data
        li {className:"shop", key:who},
          span {className:"mono"}, who
  recl
    reroll: -> shipSelector: Math.floor(Math.random()*10)
    onClick: -> @setState @reroll()
    getInitialState: -> @reroll()
    render: ->
      div {},
        h6 {},
          "Semi-random avaliable #{type}.",
          button {@onClick}, "Reroll"
        rele Shop, _.extend {}, @props, spur: "/"+@state.shipSelector

Stars   = _Options "stars"
Planets = _Options "planets"
  
Balance = Scry "/balance", ({data:{planets,stars,owner,history}})->
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
        rele Balance, spur: "/"+@state.passcode
