#!/usr/bin/env python3
# 
# Get center of mass of cortex ROI, in voxel index

import argparse
import nibabel
import numpy
import scipy.ndimage
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--axis', required=True)
parser.add_argument('--roi_niigz', required=True)
parser.add_argument('--imgval', required=True)
args = parser.parse_args()

img = nibabel.load(args.roi_niigz)
data = img.get_fdata()

# numpy can't handle nan voxels, so fix 'em
data[numpy.isnan(data)] = 0

# COM unweighted
data[data==args.imgval] = 1

# Get COM
com_vox = scipy.ndimage.center_of_mass(data)
com_world = nibabel.affines.apply_affine(img.affine, com_vox)

if args.axis == 'x':
    print('%d' % com_world[0])

if args.axis == 'y':
    print('%d' % com_world[1])

if args.axis == 'z':
    print('%d' % com_world[2])

