#!/usr/bin/env python3
#
# Need in path: /usr/local/freesurfer/python/bin

import argparse
import os
import pandas
import string

parser = argparse.ArgumentParser()
parser.add_argument('--aseg_csv', required=True)
parser.add_argument('--out_dir', required=True)
args = parser.parse_args()

# Function to sanitize varnames. Alphanumeric or underscore only
def sanitize(input_string):
    validchars = string.ascii_letters + string.digits + '_'
    output_string = ''
    for i in input_string:
        if i in validchars:
            output_string += i.lower()
        else:
            output_string += '_'
    return output_string

# Load freesurfer volumes data
aseg = pandas.read_csv(args.aseg_csv)

# Drop first column (subject label)
aseg = aseg.drop(aseg.columns[0], axis=1)

#print(aseg)

# Sanitize varnames
aseg.columns = [sanitize(x) for x in aseg.columns]

#for x in aseg.columns:
#    print(f"    '{x}',")

# Use known list of desired outputs. Fill with 0 any missing (and drop any
# that are unexpected)
rois = [
    'left_lateral_ventricle',
    'left_inf_lat_vent',
    'left_cerebellum_white_matter',
    'left_cerebellum_cortex',
    'left_thalamus',
    'left_caudate',
    'left_putamen',
    'left_pallidum',
    '3rd_ventricle',
    '4th_ventricle',
    'brain_stem',
    'left_hippocampus',
    'left_amygdala',
    'csf',
    'left_accumbens_area',
    'left_ventraldc',
    'left_vessel',
    'left_choroid_plexus',
    'right_lateral_ventricle',
    'right_inf_lat_vent',
    'right_cerebellum_white_matter',
    'right_cerebellum_cortex',
    'right_thalamus',
    'right_caudate',
    'right_putamen',
    'right_pallidum',
    'right_hippocampus',
    'right_amygdala',
    'right_accumbens_area',
    'right_ventraldc',
    'right_vessel',
    'right_choroid_plexus',
    '5th_ventricle',
    'wm_hypointensities',
    'left_wm_hypointensities',
    'right_wm_hypointensities',
    'non_wm_hypointensities',
    'left_non_wm_hypointensities',
    'right_non_wm_hypointensities',
    'optic_chiasm',
    'cc_posterior',
    'cc_mid_posterior',
    'cc_central',
    'cc_mid_anterior',
    'cc_anterior',
    'brainsegvol',
    'brainsegvolnotvent',
    'lhcortexvol',
    'rhcortexvol',
    'cortexvol',
    'lhcerebralwhitemattervol',
    'rhcerebralwhitemattervol',
    'cerebralwhitemattervol',
    'subcortgrayvol',
    'totalgrayvol',
    'supratentorialvol',
    'supratentorialvolnotvent',
    'maskvol',
    'brainsegvol_to_etiv',
    'maskvol_to_etiv',
    'lhsurfaceholes',
    'rhsurfaceholes',
    'surfaceholes',
    'estimatedtotalintracranialvol',
    ]
vals = list()
for roi in rois:
    mask = [x==roi for x in rois]
    if sum(mask)>1:
        raise Exception(f'Found >1 value for {roi}')
    elif sum(mask)==1:
        #vals.append(aseg[1].loc[aseg[0]==roi].array[0])
        vals.append(aseg[roi].array[0])
    else:
        print(f'WARNING - no volume found for ROI {roi}')
        vals.append(0)

# Make data frame and write to file
asegout = pandas.DataFrame([rois, vals])
asegout.to_csv(os.path.join(args.out_dir,'aseg.csv'), 
    header=False, index=False)
