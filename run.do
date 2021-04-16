vsim +access+r;
run -all;
acdb save;
acdb report -db fcover.acdb -txt -o coverage_data.txt;
exit
