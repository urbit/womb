{a,div} = React.DOM

recl = React.createClass

module.exports = recl 
  displayName: "InfoBox"
  getInitialState: -> expanded:no
  onClick: -> @setState expanded:!@state.expanded
  render: ->
    {expanded} = @state
    {children:[prompt,contents...]} = @props
    div {className:"info"},
      a {@onClick}, prompt
      if expanded
        div {"info contents"}, contents...
