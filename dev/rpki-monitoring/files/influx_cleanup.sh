#

tmprows=$(mktemp /tmp/cleanup_influx.XXXX)

# identify rows to be deleted

#VALIDATOR='routinator'
#VALIDATOR='rpki-client'
#VALIDATOR='fort'
#MODE="mode='rrdp'"
#MODE="mode!='norrdp'"
#REPO='lacnic_atl2'
REPO='lacnic'
LAST=20
VALIDATORS="fort rpki-client octorpki routinator"

for VALIDATOR in $VALIDATORS
do
    QRY="select validator,repo,vrp_count,host,mode from rpki where validator='$VALIDATOR' and repo='$REPO' and vrp_count < 11000 "

    echo Running $QRY

    influx -database='rpki' -execute "$QRY" | awk '/^[0-9]+/ {print $1}' | tail -$LAST | tee $tmprows

    # Deleting rows one by one

    for t in $(cat $tmprows)
    do
        DEL="delete from rpki where time=$t and validator='$VALIDATOR' and repo='$REPO'"
        echo Deleting timestamp $t: $DEL
        influx -database='rpki' -execute "$DEL"
    done

done
