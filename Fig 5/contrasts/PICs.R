library(ape)

phy <- read.tree('PA_tree_pruned.tree')
traits <- read.csv(file = 'resistances.csv', row.names = 1)
traits <- traits[phy$tip.label, ]

mexz_binary <- traits[, 1]
mexz_score <- traits[, 2]
dyn_res <- traits[, 3]
ss_res <- traits[, 4]
ratio <- traits[, 5]

contrast_mexz_binary <- pic.ortho(mexz_binary,phy)
contrast_mexz_score <- pic.ortho(mexz_score,phy)
contrast_dyn_res <- pic.ortho(dyn_res,phy)
contrast_ss_res <- pic.ortho(ss_res,phy)
contrast_ratio <- pic.ortho(ratio,phy)

contrast_mexz_binary_nonzero <- contrast_mexz_binary[contrast_mexz_binary!=0]
contrast_dyn_res_nonzero <- contrast_dyn_res[contrast_mexz_binary!=0]
contrast_ss_res_nonzero <- contrast_ss_res[contrast_mexz_binary!=0]
contrast_ratio_nonzero <- contrast_ratio[contrast_mexz_binary!=0]

pics_binary <- matrix(nrow = length(contrast_mexz_binary_nonzero), ncol = 4)
pics_binary[,1] <- contrast_mexz_binary_nonzero
pics_binary[,2] <- contrast_dyn_res_nonzero
pics_binary[,3] <- contrast_ss_res_nonzero
pics_binary[,4] <- contrast_ratio_nonzero

write.csv(pics_binary,'pics_binary.csv')

pics_cont <- matrix(nrow = length(contrast_mexz_score), ncol = 4)
pics_cont[,1] <- contrast_mexz_score
pics_cont[,2] <- contrast_dyn_res
pics_cont[,3] <- contrast_ss_res
pics_cont[,4] <- contrast_ratio

write.csv(pics_cont,'pics_cont.csv')

