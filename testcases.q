t:([]date:5#.z.d;x:til 5;y:10*til 5;z:1 1 2 2 2)
\d .unparse
tests:()
add:{tests,:enlist(),x}
test:{test0[]|test0[]}
test0:{tests!@[{p~parse unparse p:parse x};;0b]each tests}
add 1#"1"
add 1#"t"
add"flip(1 2 3;3 4 5)"
add"1+1"
add"1+1 2 3"
add"1+'1 2 3"
add"1+/1 2 3"
add"1,''\"1 2 3 4\""
add"5 mod 1 2 3"
add"1+/:'\\:1 2 3"
add"1+/:'2 3"
add"1+"
add"+[;1]"
add"+[;1+']"
add"{x+y+1}'[1 2]'[3 4]"
add"{x+y}[1][2]"
add"('[;])over(g1;g;f)"
add"{x y}[{x+y}5]"
add"(\"III\";csv)0:"
add"t lj y,u"
add"(t lj y,u)uj yy"
add"(t lj y,u)uj\\:yy"
add 1#"`"
add"a:1;b:2;a+b"
add"`a"
add"`a`b`c"
add"`a`b`c,''\\:`k`i"
add"enlist[1;2;3]"
add"(1+2)*3"
add"([]x;y)"
add"select from t"
add"select x,y from t"
add"select x from t"
add"exec enlist x:x from t"
add"exec from t"
add"select x,y+5 by z from t lj y where date=last .z.d"
add"select[n] x,y+5 by z from t lj y where date=last .z.d"
add"select x,y,z+1 by z+i,x from t"
add"select distinct x,y from t"
add"?[select from t where x>0;enlist(=;`date;`.z.d);0b;()]"
add"exec x from t where z=2"
add"?[t;enlist(=;`date;`.z.d);0b;]"
add"?[t;enlist(=;`date;`.z.d);0b;()]"
add"update c:sum x by z from t where y<30"
add"![t;enlist(<;`y;30);enlist[`z]!enlist`z;enlist[`c]!enlist(sum;`x)]"
add"()"
add"`j`k`i 4"
add"v::1"
add"delete x from t where z=2"
add"delete x,y from t where z=2"
add"delete from t where z=2"
add"delete from t"
add"delete x from t"
add"delete from delete c,x from update c:sum x by z from select from t where 1b"
add"x+:1"
add"x*:9"
add"select[x+1]from t"
add"select[>x+1]from t"
add"select[x+1;>x+1]from t"
add"select[>x]from t"
add"select[2 1;>x]from t"
add"select[1;>x]from t"
add"select[1;<x]from t"
add"select[0W;>x]from t"
add"select[0W]from t"
add"select[1+{count x}x+1;>x+1]from t"
add"?[t;();0b;(enlist c)!enlist c]"
add"([]())"
add"([]1 2)"
add"([]1 2;3)"
add"a+b*c"
add"(a+b)*c"
add"a+(b*c)"
add"f[a;b]*c"
add"f[a]*b"
add"(f[a])*b"
add"reverse[a]*b"
add"type each x"
add"(x+:1)*n"
add"f each'x"
add"f each''x"
add"(x)*::5"
add"($[1;1])*n"
add"($[1])*n"
add"(enlist[1;2])*n"
add"(enlist)*n"
add"([]1 2)*t"
add"(select from t)+1"
add"1+select from t"
add"(1>=4)*h"
add"(1+1>=)-5"
add"0--5"
add"'[{x};{y}]1"
add"+'"
add"1+'"
add"+'[;1]"
add"'`blah"
add"'`blah`k"
add"'\"blah`k\""
add"type'[x]"
add"('\"abc\"),x"
add"0 1 2'[1 2 3;10 20 30;100]"
add"'[1;5]"
add"'[{x+1};][{x+y}][1]2"
add"'[{x+1}]"
add"'[+;1]"
add",//[x],6"
add",//[x],5"
add"6,,//[x]"
add",/\\[x],6"
add",/\\[x],5"
add"6,,/\\[x]"
add"10(')[{x};{x+y}]'1 2 3"
add"10(')[{x};{x+y}]'"
add"(')[{x};{x+y}]'[10;]"
add"(')[{x};{x+y}]'[;10]"
add"(;){x+y}"
add"{x-y}[;1]4"
add"{x+y}[;]1"
add"{x+y}[2;3]6"
add"select from bt where a in(exec aa from bt2 where i<5,i in til 5)"
/ the dream
/add each {x{where not x~\:""}@[-5!;;""]each x}{@[x;where x like"k){*";{@[-1_x;2;:;" "]}]}string get .q
\d .
