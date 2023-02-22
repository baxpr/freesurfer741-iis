#!/usr/bin/env bash
#
# Generate a number of useful extra outputs from Freesurfer results: PDF page,
# regional volumes, and Nifti images.

echo "Generating outputs"

# Stats
make_xnat_csvs.sh

# Make screenshots and PDFs
mkdir "${out_dir}"/PDF
export the_date=$(date)
page1.sh
page2.sh
page3.sh
page4.sh
convert \
  "${tmp_dir}"/page1.png \
  "${tmp_dir}"/page2.png \
  "${tmp_dir}"/page3.png \
  "${tmp_dir}"/page4.png \
  "${out_dir}"/PDF/freesurfer.pdf

# Detailed PDF
make_slice_screenshots.sh

# Clean up (DAX will ignore these if we move them here)
rm -fr "${SUBJECTS_DIR}"/SUBJECT/tmp
rm -fr "${SUBJECTS_DIR}"/SUBJECT/trash


