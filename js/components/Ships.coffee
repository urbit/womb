Async = require './Async.coffee'

{p,div,pre,code} = React.DOM

module.exports = Async "/stats", ({data}) ->
    div {},
      p {}, "Womb stub: ships"
      pre {}, code {}, JSON.stringify data
