# Freesurfer 7.4.1 plus custom post-processing

The base container is stock Freesurfer 7.4.1 (docker://freesurfer/freesurfer:7.4.1).

Developed using manifest digest sha256:10b6468cbd9fcd2db3708f4651d59ad75d4da849a2c5d8bb6dba217f08b8c46b

Additional system packages are added to support freeview and imagemagick 
(see the Dockerfile).

Some custom postprocessing code -

- Reformats and combines stats outputs to a simpler CSV format

- Adds additional relabelings of the hippocampal subfield segmentation, following
    McHugo M, Talati P, Woodward ND, Armstrong K, Blackford JU, Heckers S. 
    Regionally specific volume deficits along the hippocampal long axis in 
    early and chronic psychosis. Neuroimage Clin. 2018;20:1106-1114. 
    doi: 10.1016/j.nicl.2018.10.021. PMID: 30380517; 
    [PMCID: PMC6202690](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6202690/).

- Produces two PDF-format QC reports

## Entrypoints

The default entrypoint is `run-everything.sh`, which performs recon-all plus 
subfield segmentations of hippocampus/amygdala, brainstem, thalamus; then
performs the postprocessing. Command line options are

    --t1_niigz        The T1 image to process
    --subjects_dir    Freesurfers SUBJECTS_DIR
    --label_info      A label to affix to the QC PDFs
    --out_dir         Outputs directory

A `postproc-entrypoint.sh` is also available if the main freesurfer pipeline
has already been run. Its command line options are

    --subjects_dir    Freesurfers SUBJECTS_DIR
    --label_info      A label to affix to the QC PDFs
    --out_dir         Outputs directory

`SUBJECT` is used as the Freesurfer subject ID throughout.
