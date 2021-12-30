#mike freund, 2021-12-23
#downloaded from:
#https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal/Parcellations
# location on ccplinux1: /data/nil-external/ccp/freund/atlases/Schaefer2018/annot2gifti

dir_download=/data/nil-external/ccp/freund/atlases/Schaefer2018/Parcellations
dir_out=/data/nil-external/ccp/freund/atlases/Schaefer2018/giftis

spaces=(fsaverage fsaverage5 fsaverage6)
nparcs=(100 200 300 400 500 600 700 800 900 1000)
nnetws=(7 17)
hemis=(lh rh)
hemis_out=(L R)

for nparc in ${nparcs[@]}
do
        for nnetw in ${nnetws[@]}
        do
                atlas=Schaefer2018_${nparc}Parcels_${nnetw}Networks
                echo $atlas

                for space in ${spaces[@]}
                do
                        for hemi in ${!hemis[@]}
                        do
                                input=$dir_download/FreeSurfer5.3/${space}/label/${hemis[$hemi]}.${atlas}_order.annot
                                template=$dir_download/FreeSurfer5.3/${space}/surf/${hemis[$hemi]}.white
                                output=$dir_out/${atlas}_order_${hemis_out[$hemi]}_${space}.label.gii
                                echo $input $template $output
                                mris_convert --annot $input $template $output
                        done
                done
        done
done
