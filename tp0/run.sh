
./tp0 < tests/test$1/__stdin__ > tests/test$1/__out__ 2> tests/test$1/__err__
diff -iadq tests/test$1/__out__ tests/test$1/__stdout__
diff -iadq tests/test$1/__err__ tests/test$1/__stderr__

echo $?
