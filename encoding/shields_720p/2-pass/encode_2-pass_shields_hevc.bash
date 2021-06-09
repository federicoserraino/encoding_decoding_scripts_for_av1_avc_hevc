#!/bin/bash
# SHIELDS - HEVC - ENCODING TWO PASS (with ffmpeg)

codec="hevc"
encoder_name="HEVC"
org_seq_name="shields_720p.yuv"
name="shields_2-pass"
w=1280
h=720
n=300
fps=50
dest_dir="${codec}_${name}"

mkdir ${dest_dir}

for i in {100..2000..200}
do
/usr/bin/time -o ${dest_dir}/enctime_1st-pass_${i}.txt -f "%U %S" ffmpeg -y -f rawvideo -vcodec rawvideo -pix_fmt yuv420p -s ${w}x${h} -r ${fps} -i ${org_seq_name} -c:v libx265 -b ${i}k -x265-params pass=1 -preset slow -tune psnr -f rawvideo /dev/null

(/usr/bin/time -o ${dest_dir}/enctime_2nd-pass_${i}.txt -f "%U %S" ffmpeg -y -f rawvideo -vcodec rawvideo -pix_fmt yuv420p -s ${w}x${h} -r ${fps} -i ${org_seq_name} -c:v libx265 -b ${i}k -x265-params pass=2 -preset slow -tune psnr -f mpeg2video ${dest_dir}/${name}_${i}.${codec}) &> ${dest_dir}/encdata_${i}.txt
done
