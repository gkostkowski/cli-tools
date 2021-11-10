# Overview
Script allows to filter content of a file based on values from other file.
Better alternative for imperfect 'grep -fxF'.

# Usage
```
USAGE: ./filter_by_other_content.sh -i=FILE_TO_FILTER -f=FILTERING_FILE
-o=OUTPUT [-c=COLUMN_NO_IN_FILE_TO_FILTER] [-t=COLUMN_NO_IN_FILTERING_FILE]
[-d=DELIMITER] [-e|--exclude]
```

# Help
```
./filter_by_other_content.sh -h
```
```
Script allows to filter content of a file based on values from other file.
Better alternative for imperfect 'grep -fxF'. Script allows to exclude or include
lines from given file. If '-c' and '-t' given, then you can achieve same effect
just like in case of 'join' linux tool. If delimiter will be skipped, then awk
will guess the delimiter (works for space and tabulation).Note: you have to specify
delimiter in some conditions (e.g. fields are separated by tab and each field can
contain a space).

Note: does not work properly for exclusion, if there is more than one occurence
of certain excluded string!
./filter_by_other_content.sh -i=FILE_TO_FILTER -f=FILTERING_FILE -o=OUTPUT [-c=COLUMN_NO_IN_FILE_TO_FILTER]
[-t=COLUMN_NO_IN_FILTERING_FILE] [-d=DELIMITER] [-e|--exclude]
grzesiek@GP60-2PF:/mnt/98026171026154F2/PRACA-CLARIN/REPO/cli-tools/filter-by-other-content$ ./filter_by_other_content.sh -h
Script allows to filter content of a file based on values from other file.
Better alternative for imperfect 'grep -fxF'. Script allows to exclude or include
lines from given file. If '-c' and '-t' given, then you can achieve same effect
just like in case of 'join' linux tool. If delimiter will be skipped, then awk
will guess the delimiter (works for space and tabulation).Note: you have to specify
delimiter in some conditions (e.g. fields are separated by tab and each field can
contain a space).

Note: does not work properly for exclusion, if there is more than one occurence
of certain excluded string!
USAGE: ./filter_by_other_content.sh -i=FILE_TO_FILTER -f=FILTERING_FILE -o=OUTPUT [-c=COLUMN_NO_IN_FILE_TO_FILTER]
[-t=COLUMN_NO_IN_FILTERING_FILE] [-d=DELIMITER] [-e|--exclude]
```