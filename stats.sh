code_200="$(grep 'code: 200' ./log.txt | wc -l)"
#code_404="$(grep '404' ./log.txt | wc -l)" 
code_503="$(grep '503' ./log.txt | wc -l)" 
code_499="$(grep 'code: 0' ./log.txt | wc -l)"
#code_reset="$(grep 'reset' ./log.txt | wc -l)"
code_done="$(grep 'status' ./log.txt)"

echo "200: $code_200";
#echo "404: $code_404"; 
echo "503: $code_503"; 
echo "499: $code_499"; 
#echo "reset: $code_reset"; 
echo "$code_done"; 
echo "Total: $(($code_200 + $code_503 + $code_499))"
grep 'Time' ./log.txt
