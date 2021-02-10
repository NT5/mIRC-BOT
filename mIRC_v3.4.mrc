;~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*;
;           mIRC BOT SERV                        ;
;            Made by NT5                         ;
;*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~;
;BNCConnect
on *:CONNECT: {
  if ( $me == Unknown|OFF) {
    nick Unknown
  }
}
alias quit {
  amsg 4 $+ $me Shutdown.
  nick Unknown|OFF
  quit
}
;BNCConnect
on *:load: { 
  echo -ts 12 $me By NT5
  set %spam.time | set %away.time
  set %away.razon | set %away.cont
  set %bot_state ON | set %nivel.NT5 10
  set %nivel. [ $+ [ $me ] ] 10 | set %bom off
  set %cd off
  set %invt off
  set %join_2 off
  set %fort off
  set %bot_p off
  set %ln off
  set %qln off
  set %reconect off
  set %ruleta off
  set %juego.adivina off
  set %dm off
  set %8ball off
}
on *:start: {
  set %bot_state ON
  echo -ts 12 $me 10Creado 5Por NT5.
  echo -ts 12 $me Cargado Satisfactoriamente!
  echo -ts 12 Dudas o comentarios: hendelporras@hotmail.com
  echo -ts 12 $me By NT5
  set %bot_state ON
  set %bom off
  set %cd off
  set %invt off
  set %join_2 off
  set %fort off
  set %bot_p off
  set %ln off
  set %qln off
  set %reconect off
  set %ruleta off
  set %juego.adivina off
  set %dm off
  set %8ball off
}
on *:NICK: {
  if ($nick == $me) {
    set %nivel. [ $+ [ $newnick ] ] 10
  }
}
alias NoHTML return $regsubex($replace($1,<b>,$chr(2),</b>,$chr(2)),/<[^>]+(?:>|$)|^[^<>]+>/g,) 
alias pass {
  ns identify hendel1212
}
alias kick {
  inc %kicks
  kick $$1- $+ [Nº $+ %kicks $+ ]
}
alias quit {
  quit $me Desconectado 4[10Powered by NT54]
}
;==================================Soket´s=================================================
;Traductor
on *:SockOpen:traduce: {
  sockwrite -nt traduce GET /translation/ $+ %t $+ ?src= $+ %idm HTTP/1.1
  sockwrite -nt traduce Host: spanish.dictionary.com
  sockwrite -nt traduce User-Agent: mIRC/6.35 (Windows NT; en)
  sockwrite -nt traduce $crlf
}
on *:SockRead:traduce: {
  var %r | sockread %r
  if ( *text1* iswm %r) {
    msg %tchan >5Original: $nohtml(%r)
  }
  elseif ( *text2* iswm %r) {
    msg %tchan >10Traduccion: $nohtml(%r)
    unset %t | unset %tchan | unset %tlent | unset %idm
    sockclose $sockname
  }
}
;Traductor
;RZForum
on *:sockopen:rz:{

  sockwrite -n rz GET / HTTP/1.1
  sockwrite -n rz Host: rz-clan.co.cc
  sockwrite -n rz $crlf
}
on *:sockread:rz:{
  var %r
  sockread %r
  if (*Guest iswm %r) {
    if (%r == Welcome, Guest. Please login or register.) { return %r }
    msg %rzchan >>10 $nohtml(%r)
  }
  else { 
    if (*Users iswm %r) {
      msg %rzchan >>10 $nohtml(%r)
    }
  }
  if (*Users active in past 15 minutes:* iswm %r) {
    msg %rzchan >5 $+ $nohtml(%r)
    unset %rzchan
    sockclose $sockname
  }
}
;RZForum
;XeRank
on *:sockopen:xerank:{

  sockwrite -n xerank GET / HTTP/1.1
  sockwrite -n xerank Host: xe.vrocker-hosting.co.uk
  sockwrite -n xerank $crlf
}
on *:sockread:xerank:{
  var %r
  sockread %r
  if (*<center><small>Top 10 Players based on Kills</small></center>* iswm %r) {
    msg %xetchan >>3 $noHTML(%r)
  }
  else if (<tr><td>*</td>* iswm %r) {
    var %r = $replace(%r,<td>,- ,<tr>, ,</tr>,.,</td>, )
    %r = $nohtml(%r)
    msg %xetchan >10 $+ %r
    unset %xetchan
    sockclose $sockname
  }
}
;XeRank
;XeStats
on *:sockopen:xe:{
  sockwrite -n xe GET /player.php?nick= $+ %s HTTP/1.1
  sockwrite -n xe Host: xe.vrocker-hosting.co.uk
  sockwrite -n xe $crlf
}
on *:sockread:xe:{
  var %r
  sockread %r
  if (<h3><i><center>*</center></i></h3>* iswm %r) {
    msg %chan >>10 $noHTML(%r)
  }
  else if (*</u><br/>*Kills:*<br/>* iswm %r) {
    var %r $replace(%r,Basic Stats, )
    var %r $strip(%r)
    set %xekills $nohtml(%r)
  }
  else if (*Deaths:*<br/>* iswm %r) {
    set %xedeaths $nohtml(%r)
  }
  else if (*Ratio:* iswm %r) {
    var %r $replace(%r,%s,$chr(2),'s,$chr(2),Stats,$chr(2))
    set %xeratio $nohtml(%r)
    msg %chan >>5 %xekills - %xedeaths - %xeratio
    unset %s | unset %chan | unset %xekills | unset %xedeaths | unset %xeratio
    sockclose $sockname
  }
  else if (*<h2><center>Could not find Stats for that Player.</h2>* iswm %r) { 
    msg %chan >4 $nohtml(%r)
    unset %s | unset %chan
    sockclose $sockname
  }
}
;XeStats
alias slap.error echo $color(kick) -at /SLAP: Sock $+ $2 Error. $sock($1).wsmsg 
on *:sockopen:slap:{
  if ($sockerr) || ($sock($sockname).status != active) { slap.error $sockname open | return }
  sockwrite -n $sockname GET /CreativityTools/RandomWord/RandomPhrase.aspx HTTP/1.1
  sockwrite -n $sockname Host: www.watchout4snakes.com
  sockwrite -n $sockname User-Agent: mIRC $version
  sockwrite -n $sockname $crlf
}
on *:sockread:slap:{
  var %r | sockread %r | tokenize 32 %r
  if ($sockerr) || ($sock($sockname).status != active) { slap.error $sockname read | return }
  elseif ($regex(%r,main_lblPhrase.+>(.+)</span>)) {
    tokenize 32 $sock($sockname).mark $regml(1)
    describe # $1 slaps $2 around a bit with $+(a,$iif($regex($left($3,1),[aeiou]),n)) $3-
    return
  }
  elseif ($1 == </HTML>) sockclose $sockname
}
;Youtube
on *:sockopen:youtube.*: {
  sockwrite -nt $sockname GET / $+ $gettok($sock($sockname).mark,3,32) HTTP/1.1
  sockwrite -nt $sockname HOST: www.youtube.com
  sockwrite -nt $sockname $crlf
}
on *:sockread:youtube.*: {
  var %reader
  sockread %reader
  if $regex(%reader,a href="/(.*?)".*class=.*title="(.*?)") {
    var %r $r(1,9999)
    .sockopen youtube. $+ %r www.youtube.com 80
    sockmark youtube. $+ %r $gettok($sock($sockname).mark,1-2,32) $regml(1) | set %yt.link 10Link:4 http://www.youtube.com/ $+ $regml(1)
    sockclose $sockname
  }  
  if $regex(%reader,/<meta itemprop="name" content="(.*?)"/Si) { set %yt.title $regml(1) } 
  elseif $regex(%reader,/<meta itemprop="description" content="(.*?)"/Si) {  set %yt.description $regml(1) }
  elseif $regex(%reader,/rel="author" href="/user/(.*?)"/Si) { set %yt.user $regml(1) }
  elseif $regex(%reader,<span class="likes">(.*?)</span>.*<span class="dislikes">(.*?)</span>) {
    tokenize 32 $sock($sockname).mark 
    $1 $2  1,0You0,4Tube  10Titulo:4 $replace(%yt.title,&#39;,',&quot;,") 10Me Gusta:4 $regml(1) 10No Me Gusta:4 $regml(2) 10Descripcion:4 $replace(%yt.description,&#39;,',&quot;,") $iif(%yt.link,%yt.link,$chr(32))
    sockclose $sockname | unset %yt*
  }
}
;Youtube
;Horoscopo
on *:sockopen:horoscopo:{

  sockwrite -n horoscopo GET /signo/ $+ %s $+ .html HTTP/1.1
  sockwrite -n horoscopo Host: elhoroscopodehoy.com
  sockwrite -n horoscopo $crlf
}
on *:sockread:horoscopo:{
  var %r
  sockread %r
  if (<br><b>*</b><br><br>* iswm %r) {
    var %r = $noHTML(%r) 
    msg %hchan >>10 $strip(%r)
    sockclose $sockname | unset %hchan | unset %s
  }
  else if (<br><b>*<br /></b>* iswm %r) {
    var %r = $noHTML(%r)
    msg %hchan >>10 $strip(%r) 
    sockclose $sockname
    unset %hchan | unset %s
  }
}
;Horoscopo
;Google
alias googlesearch {
  var %x = 1
  while ($sock($+(google,%x))) inc %x
  sockopen $+(google,%x) www.google.com 80
  sockmark $+(google,%x) $1-
}
ON *:SOCKOPEN:google*: {
  if ($sockerr) {
    var %cmd = $gettok($sock($sockname).mark,1,32)
    %cmd Socket error $sockerr
    return
  }

  sockwrite -n $sockname GET $+(/search?q=,$phex($gettok($sock($sockname).mark,2-,32)),&btnI=I%27m+Feeling+Lucky HTTP/1.0)
  sockwrite $sockname $crlf
}
on *:SOCKREAD:google*: {
  var %f, %cmd, %result
  %cmd = $gettok($sock($sockname).mark,1,32)

  if ($sockerr) {
    %cmd Socket error $sockerr
    return
  }

  while (1) {
    sockread %f
    if (!$sockbr) break
    if (<A HREF="*">here</a>. iswm %f) {
      %result = $gettok(%f,2,34)
      sockclose $sockname
      break
    }
    elseif (HTTP/1.0 200 OK = %f) {
      %result = 4There are no results.
      sockclose $sockname
      break
    }
  }

  if (%result) {
    %cmd %result
  }
}
alias google { googlesearch google2 $1- }
alias google2 { echo $colour(info) -a *** 2G4o7o2g3l4e 10search: $1- }

; !google query in a channel will message the channel with the results.
on *:TEXT:!google *:#: {
  set %google3 $chan
  googlesearch google3 $2-
}
alias google3 { msg %google3 2G4o7o2g3l4e 10search: $1- | unset %google3 }
; Convert some text to hexadecimal form
alias phex {
  var %x = 1, %s = $len($1), %r, %w
  while (%x <= %s) {
    %w = $mid($1,%x,1)
    if ($asc(%w) = 32) {
      %r = $+(%r,+)
    }
    elseif ($asc(%w) !isnum 65-90) && ($asc(%w) !isnum 97-122) && ($asc(%w) !isnum 48-57) {
      %r = $+(%r,%,$base($asc(%w),10,16,2))
    }
    else {
      %r = $+(%r,%w)
    }
    inc %x
  }
  return %r
}
;Galleta
on *:SockOpen:Galleta: {
  sockwrite -nt Galleta GET /galleta.php?submit=Abrir+una+galleta% $+ $rand(1,30) $+ / HTTP/1.1
  sockwrite -nt Galleta Host: www.galletadelasuerte.es
  sockwrite -nt Galleta User-Agent: mIRC/6.35 (Windows NT; en)
  sockwrite -nt Galleta $crlf
}
on *:SockRead:Galleta: {
  var %a
  sockread %a
  if (*n&uacute;meros* iswm %a) {
    var %a $replace($remove(%a,<br>,</div>,</td>),Tus n&uacute;meros,$chr(44) $+ $chr(32) $+ Tus números)
    if ($gettok(%a,-1,32) = suerte:) {
      msg %gchan 10>La Galleta estaba Dañada!
    }
    else {
      msg %gchan 3>> %a
    }
    sockclose $sockname
    unset %gchan
} }
;Galleta
;===========================Soket´s=================================================
on ln:JOIN:#:{ 
  if (%bot_state == off) { halt }
  msg $chan **4/!\ 5No Puedes Entrar estas en Lista Negra 4/!\ . 
  .timer 1 2 kick $chan $nick 4Lista Negra
}
on *:JOIN:#: {
  if ( %op. [ $+ [ $chan ] ] [ $+ [ $nick ] ] == on) { mode # +o $nick }
  if ( %mod. [ $+ [ $chan ] ] [ $+ [ $nick ] ] == on) { mode # +h $nick }

  if (%bot_state == off) { .halt }
  if ($nick == $me) {
    msg $chan 4[5 $+ $me 6Conectado a $chan $+ .4]
    msg $chan 4[10Powered by NT54]
    .halt
  }
  inc %contar.chan. [ $+ [ $chan ] ]
  msg $chan 4 $nick 14**Eres el Visitante N°4 %contar.chan. [ $+ [ $chan ] ] 5Usuarios Actuales: ( $+ $nick( #,0 ) $+ )
  if ( %contar.chan. [ $+ [ $chan ] ] == 100) { .notice $nick Eres El Visitante N° 100 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 200) { .notice $nick Eres El Visitante N° 200 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 300) { .notice $nick Eres El Visitante N° 300 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 400) { .notice $nick Eres El Visitante N° 400 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 500) { .notice $nick Eres El Visitante N° 500 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 600) { .notice $nick Eres El Visitante N° 600 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 666) { .notice $nick Eres El Visitante N° 666!! D: en entrar a $chan Felicidades! } 
  if ( %contar.chan. [ $+ [ $chan ] ] == 700) { .notice $nick Eres El Visitante N° 700 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 800) { .notice $nick Eres El Visitante N° 800 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 900) { .notice $nick Eres El Visitante N° 900 en entrar a $chan Felicidades! }
  if ( %contar.chan. [ $+ [ $chan ] ] == 1000) { .notice $nick Eres El Visitante N° 1000!! en entrar a $chan Felicidades! } 
  if ( %contar.chan. [ $+ [ $chan ] ] == 10000) { .notice $nick Eres El Visitante N° 10000!! O_O en entrar a $chan Felicidades! }
}
ON *:QUIT: {
  if ($nick == $me) { .timer* off | halt }
  if (%bom.chan == $chan ) {
    if ( %bom.sta. [ $+ [ $nick ] ] == on ) { 
      .timer.bom_7 off
      .timer.bom_6 off
      .timer.bom_5 off
      .timer.bom_4 off
      .timer.bom_3 off
      .timer.bom_2 off
      .timer.bom_1 off
      .timer.bom off
      set %bom off
      unset %bom.sta. [ $+ [ $nick ] ]
      unset %bom.chan
      unset %bom.nick
    }
  }
}
ON *:PART:#: {
  if (%bom.chan == $chan ) {
    if ( %bom.sta. [ $+ [ $nick ] ] == on ) { 
      msg $chan 10 $nick $+ !!! As Echo Evade!!
      .msg $nick 10Seras Baneado de $chan por 1 Minuto.
      mode # +b $nick
      .timer 1 60 mode # -b $nick
      .timer.bom_7 off
      .timer.bom_6 off
      .timer.bom_5 off
      .timer.bom_4 off
      .timer.bom_3 off
      .timer.bom_2 off
      .timer.bom_1 off
      .timer.bom off
      set %bom off
      unset %bom.sta. [ $+ [ $nick ] ]
      unset %bom.chan
      unset %bom.nick
    }
  }
}
on *:KICK:#: { 
  if ( $knick == $me ) { join # }
}
on *!:BAN:#: {
  if ($banmask iswm $address($me,5)) {
    mode $chan -bo+b $banmask $nick $nick 
    kick # $nick 0,6╭∩╮（︶︿︶）╭∩╮
  }
}
on *:ACTION:*:#: {
  if ($2 == $me) { describe # $1 $nick $3- | .halt }
  if ($1 == slaps) { describe # joins in and $1- too }
  if ($1 == slap) { describe # joins in and $1- too }
}
ON *:MODE:#: {
  if ( $nick == $me ) { .halt }
  if (%mute. [ $+ [ $chan ] ] == on) {
    mode # +m
  }
  if (%mute. [ $+ [ $chan ] ] == $null) {
    mode # -m
  }
  if (%lock. [ $+ [ $chan ] ] == on) {
    set -u1 %lock.t $rand(1,9) $+ $rand(1,9) $+ $rand(1,9) $+ $rand(1,9) $+ $rand(1,9) $+ $rand(1,9)
    mode # +k %lock.t
  }
  if (%lock. [ $+ [ $chan ] ] == $null) {
    mode # -k 0
  }
}
;------------------ IRC Channel Commands -------------------------------

on *:TEXT:*:#: {
  if (*!* iswm $1 ) {
    var %cmd = $strip($1)
  }
  if (%cmd == !test) {
    msg $chan esto es un test
    msg $chan %cmd
  }

  ;youtube
  if ($regex($1-,/^[!@]y(t|ube|search|outube)/Si)) {
    if (%bot_state == off) { halt }
    var %r $r(1,9999)
    sockopen youtube. $+ %r www.youtube.com 80
    sockmark youtube. $+ %r $iif($left($strip($1),1) == !, .msg $chan, msg $iif($chan,$chan,$nick)) results?search_query= $+ $replace($2-,$chr(32),+)
  }
  elseif ($regex($1-,/(youtube.com|youtu.be)\/(.+)/i)) {
    if (%bot_state == off) { halt }
    var %r $r(1,9999)
    sockopen youtube. $+ %r www.youtube.com 80
    sockmark youtube. $+ %r $iif($chan, msg $chan, msg $nick) $strip($regml(2))
  }
  ;youtube

  if (%cmd == !galleta) {
    if (%bot_state == off) { halt }
    if (%gchan != $null) { .notice $nick $1 En Progreso... | halt }
    msg $chan >>5 %nick Abre su galleta de la suerte y dice:
    sockClose Galleta
    sockOpen Galleta www.galletadelasuerte.es 80
    set %gchan $chan
  }
  if (%cmd == !xestats) {
    if (%bot_state == off) { halt }
    if ( %s ) { .notice $nick En Progreso... | halt }
    if (!%s) {
      if (!$2) {
        sockClose xe
        sockOpen xe xe.vrocker-hosting.co.uk 80
        msg $chan >10 $nick - Stats
        set %chan $chan
        set %s $nick
      }
      else {
        sockClose xe
        sockOpen xe xe.vrocker-hosting.co.uk 80
        set %chan $chan
        set %s $2
      }
    }
  }
  if (%cmd == !xetop) {
    if (%bot_state == off) { halt }
    if (%xetchan) { .notice $nick Error - En Progreso... | halt }
    else {
      sockClose xerank
      sockOpen xerank xe.vrocker-hosting.co.uk 80
      set %xetchan $chan
    }
  }
  if (%cmd == !wonline) {
    if (%rzchan) { .notice $nick Error - En Progreso.. | halt }
    sockClose rz
    sockOpen rz rz-clan.co.cc 80
    set %rzchan $chan
  }

  if (%cmd == !horoscopo) {
    if (%bot_state == off) { halt }
    if (!$2) { .notice $nick Error - $1 acuario/piscis/aries/tauro/geminis/cancer/leo/virgo/libra/escorpio/sagitario/capricornio | halt }
    if ($2 !isin acuario piscis aries tauro geminis cancer leo virgo libra escorpio sagitario capricornio) { .notice $nick Error - $2 No Es Valido! }
    else if (%hchan != $null) { .notice $nick $1 En Progreso... | halt }
    else {
      sockClose horoscopo
      sockOpen horoscopo elhoroscopodehoy.com 80
      msg $chan >>3 $nick - $2
      msg $chan 6Cargando...
      set %hchan $chan
      set %s $2
    }
  }

  if (%cmd == !traduce) || (%cmd == !traslate) {
    if (%bot_state == off) { halt }
    if ($2 !isin sp en) { .notice $nick Error $2 no es Correcto $1 sp o $1 en | halt }
    if (!$3-) { .notice $nick Error - $1 sp-en Texto a Traducir | halt }
    if (%t) { .notice $nick Error - En Progreso... | halt }
    if ($3-) { set %tlent $len($3-) | if (%tlent > 264) { .notice $nick Error - Texto Demaciado Grante!! | unset %tlent | halt } }
    msg $chan 6>Cargando...
    sockClose traduce
    sockOpen traduce spanish.dictionary.com 80
    set %t $replace($3-,$chr(32),+,$chr(35), ,$chr(36), ,$chr(40), ,$chr(41), ) | set %tchan $chan | set %idm $2
  }

  if ($1- == $me :D) {
    if (%bot_state == off) { halt }

    if ($nick == NT5) { msg $chan $nick $2 $+ !!! }
  }
  if ($1 == !len) {
    if (!$2) { .notice $nick Error - $1 Palabra | halt }
    if ($2 != $null) {

      msg $chan >>5 $+ $2- Tiene $len($2-) Caracteres.
    }
  }

  if (%cmd == !ppt) {
    if (!$2) { .notice $nick Error - %cmd papel/piedra/tigera | .halt }
    if ($2 != $null) {
      var %ppt = $rand(1,7) 
      if (%ppt = 1) var %1 piedra
      if (%ppt = 2) var %1 papel
      if (%ppt = 3) var %1 tigera
      if (%ppt = 4) var %1 piedra
      if (%ppt = 5) var %1 papel
      if (%ppt = 7) var %1 tigera
      set %ppt- $+ %1 on
      if ($2 == piedra) {
        if (%ppt-piedra != on) { msg # 5>Papel Cubre Piedra, Gano Yo. | unset %ppt-piedra | .halt }
        msg # >3Piedra Rompe Tigeras Ganas Tu.
        unset %ppt-piedra
      }
      else if ($2 == papel) {
        if (%ppt-papel != on) { msg # >5Tigeras Cortan Papel Gano Yo. | unset %ppt-papel | .halt }
        msg # >3Papel Cubre Piedra, Ganas Tu.
        unset %ppt-papel
      }
      else if ($2 == tigera) {
        if (%ppt-tigera != on) { msg # 5>Piedra Rompe Tigeras Gano Yo. | unset %ppt-tigera | .halt }
        msg # >3Tigera Corta Papel Ganas Tu.
        unset %ppt-tigera
      }
      else { .notice $nick $1 $2 $+ ?  Error - $1 papel/piedra/tigera | unset %ppt* }
    }
  }
  if (%cmd == !comandos) || (%cmd == !commands) || (%cmd == !cmds) {
    if (%bot_state == off) { halt }
    .notice $nick 4** 7Comandos:5 !botinfo !google !youtube !galleta !horoscopo !xestats !traduce !texto !addtexto !lineas !borrartexto !randon/!rand
    .notice $nick !web !fecha !joins !invitar !ausente/!away !back/!volvi !afk/!ausentes !calc !server !juegos/!games
  }
  if (%cmd == !juegos) || (%cmd == !games) {
    if (%bot_state == off) { halt }
    else {   
      .notice $nick 6Juegos DisPonibles>>10 $+ $1 $+ => !vs/!figth,  !bola8/!8ball , !iq !bomba/!boom, !boomscore, 
      .notice $nick !disparo, !ppt !num, !cd !num
    }
  }
  if (%cmd == !cmd) {
    if (%bot_state == off) { halt }
    if ($2 == bot) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        .notice $nick 4>> 7Comandos:5 !reconectar !reco !conectar !acbot !botinfo !desconectar !salir !r-contador !nick-b !script on/off
      }
    }
    if ($2 == admin) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        .notice $nick >> Comandos de Admin: !info !notice !cerrar-chan/!lock !abrir-chan/!unlock
        .notice $nick  !tban/!tempban !ln !qln !add-user !del-user !sacar/!kick !kickall !cmd-bot !voz !qvoz !mudo/!mute !mod/!qmod !qop/!op
        .notice $nick  !half/!dehaf !aop/!deaop !qsuspender/!unban  !suspender/!ban
      }
    }
  }
  if (%cmd == !botinfo) || (%cmd == !bot) {
    msg $chan 7 $+ $me 3V3.4 14Creado Por 12NT5 3Network:6[ $+ $network  $+ ] 2m7IR8C1:10[ $+ $version $+ ]6Script Status:5 $+ %bot_state
    msg $chan 10 $+ $lines($script(mIRC_v3.4[NT5].ini)) Lineas.  6Tiempo Conectado:5 $uptime(server,2) 14Conectado a $comchan($me,0) Canales
  }

  if (%cmd == !server) {
    if (%bot_state == off) { halt }
    msg $chan **10Server Name: $+ 3[NT5]..::$$War and Blood$$::..[R2]
    msg $chan **10IP:3 $ip $+ :5192
  }
  if (%cmd == !calc) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick - Calc - Error - Ej: $1 $rand(1,9) $+ + $+ $rand(1,9) }
    if ($2 != $null) {
      if ($2- isletter) { .notice $nick - Calc - Error | .halt }
      set -u3 %total $replace($2-,x,*)
      set -u3 %total $calc(%total)
      msg $chan 5Resultados: $2- = %total
    }
  }
  if (%cmd == !google) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick Error - !google Bot mIRC }
    if ($2 != $null) {
      var %x = 1
      while ($sock($+(google,%x))) inc %x
      sockopen $+(google,%x) www.google.com 80
      sockmark $+(google,%x) $1-
    }
  }
  if (%cmd == !cd) {
    if (%bot_state == off) { halt }
    if (%cd == on) .notice $nick ** 3Countdown ya esta en Progreso.
    else {
      set %cd on
      .timer 1 1 msg $chan 10------ 4 ------
      .timer 1 2 msg $chan 10------ 3 ------
      .timer 1 3 msg $chan 10------ 2 ------
      .timer 1 4 msg $chan 10------ 1 ------
      .timer 1 5 msg $chan 10- Go, Go, Go! -
      .timer 1 6 set %cd off
    }
  }
  if (%cmd == !scan) {
    if (%bot_state == off) { halt }
    else {   
      msg $chan    4  $nick enciende el 0,3 detector  "Que detecta?"  15,15.14,14.0,7 * B.O. DETECT * 14,14.15,15.
      mag $chan    0,1 :::14[]4°1,0----o  12BIP BIP BIP 
      msg $chan    3 $nick lo apunta hacia el canal # ... y comienza a detectar... 
      .timer 1 3 msg $chan 3Scanning..... 0,1 :::14[]4°1,0----o0,0 7)))
      .timer 1 6 msg $chan 3Scanning..... 0,1 :::14[]4°1,0----o0,0 7)))4))))
      .timer 1 9 msg $chan 3Blanco localizado!!..... 
      .timer 1 12 msg $chan 8,1D1,8A8,1N1,8G8,1E1,8R 15,15.14,14.9,1 $3 14,14.15,15.8,1D1,8A8,1N1,8G8,1E1,8R  
    }
  }

  if (%cmd == !bomba) || (%cmd == !boom) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { msg $msg $chan >>7Error - Forma Correcta5 $1 6[Nick]. }
    if ($2 != $null) {
      if ( $2 == $me ) { .notice $nick Error - No Le Puedes Poner Una Bomba a $me $+ !! | .halt }
      if ($2 == $nick) { .notice $nick Error - No Te Puedes Poner Una Bomba A ti Mismo $+ !! | .halt }
      if (%bom == on) { msg $chan >>4La Bomba Ya Esta Activa en14 %bom.nick 10 %bom.chan | .halt }
      if ( $2 ison $chan ) {
        .timer.bom_5 1 55 .notice $2 4 Te Quedan Menos De 5 Segundos..
        .timer.bom_4 1 30 .notice $2 4 Te Quedan Menos De 20 Segundos..
        .timer.bom_3 1 57 msg $chan 4--- 3 ---
        .timer.bom_2 1 58 msg $chan 4--- 2 ---
        .timer.bom_1 1 59 msg $chan 4--- 1 ---
        .timer.bom_6 1 60 msg $chan 4BOOM!!
        .timer.bom 1 61 kick $chan $2 ~~!!!¡¡BOOM!!¡¡~~ As Fallado - Tiempo Agotado! 
        .timer.bom_0 1 60 set %bom off 
        .timer.bom_7 1 60 inc %lost.bom. [ $+ [ $2 ] ]
        set %bom on
        set %score.bom [ $+ [ $2 ] ] on
        set -u60 %bom.sta. [ $+ [ $2 ] ] on
        set -u60 %bom.chan $chan
        set -u60 %bom.nick $2
        set %cable-r off
        set %cable-v off
        set %cable-a off
        var %bom = $rand(1,7) 
        if (%bom = 1) var %1 r
        if (%bom = 2) var %1 a 
        if (%bom = 3) var %1 v
        if (%bom = 4) var %1 a
        if (%bom = 5) var %1 r
        if (%bom = 7) var %1 v
        set %cable- $+ %1 on
        msg $chan 1,8 P 8,1 E 1,8 L 8,1 I 1,8 G 8,1 R 1,8 O 0,4 $2 1,8 P 8,1 E 1,8 L 8,1 I 1,8 G 8,1 R 1,8 O 
        msg $chan 3Ho..No!!! 10 $nick 3A Puesto una Bomba a4 $2 $+ 3!!! 
        msg $chan 4 $+ $2 10Tiene Menos De4 1 Minuto Para Desactivarla!!
        msg $chan 12Rapido!! 4!cable rojo 1- 12!cable azul 1- 3!cable verde
        halt
      }
      if ($nick != ison $chan) { .notice $nick Error - $2 No Esta En $chan $+ !! }
    }
  }

  if (%cmd == !cable) {
    if (%bot_state == off) { .halt }
    if ($2 == $null) { .notice $nick Error - !cable rojo !cable verde !cable azul | .halt }
    else if ($2 == rojo) {
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }        
        if (%cable-r == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!   
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
        if (%cable-r == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          .timer 1 1 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else if ($2 == azul) {
      if ( %bom.nick. [ $+ [ $nick ] ] == off ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
        if (%cable-a == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!  
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt 
        }
        if (%cable-a == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          timer 1 1 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else if ($2 == verde) {
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
        if (%cable-v == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!  
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off   
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt 
        }
        if (%cable-v == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          .timer 1 2 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else .notice $nick $1- $+ ? 4Error - Cable Erroneo!
  }
  if (%cmd == !boomscore) {
    if ($2 == $me) { .halt }
    if ($2 == $null) {
      if (%bot_state == off) { halt }
      if (%score.bom [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 0 | halt }
      if (%winds.bom. [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 %lost.bom. [ $+ [ $nick ] ]  | halt }
      if (%lost.bom. [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $nick ] ] 5Perdidas:10 0 | halt }
      msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $nick ] ] 5Perdidas:10 %lost.bom. [ $+ [ $nick ] ]
    }
    if ($2 != $null) {
      if ( $2 ison $chan ) {
        if (%score.bom [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 0 | halt }
        if (%winds.bom. [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 %lost.bom. [ $+ [ $2 ] ]  | halt }
        if (%lost.bom. [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $2 ] ] 5Perdidas:10 0 | halt }
        msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $2 ] ] 5Perdidas:10 %lost.bom. [ $+ [ $2 ] ]
      }
    }
  }
  if (%cmd == !disparo) || (%cmd == !shot) {
    if (%bot_state == off) { halt }
    set %ruleta off
    var %ruleta = $rand(1,4)
    if (%ruleta = 1) var %1 on    
    if (%ruleta = 2) var %1 off              
    if (%ruleta = 3) var %1 on
    if (%ruleta = 4) var %1 off        
    set %ruleta %1
    if (%ruleta == on) { 
      msg $chan 8,4BOOOOOOOM!! 2Tus sesos volaron
      .timer 1 2 kick $chan $nick 8,4BOOOOOOOM!! 2Tus sesos volaron
    }
    if (%ruleta == off) { msg # 2 [*** CLICK ***]  3UFFF por poko te has librado 1 $nick }
  }

  if (%cmd == !num) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { 
      set %juego.adivina on
      msg $chan 4El juego 2ADIVINA el NÜMERO 3está activado 6para probar suerte pon !num Nº (ej: !num $rand(0,100) ) 12 está entre el 0 y el 100 
      set %num.adi $rand(1,100)
    }
    if ($2 != $null) {
      if ( %juego.adivina == off ) { msg $chan 4El Juego Esta Desactivado! }
      else { 
        if ( %juego.adivina == on ) { 
          if ( $2 == %num.adi ) {
            msg $chan  6Muy bien 1 $+ $nick $+  6has acertatado, el número era4 %num.adi 
            set %juego.adivina off
            unset %num.adi  
          }
        }
        if ( $2  < %num.adi ) { .notice $nick 2Más alto }
        if ( $2  > %num.adi ) { .notice $nick 2Más bajo }
        if ( $2  > 100 ) { .notice $nick 2Está entre el 0 y el 100, asique $2 no vale }
      }
    }
  }

  if (%cmd == !vs) || (%cmd == !fight) {
    if (%bot_state == off) { .halt }
    if ($2 == $null) {   msg $chan 1**4 **4Error: 12Forma Correcta:7 $1 [Nick.] }
    if ($2 != $null) {
      if ( $2 ison $chan ) {
        if (%dm == on) .notice $nick **10Pelea En Proseso...
        else {
          set %dm on
          msg $chan >>12[ $+ Pelea Entre $nick , $2 $+ ]
          msg $chan >>12[ $+ El Ganador Seria... $+ ]
          msg $chan >>10[ $+ Peleando... $+ ]
          var %dm = $rand(1,7) 
          if (%dm = 1) var %1 $2 
          if (%dm = 2) var %1 Empate!
          if (%dm = 3) var %1 $nick
          if (%dm = 4) var %1 Empate!
          if (%dm = 5) var %1 $2
          if (%dm = 6) var %1 Empate!
          if (%dm = 7) var %1 $nick
          .timer 1 3 msg $chan **4GANADOR=> $+ %1
          .timer 1 3 set %dm off
        }
      } 
    }
  }

  if (%cmd == !bola8) || (%cmd == !8ball) {
    if (%bot_state == off) { halt }
    else {      
      if ($2 == $null) { msg $chan 1**4 **4Error: 12Forma Correcta:7 $1 [Pregunta]. }
      if ($2 != $null) { 
        if (%8ball == on) .notice $nick **12Espera Mientras Se Reajustan Las Respuestas...4=>10 $1.
        else {
          set %8ball on
          msg $chan >>4[10Pregunta=> 12 $2- $+ 4]
          msg $chan >>3[12Cargando.....3]
          var %8ball = $rand(1,22) 
          if (%8ball = 1) var %1 Claro!                                                 | if (%8ball = 12) var %1 jaja Estas Loco?.. Claro que Si!
          if (%8ball = 2) var %1 No Lo Creo.                                      | if (%8ball = 13) var %1 Un 50% que Si..
          if (%8ball = 3) var %1 hmm... Quisas...                                | if (%8ball = 14) var %1 No Se, No Soy Adivino :/
          if (%8ball = 4) var %1 Definitivamente NO!                      | if (%8ball = 15) var %1Tu que Crees...
          if (%8ball = 5) var %1 Definitivamente SI!                         | if (%8ball = 16) var %1 eh???!! >_< que Pregunta Mas Rara 
          if (%8ball = 6) var %1 jaja Estas Loco?.. Claro que NO!  | if (%8ball = 17) var %1 Ni Que Llegue el Apocalipsis
          if (%8ball = 7) var %1 No Puedo Contestar Eso                | if (%8ball = 18) var %1 El Mundo Se Acaba Y Seguirando Ciendo No!
          if (%8ball = 8) var %1 Me Repites La Pregunta?              | if (%8ball = 19) var %1 Pero Claro Que Porsupuesto Que Desde Luego Que SI!!
          if (%8ball = 9) var %1 No.                                                     | if (%8ball = 20) var %1 Me Repites Eso??
          if (%8ball = 10) var %1 Si.                                                     | if (%8ball = 21) var %1 em... No Puedo Responderte Eso..
          if (%8ball = 11) var %1Posiblemente...                               | if (%8ball = 22) var %1 Jamas!
          if (%1 == $null) {
            var %8ball = $rand(1,22) 
            if (%8ball = 1) var %1 Claro!                                                 | if (%8ball = 12) var %1 jaja Estas Loco?.. Claro que Si!
            if (%8ball = 2) var %1 No Lo Creo.                                      | if (%8ball = 13) var %1 Un 50% que Si..
            if (%8ball = 3) var %1 hmm... Quisas...                                | if (%8ball = 14) var %1 No Se, No Soy Adivino :/
            if (%8ball = 4) var %1 Definitivamente NO!                      | if (%8ball = 15) var %1Tu que Crees...
            if (%8ball = 5) var %1 Definitivamente SI!                         | if (%8ball = 16) var %1 eh???!! >_< que Pregunta Mas Rara 
            if (%8ball = 6) var %1 jaja Estas Loco?.. Claro que NO!  | if (%8ball = 17) var %1 Ni Que Llegue el Apocalipsis
            if (%8ball = 7) var %1 No Puedo Contestar Eso                | if (%8ball = 18) var %1 El Mundo Se Acaba Y Seguirando Ciendo No!
            if (%8ball = 8) var %1 Me Repites La Pregunta?              | if (%8ball = 19) var %1 Pero Claro Que Porsupuesto Que Desde Luego Que SI!!
            if (%8ball = 9) var %1 No.                                                     | if (%8ball = 20) var %1 Me Repites Eso??
            if (%8ball = 10) var %1 Si.                                                     | if (%8ball = 21) var %1 em... No Puedo Responderte Eso..
            if (%8ball = 11) var %1Posiblemente...                               | if (%8ball = 22) var %1 Jamas!
            .timer 1 5 msg $chan >>13[3Respuesta=> 6 $+ %1 $+ 13]
            .timer 1 6 set %8ball off
          }
          else {
            .timer 1 5 msg $chan >>13[3Respuesta=> 6 $+ %1 $+ 13]
            .timer 1 6 set %8ball off
          }
        }
      }
    }
  }

  if (%cmd == !iq) {
    if (%bot_state == off) { halt }
    var %iq = $rand(1,16) 
    if (%iq = 1) var %1 1,14/2
    if (%iq = 2) var %1 1,14//2
    if (%iq = 3) var %1 1,14///2
    if (%iq = 4) var %1 1,14////2
    if (%iq = 5) var %1 1,14/////2
    if (%iq = 6) var %1 1,14//////2
    if (%iq = 7) var %1 1,14///////2
    if (%iq = 8) var %1 1,14////////2
    if (%iq = 9) var %1 1,14/////////2
    if (%iq = 10) var %1 1,14//////////2
    if (%iq = 11) var %1 1,14///////////2
    if (%iq = 12) var %1 1,14////////////2
    if (%iq = 13) var %1 1,14/////////////2
    if (%iq = 14) var %1 1,14//////////////2
    if (%iq = 15) var %1 1,14////////////////2
    if (%iq = 16) var %1 1,14//////////////////2
    .timer 1 1  msg $chan >>2[12Cargando.....2]    
    if ($2 == $null) { .timer 1 5 msg $chan >>12[3 $+ $nick IQ=>1,2[6 $+ %1 $+ 1,2]
      msg $chan >>4[10IQ=>12 $+ $nick $+ 4]
    }
    if ($2 != $null) { .timer 1 5 msg $chan >>4[3 $+ $2- IQ=>1,2[6 $+ %1 $+ 1,2] 
      msg $chan >>4[10IQ=>12 $+ $2- $+ 4]
    }
  }

  if (%cmd == !ausente) || (%cmd == !away) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick 4Error - Escrive una Razon | halt }
    if ($2 != $null) { 
      var %away.razon = %away.razon. [ $+ [ $nick ] $+ ]
      var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick ] ] ),1)
      if (%away. [ $+ [ $nick ] ] == on) { 
        .notice $nick As Cabiado Tu Razon De Away! ( $+ %away.razon $+ )
        msg $chan 2 $nick 5is Back from 6"14 %away.razon 6" 10Time: %away.time
        msg $chan 3 $nick 10is Away Razon: $2-
        set %away.razon. [ $+ [ $nick ] ] $2-
        set %away.time. [ $+ [ $nick ] ] $ctime
        .halt
      }
      set %away. [ $+ [ $nick ] ] on
      set %away.razon. [ $+ [ $nick ] ] $2-
      set %away.time. [ $+ [ $nick ] ] $ctime
      msg $chan 1**4 $nick 6is Away, Razon:12 $2-
    }
  }
  if (%cmd == !ausentes) || (%cmd == !afk) { 
    if (%bot_state == off) { halt }
    set %totalnikc $nick(#,0)
    set %b 1
    while (%totalnikc >= %b) {
      if ( %away. [ $+ [ $nick(#,%b) ] ] == on) { inc %away.cont }
      inc %b
    }
    if ( %away.cont == $null ) { msg $chan 10No Hay Personas Ausentes! | unset %b | unset %totalnikc | halt }
    set %totalnikc $nick(#,0)
    set %b 1
    msg $chan 4[10Count4]6 %away.cont de $nick(#,0) Usuarios - $chan
    while (%totalnikc >= %b) {
      if ( %away. [ $+ [ $nick(#,%b) ] ] ) {
        var %away.razon = %away.razon. [ $+ [ $nick(#,%b) ] ]
        var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick(#,%b) ] ] ),1)
        msg $chan 5>> $nick(#,%b) - Razon - %away.razon - Tiempo - %away.time
      }
      inc %b
    }
    unset %b
    unset %totalnikc
    set %away.cont
  }
  if (%cmd == !back) || (%cmd == !volvi) {   
    if (%bot_state == off) { halt }
    if (%away. [ $+ [ $nick ] ] == $null) { .notice $nick - No Estas Ausente. | .halt }
    var %away.razon = %away.razon. [ $+ [ $nick ] ]
    var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick ] ] ),1)
    msg $chan 1**4 $nick 14is Back from: " $+ 3 %away.razon 14" Time: %away.time
    unset %away. [ $+ [ $nick ] ]
    unset %away.razon. [ $+ [ $nick ] ]
    unset %away.time. [ $+ [ $nick ] ]
  }
  if ($1 == !reglas) || (%cmd == !rules) {
    if (%bot_state == off) { halt }
    msg $chan **/!\4-No Insultos 11-No Jodas -.- 12-No Agas Spam 3No Abuses 3De las MAYUSCULAS 7- Pasala Bien ;)
  }

  if (%cmd == !joins) {
    if (%bot_state == off) { halt } 
    if ($2 == $null) {
      msg $chan 4>>10Joins en $chan $+ => $+ %contar.chan. [ $+ [ $chan ] ]
    }
    if ($2 != $null) { 
      msg $chan 4>>10Joins en $2 $+ => $+ %contar.chan. [ $+ [ $2 ] ]
    }
  }

  if (%cmd == !web) {
    if (%bot_state == off) { halt }
    msg $chan 4**3Web:14http://www.GuiaPC.TK/
  }

  if (%cmd == !users) {
    if (%bot_state == off) { halt }
    .notice $nick **12 Users:( $+ $nick( #,0 ) $+ )
    .notice $nick **10 Operators:( $+ $nick(#,0,o) $+ )
    .notice $nick **3 Voices:( $+ $nick(#,0,v) $+ )
    .notice $nick ** 14Regular:( $+ $nick(#,0,r) $+ ) 
  }

  if (%cmd == !fecha) {
    if (%bot_state == off) { halt }
    msg $chan 10Hoy es5 $replace($day,Monday,Lunes,Tuesday,Martes,Wednesday,Miercoles,Thursday,Jueves,Friday,Viernes,Saturday,Sabado,Sunday,Domingo) $gettok($date,1,47) 6del mes:5  $replace($gettok($date,2,47),01,Enero,02,Febrero,03,Marzo,04,Abril,05,Mayo,06,Junio,07,Julio,08,Agosto,09,Septiembre,10,Octubre,11,Noviembre,12,Diciembre) 6del año:5 $gettok($date,3,47)
  }

  if (%cmd == !info) || ($1 == !whois) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 $1 [Nick] }
    if ($2 != $null ) {
      if (%Whois.antispam != $null) { .halt }
      else { 
        set -u5 %Whois.antispam activated
        set -u5 %chan $nick
        whois $2
      }
    }
  }

  if (%cmd == !addtexto) || (%cmd == !addquote) {
    if (%bot_state == off) { halt }
    write Quote.txt 14" $+ $$2- $+ "
    if (%quote != $null) {
      .notice $nick 2>>7 Quote ( $+ $lines(Quote.txt.) $+ ) $$2-
      inc %quote 1
    }
    if (%quote == $null) {
      set %quote 1
      msg # 11A Sido Agregado al Archivo de Texto %quote $+ .
    }
  }

  if (%cmd == !randon) || (%cmd == !rand) {
    if (%bot_state == off) { halt }
    play -r # quote.txt 
  }

  if (%cmd == !texto) || (%cmd == !quote) {
    if (%bot_state == off) { halt }
    msg # **7 Quote (  $+ $2 $+  /  $+ $lines(Quote.txt) $+  )14 $read(Quote.txt, $2-  )
  }

  if (%cmd == !lineas) || (%cmd == !lines) {
    if (%bot_state == off) { halt }
    msg $chan 2>>7 $lines(Quote.txt)l Lineas en el Archivo De Texto
  }

  ;------------------ IRC Channel Commands ------------------------

  if (%cmd == !adduser) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { .notice $nick 4Error: 10Forma Correcta:7 $1 [Nick] | halt }
      if ($2 != $null) {
        if ($2 ison $chan) {
          if (%nivel. [ $+ [ $2 ] ] == 10) { .notice $nick Error - $2 Ya Esta En La Lista De User´s | halt }
          set %nivel. [ $+ [ $2 ] ] 10
          msg $chan 1** 4 $2 14A Sido Agragado a la lista de 4Users De $me
        }
      }
      if ($2 !ison $chan) { .notice $nick Error - $2 No Esta En $chan }
    }
  }

  if (%cmd == !deluser) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { .notice $nick 4Error: 10Forma Correcta:14 $1[Nick] | halt }
      if ($2 != $null) {    
        if ($2 ison $chan) {
          if (%nivel. [ $+ [ $2 ] ] == $null) { .notice $nick Error - $2 No Esta En La Lista De User´s | halt }
          unset %nivel. [ $+ [ $2 ] ]
          msg $chan 4 $+ $2 14A Sido Removido de la lista de 4Users De $me
        }
      }
      if ($2 !ison $chan) { .notice $nick Error - $2 No Esta En $chan }
    }
  }

  if (%cmd == !suspender) || (%cmd == !ban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Forma Correcta:14 $1 [Nombre] [Razon]. }
      if ($2 != $null) { 
        if ( $$2 == $me ) { .notice $nick Error - No Puedes dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          ban $chan $$2 
          kick $chan $$2 4Suspendido.
        }
      }
    }
  }

  if (%cmd == !qsuspender) || ($1 == !unban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Forma Correcta:14 $1 [Nombre] }
      if ($2 != $null) {
        mode # -b $2 
        invite $2 $chan 
      }
    }
  }

  if (%cmd == !sacar) || (%cmd == !kick) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error Forma Correcta:7 $1 [Nick]. }
      if ($2 != $null) {
        if ( $$2 == $me ) { .notice $nick Error - No Puedes Dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          kick $chan $$2 $nick
        }
      }
    }
  }

  if (%cmd == !kickall) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      unset %total
      set -u30 %count.nick 0
      set -u30 %total $nick(#,0)
      :start
      inc %count.nick
      if (%count.nick > %total) { halt }
      if ($nick(#,%count.nick) == $me) { goto start } 
      else { kick # $nick(#,%count.nick) Todos An Sido Sacados. | goto start }
    }
  }
  if (%cmd == !voiceall) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      unset %total
      set -u30 %count.nick 0
      set -u30 %total $nick(#,0)
      :start
      inc %count.nick
      if (%count.nick > %total) { halt }
      if ($nick(#,%count.nick) == $me) { goto start } 
      else { mode # +v $nick(#,%count.nick) | goto start }
    }
  }


  if (%cmd == !tban) || (%cmd == !tempban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta7 $1 [Nick] [Tiempo]. }
      if ($2 != $null) {
        if ( $$2 == $me ) { .notice $nick Error - No Puedes Dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          msg $chan 1 >>2 $+ Ban10 $$2 - 14Duracion: $$3 - 14Segundos 
          mode # +b $$2 
          kick # $$2 4Baneado Temporalmente 
          .timer 1 $$3- /msg $chan ** 4 $$2 7Baneo Expirado 
          .timer 1 $$3- /mode # -b $$2  
          .timer 1 $$3- .msg $$2 >>4Baneo Temporal Expirado Entra a7 $chan
        }
      }
    }
  }

  if (%cmd == !mod) || (%cmd == !mode) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }    
      if ($2 != $null) {
        mode $chan +h $$2
      }
    }
  }

  if (%cmd == !qmode) || (%cmd == !qmod)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }
      if ($2 != $null) {
        mode $chan -h $$2
      }
    }
  }

  if (%cmd == !half)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }    
      if ($2 != $null) {
        if ( $2 ison $chan ) {
          mode $chan +h $2
          set %mod. [ $+ [ $chan ] ] [ $+ [ $2 ] ] on
        }
      }
    }
  }

  if (%cmd == !dehalf)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }
      if ($2 != $null) {
        mode $chan -h $2
        unset %mod. [ $+ [ $chan ] ] [ $+ [ $2 ] ]
      }
    }
  }

  if (%cmd == !op) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 !op [Nick] }
      if ($2 != $null) {
        mode $chan +o $$2
      }
    }
  }

  if (%cmd == !qop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7!qop [Nick] }
      if ($2 != $null) {
        mode $chan -o $$2
      }
    }
  }

  if (%cmd == !aop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 !op [Nick] }
      if ($2 != $null) {
        if ( $2 ison $chan ) {
          mode $chan +o $2
          set %op. [ $+ [ $chan ] ] [ $+ [ $2 ] ] on
        }
      }
    }
  }

  if (%cmd == !deaop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7!qop [Nick] }
      if ($2 != $null) {
        mode $chan -o $2
        unset %op. [ $+ [ $chan ] ] [ $+ [ $2 ] ]
      }
    }
  }

  if (%cmd == !voz) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 !voz [Nick] }
      if ($2 != $null) {    
        mode $chan +v $2
      }
    }
  }

  if (%cmd == !qvoz) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 !qvoz [Nick] }
      if ($2 != $null) { 
        mode $chan -v $2 
      }
    }
  }

  if (%cmd == !mudo) || (%cmd == !mute) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Correcta Forma:14 $1 [on/off] }
      if ($2 == off) {
        if (%mute. [ $+ [ $chan ] ] == $null) msg $chan **12El Chanel Ya Tiene el Mute Apagado.
        else {
          unset %mute. [ $+ [ $chan ] ]
          mode $chan -m
        }
      }
      if ($2 == on) {
        if (%mute. [ $+ [ $chan ] ] == on) msg $chan **12El Chanel Ya Esta en Mute.
        else {
          set %mute. [ $+ [ $chan ] ] on
          mode $chan +m 
        }
      }
    }
  }

  if (%cmd == !reconectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%reconect == on) msg $chan **12Bot En Proseso De Desconeccion.
      else {
        set %reconect on
        msg $chan 4**14Desconectando Bot...  
        .timer 1 8 set %reconect off | timer 1 8 server liberty-unleashed.co.uk
      }
    }
  }

  if (%cmd == !reco) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan 4**14Desconectando Bot... |  /hop $chan
    }
  }

  if (%cmd == !nick-b) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: $1 [Nick]. } 
      if ($2 != $null) { 
        if (%bot_p == on) notice $nick **12Espera 10 segundos...
        else {
          .notice $nick As Cambiado El nombre al Bot Por $2
          set %bot_p on
          nick $2
          timer 1 10 set %bot_p off
        }
      }
    }
  }

  if (%cmd == !conectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: $1 [Nombre Del Chanel]. }  
      if ($2 != $null) {
        if (%join_2 == on) .notice $nick **12Espera 10 segundos antes Del Proccimo Join.
        else {
          set %join_2 on
          .timer 1 10 set %join_2 off
          msg $chan 4**14Conectando Bot al Chanel10 $+ $$2...
          join #$$2
        }
      }
    }
  }

  if (%cmd == !script) {
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Correcta Forma:14 $1 [on/off] }
      if ($2 == off) {
        if (%bot_state == off) msg $chan **12 $me Ya Esta Apagado.
        else {
          msg $chan 4**4/!\ $me Apagado. 
          set %bot_state OFF
          .timer* off
        }
      }
      if ($2 == on) {
        if (%bot_state == on) msg $chan **12 $me Ya Esta En Funcionamiento.
        else {
          msg $chan 4**14/!\ $me En Funcionamiento!! 
          set %bot_state ON
        }
      }
    }
  }

  if (%cmd == !autod) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan ** $me *4Auto Destrucion Activada!!
      .timer 1 2 msg $chan 10Destruccion en 5 Segundos..
      .timer 1 4 msg $chan 10 --  3 --
      .timer 1 5 msg $chan 10 -- 2 --
      .timer 1 6 msg $chan 10 -- 1 --
      .timer 1 7 msg $chan 6 Hasta La Vista $nick ;)
      .timer 1 9 msg $chan 6 PD: Volvere...
      .timer 1 10 part # 4DIED!
    }
  }

  if (%cmd == !desconectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: !desconectar [Nombre Del Chanel]. }  
      if ($2 != $null) {
        msg $chan 4**14Bot Desconectado del Chanel 4 $2. 
        .timer 1 2 part #$2
      }
    }
  }

  if (%cmd == !salir) || (%cmd == !exit) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan 4**14/!\ $+ %bot_name Desconectado del Chanel. 
      part $chan
    }
  }

  if (%cmd == !acbot) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      pass
      msg $chan **10Bot Reconosido.
    }
  }

  if (%cmd == !r-contador) || (%cmd == !r.contador) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      set %contar.chan. [ $+ [ $chan ] ] 0
      msg $chan **4Contador Reiniciado.
    }
  }
  if (%cmd == !invitar) || (%cmd == !invite) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan  **4Error: 12Forma Correcta:7 !invitar [Nick] }
      if ($2 != $null) {
        if (%invt == on) .notice $nick **12Espera unos Segundos...
        else {
          set %invt on
          .timer 1 20 set %invt off
          invite $$2 $chan
        }
      }
    }
  }

  if (%cmd == !notice) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan **4Error:12Forma Correcta:13!notice [Mesaje] }
      if ($2 != $null) {
        amsg 10Noticia Embiada Por 12 $nick => 12 $chan $+ :13 $2-
      }
    }
  }

  if (%cmd == !borrartexto) || (%cmd == !delquote) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 2,0Sorry $nick you need to add a number between 1 and $lines(quote.txt) }
      if ($2 != $null) {
        write -dl $+ $2 quote.txt
        msg $chan **10 Mensaje $2 10Ha sido Removido
      }
    }
  }

  if (%cmd == !ln) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 4Error: Forma Correcta 7!ln [Nick]. }
      if ($2 != $null) {
        if ( $2 == $me ) { .notice $nick Error - No Le Puedes dar $1 a $me | halt }
        if ( $2 ison $chan ) {
          if (%ln == on) .notice $nick **12Espera Unos Segundos, 4Abusas del Comando.
          else {
            set %ln on
            .timer 1 20 set %ln off
            .notice $nick **4/!\ $2 7ha sido agregado a la Lista Negra. 
            auser ln $2 
            .timer 1 3  kick $chan $2 4/!\Lista Negra/!\ 
          }
        }
      }
    }
  }

  if (%cmd == !qln) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 4Error: Forma Correcta 7!qln [Nick]. }
      if ($2 != $null) {
        if ( $2 == $me ) { .notice $nick Error - No Le Puedes dar $1 a $me | halt }
        if ( $2 ison $chan ) {
          if (%qln == on) .notice $nick **12Espera Unos Segundos, 4Abusas del Comando.
          else {
            msg $chan ** $2 12ha sido Removido de la Lista Negra. 
            set %qln on
            .timer 1 20 set %qln off
            ruser ln $2
            invite $2 $chan
          }
        }
      }
    }
  }

  if (%cmd == !abrir-chan) || (%cmd == !unlock) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%lock. [ $+ [ $chan ] ] == $null) msg $chan **12El Chanel No Tiene Ninguna Pass.
      else {
        unset %lock. [ $+ [ $chan ] ]
        msg $chan >>3Chanel Abierto.
        mode $chan -k 0
      }
    }
  }

  if (%cmd == !cerrar-chan) || (%cmd == !lock) {
    if (%bot_state == off) { halt }
    if ($2 == $null) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        if (%lock. [ $+ [ $chan ] ] == on) msg $chan **12El Chan Ya Esta Cerrado.
        else {
          set %lock. [ $+ [ $chan ] ] on
          msg $chan >>12Buscando Contraseña para el chanel...
          var %lock = $rand(1,9) | var %lock_2 = $rand(1,9) | var %lock_3 = $rand(1,9) | var %lock_4 = $rand(1,9) | var %lock_5 = $rand(1,9) | var %lock_6 = $rand(1,9)
          if (%lock = 1) var %1 1 | if (%lock_2 = 1) var %2 1 | if (%lock_3 = 1) var %3 1 | if (%lock_4 = 1) var %4 1 | if (%lock_5 = 1) var %5 1 | if (%lock_6 = 1) var %6 1
          if (%lock = 2) var %1 2 | if (%lock_2 = 2) var %2 2 | if (%lock_3 = 2) var %3 2 | if (%lock_4 = 2) var %4 2 | if (%lock_5 = 2) var %5 2 | if (%lock_6 = 2) var %6 2
          if (%lock = 3) var %1 3 | if (%lock_2 = 3) var %2  3 | if (%lock_3 = 3) var %3 3 | if (%lock_4 = 3) var %4 3 | if (%lock_5 = 3) var %5 3 | if (%lock_6 = 3) var %6 3
          if (%lock = 4) var %1 4 | if (%lock_2 = 4) var %2  4 | if (%lock_3 = 4) var %3 4 | if (%lock_4 = 4) var %4 4 | if (%lock_5 = 4) var %5 4 | if (%lock_6 = 4) var %6 4
          if (%lock = 5) var %1 5 | if (%lock_2 = 5) var %2 5 | if (%lock_3 = 5) var %3 5 | if (%lock_4 = 5) var %4 5 | if (%lock_5 = 5) var %5 5 | if (%lock_6 = 5) var %6 5
          if (%lock = 6) var %1 6 | if (%lock_2 = 6) var %2  6 | if (%lock_3 = 6) var %3 6 | if (%lock_4 = 6) var %4 6 | if (%lock_5 = 6) var %5 6 | if (%lock_6 = 6) var %6 6
          if (%lock = 7) var %1 7 | if (%lock _2 = 7) var %2 7 | if (%lock_3 = 7) var %3 7 | if (%lock_4 = 7) var %4 7 | if (%lock_5 = 7) var %5 7 | if (%lock_6 = 7) var %6 7
          if (%lock = 8) var %1 8 | if (%lock_2 = 8) var %2 8 | if (%lock_3 = 8) var %3 8 | if (%lock_4 = 8) var %4 8 | if (%lock_5 = 8) var %5 8 | if (%lock_6 = 8) var %6 8
          if (%lock = 9) var %1 9 | if (%lock_2 = 9) var %2 9 | if (%lock_3 = 9) var %3 9 | if (%lock_4 = 9) var %4 9 | if (%lock_5 = 9) var %5 9 | if (%lock_6 = 9) var %6 9
          .timer 1 2 mode $chan +k %1 $+ %2 $+ %3 $+ %4 $+ %5 $+ %6
          .timer 1 2 msg $chan >>4Chanel Bloqueadon con la Pass13 %1 $+ %2 $+ %3 $+ %4 $+ %5 $+ %6
        }
      }
    }
    if ($2 != $null) {
      mode $chan +k $2
      msg $chan >>4Chanel Bloqueadon con la Pass13 $2
      set %lock. [ $+ [ $chan ] ] on
      .timer 1 10 unset %lock. [ $+ [ $chan ] ]
    }
  }
}

