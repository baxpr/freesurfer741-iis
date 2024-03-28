# Freesurfer 7.4.1 plus custom post-processing

The base container is stock Freesurfer 7.4.1 (docker://freesurfer/freesurfer:7.4.1).

Developed using manifest digest sha256:10b6468cbd9fcd2db3708f4651d59ad75d4da849a2c5d8bb6dba217f08b8c46b

Additional system packages are added to support freeview and imagemagick 
(see the Dockerfile).

Some custom postprocessing code -

- Reformats stats outputs to a more friendly CSV

- Adds additional relabelings of the hippocampal subfield segmentation, following
    McHugo M, Talati P, Woodward ND, Armstrong K, Blackford JU, Heckers S. 
    Regionally specific volume deficits along the hippocampal long axis in 
    early and chronic psychosis. Neuroimage Clin. 2018;20:1106-1114. 
    doi: 10.1016/j.nicl.2018.10.021. PMID: 30380517; 
    [PMCID: PMC6202690](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6202690/).

- Produces two PDF-format QC reports
