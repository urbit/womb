Actions = require '../Actions.coffee'

Scry = require './Scry.coffee'
Label = require './Label.coffee'
ShipInput = require './ShipInput.coffee'
MailInput = require './MailInput.coffee'

{a,div,span,button} = React.DOM

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

RecycleButton = name "RecycleButton", ({disabled,onClick})->
  unless disabled
    button {onClick}, "Exchange"
  else
    button {disabled}, "Exchange (email required)" # XX CSS

RecycleTicket = name "RecycleTicket",
  Scry "/ticket/~:ship/~:tick", ({ship,tick,mail,ticket:{passcode,status}})->
    doRecycle = -> Actions.recycleTicket {ship,tick,mail}, passcode
    div {className:'recycleTicket'},
      switch status ? "fail"
        when "fail" then Label "Bad ticket", "warning"
        when "good" then rele RecycleButton, {disabled:!mail,onClick:doRecycle}
        when "used"
          span {},
            a {onClick: -> Actions.setPasscode passcode}, passcode
            Label "Ticket exchanged", "info"
        else throw new Error "Bad ticket status: #{status}"

Recycling = recl
  getInitialState: -> {ship:"",tick:"",mail:""}
  render: ->
    getShip = rele ShipInput, {placeholder:'some-ship', length:14, oldFormat:yes, onInputShip: (ship) => @setState {ship}}
    getTick = rele ShipInput, {placeholder:'some-sample-ticket-code', length:28, oldFormat:yes, onInputShip: (tick) => @setState {tick}}
    getMail = rele MailInput, {onInputMail: (mail) => @setState {mail}}
    {ship,tick,mail} = @state
    div {className:"recycling"},
      "To convert an old ship and ticket, input your information here."
      div {}, (div {className:'label'},"Planet"), getShip, (if ship then Label "✓", "success")
      div {}, (div {className:'label'},"Ticket"), getTick, (if tick then Label "✓", "success")
      div {}, (div {className:'label'},"Email"),  getMail, (if mail then Label "✓", "success")
      if ship and tick
        rele RecycleTicket, {ship, tick, mail}

module.exports = name "Recycling", Recycling
