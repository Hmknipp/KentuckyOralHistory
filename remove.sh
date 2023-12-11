for i in *.txt
do
    echo -n $(tr -d "\\n" < "$i") > "$i"
done