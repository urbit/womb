{shipShape} = require '../util.coffee'

{input} = React.DOM

recl = React.createClass
name = (displayName,component)-> _.extend component, {displayName}

module.exports = name "ShipInput", ({onInputShip,length,defaultValue,oldFormat,placeholder})->
  input {
    defaultValue,
    placeholder:placeholder
    className: 'mono pick'
    onChange: ({target})->
      ship = target.value.trim()
      if ship[0] isnt '~'
        ship = "~" + ship
      onInputShip (
        if (shipShape ship, oldFormat) and ship.length is length
          ship[1..]
      )
  }
