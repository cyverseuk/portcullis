a#!/bin/bash

function debug {
  echo "creating debugging directory"
mkdir .debug
for word in ${rmthis}
  do
    if [[ "${word}" == *.sh ]] || [[ "${word}" == lib ]]
      then
        mv "${word}" .debug;
      fi
  done
}

rmthis=`ls`
echo ${rmthis}

GENOMEU="${genome}"
BAMFILEU="${bam_file}"
REFERENCEU=(${reference})
INPUTSU="${GENOMEU}, ${BAMFILE}, ${REFERENCEU[@]:1}"
CMDLINEARG="portcullis full -o output ${reference} ${verbose} ${bam_filter} ${exon_gff} ${intron_gff} ${use_csi} ${orientation} ${strandedness} ${separate} ${extra} ${max_length} ${canonical} ${min_cov} ${save_bad} ${GENOMEU} ${BAMFILEU}"
echo inputs are ${INPUTSU}
echo arguments are ${CMDLINEARG}


echo  universe                = docker >> lib/condorSubmitEdit.htc
echo docker_image            =  cyverseuk/portcullis:1.0.0beta6 >> lib/condorSubmitEdit.htc ######
echo executable               =  ./launch.sh >> lib/condorSubmitEdit.htc
echo arguments                          = ${CMDLINEARG} >> lib/condorSubmitEdit.htc
echo transfer_input_files = ${INPUTSU} >> lib/condorSubmitEdit.htc
echo transfer_output_files = output >> lib/condorSubmitEdit.htc
cat /mnt/data/apps/lib/condorSubmit.htc >> lib/condorSubmitEdit.htc

less lib/condorSubmitEdit.htc

jobid=`condor_submit lib/condorSubmitEdit.htc`
jobid=`echo $jobid | sed -e 's/Sub.*uster //'`
jobid=`echo $jobid | sed -e 's/\.//'`

#echo $jobid

#echo going to monitor job $jobid
condor_tail -f $jobid

debug

exit 0

