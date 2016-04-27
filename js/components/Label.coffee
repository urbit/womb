{span} = React.DOM

module.exports = (s,type="default")->
  span {className:"label label-#{type}"}, s
