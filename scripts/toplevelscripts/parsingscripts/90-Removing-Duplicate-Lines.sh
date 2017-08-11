#!/bin/bash
## Duplicate Removal

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../../scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

cat -s $TEMPFILEL | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEM
