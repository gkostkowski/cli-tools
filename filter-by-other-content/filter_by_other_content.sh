#!/bin/bash
# Script allows to filter content of a file based on values from other file.
#  filtrowanie N-TEJ kolumny pliku wartościami z innego pliku
# lub całych linii wartościami z innego pliku
# alternatywa dla wadliwego grep -fxF
# skrypt działa dla separatorów: spacja lub tabulator
# skrypt posiada możliwość wykluczenia wyników z pliku FILTERING_FILE w pliku
# FILE_TO_FILTER

DESCR="Script allows to filter content of a file based on values from other file.
Better alternative for imperfect 'grep -fxF'. Script allows to exclude or include
lines from given file. If '-c' and '-t' given, then you can achieve same effect
just like in case of 'join' linux tool. If delimiter will be skipped, then awk
will guess the delimiter (works for space and tabulation).Note: you have to specify
delimiter in some conditions (e.g. fields are separated by tab and each field can
contain a space).

Note: does not work properly for exclusion, if there is more than one occurence
of certain excluded string!"
USAGE="USAGE: $0 -i=FILE_TO_FILTER -f=FILTERING_FILE -o=OUTPUT [-c=COLUMN_NO_IN_FILE_TO_FILTER]
[-t=COLUMN_NO_IN_FILTERING_FILE] [-d=DELIMITER] [-e|--exclude]"
INFO="$DESCR
$USAGE"

# returns absolute path
# as_abs() {
	# if [[ ! "$1" = /* ]]; then
	    # local result="$PWD/$1"
	# else
		# local result=$(realpath "$1")
	# fi
	# echo "$result"
# }
as_abs() {
	result=$(realpath "$1")
	echo "$result"
}

# defs
# first column has index == 1
column_no="0"  # defaults for full lines comparision
column_no_filtering="0"
exclude=""  # only included in both, by default
delim=''  # auto mode, guessing delimiter

# parse parameters
for i in "$@"
do
case $i in
    -i=* | --input=*) # file which will be filtered
    file_to_filter=$(realpath "${i#*=}")
    ;;
    -o=* | --output=*)
    output=$(realpath "${i#*=}")
    ;;
    -f=* | --from=*)  # file with lines to include/exclude in --input file
    filtering_file=$(realpath "${i#*=}")
    ;;
    -c=* | --col-no=*)  # number of column in input file which will be compared (whole line by default)
    column_no="${i#*=}"
    ;;
    -d=* | --delimiter=*)
    delim="${i#*=}"
    ;;
    -t=*)  # number of column in input file which will be used for comparision (whole line by default)
    column_no_filtering="${i#*=}"
    ;;
    -e | --exclude)
    exclude="yes"
    ;;
    -h | --help)
	echo "$INFO"
    exit 0
    ;;
    *)
	echo "ERROR: Unknown option."
	echo "$USAGE"
    # unknown option
    ;;
esac
done


if [ "$column_no" = 0 ];then
	echo "Filtering full lines ..."
fi

if [ "$column_no" = 0 ];then
	echo "Using only column $column_no_filtering from filtering file ..."
fi


if [ "$exclude" = yes ];then
	echo "Excluding lines from $filtering_file in $file_to_filter ..."
	excl='!'
else
	echo "Including lines from $filtering_file in $file_to_filter ..."
	excl=''
fi


if [ ! -z "$delim" ];then
	echo "Using specified delimiter '$delim' ..."
	awk \
		-F "$delim" \
		-v i=$column_no \
		-v j=$column_no_filtering \
		'FNR==NR { a[$j]; next } '$excl'($i in a)' \
		"$filtering_file" \
		"$file_to_filter" \
	> "$output"
else
	awk \
		-v i=$column_no \
		-v j=$column_no_filtering \
		'FNR==NR { a[$j]; next } '$excl'($i in a)' \
		"$filtering_file" \
		"$file_to_filter" \
	> "$output"
fi

echo "Result stored in $output"
