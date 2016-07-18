/ should return same parse tree -> {p~parse .unparse.unparse p:parse x}"1+2 3"
/ q).unparse.unparse parse"1+/:1 2 3*5"
/ "+/:[1;(1 2 3*5)]"
\d .unparse
unparse:{$[sql x;sql0 x;break x;disp[first x;str first x;.z.s each 1_x];vchar x;str first x;str x]};
disp:{[f;x;y]$[101h=t:type f;dmonad f;(2=count y)&102h=t;dinfix;dother][x;y]}; / display
dmonad:{[f;x;y]$[(2=count y)|(f~(::))|enlist~f;dother[x;y];x," ",raze y]};
dinfix:{$[""~y 0;dother;last[x]in"+-*%~!@#$^&|<>,?:";dwrap"";dwrap" "][x;y]};
dother:{x,"[",(";"sv y),"]"};
dwrap:{[d;x;y]"(",(d sv(y 0;x;y 1)),")"};
break:{$[type x;0b;vchar x;0b;not x~()]};
achar:(1#-11h)~type';  / char atom?
vchar:(1# 11h)~type';  / char vector?
str:{str0 keyw x};     / string
str0:{(raze/)$[not -11h=type x;strop x;x in key .q;string x;strop x]};
strop:{$[x~();"()";x~(:);" :";type x;s1 x;103h=type first x;.z.s'[1_x],s1 first x;.z.s[first x],$[count 1_x;"[",s1'[1_x],"]";""]]};
s1:{$[proj x;"";-11h=type x;string x;achar[x]|vchar x;.Q.s1 first x;any m:keyw0 x;string first where m;.Q.s1 x]};
keyw:{$[proj x;x;any m:keyw0 x;first where m;x]}; / keyword? e.g. flip
keyw0:{x~/:comp,(1_where 102h<>type each .q)#.q};
comp:{(`$x)!parse each x}("<>";">=";"<=");
proj:{104h=type(0;x)}; / projection? function courtesy of Kieran Lucid

/ sql needs special handling..
sql:{$[proj f:first x;0b;not any(?;!)~\:f;0b;5>count x;0b;proj x 2;0b;((1=count x4)&0h=type x4)|(99h=type x4)|(()~x4)|(`$())~x4:x 4;not enlist~first x 2;0b]};
sql0:{" "sv{x where 0<count each x}(sqlf x;sqln . x 5 6;sqla x 4;sqlb x 3;"from";unparse x 1;sqlc x 2)};
sqlf:{$[(?)~first x;$[1b~x 3;"select distinct";not(::)~x 5;"select";(3#())~x 2 3 4;"exec";(0b~x 3)|()~x 4;"select";"exec"];11h=abs type first x 4;"delete";"update"]};
sqla:{$[11h=type x;"";type x;","sv get string[key x],'":",'unparse each x;(11h=type first x)&1=count x;","sv string first x;count x;unparse first x;""]};
sqlb:{$[-1h=type x;"";x~();"";"by ",sqla x]};
sqlc:{$[x~();"";"where ",","sv unparse each first x]};
/ assumes 6th arg is 2 element tuple, first is either > or <
sqln:{[n;o]{$[count x;"[",x,"]";""]}{$[count x;x,";",y;y]}.($[n~(::);"";not[(::)~first o]&n~0W;"";unparse n];$[(::)~o:first o;"";(1#string first o),unparse last o])};
\d .
