#!/bin/bash
# SHIELDS - RAV1E - ENCODING

codec="av1"
encoder_name="RAV1E"
org_seq_name="shields_720p.y4m"
name="shields"
w=1280
h=720
n=300
fps=50

curr_dir=`pwd`
dest_dir="${encoder_name}_${name}"

encoder_path="/home/ubuntu/rav1e" # Set param with your svtav1 encoder path
cp -r ${encoder_path} ${dest_dir}
cd ${dest_dir}

encode() {
(/usr/bin/time -o enctime_${i}.txt -f "%U %S %E" ./rav1e ${curr_dir}/${org_seq_name} -s 1 --tiles 4 --tune Psnr -b ${i} -o ${name}_${i}.ivf) &> encdata_${i}.txt
}

for i in {500..1100..200}
do
    encode
done

for i in {1500..8000..500}
do
    encode
done

cd ${curr_dir}
