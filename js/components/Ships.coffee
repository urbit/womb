clas = require 'classnames'

Scry = require './Scry.coffee'
Label = require './Label.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{p,ul,li,span,div,pre,code} = React.DOM

labels = 
  free: "Unallocated"
  owned: "Issued"
  split: "Distributing"
    
Stat = name "Stat", (stats)-> 
    ul {},
      for ship, {live,dist} of stats
        {free, owned, split} = dist # one of
        className = clas dist
        li {className,key:ship},
          span {className:"mono"}, "~#{ship}"
          " (", live, "): "  # XX also a label?
          switch
            when free?  then Label labels.free
            when owned? then Label labels.owned
            when split?
              if _.isEmpty split
                Label labels.split
              else rele Stat, split
            else throw new Error "Bad stat: #{_.keys dist}"
      
module.exports = Scry "/stats", ({data}) -> rele Stat, data
