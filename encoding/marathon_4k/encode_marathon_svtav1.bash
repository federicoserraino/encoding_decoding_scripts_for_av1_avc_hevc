#!/bin/bash
# MARATHON - SVT_AV1 - ENCODING

codec="av1"
encoder_name="SVTAV1"
org_seq_name="marathon_4k.yuv"
name="marathon"
w=3840
h=2160
n=150
fps=30

curr_dir=`pwd`
dest_dir="${encoder_name}_${name}"

encoder_path="/home/ubuntu/svtav1" # Set param with your svtav1 encoder path
cp -r ${encoder_path} ${dest_dir}
cd ${dest_dir}

for i in {5000..30000..2500}
do
(/usr/bin/time -o enctime_${i}.txt -f "%U %S %E" ./SvtAv1EncApp -i ${curr_dir}/${org_seq_name} -w ${w} -h ${h} -n ${n} --fps ${fps} --preset 4 --progress 2 --rc 1 --tbr ${i} -b ${name}_${i}.${codec}) &> encdata_${i}.txt
done

cd ${curr_dir}
