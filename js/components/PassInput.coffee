{uvShape} = require '../util.coffee'

{input} = React.DOM

recl = React.createClass
name = (displayName,component)-> _.extend component, {displayName}

module.exports = name "PassInput", ({onInputPass,minLength,defaultValue})->
  input {
    defaultValue,
    className:'mono womb-pass-input'
    style:{width:'100%'}
    placeholder: "0v0.00000.00000.00000.00000.00000"
    onChange: ({target})->
      pass = target.value.trim()
      onInputPass (
        if (uvShape pass) and pass.length >= minLength
          pass
      )
  }
