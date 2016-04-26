
./tp1 < tests/test$1/__stdin__ > tests/test$1/__out__ 2> tests/test$1/__err__

diff -iadq tests/test$1/__out__ tests/test$1/__stdout__
v1=$?
diff -iadq tests/test$1/__err__ tests/test$1/__stderr__
v2=$?


if [ $v1 -eq 0 ] && [ $v2 -eq 0 ]; then
	echo "Paso la prueba $1"
else
	echo "NO PASA LA PRUEBA $1!!!!!!!"
fi