;------------------ IRC For BoT Commands -------------------------------

;~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*;
;           mIRC BOT SERV                        ;
;            Made by NT5                         ;
;*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~;

on *:INPUT:#: {
  ;youtube
  if ($regex($1-,/^[!@]y(t|ube|search|outube)/Si)) {
    if (%bot_state == off) { halt }
    var %r $r(1,9999)
    sockopen youtube. $+ %r www.youtube.com 80
    sockmark youtube. $+ %r $iif($left($strip($1),1) == !, .msg $chan, msg $iif($chan,$chan,$nick)) results?search_query= $+ $replace($2-,$chr(32),+)
  }
  elseif ($regex($1-,/(youtube.com|youtu.be)\/(.+)/i)) {
    if (%bot_state == off) { halt }
    var %r $r(1,9999)
    sockopen youtube. $+ %r www.youtube.com 80
    sockmark youtube. $+ %r $iif($chan, msg $chan, msg $nick) $strip($regml(2))
  }
  ;youtube

  if ($1 == !galleta) {
    if (%bot_state == off) { halt }
    if (%gchan != $null) { .notice $nick $1 En Progreso... | halt }
    msg $chan >>5 %nick Abre su galleta de la suerte y dice:
    sockClose Galleta
    sockOpen Galleta www.galletadelasuerte.es 80
    set -u5 %gchan $chan
  }
  if ($1 == !xestats) {
    if (%bot_state == off) { halt }
    if ( %s ) { .notice $nick En Progreso... | halt }
    if (!%s) {
      if (!$2) {
        sockClose xe
        sockOpen xe xe.vrocker-hosting.co.uk 80
        msg $chan >10 $nick - Stats
        set %chan $chan
        set %s $nick
      }
      else {
        sockClose xe
        sockOpen xe xe.vrocker-hosting.co.uk 80
        set %chan $chan
        set %s $2
      }
    }
  }

  if ($1 == !horoscopo) {
    if (%bot_state == off) { halt }
    if (!$2) { .notice $nick Error - $1 acuario/piscis/aries/tauro/geminis/cancer/leo/virgo/libra/escorpio/sagitario/capricornio | halt }
    if ($2 !isin acuario piscis aries tauro geminis cancer leo virgo libra escorpio sagitario capricornio) { .notice $nick Error - $2 No Es Valido! }
    else if (%hchan != $null) { .notice $nick $1 En Progreso... | halt }
    else {
      sockClose horoscopo
      sockOpen horoscopo elhoroscopodehoy.com 80
      msg $chan >>3 $nick - $2
      msg $chan 6Cargando...
      set -u5 %hchan $chan
      set -u5 %s $2
    }
  }

  if ($1- == $me :D) {
    if (%bot_state == off) { halt }
    if ($nick == NT5) { msg $chan $nick $2 $+ !!! }
  }
  if ($1 == !len) {
    if (!$2) { .notice $nick Error - $1 Palabra | halt }
    if ($2 != $null) {

      msg $chan >>5 $+ $2- Tiene $len($2-) Caracteres.
    }
  }

  if ($1 == !ppt) {
    if (!$2) { .notice $nick Error - $1 papel/piedra/tigera | .halt }
    if ($2 != $null) {
      var %ppt = $rand(1,7) 
      if (%ppt = 1) var %1 piedra
      if (%ppt = 2) var %1 papel
      if (%ppt = 3) var %1 tigera
      if (%ppt = 4) var %1 piedra
      if (%ppt = 5) var %1 papel
      if (%ppt = 7) var %1 tigera
      set %ppt- $+ %1 on
      if ($2 == piedra) {
        if (%ppt-piedra != on) { msg # 5>Papel Cubre Piedra, Gano Yo. | unset %ppt-piedra | .halt }
        msg # >3Piedra Rompe Tigeras Ganas Tu.
        unset %ppt-piedra
      }
      else if ($2 == papel) {
        if (%ppt-papel != on) { msg # >5Tigeras Cortan Papel Gano Yo. | unset %ppt-papel | .halt }
        msg # >3Papel Cubre Piedra, Ganas Tu.
        unset %ppt-papel
      }
      else if ($2 == tigera) {
        if (%ppt-tigera != on) { msg # 5>Piedra Rompe Tigeras Gano Yo. | unset %ppt-tigera | .halt }
        msg # >3Tigera Corta Papel Ganas Tu.
        unset %ppt-tigera
      }
      else { .notice $nick $1 $2 $+ ?  Error - $1 papel/piedra/tigera | unset %ppt* }
    }
  }
  if ($1 == !comandos) || ($1 == !commands) || ($1 == !cmds) {
    if (%bot_state == off) { halt }
    .notice $nick 4** 7Comandos:5 !botinfo !google !youtube !galleta !horoscopo !xestats 12!texto 11!addtexto 11!lineas 12!borrartexto !randon/!rand
    .notice $nick !web !fecha !joins !invitar !ausente/!away !back/!volvi !afk/!ausentes !calc !server !juegos/!games
    .notice $nick 3!disparo  ,5!fortuna , 14!num, !cd, !vs/!figth,4!bola8/!8ball,3!iq 12!bomba/!boom, !boomscore
  }
  if ($1 == !juegos) || ($1 == !games) {
    if (%bot_state == off) { halt }
    else {   
      .notice $nick 6Juegos DisPonibles>>10 $+ $1 $+ =>14 !vs/!figth,  4!bola8/!8ball , 3!iq 12!bomba/!boom, !boomscore, 
      .notice $nick 3!disparo, 5!ppt 14!num, !cd
    }
  }
  if ($1 == !cmd) {
    if (%bot_state == off) { halt }
    if ($2 == bot) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        .notice $nick 4>> 7Comandos:5 !reconectar !reco !conectar !acbot !botinfo !desconectar !salir !r-contador !nick-b !script on/off
      }
    }
    if ($2 == admin) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        .notice $nick >> Comandos de Admin: !info !notice !cerrar-chan/!lock !abrir-chan/!unlock
        .notice $nick  !tban/!tempban !ln !qln !add-user !del-user !sacar/!kick !kickall !cmd-bot !voz !qvoz !mudo/!mute !mod/!qmod !qop/!op
        .notice $nick  !half/!dehaf !aop/!deaop !qsuspender/!unban  !suspender/!ban
      }
    }
  }
  if ($1 == !botinfo) || ($1 == !bot) {
    msg $chan 7 $+ $me 3V3.4 14Creado Por 12NT5 3Network:6[ $+ $network  $+ ] 2m7IR8C1:10[ $+ $version $+ ]6Script Status:5 $+ %bot_state
    msg $chan 10 $+ $lines($script(mIRC_v3.4[NT5].ini)) Lineas.  6Tiempo Conectado:5 $uptime(server,2) 14Conectado a $comchan($me,0) Canales
  }

  if ($1 == !server) {
    if (%bot_state == off) { halt }
    msg $chan **10Server Name: $+ 3[NT5]..::$$War and Blood$$::..[R2]
    msg $chan **10IP:3 $ip $+ :5192
  }
  if ($1 == !calc) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick - Calc - Error - Ej: $1 $rand(1,9) $+ + $+ $rand(1,9) }
    if ($2 != $null) {
      if ($2- isletter) { .notice $nick - Calc - Error | .halt }
      set -u3 %total $replace($2-,x,*)
      set -u3 %total $calc(%total)
      msg $chan 5Resultados: $2- = %total
    }
  }
  if ($1 == !google) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick Error - !google Bot mIRC }
    if ($2 != $null) {
      var %x = 1
      while ($sock($+(google,%x))) inc %x
      sockopen $+(google,%x) www.google.com 80
      sockmark $+(google,%x) $1-
    }
  }
  if ($1 == !cd) {
    if (%bot_state == off) { halt }
    if (%cd == on) .notice $nick ** 3Countdown ya esta en Progreso.
    else {
      set %cd on
      .timer 1 1 msg $chan 10------ 4 ------
      .timer 1 2 msg $chan 10------ 3 ------
      .timer 1 3 msg $chan 10------ 2 ------
      .timer 1 4 msg $chan 10------ 1 ------
      .timer 1 5 msg $chan 10- Go, Go, Go! -
      .timer 1 6 set %cd off
    }
  }
  if ($1 == !scan) {
    if (%bot_state == off) { halt }
    else {   
      msg $chan    4  $nick enciende el 0,3 detector  "Que detecta?"  15,15.14,14.0,7 * B.O. DETECT * 14,14.15,15.
      mag $chan    0,1 :::14[]4°1,0----o  12BIP BIP BIP 
      msg $chan    3 $nick lo apunta hacia el canal # ... y comienza a detectar... 
      .timer 1 3 msg $chan 3Scanning..... 0,1 :::14[]4°1,0----o0,0 7)))
      .timer 1 6 msg $chan 3Scanning..... 0,1 :::14[]4°1,0----o0,0 7)))4))))
      .timer 1 9 msg $chan 3Blanco localizado!!..... 
      .timer 1 12 msg $chan 8,1D1,8A8,1N1,8G8,1E1,8R 15,15.14,14.9,1 $3 14,14.15,15.8,1D1,8A8,1N1,8G8,1E1,8R  
    }
  }

  if ($1 == !bomba) || ($1 == !boom) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { msg $msg $chan >>7Error - Forma Correcta5 $1 6[Nick]. }
    if ($2 != $null) {
      if ( $2 == $me ) { .notice $nick Error - No Le Puedes Poner Una Bomba a $me $+ !! | .halt }
      if ($2 == $nick) { .notice $nick Error - No Te Puedes Poner Una Bomba A ti Mismo $+ !! | .halt }
      if (%bom == on) { msg $chan >>4La Bomba Ya Esta Activa en14 %bom.nick 10 %bom.chan | .halt }
      if ( $2 ison $chan ) {
        .timer.bom_5 1 55 .notice $2 4 Te Quedan Menos De 5 Segundos..
        .timer.bom_4 1 30 .notice $2 4 Te Quedan Menos De 20 Segundos..
        .timer.bom_3 1 57 msg $chan 4--- 3 ---
        .timer.bom_2 1 58 msg $chan 4--- 2 ---
        .timer.bom_1 1 59 msg $chan 4--- 1 ---
        .timer.bom_6 1 60 msg $chan 4BOOM!!
        .timer.bom 1 61 kick $chan $2 ~~!!!¡¡BOOM!!¡¡~~ As Fallado - Tiempo Agotado! 
        .timer.bom_0 1 60 set %bom off 
        .timer.bom_7 1 60 inc %lost.bom. [ $+ [ $2 ] ]
        set %bom on
        set %score.bom [ $+ [ $2 ] ] on
        set -u60 %bom.sta. [ $+ [ $2 ] ] on
        set -u60 %bom.chan $chan
        set -u60 %bom.nick $2
        set %cable-r off
        set %cable-v off
        set %cable-a off
        var %bom = $rand(1,7) 
        if (%bom = 1) var %1 r
        if (%bom = 2) var %1 a 
        if (%bom = 3) var %1 v
        if (%bom = 4) var %1 a
        if (%bom = 5) var %1 r
        if (%bom = 7) var %1 v
        set %cable- $+ %1 on
        msg $chan 1,8 P 8,1 E 1,8 L 8,1 I 1,8 G 8,1 R 1,8 O 0,4 $2 1,8 P 8,1 E 1,8 L 8,1 I 1,8 G 8,1 R 1,8 O 
        msg $chan 3Ho..No!!! 10 $nick 3A Puesto una Bomba a4 $2 $+ 3!!! 
        msg $chan 4 $+ $2 10Tiene Menos De4 1 Minuto Para Desactivarla!!
        msg $chan 12Rapido!! 4!cable rojo 1- 12!cable azul 1- 3!cable verde
        halt
      }
      if ($nick != ison $chan) { .notice $nick Error - $2 No Esta En $chan $+ !! }
    }
  }

  if ($1 == !cable) {
    if (%bot_state == off) { .halt }
    if ($2 == $null) { .notice $nick Error - !cable rojo !cable verde !cable azul | .halt }
    else if ($2 == rojo) {
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }        
        if (%cable-r == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!   
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
        if (%cable-r == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          .timer 1 1 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else if ($2 == azul) {
      if ( %bom.nick. [ $+ [ $nick ] ] == off ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
        if (%cable-a == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!  
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt 
        }
        if (%cable-a == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          timer 1 1 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else if ($2 == verde) {
      if (%bom == off) { msg $chan >>3La Bomba Esta Desactivada! }
      else {
        if ( %bom.sta. [ $+ [ $nick ] ] == $null ) { .notice $nick Error - Tu no Tienes La Bomba! | halt }
        if (%cable-v == on) { msg $chan 12Felicidades! $nick As Desactivado La Bomba Con Exito!  
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off   
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %winds.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt 
        }
        if (%cable-v == off) { msg $chan 4ERROR FATAL!! - Te As Equivocado!
          .notice $nick Te As Equivocado! Seras Sacado Del Chan. 
          .timer 1 2 kick $chan $nick  /!\~~!!!¡¡BOOM!!¡¡~~/!\
          .timer.bom_7 off
          .timer.bom_6 off
          .timer.bom_5 off
          .timer.bom_4 off
          .timer.bom_3 off
          .timer.bom_2 off
          .timer.bom_1 off
          .timer.bom off
          set %bom off
          inc %lost.bom. [ $+ [ $nick ] ]
          unset %bom.sta. [ $+ [ $nick ] ]
          unset %bom.chan
          unset %bom.nick
          halt
        }
      }
    }
    else .notice $nick $1- $+ ? 4Error - Cable Erroneo!
  }
  if ($1 == !boomscore) {
    if ($2 == $me) { .halt }
    if ($2 == $null) {
      if (%bot_state == off) { halt }
      if (%score.bom [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 0 | halt }
      if (%winds.bom. [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 %lost.bom. [ $+ [ $nick ] ]  | halt }
      if (%lost.bom. [ $+ [ $nick ] ] == $null) { msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $nick ] ] 5Perdidas:10 0 | halt }
      msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $nick ] ] 5Perdidas:10 %lost.bom. [ $+ [ $nick ] ]
    }
    if ($2 != $null) {
      if ( $2 ison $chan ) {
        if (%score.bom [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 0 | halt }
        if (%winds.bom. [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ 0 5Perdidas:10 %lost.bom. [ $+ [ $2 ] ]  | halt }
        if (%lost.bom. [ $+ [ $2 ] ] == $null) { msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $2 ] ] 5Perdidas:10 0 | halt }
        msg $chan 5Ganadas: 10 $+ %winds.bom. [ $+ [ $2 ] ] 5Perdidas:10 %lost.bom. [ $+ [ $2 ] ]
      }
    }
  }
  if ( $1 == !disparo) || ($1 == !shot) {
    if (%bot_state == off) { halt }
    set %ruleta off
    var %ruleta = $rand(1,4)
    if (%ruleta = 1) var %1 on    
    if (%ruleta = 2) var %1 off              
    if (%ruleta = 3) var %1 on
    if (%ruleta = 4) var %1 off        
    set %ruleta %1
    if (%ruleta == on) { 
      msg $chan 8,4BOOOOOOOM!! 2Tus sesos volaron
      .timer 1 2 kick $chan $nick 8,4BOOOOOOOM!! 2Tus sesos volaron
    }
    if (%ruleta == off) { msg # 2 [*** CLICK ***]  3UFFF por poko te has librado 1 $nick }
  }

  if ($1 == !num) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { 
      set %juego.adivina on
      msg $chan 4El juego 2ADIVINA el NÜMERO 3está activado 6para probar suerte pon !num Nº (ej: !num $rand(0,100) ) 12 está entre el 0 y el 100 
      set %num.adi $rand(1,100)
    }
    if ($2 != $null) {
      if ( %juego.adivina == off ) { msg $chan 4El Juego Esta Desactivado! }
      else { 
        if ( %juego.adivina == on ) { 
          if ( $2 == %num.adi ) {
            msg $chan  6Muy bien 1 $+ $nick $+  6has acertatado, el número era4 %num.adi 
            set %juego.adivina off
            unset %num.adi  
          }
        }
        if ( $2  < %num.adi ) { .notice $nick 2Más alto }
        if ( $2  > %num.adi ) { .notice $nick 2Más bajo }
        if ( $2  > 100 ) { .notice $nick 2Está entre el 0 y el 100, asique $2 no vale }
      }
    }
  }

  if ($1 == !vs) || ($1 == !fight) {
    if (%bot_state == off) { .halt }
    if ($2 == $null) {   msg $chan 1**4 **4Error: 12Forma Correcta:7 $1 [Nick.] }
    if ($2 != $null) {
      if ( $2 ison $chan ) {
        if (%dm == on) .notice $nick **10Pelea En Proseso...
        else {
          set %dm on
          msg $chan >>12[ $+ Pelea Entre $nick , $2 $+ ]
          msg $chan >>12[ $+ El Ganador Seria... $+ ]
          msg $chan >>10[ $+ Peleando... $+ ]
          var %dm = $rand(1,7) 
          if (%dm = 1) var %1 $2 
          if (%dm = 2) var %1 Empate!
          if (%dm = 3) var %1 $nick
          if (%dm = 4) var %1 Empate!
          if (%dm = 5) var %1 $2
          if (%dm = 6) var %1 Empate!
          if (%dm = 7) var %1 $nick
          .timer 1 3 msg $chan **4GANADOR=> $+ %1
          .timer 1 3 set %dm off
        }
      } 
    }
  }

  if ($1 == !bola8) || ($1 == !8ball) {
    if (%bot_state == off) { halt }
    else {      
      if ($2 == $null) { msg $chan 1**4 **4Error: 12Forma Correcta:7 $1 [Pregunta]. }
      if ($2 != $null) { 
        if (%8ball == on) .notice $nick **12Espera Mientras Se Reajustan Las Respuestas...4=>10 $1.
        else {
          set %8ball on
          msg $chan >>4[10Pregunta=> 12 $2- $+ 4]
          msg $chan >>3[12Cargando.....3]
          var %8ball = $rand(1,22) 
          if (%8ball = 1) var %1 Claro!                                                 | if (%8ball = 12) var %1 jaja Estas Loco?.. Claro que Si!
          if (%8ball = 2) var %1 No Lo Creo.                                      | if (%8ball = 13) var %1 Un 50% que Si..
          if (%8ball = 3) var %1 hmm... Quisas...                                | if (%8ball = 14) var %1 No Se, No Soy Adivino :/
          if (%8ball = 4) var %1 Definitivamente NO!                      | if (%8ball = 15) var %1Tu que Crees...
          if (%8ball = 5) var %1 Definitivamente SI!                         | if (%8ball = 16) var %1 eh???!! >_< que Pregunta Mas Rara 
          if (%8ball = 6) var %1 jaja Estas Loco?.. Claro que NO!  | if (%8ball = 17) var %1 Ni Que Llegue el Apocalipsis
          if (%8ball = 7) var %1 No Puedo Contestar Eso                | if (%8ball = 18) var %1 El Mundo Se Acaba Y Seguirando Ciendo No!
          if (%8ball = 8) var %1 Me Repites La Pregunta?              | if (%8ball = 19) var %1 Pero Claro Que Porsupuesto Que Desde Luego Que SI!!
          if (%8ball = 9) var %1 No.                                                     | if (%8ball = 20) var %1 Me Repites Eso??
          if (%8ball = 10) var %1 Si.                                                     | if (%8ball = 21) var %1 em... No Puedo Responderte Eso..
          if (%8ball = 11) var %1Posiblemente...                               | if (%8ball = 22) var %1 Jamas!
          if (%1 == $null) {
            var %8ball = $rand(1,22) 
            if (%8ball = 1) var %1 Claro!                                                 | if (%8ball = 12) var %1 jaja Estas Loco?.. Claro que Si!
            if (%8ball = 2) var %1 No Lo Creo.                                      | if (%8ball = 13) var %1 Un 50% que Si..
            if (%8ball = 3) var %1 hmm... Quisas...                                | if (%8ball = 14) var %1 No Se, No Soy Adivino :/
            if (%8ball = 4) var %1 Definitivamente NO!                      | if (%8ball = 15) var %1Tu que Crees...
            if (%8ball = 5) var %1 Definitivamente SI!                         | if (%8ball = 16) var %1 eh???!! >_< que Pregunta Mas Rara 
            if (%8ball = 6) var %1 jaja Estas Loco?.. Claro que NO!  | if (%8ball = 17) var %1 Ni Que Llegue el Apocalipsis
            if (%8ball = 7) var %1 No Puedo Contestar Eso                | if (%8ball = 18) var %1 El Mundo Se Acaba Y Seguirando Ciendo No!
            if (%8ball = 8) var %1 Me Repites La Pregunta?              | if (%8ball = 19) var %1 Pero Claro Que Porsupuesto Que Desde Luego Que SI!!
            if (%8ball = 9) var %1 No.                                                     | if (%8ball = 20) var %1 Me Repites Eso??
            if (%8ball = 10) var %1 Si.                                                     | if (%8ball = 21) var %1 em... No Puedo Responderte Eso..
            if (%8ball = 11) var %1Posiblemente...                               | if (%8ball = 22) var %1 Jamas!
            .timer 1 5 msg $chan >>13[3Respuesta=> 6 $+ %1 $+ 13]
            .timer 1 6 set %8ball off
          }
          else {
            .timer 1 5 msg $chan >>13[3Respuesta=> 6 $+ %1 $+ 13]
            .timer 1 6 set %8ball off
          }
        }
      }
    }
  }

  if ($1 == !iq) {
    if (%bot_state == off) { halt }
    var %iq = $rand(1,16) 
    if (%iq = 1) var %1 1,14/2
    if (%iq = 2) var %1 1,14//2
    if (%iq = 3) var %1 1,14///2
    if (%iq = 4) var %1 1,14////2
    if (%iq = 5) var %1 1,14/////2
    if (%iq = 6) var %1 1,14//////2
    if (%iq = 7) var %1 1,14///////2
    if (%iq = 8) var %1 1,14////////2
    if (%iq = 9) var %1 1,14/////////2
    if (%iq = 10) var %1 1,14//////////2
    if (%iq = 11) var %1 1,14///////////2
    if (%iq = 12) var %1 1,14////////////2
    if (%iq = 13) var %1 1,14/////////////2
    if (%iq = 14) var %1 1,14//////////////2
    if (%iq = 15) var %1 1,14////////////////2
    if (%iq = 16) var %1 1,14//////////////////2
    .timer 1 1  msg $chan >>2[12Cargando.....2]    
    if ($2 == $null) { .timer 1 5 msg $chan >>12[3 $+ $nick IQ=>1,2[6 $+ %1 $+ 1,2]
      msg $chan >>4[10IQ=>12 $+ $nick $+ 4]
    }
    if ($2 != $null) { .timer 1 5 msg $chan >>4[3 $+ $2- IQ=>1,2[6 $+ %1 $+ 1,2] 
      msg $chan >>4[10IQ=>12 $+ $2- $+ 4]
    }
  }

  if ($1 == !ausente) || ($1 == !away) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { .notice $nick 4Error - Escrive una Razon | halt }
    if ($2 != $null) { 
      var %away.razon = %away.razon. [ $+ [ $nick ] $+ ]
      var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick ] ] ),1)
      if (%away. [ $+ [ $nick ] ] == on) { 
        .notice $nick As Cabiado Tu Razon De Away! ( $+ %away.razon $+ )
        msg $chan 2 $nick 5is Back from 6"14 %away.razon 6" 10Time: %away.time
        msg $chan 3 $nick 10is Away Razon: $2-
        set -e %away.razon. [ $+ [ $nick ] ] $2-
        set -e %away.time. [ $+ [ $nick ] ] $ctime
        .halt
      }
      set %away. [ $+ [ $nick ] ] on
      set -e %away.razon. [ $+ [ $nick ] ] $2-
      set -e %away.time. [ $+ [ $nick ] ] $ctime
      msg $chan 1**4 $nick 6is Away, Razon:12 $2-
    }
  }
  if ($1 == !ausentes) || ($1 == !afk) { 
    if (%bot_state == off) { halt }
    set %totalnikc $nick(#,0)
    set %b 1
    while (%totalnikc >= %b) {
      if ( %away. [ $+ [ $nick(#,%b) ] ] == on) { inc %away.cont }
      inc %b
    }
    if ( %away.cont == $null ) { msg $chan 10No Hay Personas Ausentes! | unset %b | unset %totalnikc | halt }
    set %totalnikc $nick(#,0)
    set %b 1
    msg $chan 4[10Count4]6 %away.cont de $nick(#,0) Usuarios - $chan
    while (%totalnikc >= %b) {
      if ( %away. [ $+ [ $nick(#,%b) ] ] ) {
        var %away.razon = %away.razon. [ $+ [ $nick(#,%b) ] ]
        var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick(#,%b) ] ] ),1)
        msg $chan 5>> $nick(#,%b) - Razon - %away.razon - Tiempo - %away.time
      }
      inc %b
    }
    unset %b
    unset %totalnikc
    set %away.cont
  }
  if ($1 == !back) || ($1 == !volvi) {   
    if (%bot_state == off) { halt }
    if (%away. [ $+ [ $nick ] ] == $null) { .notice $nick - No Estas Ausente. | .halt }
    var %away.razon = %away.razon. [ $+ [ $nick ] ]
    var %away.time = $duration($calc($ctime - %away.time. [ $+ [ $nick ] ] ),1)
    msg $chan 1**4 $nick 14is Back from: " $+ 3 %away.razon 14" Time: %away.time
    unset %away. [ $+ [ $nick ] ]
    unset %away.razon. [ $+ [ $nick ] ]
    unset %away.time. [ $+ [ $nick ] ]
  }
  if ($1 == !reglas) || ($1 == !rules) {
    if (%bot_state == off) { halt }
    msg $chan **/!\4-No Insultos 11-No Jodas -.- 12-No Agas Spam 3No Abuses 3De las MAYUSCULAS 7- Pasala Bien ;)
  }

  if ($1 == !joins) {
    if (%bot_state == off) { halt } 
    if ($2 == $null) {
      msg $chan 4>>10Joins en $chan $+ => $+ %contar.chan. [ $+ [ $chan ] ]
    }
    if ($2 != $null) { 
      msg $chan 4>>10Joins en $2 $+ => $+ %contar.chan. [ $+ [ $2 ] ]
    }
  }

  if ($1 == !web) {
    if (%bot_state == off) { halt }
    msg $chan 4**3Web:14http://www.GuiaPC.TK/
  }

  if ($1 == !users) {
    if (%bot_state == off) { halt }
    .notice $nick **12 Users:( $+ $nick( #,0 ) $+ )
    .notice $nick **10 Operators:( $+ $nick(#,0,o) $+ )
    .notice $nick **3 Voices:( $+ $nick(#,0,v) $+ )
    .notice $nick ** 14Regular:( $+ $nick(#,0,r) $+ ) 
  }

  if ($1 == !fecha) {
    if (%bot_state == off) { halt }
    msg $chan 10Hoy es5 $replace($day,Monday,Lunes,Tuesday,Martes,Wednesday,Miercoles,Thursday,Jueves,Friday,Viernes,Saturday,Sabado,Sunday,Domingo) $gettok($date,1,47) 6del mes:5  $replace($gettok($date,2,47),01,Enero,02,Febrero,03,Marzo,04,Abril,05,Mayo,06,Junio,07,Julio,08,Agosto,09,Septiembre,10,Octubre,11,Noviembre,12,Diciembre) 6del año:5 $gettok($date,3,47)
  }

  if ($1 == !info) || ($1 == !whois) {
    if (%bot_state == off) { halt }
    if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 $1 [Nick] }
    if ($2 != $null ) {
      if (%Whois.antispam != $null) { .halt }
      else { 
        set -u5 %Whois.antispam activated
        set -u5 %chan $nick
        whois $2
      }
    }
  }

  if ($1 == !addtexto) || ($1 == !addquote) {
    if (%bot_state == off) { halt }
    write Quote.txt 14" $+ $$2- $+ "
    if (%quote != $null) {
      .notice $nick 2>>7 Quote ( $+ $lines(Quote.txt.) $+ ) $$2-
      inc %quote 1
    }
    if (%quote == $null) {
      set %quote 1
      msg # 11A Sido Agregado al Archivo de Texto %quote $+ .
    }
  }

  if ($1 == !randon) || ($1 == !rand) {
    if (%bot_state == off) { halt }
    play -r # quote.txt 
  }

  if ($1 == !texto) || ($1 == !quote) {
    if (%bot_state == off) { halt }
    msg # **7 Quote (  $+ $2 $+  /  $+ $lines(Quote.txt) $+  )14 $read(Quote.txt, $2-  )
  }

  if ($1 == !lineas) || ($1 == !lines) {
    if (%bot_state == off) { halt }
    msg $chan 2>>7 $lines(Quote.txt)l Lineas en el Archivo De Texto
  }

  ;------------------ IRC Channel Commands ------------------------

  if ($1 == !adduser) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { .notice $nick 4Error: 10Forma Correcta:7 $1 [Nick] | halt }
      if ($2 != $null) {
        if ($2 ison $chan) {
          if (%nivel. [ $+ [ $2 ] ] == 10) { .notice $nick Error - $2 Ya Esta En La Lista De User´s | halt }
          set %nivel. [ $+ [ $2 ] ] 10
          msg $chan 1** 4 $2 14A Sido Agragado a la lista de 4Users De $me
        }
      }
      if ($2 !ison $chan) { .notice $nick Error - $2 No Esta En $chan }
    }
  }

  if ($1 == !deluser) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { .notice $nick 4Error: 10Forma Correcta:14 $1[Nick] | halt }
      if ($2 != $null) {    
        if ($2 ison $chan) {
          if (%nivel. [ $+ [ $2 ] ] == $null) { .notice $nick Error - $2 No Esta En La Lista De User´s | halt }
          unset %nivel. [ $+ [ $2 ] ]
          msg $chan 4 $+ $2 14A Sido Removido de la lista de 4Users De $me
        }
      }
      if ($2 !ison $chan) { .notice $nick Error - $2 No Esta En $chan }
    }
  }

  if ($1 == !suspender) || ($1 == !ban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Forma Correcta:14 $1 [Nombre] [Razon]. }
      if ($2 != $null) { 
        if ( $$2 == $me ) { .notice $nick Error - No Puedes dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          ban $chan $$2 
          kick $chan $$2 4Suspendido.
        }
      }
    }
  }

  if ($1 == !qsuspender) || ($1 == !unban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Forma Correcta:14 $1 [Nombre] }
      if ($2 != $null) {
        mode # -b $2 
        invite $2 $chan 
      }
    }
  }

  if ($1 == !sacar) || ($1 == !kick) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error Forma Correcta:7 $1 [Nick]. }
      if ($2 != $null) {
        if ( $$2 == $me ) { .notice $nick Error - No Puedes Dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          kick $chan $$2 $nick
        }
      }
    }
  }

  if ($1 == !kickall) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      unset %total
      set -u30 %count.nick 0
      set -u30 %total $nick(#,0)
      :start
      inc %count.nick
      if (%count.nick > %total) { halt }
      if ($nick(#,%count.nick) == $me) { goto start } 
      else { kick # $nick(#,%count.nick) Todos An Sido Sacados. | goto start }
    }
  }
  if ($1 == !voiceusers) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      unset %total
      set -u30 %count.nick 0
      set -u30 %total $nick(#,0)
      :start
      inc %count.nick
      if (%count.nick > %total) { halt }
      if ($nick(#,%count.nick) == $me) { goto start } 
      else { mode # +v $nick(#,%count.nick) | goto start }
    }
  }


  if ($1 == !tban) || ($1 == !tempban) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta7 $1 [Nick] [Tiempo]. }
      if ($2 != $null) {
        if ( $$2 == $me ) { .notice $nick Error - No Puedes Dar $1 a $me | halt }
        if ( $$2 ison $chan ) {
          msg $chan 1 >>2 $+ Ban10 $$2 - 14Duracion: $$3 - 14Segundos 
          mode # +b $$2 
          kick # $$2 4Baneado Temporalmente 
          .timer 1 $$3- /msg $chan ** 4 $$2 7Baneo Expirado 
          .timer 1 $$3- /mode # -b $$2  
          .timer 1 $$3- .msg $$2 >>4Baneo Temporal Expirado Entra a7 $chan
        }
      }
    }
  }

  if ($1 == !mod) || ($1 == !mode) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }    
      if ($2 != $null) {
        mode $chan +h $$2
      }
    }
  }

  if ($1 == !qmode) || ($1 == !qmod)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }
      if ($2 != $null) {
        mode $chan -h $$2
      }
    }
  }

  if ($1 == !half)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }    
      if ($2 != $null) {
        if ( $2 ison $chan ) {
          mode $chan +h $2
          set %mod. [ $+ [ $chan ] ] [ $+ [ $2 ] ] on
        }
      }
    }
  }

  if ($1 == !dehalf)  {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 $1 [Nick] }
      if ($2 != $null) {
        mode $chan -h $2
        unset %mod. [ $+ [ $chan ] ] [ $+ [ $2 ] ]
      }
    }
  }

  if ($1 == !op) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 !op [Nick] }
      if ($2 != $null) {
        mode $chan +o $$2
      }
    }
  }

  if ($1 == !qop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7!qop [Nick] }
      if ($2 != $null) {
        mode $chan -o $$2
      }
    }
  }

  if ($1 == !aop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7 !op [Nick] }
      if ($2 != $null) {
        if ( $2 ison $chan ) {
          mode $chan +o $2
          set %op. [ $+ [ $chan ] ] [ $+ [ $2 ] ] on
        }
      }
    }
  }

  if ($1 == !deaop) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4Error: 12Forma Correcta: 7!qop [Nick] }
      if ($2 != $null) {
        mode $chan -o $2
        unset %op. [ $+ [ $chan ] ] [ $+ [ $2 ] ]
      }
    }
  }

  if ($1 == !voz) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 !voz [Nick] }
      if ($2 != $null) {    
        mode $chan +v $2
      }
    }
  }

  if ($1 == !qvoz) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan  **4Error: 12Forma Correcta:7 !qvoz [Nick] }
      if ($2 != $null) { 
        mode $chan -v $2 
      }
    }
  }

  if ($1 == !mudo) || ($1 == !mute) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Correcta Forma:14 $1 [on/off] }
      if ($2 == off) {
        if (%mute. [ $+ [ $chan ] ] == $null) msg $chan **12El Chanel Ya Tiene el Mute Apagado.
        else {
          unset %mute. [ $+ [ $chan ] ]
          mode $chan -m
        }
      }
      if ($2 == on) {
        if (%mute. [ $+ [ $chan ] ] == on) msg $chan **12El Chanel Ya Esta en Mute.
        else {
          set %mute. [ $+ [ $chan ] ] on
          mode $chan +m 
        }
      }
    }
  }

  if ($1 == !reconectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%reconect == on) msg $chan **12Bot En Proseso De Desconeccion.
      else {
        set %reconect on
        msg $chan 4**14Desconectando Bot...  
        .timer 1 8 set %reconect off | timer 1 8 server liberty-unleashed.co.uk
      }
    }
  }

  if ($1 == !reco) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan 4**14Desconectando Bot... |  /hop $chan
    }
  }

  if ($1 == !nick-b) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: $1 [Nick]. } 
      if ($2 != $null) { 
        if (%bot_p == on) notice $nick **12Espera 10 segundos...
        else {
          .notice $nick As Cambiado El nombre al Bot Por $2
          set %bot_p on
          nick $2
          timer 1 10 set %bot_p off
        }
      }
    }
  }

  if ($1 == !conectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: $1 [Nombre Del Chanel]. }  
      if ($2 != $null) {
        if (%join_2 == on) .notice $nick **12Espera 10 segundos antes Del Proccimo Join.
        else {
          set %join_2 on
          .timer 1 10 set %join_2 off
          msg $chan 4**14Conectando Bot al Chanel10 $+ $$2...
          join #$$2
        }
      }
    }
  }

  if ($1 == !script) {
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan **4 Error - Correcta Forma:14 $1 [on/off] }
      if ($2 == off) {
        if (%bot_state == off) msg $chan **12 $me Ya Esta Apagado.
        else {
          msg $chan 4**4/!\ $me Apagado. 
          set %bot_state OFF
          .timer* off
        }
      }
      if ($2 == on) {
        if (%bot_state == on) msg $chan **12 $me Ya Esta En Funcionamiento.
        else {
          msg $chan 4**14/!\ $me En Funcionamiento!! 
          set %bot_state ON
        }
      }
    }
  }

  if ($1 == !autod) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan ** $me *4Auto Destrucion Activada!!
      .timer 1 2 msg $chan 10Destruccion en 5 Segundos..
      .timer 1 4 msg $chan 10 --  3 --
      .timer 1 5 msg $chan 10 -- 2 --
      .timer 1 6 msg $chan 10 -- 1 --
      .timer 1 7 msg $chan 6 Hasta La Vista $nick ;)
      .timer 1 9 msg $chan 6 PD: Volvere...
      .timer 1 10 part # 4DIED!
    }
  }

  if ($1 == !desconectar) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan 4**14<Error>  Forma Correcta: !desconectar [Nombre Del Chanel]. }  
      if ($2 != $null) {
        msg $chan 4**14Bot Desconectado del Chanel 4 $2. 
        .timer 1 2 part #$2
      }
    }
  }

  if ($1 == !salir) || ($1 == !exit) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      msg $chan 4**14/!\ $+ %bot_name Desconectado del Chanel. 
      part $chan
    }
  }

  if ($1 == !acbot) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      pass
      msg $chan **10Bot Reconosido.
    }
  }

  if ($1 == !r-contador) || ($1 == !r.contador) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      set %contar.chan. [ $+ [ $chan ] ] 0
      msg $chan **4Contador Reiniciado.
    }
  }
  if ($1 == !invitar) || ($1 == !invite) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan  **4Error: 12Forma Correcta:7 !invitar [Nick] }
      if ($2 != $null) {
        if (%invt == on) .notice $nick **12Espera unos Segundos...
        else {
          set %invt on
          .timer 1 20 set %invt off
          invite $$2 $chan
        }
      }
    }
  }

  if ($1 == !notice) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) {  msg $chan **4Error:12Forma Correcta:13!notice [Mesaje] }
      if ($2 != $null) {
        amsg 10Noticia Embiada Por 12 $nick => 12 $chan $+ :13 $2-
      }
    }
  }

  if ($1 == !borrartexto) || ($1 == !delquote) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 2,0Sorry $nick you need to add a number between 1 and $lines(quote.txt) }
      if ($2 != $null) {
        write -dl $+ $2 quote.txt
        msg $chan **10 Mensaje $2 10Ha sido Removido
      }
    }
  }

  if ($1 == !ln) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 4Error: Forma Correcta 7!ln [Nick]. }
      if ($2 != $null) {
        if ( $2 == $me ) { .notice $nick Error - No Le Puedes dar $1 a $me | halt }
        if ( $2 ison $chan ) {
          if (%ln == on) .notice $nick **12Espera Unos Segundos, 4Abusas del Comando.
          else {
            set %ln on
            .timer 1 20 set %ln off
            .notice $nick **4/!\ $2 7ha sido agregado a la Lista Negra. 
            auser ln $2 
            .timer 1 3  kick $chan $2 4/!\Lista Negra/!\ 
          }
        }
      }
    }
  }

  if ($1 == !qln) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if ($2 == $null) { msg $chan ** 4Error: Forma Correcta 7!qln [Nick]. }
      if ($2 != $null) {
        if ( $2 == $me ) { .notice $nick Error - No Le Puedes dar $1 a $me | halt }
        if ( $2 ison $chan ) {
          if (%qln == on) .notice $nick **12Espera Unos Segundos, 4Abusas del Comando.
          else {
            msg $chan ** $2 12ha sido Removido de la Lista Negra. 
            set %qln on
            .timer 1 20 set %qln off
            ruser ln $2
            invite $2 $chan
          }
        }
      }
    }
  }

  if ($1 == !abrir-chan) || ($1 == !unlock) {
    if (%bot_state == off) { halt }
    if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
    if (%nivel. [ $+ [ $nick ] ] == 10) {
      if (%lock. [ $+ [ $chan ] ] == $null) msg $chan **12El Chanel No Tiene Ninguna Pass.
      else {
        unset %lock. [ $+ [ $chan ] ]
        msg $chan >>3Chanel Abierto.
        mode $chan -k 0
      }
    }
  }

  if ($1 == !cerrar-chan) || ($1 == !lock) {
    if (%bot_state == off) { halt }
    if ($2 == $null) {
      if (%nivel. [ $+ [ $nick ] ] == $null) { .notice $nick Error - Acceso Denegado! | .halt }
      if (%nivel. [ $+ [ $nick ] ] == 10) {
        if (%lock. [ $+ [ $chan ] ] == on) msg $chan **12El Chan Ya Esta Cerrado.
        else {
          set %lock. [ $+ [ $chan ] ] on
          msg $chan >>12Buscando Contraseña para el chanel...
          var %lock = $rand(1,9) | var %lock_2 = $rand(1,9) | var %lock_3 = $rand(1,9) | var %lock_4 = $rand(1,9) | var %lock_5 = $rand(1,9) | var %lock_6 = $rand(1,9)
          if (%lock = 1) var %1 1 | if (%lock_2 = 1) var %2 1 | if (%lock_3 = 1) var %3 1 | if (%lock_4 = 1) var %4 1 | if (%lock_5 = 1) var %5 1 | if (%lock_6 = 1) var %6 1
          if (%lock = 2) var %1 2 | if (%lock_2 = 2) var %2 2 | if (%lock_3 = 2) var %3 2 | if (%lock_4 = 2) var %4 2 | if (%lock_5 = 2) var %5 2 | if (%lock_6 = 2) var %6 2
          if (%lock = 3) var %1 3 | if (%lock_2 = 3) var %2  3 | if (%lock_3 = 3) var %3 3 | if (%lock_4 = 3) var %4 3 | if (%lock_5 = 3) var %5 3 | if (%lock_6 = 3) var %6 3
          if (%lock = 4) var %1 4 | if (%lock_2 = 4) var %2  4 | if (%lock_3 = 4) var %3 4 | if (%lock_4 = 4) var %4 4 | if (%lock_5 = 4) var %5 4 | if (%lock_6 = 4) var %6 4
          if (%lock = 5) var %1 5 | if (%lock_2 = 5) var %2 5 | if (%lock_3 = 5) var %3 5 | if (%lock_4 = 5) var %4 5 | if (%lock_5 = 5) var %5 5 | if (%lock_6 = 5) var %6 5
          if (%lock = 6) var %1 6 | if (%lock_2 = 6) var %2  6 | if (%lock_3 = 6) var %3 6 | if (%lock_4 = 6) var %4 6 | if (%lock_5 = 6) var %5 6 | if (%lock_6 = 6) var %6 6
          if (%lock = 7) var %1 7 | if (%lock _2 = 7) var %2 7 | if (%lock_3 = 7) var %3 7 | if (%lock_4 = 7) var %4 7 | if (%lock_5 = 7) var %5 7 | if (%lock_6 = 7) var %6 7
          if (%lock = 8) var %1 8 | if (%lock_2 = 8) var %2 8 | if (%lock_3 = 8) var %3 8 | if (%lock_4 = 8) var %4 8 | if (%lock_5 = 8) var %5 8 | if (%lock_6 = 8) var %6 8
          if (%lock = 9) var %1 9 | if (%lock_2 = 9) var %2 9 | if (%lock_3 = 9) var %3 9 | if (%lock_4 = 9) var %4 9 | if (%lock_5 = 9) var %5 9 | if (%lock_6 = 9) var %6 9
          .timer 1 2 mode $chan +k %1 $+ %2 $+ %3 $+ %4 $+ %5 $+ %6
          .timer 1 2 msg $chan >>4Chanel Bloqueadon con la Pass13 %1 $+ %2 $+ %3 $+ %4 $+ %5 $+ %6
        }
      }
    }
    if ($2 != $null) {
      mode $chan +k $2
      msg $chan >>4Chanel Bloqueadon con la Pass13 $2
      set %lock. [ $+ [ $chan ] ] on
      .timer 1 10 unset %lock. [ $+ [ $chan ] ]
    }
  }
}
raw 311:*:{ .notice %chan >> Nickname: $2 | .notice %chan >> Name: $6 | .notice %chan >> Identity: $3 | .notice %chan >> Host: $4 | .halt }
raw 307:*:{ .notice %chan >> Registered: Yes | .halt }
raw 319:*:{ .notice %chan >> Channels: $3- | .halt }
raw 312:*:{ .notice %chan >> Server: $3 | .notice %chan >> Description: $4- | .halt }
raw 328:*:{ .notice %chan 4>> IP: $7- | .halt }
raw 317:*:{ .notice %chan >> Idle Time: $replace($duration($3),wks,wks,wk,week,hrs,hrs,hr,hr,mins,mins,min,mim,secs,secs,sec,sec,days,days,day,day) | .notice %chan >> SignOn: $asctime($4) | .halt }
raw 418:*:{ .msg %chan $e $+  $3- | .halt }
raw 318:*:{ .notice %chan $e $+ >> End of Whois | .halt }
raw 313:*:{ .notice %chan >> IRCop: $5- | .halt }
raw 308:*:{ .notice %chan >> Service Agent: Yes | .halt }
raw 310:*:{ if (austnet.org isin $server) { .msg %chan >> Service: Yes | halt } | else { .msg %chan >> Helpful: $3- | .halt } } 
raw 309:*:{ .notice %chan >> Language: $3- | .halt }
raw 325:*:{ .notice %chan >> Language Filter:  $+ $3- | .halt }
raw 301:*:{ .notice %chan >> Away: $3- | .halt }

;~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*;
;           mIRC BOT SERV                        ;
;            Made by NT5                         ;
;*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~;
