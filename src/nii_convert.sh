#!/usr/bin/env bash

for f in \
        nu \
        aseq \
        wmparc \
        brainmask \
        ThalamicNuclei.v12.T1.FSvoxelSpace \
        brainstemSsLabels.v12.FSvoxelSpace \
        lh.hippoAmygLabels-T1.v21.FSvoxelSpace \
        rh.hippoAmygLabels-T1.v21.FSvoxelSpace \
        lh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace \
        rh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace \
        lh.hippoAmygLabels-T1.v21.FS60.FSvoxelSpace \
        rh.hippoAmygLabels-T1.v21.FS60.FSvoxelSpace \
        lh.hippoAmygLabels-T1.v21.CA.FSvoxelSpace \
        rh.hippoAmygLabels-T1.v21.CA.FSvoxelSpace \
        lh.hippoLabels-T1.v21.MMAP.FSVoxelSpace \
        lh.hippoLabels-T1.v21.MMHBT.FSVoxelSpace \
        rh.hippoLabels-T1.v21.MMAP.FSVoxelSpace \
        rh.hippoLabels-T1.v21.MMHBT.FSVoxelSpace \
        lh.hippoLabels-T1.v21.MMAP \
        lh.hippoLabels-T1.v21.MMHBT \
        rh.hippoLabels-T1.v21.MMAP \
        rh.hippoLabels-T1.v21.MMHBT \
        ; do
    mri_convert "${mri_dir}/${f}.mgz" "${nii_dir}"/$(basename "${f}" .mgz).nii.gz
done

cp \
    "${mri_dir}/hippoLabels-T1.v21.MMAP.csv" \
    "${mri_dir}/hippoLabels-T1.v21.MMHBT.csv" \
    "${nii_dir}"
