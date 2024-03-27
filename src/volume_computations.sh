#!/usr/bin/env bash
#
# Compute and reformat regional volume/area/thickness measures

echo Volume computations

# MM computations
echo "MM volume computations"
volume_computations.py "${subj_dir}"/stats "${tmp_dir}"


# Reformat CSVs
echo "Reformatting CSVs"
reformat_csvs.py "${tmp_dir}"
