Actions = require '../Actions.coffee'
Store = require '../Store.coffee'

recl = React.createClass
rele = React.createElement

{div,i} = React.DOM

FromStore = (path,Child)-> recl
  displayName: "FromStore."+path.split('/').join('-')
  getInitialState: -> @retrieveData()
  retrieveData: ->
    data = Store.retrieve @getPath()
    {loaded:data?, "#{@getKey()}": data}

  # matches both "local" claim/... and leading-/ scry paths
  getKey: -> path.match(/[a-z0-9-]+/)[0] 
      
  getPath: -> path + (@props.spur ? "")

  componentDidMount: -> Store.addChangeListener @changeListener
  componentWillUnmount: -> Store.removeChangeListener @changeListener
  
  componentDidUpdate: (_props,_state) ->
    if _props isnt @props
      @setState @retrieveData()

  changeListener: -> if @isMounted() then @setState @retrieveData()
  render: -> 
      rele Child, (_.extend {}, @props, @state, {path:@getPath()})

Scry = (path,Child)-> FromStore path, recl
  displayName: "Scry"
  checkProps: ->
    if !@props.loaded
      Actions.getData @props.path

  componentDidMount: -> @checkProps()  
  componentDidUpdate: (_props,_state) -> @checkProps()

  render: ->
    div {style:display:"inline"}, # XX CSS
      if !@props.loaded
        i {key:"load"}, "Fetching data..."
      else
        rele Child,
          (_.extend {}, @props, {key:"got"}),
          @props.children

module.exports = Scry
module.exports.FromStore = FromStore
