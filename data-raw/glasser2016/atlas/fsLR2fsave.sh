
# 0 mmp in fslr
# downloaded from: https://balsa.wustl.edu/WN56

# 0.1 convert to label.gii

#in_path=./Glasser_et_al_2016_HCP_MMP1.0_kN_RVVG/HCP_PhaseTwo/Q1-Q6_RelatedParcellation210/MNINonLinear/fsaverage_LR32k/
fname_l=Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR
fname_r=Q1-Q6_RelatedParcellation210.R.CorticalAreas_dil_Colors.32k_fs_LR
wb_command -cifti-separate $fname_l.dlabel.nii COLUMN -label CORTEX_LEFT $fname_l.label.gii
wb_command -cifti-separate $fname_r.dlabel.nii COLUMN -label CORTEX_RIGHT $fname_r.label.gii


# 1 mmp in fsaverage

# 1.1 download from: https://figshare.com/articles/dataset/HCP-MMP1_0_projected_on_fsaverage/3498446

# 1.2 downsampling to fsaverage5 and fsaverage6
hemis=(lh rh)
spaces=(fsaverage5 fsaverage6)
for space in ${spaces[@]}
do
    for hemi in ${hemis[@]}
    do
        mri_surf2surf --srcsubject fsaverage \
        --trgsubject $space \
        --sval-annot ./${hemi}.HCP-MMP1.annot \
        --tval ./${hemi}.HCP-MMP1_${space}.annot --hemi ${hemi}
    done
done

# 1.3 converting .annot to .gii
spaces=(fsaverage fsaverage5 fsaverage6)
for space in ${spaces[@]}
do
    if [[ $space = "fsaverage" ]]
    then
        inspace=""
    else
        inspace=_$space
    fi

    for hemi in ${hemis[@]}
    do
        mris_convert \
        --annot ${hemi}.HCP-MMP1${inspace}.annot \
        /usr/local/freesurfer/subjects/${space}/surf/${hemi}.white ${hemi}.HCP-MMP1_${space}.gii
    done
done

