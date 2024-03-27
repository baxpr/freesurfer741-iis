#!/usr/bin/env python3
#
# Need in path: /usr/local/freesurfer/python/bin

import os
import pandas
import string

subject_dir = '/wkdir/INPUTS/SUBJECT'
mri_dir = f'{subject_dir}/mri'

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
hipp_lh = pandas.read_csv(os.path.join(mri_dir,'lh.hippoSfVolumes.txt'),
    sep=' ',header=None)
hipp_rh = pandas.read_csv(os.path.join(mri_dir,'rh.hippoSfVolumes.txt'),
    sep=' ',header=None)

# Append hemisphere to var name
hipp_lh[0] = [f'lh_{x}' for x in hipp_lh[0]]
hipp_rh[0] = [f'rh_{x}' for x in hipp_rh[0]]

# Concatenate
hipp = pandas.concat([hipp_lh, hipp_rh], axis=0)

# Sanitize varnames
hipp[0] = [sanitize(x) for x in hipp[0]]

# Tranpose and write to file
hipp.transpose().to_csv('test.csv', header=False, index=False)

