# !/bin/bash

# PART 1
cd ~/Desktop

unzip titanic.zip
cd ./titanic/
printf "\n"
echo "No. of rows:"
cat train.csv  | wc -l  # print the row no.

printf "\n"
echo "No. of columns:"
awk -F, '{print NF; exit}' train.csv

printf "\n"
echo "Head of the file:"
head -n 5 ./train.csv

printf "\n"
echo "tail of the file:"
tail -n 5 ./train.csv

printf "\n"
echo "show the whole file with cat:"
cat train.csv

printf "\n"
echo "show the file with less:"
less -XE train.csv

printf "\n"
echo "show the names:"
cut -d '"' -f 2 train.csv | tr -d '"'

# print the last 5 lines to this tail file
touch train_tail.csv
tail -n 5 train.csv > train_tail.csv

printf "\n"
echo "3rd to 5th line of train.csv"
awk 'FNR>=3 && FNR<=5' train.csv


# Q8: Explain du -a . | sort -n -r | head -n 20:
# basically you sort something like the disk space
# under current folder and its sub-folders and take the
# first 20 for the sake of decency
# I don't see it's a very practical command
# Sherry Liu

# split train.csv
split -l 20 ./train.csv tempfile.part.


# PART 2
printf "\n"
echo "here begins part_2"

mkdir ~/ultratrail/
cd ~/ultratrail/
# HERE we needa wget the source file but it failed from the slack side...

#!/bin/bash
for (( c=2003; c<=2017; c++ ))
do
    echo "No. of rows of utmb_$c:"
    cat utmb_$c.csv  | wc -l
    echo "No. of columns of utmb_$c:"
    awk -F, '{print NF; exit}' utmb_$c.csv
    echo "first 2 lines of utmb_$c:"
    head -n 2 utmb_$c.csv
    printf "\n"
done

# Question 3
mkdir ./backups/
for i in *.csv; do
    cp $i ./backups/bkp-$i
done


# PART 3
# Question 1
#!/bin/bash
echo "Type the data format that you want, followed by [ENTER]:"
read format
if [ "$format" == "csv" ] || [ "$format" == "xlsx" ] || [ "$format" == "pdf" ] || [ "$format" == "doc" ] || [ "$format" == "txt" ]; then
    touch selected.$format
else
    echo "format can only be csv, xlsx, pdf, doc, or txt."
fi


# Question 2
# keep the first N lines of each file ended with csv
#!/bin/bash
echo "Type the number of lines you want and [ENTER]:"
read nol
if ! [[ "$nol" =~ ^[0-9]+$ ]]; then
    echo "error: Not an integer"
else
    for i in *.csv; do
	touch new_$i
	mv $i ori_$i
	head -n $nol ori_$i > new_$i
	rm ori_$i
	mv new_$i $i || break
    done  # end of for
fi  # end of if

# send these files out at 8:00 AM
while :; do sleep 1d; echo "hello" | mail -s "subject" your@email.com; done
# or we can use if under this never-ending while condition
# so that when the clock hits 8:00 AM we shoot out the email
