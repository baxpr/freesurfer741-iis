#!/usr/bin/env bash
#
# Compute regional volume/area/thickness measures
#
# Needs SUBJECTS_DIR, out_dir

echo stats2tables2outputs

subj_dir="${SUBJECTS_DIR}"/SUBJECT
stats_dir="${out_dir}"/STATS
tmp_dir="${out_dir}"/tmp

mkdir -p "${stats_dir}"
mkdir -p "${tmp_dir}"

# aseg volumes
asegstats2table \
    --delimiter comma \
    --meas volume \
    --subjects SUBJECT \
    --stats aseg.stats \
    --tablefile "${tmp_dir}"/aseg.csv

# Surface parcellations
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

# Convert FS CSVs to dax-friendly CSVs
process_aseg.py --aseg_csv "${tmp_dir}"/aseg.csv --out_dir "${stats_dir}"

process_BA_exvivo.py --csv_dir "${tmp_dir}" --out_dir "${stats_dir}"
process_DKTatlas.py --csv_dir "${tmp_dir}" --out_dir "${stats_dir}"
process_a2009s.py --csv_dir "${tmp_dir}" --out_dir "${stats_dir}"
process_aparc.py --csv_dir "${tmp_dir}" --out_dir "${stats_dir}"
process_pial.py --csv_dir "${tmp_dir}" --out_dir "${stats_dir}"

process_brainstem_volumes.py --subject_dir "${subj_dir}" --out_dir "${stats_dir}"
process_hippamyg_volumes.py --subject_dir "${subj_dir}" --out_dir "${stats_dir}"
process_thalamus_volumes.py --subject_dir "${subj_dir}" --out_dir "${stats_dir}"

# Extra computations for MM relabeling of hippocampus subfields
compute_MM_volumes.py --stats_dir "${stats_dir}"
