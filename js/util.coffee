module.exports =
  unpackFrond: (a)->
    [key,alts...] = _.keys a
    unless _.isEmpty alts
      throw new Error "Improper frond: #{[key,alts...].join ','}"
    [key, a[key]]
