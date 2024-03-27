#!/usr/bin/env bash
#
# Produce PDF reports

# Source and working dirs
export src_dir=$(realpath $(dirname $(which ${0})))
export tmp_dir="${out_dir}"/imgtmp && mkdir -p "${tmp_dir}"
export subj_dir="${SUBJECTS_DIR}"/SUBJECT
export mri_dir="${subj_dir}"/mri
export surf_dir="${subj_dir}"/surf

mkdir -p "${out_dir}"/PDF

# Make screenshots and PDFs
export the_date=$(date)
page1.sh
page2.sh
page3.sh

exit 0

page4.sh
convert \
  "${tmp_dir}"/page1.png \
  "${tmp_dir}"/page2.png \
  "${tmp_dir}"/page3.png \
  "${tmp_dir}"/page4.png \
  "${out_dir}"/PDF/Freesurfer-QA.pdf

# Detailed PDF
make_slice_screenshots.sh

# Clean up
rm -fr "${subj_dir}"/trash
