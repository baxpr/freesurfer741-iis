#!/usr/bin/env bash
#
# Produce QA report and reformatted stats output from a Freesurfer subject
# directory after recon-all

# Defaults for input options
export subj_indir=/INPUTS/SUBJECT
export out_dir=/OUTPUTS
export label_info=


# Parse input options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in      
        --subj_indir)     export subj_indir="$2";     shift; shift ;;
        --out_dir)        export out_dir="$2";        shift; shift ;;
        --label_info)     export label_info="$2";     shift; shift ;;
        *) echo "Input ${1} not recognized"; shift ;;
    esac
done

# Output dirs
export SUBJECTS_DIR=/OUTPUTS
export subj_dir="${SUBJECTS_DIR}"/SUBJECT
cp -R "${subj_indir}" "${subj_dir}"
mkdir "${out_dir}"/{PDF,PDF_DETAIL,NIFTI,STATS,STATS_ABBREV}
export nii_dir="${out_dir}"/NIFTI

# Source and working dirs
export src_dir=$(realpath $(dirname $(which ${0})))
export tmp_dir="${subj_dir}"/tmp && mkdir -p "${tmp_dir}"
export mri_dir="${subj_dir}"/mri
export surf_dir="${subj_dir}"/surf

# Make additional MM ROI sets
create_MM_labelmaps.sh

# Convert some images to Nifti
nii_convert.sh

# Volume computations
volume_computations.sh

# Make CSV outputs
make_xnat_csvs.sh

# Make screenshots and PDFs
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
  "${out_dir}"/PDF/Freesurfer-QA.pdf

# Detailed PDF
make_slice_screenshots.sh

# Clean up
rm -fr "${subj_dir}"/tmp
rm -fr "${subj_dir}"/trash
