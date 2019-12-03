
编译原理第一次上机

.l是词法分析
.y是语法分析

编译文件命令

flex xx.l
bison -d xx.y
gcc -o scanner.exe lex.yy.c ast.c xx.tab.c
