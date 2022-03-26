/ should return same parse tree -> {p~parse .unparse.unparse p:parse x}"1+2 3"
/ q).unparse.unparse parse"1+/:1 2 3*5"
/ "+/:[1;1 2 3*5]"
\d .unparse
unparse:{[pt]$[tab pt;tab0 pt;sql pt;sql0 pt;break pt;disp[pt;.z.s each 1_pt];vchar pt;str first pt;str pt]}; / [parse tree]

disp:{[pt;a]$[101h=t:type fn:first pt;dmonad fn;(fn~(each))|(2=count a)&102h=t;dinfix pt;dother][str first pt;a]}; / display[parse tree;args]
dmonad:{[fn;fs;a]$[(fn~(::))|enlist~fn;dother[fs;a];2=count a;string[fn]sv a;dother[fs;a]]};      / [function;function string;args]
dinfix:{[pt;fs;a]$[""~a 0;dother;last[fs]in"+-*%~!@#$^&|<>,?:=";dwrap[pt]"";dwrap[pt]" "][fs;a]}; / [parse tree;function string;args]
dother:{[fs;a]fs,"[",(";"sv a),"]"};
dwrap:{[pt;dl;fs;a]dl sv(dwrap0[pt 1]a 0;fs;a 1)}; / [parse tree;delim;function string;args]
dwrap0:{[pt;lhs]$[$[enlist~fn:first pt;0;sql[pt]|(fn~(each))|(3=count pt)&type[fn]in 101 102h];"(",lhs,")";lhs]}; / [parse tree;lhs arg]

break:{$[type x;0b;vchar x;0b;not x~()]};
achar:(1#-11h)~type';  / char atom?
vchar:(1# 11h)~type';  / char vector?
str:{str0 keyw x};     / string
str0:{(raze/)$[not -11h=type x;strop x;x in key .q;string x;strop x]};
strop:{$[x~();"()";x~(:);" :";type x;s1 x;not 103h=type first x;.z.s[first x],$[count 1_x;"[",{";"sv x}[s1'[1_x]],"]";""];
         2<count x;dother[s1 first x;s1'[1_x]];.z.s'[1_x],s1 first x]}; / adverbs
s1:{$[proj x;"";-11h=type x;string x;achar[x]|vchar x;.Q.s1 first x;any m:keyw0 x;string first where m;.Q.s1 x]};
keyw:{$[proj x;x;any m:keyw0 x;first where m;x]}; / keyword? e.g. flip
keyw0:{x~/:comp,(1_where 102h<>type each .q)#.q};
comp:{(`$x)!parse each x}("<>";">=";"<=");
proj:{104h=type(0;x)}; / projection? function courtesy of Kieran Lucid

/ sql needs special handling..
sql:{$[proj f:first x;0b;not any(?;!)~\:f;0b;5>count x;0b;proj x 2;0b;
       ((1=count x4)&0h=type x4)|(99h=type x4)|(()~x4)|(`$())~x4:x 4;not enlist~first x 2;0b]};
sql0:{" "sv{x where 0<count each x}(sqlf x;sqln . x 5 6;sqla x 4;sqlb x 3;"from";unparse x 1;sqlc x 2)};
sqlf:{$[(?)~first x;$[1b~x 3;"select distinct";not(::)~x 5;"select";(3#())~x 2 3 4;"exec";(0b~x 3)|()~x 4;"select";"exec"];
        11h=abs type first x 4;"delete";"update"]};
sqla:{$[11h=type x;"";type x;","sv get string[key x],'":",'unparse each x;(11h=type first x)&1=count x;","sv string first x;count x;unparse first x;""]};
sqlb:{$[-1h=type x;"";x~();"";"by ",sqla x]};
sqlc:{$[x~();"";"where ",","sv unparse each first x]};
/ assumes 6th arg is 2 element tuple, first is either > or <
sqln:{[n;o]{$[count x;"[",x,"]";""]}{$[count x;x,";",y;y]}.($[n~(::);"";not[(::)~first o]&n~0W;"";unparse n];$[(::)~o:first o;"";(1#string first o),unparse last o])};

/ table creation syntax needs special handling e.g. ([]1 2 3)
tab:{$[type x;0b;2<>count x;0b;not(+:)~first x;0b;type lx:last x;0b;3<>count lx;0b;not(!)~first lx;0b;
       not vchar lx 1;0b;type lx@:2;0b;not(enlist)~first lx;0b;count[lx]=1+count x . 1 1 0]};
tab0:{x:1 _ last x; / discard +: and !
      c:2 first/x;  / column names
      v:last x;     / values
      u:";"sv 1_(string each`,c),'":",'unparse each v;
      :"([]",u,")";
     };
\d .
