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

Stat = name "Stat", ({stats})->
    ul {className:'network'},
      for ship, {live,dist} of stats
        {free, owned, split} = dist # one of
        className = clas dist
        li {className,key:ship},
          span {className:"mono"}, "~#{ship}"
          switch
            when free?  then Label labels.free
            when owned? then Label labels.owned
            when split?
              if _.isEmpty split
                Label labels.split
              else rele Stat, stats:split
            else throw new Error "Bad stat: #{_.keys dist}"

# module.exports = Scry "/stats", Stat
module.exports =  -> Stat stats:
  {"binzod":{"dist":{"split":{"pacnym-disber":{"dist":{"owned":""},"live":"cold"},"natmeb-rapdux":{"dist":{"owned":""},"live":"cold"},"donlyt-pidhec":{"dist":{"owned":""},"live":"cold"},"malnus-nidfes":{"dist":{"owned":""},"live":"cold"},"fontyd-rovsyx":{"dist":{"owned":""},"live":"cold"},"rovtev-nompyx":{"dist":{"owned":""},"live":"cold"},"tonrex-balsur":{"dist":{"owned":""},"live":"cold"},"donryg-ribwyt":{"dist":{"owned":""},"live":"cold"},"dalrys-pocnyx":{"dist":{"owned":""},"live":"cold"},"dandel-rovbur":{"dist":{"owned":""},"live":"cold"},"sicdyt-lidwed":{"dist":{"owned":""},"live":"cold"},"danren-tidren":{"dist":{"owned":""},"live":"cold"}}},"live":"seen"},"bus":{"dist":{"split":{"rocbus":{"dist":{"owned":""},"live":"cold"},"hidbus":{"dist":{"owned":""},"live":"cold"},"nimbus":{"dist":{"owned":""},"live":"cold"},"lisbus":{"dist":{"owned":""},"live":"cold"},"sambus":{"dist":{"owned":""},"live":"cold"},"litbus":{"dist":{"owned":""},"live":"cold"},"sigbus":{"dist":{"owned":""},"live":"cold"},"fidbus":{"dist":{"owned":""},"live":"cold"},"wacbus":{"dist":{"owned":""},"live":"cold"},"wanbus":{"dist":{"owned":""},"live":"cold"},"dirbus":{"dist":{"owned":""},"live":"cold"},"binbus":{"dist":{"owned":""},"live":"cold"},"sabbus":{"dist":{"owned":""},"live":"cold"},"marbus":{"dist":{"owned":""},"live":"cold"}}},"live":"live"},"samzod":{"dist":{"split":{"wannes-sopsyx":{"dist":{"owned":""},"live":"cold"},"winsyx-wicsyl":{"dist":{"owned":""},"live":"cold"}}},"live":"live"},"pub":{"dist":{"split":{"dirpub":{"dist":{"owned":""},"live":"cold"},"lispub":{"dist":{"owned":""},"live":"cold"},"sampub":{"dist":{"owned":""},"live":"cold"},"wanpub":{"dist":{"owned":""},"live":"cold"},"sigpub":{"dist":{"owned":""},"live":"cold"},"marpub":{"dist":{"owned":""},"live":"cold"},"wacpub":{"dist":{"owned":""},"live":"cold"},"binpub":{"dist":{"owned":""},"live":"cold"},"lanpub":{"dist":{"owned":""},"live":"cold"},"litpub":{"dist":{"owned":""},"live":"cold"},"sogpub":{"dist":{"owned":""},"live":"cold"},"hidpub":{"dist":{"owned":""},"live":"cold"}}},"live":"live"},"dev":{"dist":{"split":{"wandev":{"dist":{"owned":""},"live":"cold"},"litdev":{"dist":{"owned":""},"live":"cold"},"bindev":{"dist":{"owned":""},"live":"cold"},"sigdev":{"dist":{"owned":""},"live":"cold"},"samdev":{"dist":{"owned":""},"live":"cold"},"mardev":{"dist":{"owned":""},"live":"cold"},"hiddev":{"dist":{"owned":""},"live":"cold"},"dirdev":{"dist":{"owned":""},"live":"cold"},"lisdev":{"dist":{"owned":""},"live":"cold"}}},"live":"seen"},"marzod":{"dist":{"split":{"wicdev-wisryt":{"dist":{"owned":""},"live":"cold"},"tomfur-figpur":{"dist":{"owned":""},"live":"cold"},"panret-tocsel":{"dist":{"owned":""},"live":"cold"},"pittyp-datfyn":{"dist":{"owned":""},"live":"cold"},"tocbel-habnyx":{"dist":{"owned":""},"live":"cold"},"locnyl-dacdel":{"dist":{"owned":""},"live":"cold"}}},"live":"seen"},"wanzod":{"dist":{"split":{"maldeb-hapben":{"dist":{"owned":""},"live":"cold"},"modlep-fosreg":{"dist":{"owned":""},"live":"cold"},"dalnut-dovtux":{"dist":{"owned":""},"live":"cold"},"dirwex-dosrev":{"dist":{"owned":""},"live":"cold"},"lanrus-rinfep":{"dist":{"owned":""},"live":"cold"},"novlud-padtyv":{"dist":{"owned":""},"live":"cold"},"rostex-fossyl":{"dist":{"owned":""},"live":"cold"},"rossec-nordys":{"dist":{"owned":""},"live":"cold"},"balhul-polsub":{"dist":{"owned":""},"live":"cold"},"hapryx-hopner":{"dist":{"owned":""},"live":"cold"}}},"live":"seen"},"ten":{"dist":{"split":{"wisten":{"dist":{"owned":""},"live":"cold"},"molten":{"dist":{"owned":""},"live":"cold"},"marten":{"dist":{"owned":""},"live":"cold"},"binten":{"dist":{"owned":""},"live":"cold"},"sigten":{"dist":{"owned":""},"live":"cold"},"wacten":{"dist":{"owned":""},"live":"cold"},"wanten":{"dist":{"owned":""},"live":"cold"},"mitten":{"dist":{"owned":""},"live":"cold"},"dirten":{"dist":{"owned":""},"live":"cold"},"sabten":{"dist":{"owned":""},"live":"cold"},"samten":{"dist":{"owned":""},"live":"cold"},"listen":{"dist":{"owned":""},"live":"cold"},"sogten":{"dist":{"owned":""},"live":"cold"},"tarten":{"dist":{"owned":""},"live":"cold"},"litten":{"dist":{"owned":""},"live":"cold"}}},"live":"live"}}
