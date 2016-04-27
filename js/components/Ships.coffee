clas = require 'classnames'

Scry = require './Scry.coffee'

recl = React.createClass
rele = React.createElement
name = (displayName,component)-> _.extend component, {displayName}

{p,ul,li,div,pre,code} = React.DOM

Stat = name "Stat", (stats)-> 
    ul {},
      for ship, stat of stats
        {free, owned, split} = stat # one of
        className = clas stat
        li {className,key:ship},
          "~#{ship}: ",
          switch
            when free?  then "Unallocated"
            when owned? then "Granted to "+owned
            when split?
              if _.isEmpty split
                "Split"
              else rele Stat, split
            else throw new Error "Bad stat: #{_.keys stat}"
      
module.exports = Scry "/stats", ({data}) -> rele Stat, data
