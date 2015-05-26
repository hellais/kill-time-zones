#!/bin/sh

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
verbose=0

TIMEZONES="
A|+1:00|Alpha Time Zone|Military
ACDT|+10:30|Australian Central Daylight Time,CDT – Central Daylight TimeCDST – Central Daylight Savings Time|Australia
ACST|+9:30|Australian Central Standard Time,CST – Central Standard Time|Australia
ACT|-5:00|Acre Time|South America
ACT|+9:30|Australian Central Time|Australia
ACWST|+8:45|Australian Central Western Standard Time|Australia
ADT|+3:00|Arabia Daylight Time,AST – Arabia Summer Time|Asia
ADT|-3:00|Atlantic Daylight Time,ADST – Atlantic Daylight Saving TimeAST – Atlantic Summer Time,HAA – Heure Avancée de l'Atlantique (French)|North America,Atlantic
AEDT|+11:00|Australian Eastern Daylight Time,EDT – Eastern Daylight TimeEDST – Eastern Daylight Saving Time|Australia,Pacific
AEST|+10:00|Australian Eastern Standard Time,EST – Eastern Standard TimeAET – Australian Eastern Time|Australia
AET|+10:00|Australian Eastern Time|Australia
AFT|+4:30|Afghanistan Time|Asia
AKDT|-8:00|Alaska Daylight Time,ADST – Alaska Daylight Saving Time|North America
AKST|-9:00|Alaska Standard Time,AT – Alaska Time|North America
ALMT|+6:00|Alma-Ata Time|Asia
AMST|-3:00|Amazon Summer Time|South America
AMST|+5:00|Armenia Summer Time,AMDT – Armenia Daylight Time|Asia
AMT|-4:00|Amazon Time|South America
AMT|+4:00|Armenia Time|Asia
ANAST|+12:00|Anadyr Summer Time|Asia
ANAT|+12:00|Anadyr Time|Asia
AQTT|+5:00|Aqtobe Time|Asia
ART|-3:00|Argentina Time|South America
AST|+3:00|Arabia Standard Time,AST – Arabic Standard TimeAST – Al Manamah Standard Time|Asia
AST|-4:00|Atlantic Standard Time,AT – Atlantic Time,AST – Tiempo Estándar del Atlántico  (Spanish)HNA – Heure Normale de l'Atlantique (French)|North America,Atlantic,Caribbean
AT|-3:00|Atlantic Time|North America,Atlantic
AWDT|+9:00|Australian Western Daylight Time,WDT – Western Daylight TimeWST – Western Summer Time|Australia
AWST|+8:00|Australian Western Standard Time,WST – Western Standard TimeWAT – Western Australia Time|Australia
AZOST|+0:00|Azores Summer Time,AZODT – Azores Daylight Time|Atlantic
AZOT|-1:00|Azores Time,AZOST – Azores Standard Time|Atlantic
AZST|+5:00|Azerbaijan Summer Time|Asia
AZT|+4:00|Azerbaijan Time|Asia
AoE|-12:00|Anywhere on Earth|Pacific
B|+2:00|Bravo Time Zone|Military
BNT|+8:00|Brunei Darussalam Time,BDT – Brunei Time|Asia
BOT|-4:00|Bolivia Time|South America
BRST|-2:00|Brasília Summer Time,BST – Brazil Summer TimeBST – Brazilian Summer Time|South America
BRT|-3:00|Brasília Time,BT – Brazil TimeBT – Brazilian Time|South America
BST|+6:00|Bangladesh Standard Time|Asia
BST|+1:00|British Summer Time,BDT – British Daylight TimeBDST – British Daylight Saving Time|Europe
BTT|+6:00|Bhutan Time|Asia
C|+3:00|Charlie Time Zone|Military
CAST|+8:00|Casey Time|Antarctica
CAT|+2:00|Central Africa Time|Africa
CCT|+6:30|Cocos Islands Time|Indian Ocean
CDT|-5:00|Central Daylight Time,CDST – Central Daylight Saving TimeNACDT – North American Central Daylight Time,HAC – Heure Avancée du Centre (French)|North America
CDT|-4:00|Cuba Daylight Time|Caribbean
CEST|+2:00|Central European Summer Time,CEDT – Central European Daylight TimeECST – European Central Summer Time,MESZ – Mitteleuropäische Sommerzeit (German)|Europe,Antarctica
CET|+1:00|Central European Time,ECT – European Central Time,CET – Central Europe Time,lMEZ – Mitteleuropäische Zeit (German)|Europe,Africa,Antarctica
CHADT|+13:45|Chatham Island Daylight Time,CDT – Chatham Daylight Time|Pacific
CHAST|+12:45|Chatham Island Standard Time|Pacific
CHOT|+8:00|Choibalsan Time|Asia
CHUT|+10:00|Chuuk Time|Pacific
CKT|-10:00|Cook Island Time|Pacific
CLST|-3:00|Chile Summer Time,CLDT – Chile Daylight Time|South America,Antarctica
CLT|-4:00|Chile Standard Time,CT – Chile TimeCLST – Chile Standard Time|South America,Antarctica
COT|-5:00|Colombia Time|South America
CST|-6:00|Central Standard Time,CT – Central Time,NACST – North American Central Standard Time,CST – Tiempo Central Estándar (Spanish)HNC – Heure Normale du Centre (French)|North America,Central America
CST|+8:00|China Standard Time|Asia
CST|-5:00|Cuba Standard Time|Caribbean
CT|-5:00|Central Time|North America
CVT|-1:00|Cape Verde Time|Africa
CXT|+7:00|Christmas Island Time|Australia
ChST|+10:00|Chamorro Standard Time,GST – Guam Standard Time|Pacific
D|+4:00|Delta Time Zone|Military
DAVT|+7:00|Davis Time|Antarctica
DDUT|+10:00|Dumont-d'Urville Time|Antarctica
E|+5:00|Echo Time Zone|Military
EASST|-5:00|Easter Island Summer Time,EADT – Easter Island Daylight Time|Pacific
EAST|-6:00|Easter Island Standard Time|Pacific
EAT|+3:00|Eastern Africa Time,EAT – East Africa Time|Africa,Indian Ocean
ECT|-5:00|Ecuador Time|South America
EDT|-4:00|Eastern Daylight Time,EDST – Eastern Daylight Savings Time,NAEDT – North American Eastern Daylight Time,HAE – Heure Avancée de l'Est  (French)EDT – Tiempo de verano del Este (Spanish)|North America,Caribbean
EEST|+3:00|Eastern European Summer Time,EEDT – Eastern European Daylight Time,OESZ – Osteuropäische Sommerzeit (German)|Europe,Asia
EET|+2:00|Eastern European Time,OEZ – Osteuropäische Zeit (German)|Europe,Asia,Africa
EGST|+0:00|Eastern Greenland Summer Time,EGST – East Greenland Summer Time|North America
EGT|-1:00|East Greenland Time,EGT – Eastern Greenland Time|North America
EST|-5:00|Eastern Standard Time,ET – Eastern Time NAEST – North American Eastern Standard Time,ET – Tiempo del Este  (Spanish)HNE – Heure Normale de l'Est (French)|North America,Caribbean,Central America
ET|-4:00|Eastern Time|North AmericaCaribbean
F|+6:00|Foxtrot Time Zone|Military
FET|+3:00|Further-Eastern European Time|Europe
FJST|+13:00|Fiji Summer Time,FJDT – Fiji Daylight Time|Pacific
FJT|+12:00|Fiji Time|Pacific
FKST|-3:00|Falkland Islands Summer Time,FKDT – Falkland Island Daylight Time|South America
FKT|-4:00|Falkland Island Time,FKST – Falkland Island Standard Time|South America
FNT|-2:00|Fernando de Noronha Time|South America
G|+7:00|Golf Time Zone|Military
GALT|-6:00|Galapagos Time|Pacific
GAMT|-9:00|Gambier Time,GAMT – Gambier Islands Time|Pacific
GET|+4:00|Georgia Standard Time|Asia
GFT|-3:00|French Guiana Time|South America
GILT|+12:00|Gilbert Island Time|Pacific
GMT|+0:00|Greenwich Mean Time,UTC – Coordinated Universal Time,GT – Greenwich Time|Europe,Africa,North America,Antarctica
GST|+4:00|Gulf Standard Time|Asia
GST|-2:00|South Georgia Time|South America
GYT|-4:00|Guyana Time|South America
H|+8:00|Hotel Time Zone|Military
HADT|-9:00|Hawaii-Aleutian Daylight Time,HDT – Hawaii Daylight Time|North America
HAST|-10:00|Hawaii-Aleutian Standard Time,HST – Hawaii Standard Time|North America,Pacific
HKT|+8:00|Hong Kong Time|Asia
HOVT|+7:00|Hovd Time|Asia
I|+9:00|India Time Zone|Military
ICT|+7:00|Indochina Time|Asia
IDT|+3:00|Israel Daylight Time|Asia
IOT|+6:00|Indian Chagos Time|Indian Ocean
IRDT|+4:30|Iran Daylight Time,IRST – Iran Summer TimeIDT – Iran Daylight Time|Asia
IRKST|+9:00|Irkutsk Summer Time|Asia
IRKT|+8:00|Irkutsk Time|Asia
IRST|+3:30|Iran Standard Time,IT – Iran Time|Asia
IST|+5:30|India Standard Time,IT – India TimeIST – Indian Standard Time|Asia
IST|+1:00|Irish Standard Time,IST – Irish Summer Time|Europe
IST|+2:00|Israel Standard Time|Asia
JST|+9:00|Japan Standard Time|Asia
K|+10:00|Kilo Time Zone|Military
KGT|+6:00|Kyrgyzstan Time|Asia
KOST|+11:00|Kosrae Time|Pacific
KRAST|+8:00|Krasnoyarsk Summer Time|Asia
KRAT|+7:00|Krasnoyarsk Time|Asia
KST|+9:00|Korea Standard Time,KST – Korean Standard TimeKT – Korea Time|Asia
KUYT|+4:00|Kuybyshev Time,SAMST – Samara Summer Time|Europe
L|+11:00|Lima Time Zone|Military
LHDT|+11:00|Lord Howe Daylight Time|Australia
LHST|+10:30|Lord Howe Standard Time|Australia
LINT|+14:00|Line Islands Time|Pacific
M|+12:00|Mike Time Zone|Military
MAGST|+12:00|Magadan Summer Time,MAGST – Magadan Island Summer Time|Asia
MAGT|+10:00|Magadan Time,MAGT – Magadan Island Time|Asia
MART|-9:30|Marquesas Time|Pacific
MAWT|+5:00|Mawson Time|Antarctica
MDT|-6:00|Mountain Daylight Time,MDST – Mountain Daylight Saving TimeNAMDT – North American Mountain Daylight Time
HAR – Heure Avancée des Rocheuses (French)|North America
MHT|+12:00|Marshall Islands Time|Pacific
MMT|+6:30|Myanmar Time|Asia
MSD|+4:00|Moscow Daylight Time,Moscow Summer Time|Europe
MSK|+3:00|Moscow Standard Time,MCK – Moscow Time|EuropeAsia
MST|-7:00|Mountain Standard Time,MT – Mountain TimeNAMST – North American Mountain Standard Time,HNR – Heure Normale des Rocheuses (French)|North America
MT|-6:00|Mountain Time|North America
MUT|+4:00|Mauritius Time|Africa
MVT|+5:00|Maldives Time|Asia
MYT|+8:00|Malaysia Time,MST – Malaysian Standard Time|Asia
N|-1:00|November Time Zone|Military
NCT|+11:00|New Caledonia Time|Pacific
NDT|-2:30|Newfoundland Daylight Time,HAT – Heure Avancée de Terre-Neuve (French)|North America
NFT|+11:30|Norfolk Time,NFT – Norfolk Island Time|Australia
NOVST|+7:00|Novosibirsk Summer Time,OMSST – Omsk Summer Time|Asia
NOVT|+6:00|Novosibirsk Time,OMST – Omsk Standard Time|Asia
NPT|+5:45|Nepal Time|Asia
NRT|+12:00|Nauru Time|Pacific
NST|-3:30|Newfoundland Standard Time,HNT – Heure Normale de Terre-Neuve (French)|North America
NUT|-11:00|Niue Time|Pacific
NZDT|+13:00|New Zealand Daylight Time|PacificAntarctica
NZST|+12:00|New Zealand Standard Time|PacificAntarctica
O|-2:00|Oscar Time Zone|Military
OMSST|+7:00|Omsk Summer Time,NOVST – Novosibirsk Summer Time|Asia
OMST|+6:00|Omsk Standard Time,OMST – Omsk TimeNOVT – Novosibirsk Time|Asia
ORAT|+5:00|Oral Time|Asia
P|-3:00|Papa Time Zone|Military
PDT|-7:00|Pacific Daylight Time,PDST – Pacific Daylight Saving TimeNAPDT – North American Pacific Daylight Time
HAP – Heure Avancée du Pacifique (French)|North America
PET|-5:00|Peru Time|South America
PETST|+12:00|Kamchatka Summer Time|Asia
PETT|+12:00|Kamchatka Time,PETT – Petropavlovsk-Kamchatski Time|Asia
PGT|+10:00|Papua New Guinea Time|Pacific
PHOT|+13:00|Phoenix Island Time|Pacific
PHT|+8:00|Philippine Time,PST – Philippine Standard Time|Asia
PKT|+5:00|Pakistan Standard Time,PKT – Pakistan Time|Asia
PMDT|-2:00|Pierre & Miquelon Daylight Time|North America
PMST|-3:00|Pierre & Miquelon Standard Time|North America
PONT|+11:00|Pohnpei Standard Time|Pacific
PST|-8:00|Pacific Standard Time,PT – Pacific TimeNAPST – North American Pacific Standard Time,PT – Tiempo del Pacífico (Spanish),HNP – Heure Normale du Pacifique (French)|North America
PST|-8:00|Pitcairn Standard Time|Pacific
PT|-7:00|Pacific Time|North America
PWT|+9:00|Palau Time|Pacific
PYST|-3:00|Paraguay Summer Time|South America
PYT|-4:00|Paraguay Time|South America
Q|-4:00|Quebec Time Zone|Military
QYZT|+6:00|Qyzylorda Time|Asia
R|-5:00|Romeo Time Zone|Military
RET|+4:00|Reunion Time|Africa
ROTT|-3:00|Rothera Time|Antarctica
S|-6:00|Sierra Time Zone|Military
SAKT|+10:00|Sakhalin Time|Asia
SAMT|+4:00|Samara Time,SAMT – Samara Standard Time|Europe
SAST|+2:00|South Africa Standard Time,SAST – South African Standard Time|Africa
SBT|+11:00|Solomon Islands Time,SBT – Solomon Island Time|Pacific
SCT|+4:00|Seychelles Time|Africa
SGT|+8:00|Singapore Time,SST – Singapore Standard Time|Asia
SRET|+11:00|Srednekolymsk Time|Asia
SRT|-3:00|Suriname Time|South America
SST|-11:00|Samoa Standard Time|Pacific
SYOT|+3:00|Syowa Time|Antarctica
T|-7:00|Tango Time Zone|Military
TAHT|-10:00|Tahiti Time|Pacific
TFT|+5:00|French Southern and Antarctic Time,KIT – Kerguelen (Islands) Time|Indian Ocean
TJT|+5:00|Tajikistan Time|Asia
TKT|+13:00|Tokelau Time|Pacific
TLT|+9:00|East Timor Time|Asia
TMT|+5:00|Turkmenistan Time|Asia
TOT|+13:00|Tonga Time|Pacific
TVT|+12:00|Tuvalu Time|Pacific
U|-8:00|Uniform Time Zone|Military
ULAT|+8:00|Ulaanbaatar Time,ULAT – Ulan Bator Time|Asia
UTC|UTC|Coordinated Universal Time|Worldwide
UYST|-2:00|Uruguay Summer Time|South America
UYT|-3:00|Uruguay Time|South America
UZT|+5:00|Uzbekistan Time|Asia
V|-9:00|Victor Time Zone|Military
VET|-4:30|Venezuelan Standard Time,HLV – Hora Legal de Venezuela (Spanish)|South America
VLAST|+11:00|Vladivostok Summer Time|Asia
VLAT|+10:00|Vladivostok Time|Asia
VOST|+6:00|Vostok Time|Antarctica
VUT|+11:00|Vanuatu Time,EFATE – Efate Time|Pacific
W|-10:00|Whiskey Time Zone|Military
WAKT|+12:00|Wake Time|Pacific
WARST|-3:00|Western Argentine Summer Time|South America
WAST|+2:00|West Africa Summer Time|Africa
WAT|+1:00|West Africa Time|Africa
WEST|+1:00|Western European Summer Time,WEDT – Western European Daylight Time,WESZ – Westeuropäische Sommerzeit (German)|Europe,Africa
WET|+0:00|Western European Time,GMT – Greenwich Mean Time,WEZ – Westeuropäische Zeit (German)|Europe,Africa
WFT|+12:00|Wallis and Futuna Time|Pacific
WGST|-2:00|Western Greenland Summer Time,WGST – West Greenland Summer Time|North America
WGT|-3:00|West Greenland Time,WGT – Western Greenland Time|North America
WIB|+7:00|Western Indonesian Time,WIB – Waktu Indonesia Barat|Asia
WIT|+9:00|Eastern Indonesian Time,WIT – Waktu Indonesia Timur|Asia
WITA|+8:00|Central Indonesian Time,WITA – Waktu Indonesia Tengah|Asia
WST|+13:00|West Samoa Time
ST – Samoa Time|Pacific
WST|+1:00|Western Sahara Summer Time|Africa
WT|+0:00|Western Sahara Standard Time,WT – Western Sahara Time|Africa
X|-11:00|X-ray Time Zone|Military
Y|-12:00|Yankee Time Zone|Military
YAKST|+10:00|Yakutsk Summer Time|Asia
YAKT|+9:00|Yakutsk Time|Asia
YAPT|+10:00|Yap Time|Pacific
YEKST|+6:00|Yekaterinburg Summer Time|Asia
YEKT|+5:00|Yekaterinburg Time|Asia
Z|+0:00|Zulu Time Zone|Military
"

