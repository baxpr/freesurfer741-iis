#!/usr/bin/env bash
#
# Produce QA report and reformatted stats output from a Freesurfer subject
# directory after recon-all

# Defaults for input options
export SUBJECTS_DIR=/INPUTS
export subj=SUBJECT
export out_dir=/OUTPUTS
export label_info=


# Parse input options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in      
        --SUBJECTS_DIR)   export SUBJECTS_DIR="$2";   shift; shift ;;
        --subj)           export subj="$2";           shift; shift ;;
        --out_dir)        export out_dir="$2";        shift; shift ;;
        --label_info)     export label_info="$2";     shift; shift ;;
        *) echo "Input ${1} not recognized"; shift ;;
    esac
done

# Various source and working dirs
export src_dir=$(realpath $(dirname $(which ${0})))
export subj_dir="${SUBJECTS_DIR}/${subj}"
export tmp_dir="${subj_dir}"/tmp
export mri_dir="${subj_dir}"/mri
export surf_dir="${subj_dir}"/surf

# Make screenshots and PDFs
export the_date=$(date)
mkdir "${out_dir}"/PDF
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
