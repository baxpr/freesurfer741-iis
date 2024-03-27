#!/bin/bash
#
# Entrypoint for post-freesurfer QA report and data reorg

# Defaults
export SUBJECTS_DIR=/OUTPUTS
export out_dir=/OUTPUTS
export label_info="Unknown label"

# Parse inputs
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --SUBJECTS_DIR)
        export SUBJECTS_DIR="$2"; shift; shift;;
    --label_info)
        export label_info="$2"; shift; shift;;
    --out_dir)
        export out_dir="$2"; shift; shift;;
    *)
		echo "Unknown argument $key"; shift;;
  esac
done

# Show what we got
echo SUBJECTS_DIR = "${SUBJECTS_DIR}"
echo out_dir      = "${out_dir}"

# Convert FS text stats output to dax-friendly CSV. Also compute for MM relabeling
stats2tables2outputs.sh

# Images for MM relabeling
create_MM_labelmaps.sh

# Convert some images to Nifti for convenience
nii_convert.sh

# Make PDFs

