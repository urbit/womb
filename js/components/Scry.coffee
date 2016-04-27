Actions = require '../Actions.coffee'
Store = require '../Store.coffee'

recl = React.createClass
rele = React.createElement

{div,i} = React.DOM

module.exports = (path,Child)-> recl
  displayName: "Scry"+path.split('/').join('-')
  getInitialState: -> @retrieveData()
  retrieveData: -> data: Store.retrieve @getPath()
  
  getPath: -> path + (@props.spur ? "")

  checkState: ->
    if !@state.data?
      Actions.getData @getPath()

  componentDidMount: ->
    Store.addChangeListener @changeListener
    @checkState()
  
  componentWillUnmount: ->
    Store.removeChangeListener @changeListener
  
  componentDidUpdate: (_props,_state) ->
    if _props isnt @props
      @setState @retrieveData()
    @checkState()

  changeListener: -> if @isMounted() then @setState @retrieveData()

  render: -> div {style:display:"inline"}, # XX CSS
    if !@state.data?
      i {key:"load"}, "Fetching data..."
    else
      rele Child,
        (_.extend {}, @props, {key:"got", data: @state.data}),
        @props.children
