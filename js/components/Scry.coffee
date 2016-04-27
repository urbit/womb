Actions = require '../Actions.coffee'
Store = require '../Store.coffee'

recl = React.createClass
rele = React.createElement

{div,i} = React.DOM

module.exports = (path,Child)-> recl
  displayName: "Scry"+path.split('/').join('-')
  getInitialState: -> @retrieveData()
  retrieveData: -> data: Store.retrieve path
  
  componentDidMount: ->
    Store.addChangeListener @changeListener
    if !@state.data?
      Actions.getData path
  
  componentWillUnmount: ->
    Store.removeChangeListener @changeListener
  
  changeListener: -> if @isMounted() then @setState @retrieveData()

  render: -> div {},
    if !@state.data?
      i {key:"load"}, "Fetching data..."
    else
      rele Child,
        (_.extend {}, @props, {key:"got", data: @state.data}),
        @props.children
