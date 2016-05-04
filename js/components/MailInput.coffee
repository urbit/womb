{mailShape} = require '../util.coffee'

{input} = React.DOM

recl = React.createClass
name = (displayName,component)-> _.extend component, {displayName}

module.exports = name "MailInput", ({onInputMail})->
  input {
    placeholder: "me@example.com"
    onChange: ({target})->
      mail = target.value.trim()
      onInputMail (
        if (mailShape mail)
          mail
      )
  }