show_help() {
  echo "Kill timezones"
}

bsd_convert() {
  start_date=$1
  read -r h m <<< $( echo $2 | tr ':' ' ' )
  if [ "$( echo $h | sed s/\+// )" == $h ];then
    sign="-"
    h=$( echo $h | sed s/\-// )
  else
    sign="+"
    h=$( echo $h | sed s/\+// )
  fi
  date -v$sign${m}M -v$sign${h}H -jf "%H:%M" "$start_date+0000" +%H:%M 2>/dev/null 
}

hours_to_seconds() {
  read -r h m <<< $( echo $1 | tr ':' ' ' )
  if [ "$( echo $h | sed s/\+// )" == $h ];then
    sign="-"
    h=$( echo $h | sed s/\-// )
  else
    sign="+"
    h=$( echo $h | sed s/\+// )
  fi
  echo "$sign$(($h*60*60+$m*60))"
}

seconds_to_hours() {
  s=$1
  if [ "$( echo $s | sed s/\+// )" == "$s" ];then
    sign="-"
    s=$( echo $s | sed s/\-// )
  else
    sign="+"
    s=$( echo $s | sed s/\+// )
  fi

  h=$(( $s/(60*60) ))
  m=$(( ($s-($h*60*60))/60 ))
  [ "$m" == "0" ] && m="00"
  echo "$sign$h:$m"
}

get_offset() {
  start_offset=$( echo "$TIMEZONES" | grep -e "^$start_timezone" | cut -d '|' -f2 )
  end_offset=$( echo "$TIMEZONES" | grep -e "^$end_timezone" | cut -d '|' -f2 )
  [ "$start_offset" == "UTC" ] && start_offset="+00:00"
  [ "$end_offset" == "UTC" ] && end_offset="+00:00"
  start_offset_seconds=$(hours_to_seconds $start_offset)
  end_offset_seconds=$(hours_to_seconds $end_offset)
  
  diff=$(($end_offset_seconds - $start_offset_seconds))
  
  seconds_to_hours $diff
}

convert() {
  start_time=$1 && shift
  start_timezone=$1 && shift
  [ "$1" == "to" ] && shift
  echo "$start_timezone: $start_time"
  while [ "$1" != "" ];do
    end_timezone=$1 && shift
    offset=$(get_offset $start_timezone $end_timezone)
    new_time=$(bsd_convert $start_time $offset)
    echo "$end_timezone: $new_time"
  done
}

while getopts "h?vf:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    f)  output_file=$OPTARG
        ;;
    esac
done


shift $((OPTIND-1))

[ "$1" = "--" ] && shift

ACTION=$1

case "$ACTION" in
  "convert" )
    shift;
    convert $@
esac
