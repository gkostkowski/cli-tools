# Overview
Script allows to filter content of a file based on values from other file.
Better alternative for imperfect 'grep -fxF'. Script allows to exclude or include
lines from given file. If '-c1' and '-c2' given, then you can achieve same effect
just like in case of 'join' linux tool. If delimiter will be skipped, then awk
will guess the delimiter (works for space and tabulation).Note: you have to specify
delimiter in some conditions (e.g. fields are separated by tab and each field can
contain a space).

Note: does not work properly for exclusion, if there is more than one occurence
of certain excluded string!

# Help & usage
```
./filter_by_other_content -h
```

```
Program: filter_by_other_content 0.0.1 by grzegorz.kostkowski@pwr.edu.pl
Updated: 2021-11-30 23:16
Description: Script allows to filter content of a file based on values from other file.
Usage: filter_by_other_content [-h] [-q] [-v] [-f] [-e] [-l <log_dir>] [-t <tmp_dir>] [-o <output>] [-c1 <filtered_col>] [-c2 <filtering_col>] [-d <delimiter>] <filtered_file> <filtering_file?>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -q|--quiet       : [flag] no output [default: off]
    -v|--verbose     : [flag] output more [default: off]
    -f|--force       : [flag] do not ask for confirmation (always yes) [default: off]
    -e|--exclude     : [flag] exclude content from <filtered-file> found in <filtering-file>; inclusion is the default mode [default: off]
    -l|--log_dir <?> : [option] folder for log files   [default: /home/grzesiek/log/filter_by_other_content]
    -t|--tmp_dir <?> : [option] folder for temp files  [default: /tmp/filter_by_other_content]
    -o|--output <?>  : [option] filtered content of <filtered-file>; if not given then outputs to STDOUT
    -c1|--filtered_col <?>: [option] index (starts from 1) of column in <filtered-file> which will be compared (whole line by default)
    -c2|--filtering_col <?>: [option] index (starts from 1) of column in <filtering-file> which will be compared (whole line by default)
    -d|--delimiter <?>: [option] delimiter (separator) for <filtered-file> and <filtering-file>
    <filtered_file>  : [parameter] file which will be filtered
    <filtering_file> : [parameter] file used to filter content of <filtered-file> (optional)

### TIPS & EXAMPLES
* #EXAMPLE: Filtering based on second columns, using any whitespace as a delimiter:
  #EXAMPLE:> filter_by_other_content -c1 2 -c2 2 -d ' ' -o /tmp/outfile tests/data/file03.tsv tests/data/file02.txt
* #EXAMPLE: Excluding based on second column and first, using dabulator as a delimiter:
  #EXAMPLE:> filter_by_other_content -c1 2 -c2 1 -d $'\t' -e -o /tmp/outfile tests/data/file03.tsv tests/data/file01.txt
```

# Acknowledgements
- Script built with [bashew](https://github.com/pforret/bashew) tool
- Tests use [bash_unit](https://github.com/pgrange/bash_unit)
