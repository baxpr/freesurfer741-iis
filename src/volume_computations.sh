#!/usr/bin/env bash
#
# Compute and reformat regional volume/area/thickness measures

echo Volume computations

# Subcortical regions, aseg

# This provides our eTIV
asegstats2table \
    --delimiter comma \
    --meas volume \
    --subjects SUBJECT \
    --stats aseg.stats \
    --tablefile "${tmp_dir}"/aseg.csv

# High resolution pipelines
asegstats2table --delimiter comma -m volume \
    -s SUBJECT --statsfile=hipposubfields.lh.T1.v21.stats --tablefile=hipposubfields.lh.T1.v21.dat ...

# Surface parcels
#    aparc, aparc.pial, aparc.a2009s, aparc.DKTatlas, BA_exvivo
#    lh, rh
#    volume, area, thickness
for aparc in aparc aparc.a2009s aparc.pial aparc.DKTatlas BA_exvivo ; do
	for meas in volume area thickness ; do
		for hemi in lh rh ; do
			aparcstats2table --delimiter comma \
			-m $meas --hemi $hemi -s SUBJECT --parc $aparc \
			-t "${tmp_dir}"/"${hemi}-${aparc}-${meas}.csv"
		done
	done
done


# MM computations
echo "MM volume computations"
volume_computations.py "${subj_dir}"/stats "${tmp_dir}"


# Reformat CSVs
echo "Reformatting CSVs"
reformat_csvs.py "${tmp_dir}"
