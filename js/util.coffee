SHIPSHAPE = ///
^~?(                              #preamble
   [a-z]{3}                       # galaxy
 | [a-z]{6}(-[a-z]{6}){0,3}       # star - moon
 |   [a-z]{6}(-[a-z]{6}){3}       # comet
   (--[a-z]{6}(-[a-z]{6}){3})+    #
)$                                #postamble
///
PO = '''
dozmarbinwansamlitsighidfidlissogdirwacsabwissib
rigsoldopmodfoglidhopdardorlorhodfolrintogsilmir
holpaslacrovlivdalsatlibtabhanticpidtorbolfosdot
losdilforpilramtirwintadbicdifrocwidbisdasmidlop
rilnardapmolsanlocnovsitnidtipsicropwitnatpanmin
ritpodmottamtolsavposnapnopsomfinfonbanporworsip
ronnorbotwicsocwatdolmagpicdavbidbaltimtasmallig
sivtagpadsaldivdactansidfabtarmonranniswolmispal
lasdismaprabtobrollatlonnodnavfignomnibpagsopral
bilhaddocridmocpacravripfaltodtiltinhapmicfanpat
taclabmogsimsonpinlomrictapfirhasbosbatpochactid
havsaplindibhosdabbitbarracparloddosbortochilmac
tomdigfilfasmithobharmighinradmashalraglagfadtop
mophabnilnosmilfopfamdatnoldinhatnacrisfotribhoc
nimlarfitwalrapsarnalmoslandondanladdovrivbacpol
laptalpitnambonrostonfodponsovnocsorlavmatmipfap

zodnecbudwessevpersutletfulpensytdurwepserwylsun
rypsyxdyrnuphebpeglupdepdysputlughecryttyvsydnex
lunmeplutseppesdelsulpedtemledtulmetwenbynhexfeb
pyldulhetmevruttylwydtepbesdexsefwycburderneppur
rysrebdennutsubpetrulsynregtydsupsemwynrecmegnet
secmulnymtevwebsummutnyxrextebfushepbenmuswyxsym
selrucdecwexsyrwetdylmynmesdetbetbeltuxtugmyrpel
syptermebsetdutdegtexsurfeltudnuxruxrenwytnubmed
lytdusnebrumtynseglyxpunresredfunrevrefmectedrus
bexlebduxrynnumpyxrygryxfeptyrtustyclegnemfermer
tenlusnussyltecmexpubrymtucfyllepdebbermughuttun
bylsudpemdevlurdefbusbeprunmelpexdytbyttyplevmyl
wedducfurfexnulluclennerlexrupnedlecrydlydfenwel
nydhusrelrudneshesfetdesretdunlernyrsebhulryllud
remlysfynwerrycsugnysnyllyndyndemluxfedsedbecmun
lyrtesmudnytbyrsenwegfyrmurtelreptegpecnelnevfes
'''

module.exports =
  unpackFrond: (a)->
    [key,alts...] = _.keys a
    unless _.isEmpty alts
      throw new Error "Improper frond: #{[key,alts...].join ','}"
    [key, a[key]]
    
  shipShape: (a)->
    (SHIPSHAPE.test a) and 
      _.all (a.match /[a-z]{3}/g), (b)-> -1 isnt PO.indexOf(b)

  mailShape: (a)->
    valid = (a.indexOf('@') != -1 &&
      a.indexOf('.') != -1 &&
      a.length > 7 &&
      a.split(".")[1].length > 1 &&
      a.split("@")[0].length > 0 &&
      a.split("@")[1].length > 4)
