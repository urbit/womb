{shipShape} = require '../util.coffee'

{input} = React.DOM

recl = React.createClass
name = (displayName,component)-> _.extend component, {displayName}

module.exports = name "ShipInput", ({onInputShip,length,defaultValue})->
  input {
    defaultValue,
    onChange: ({target})->
      ship = target.value.trim()
      if ship[0] isnt '~'
        ship = "~" + ship
      onInputShip (
        if (shipShape ship) and ship.length is length
          ship[1..]
      )
  }