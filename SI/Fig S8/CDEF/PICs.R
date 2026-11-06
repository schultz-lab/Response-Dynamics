library(ape)

phy <- read.tree('PA_tree_pruned.tree')
traits <- read.csv(file = 'resistances.csv', row.names = 1)
traits <- traits[phy$tip.label, ]
traits1 <- read.csv(file = 'resistances1.csv', row.names = 1)
traits1 <- traits1[phy$tip.label, ]
traits2 <- read.csv(file = 'resistances2.csv', row.names = 1)
traits2 <- traits2[phy$tip.label, ]

mexz_binary <- traits[, 1]
mexz_score <- traits[, 2]
dyn_res <- traits[, 3]
dyn_res1 <- traits1[, 1]
dyn_res2 <- traits2[, 1]
ss_res <- traits[, 4]
ratio <- traits[, 5]

contrast_mexz_binary <- pic.ortho(mexz_binary,phy)
contrast_mexz_score <- pic.ortho(mexz_score,phy)
contrast_dyn_res <- pic.ortho(dyn_res,phy)
contrast_ss_res <- pic.ortho(ss_res,phy)
contrast_ratio <- pic.ortho(ratio,phy)
contrast_dyn_res1 <- pic.ortho(dyn_res1,phy)
contrast_dyn_res2 <- pic.ortho(dyn_res2,phy)

contrast_mexz_binary_nonzero <- contrast_mexz_binary[contrast_mexz_binary!=0]
contrast_dyn_res_nonzero <- contrast_dyn_res[contrast_mexz_binary!=0]
contrast_ss_res_nonzero <- contrast_ss_res[contrast_mexz_binary!=0]
contrast_ratio_nonzero <- contrast_ratio[contrast_mexz_binary!=0]
contrast_dyn_res_nonzero1 <- contrast_dyn_res1[contrast_mexz_binary!=0]
contrast_dyn_res_nonzero2 <- contrast_dyn_res2[contrast_mexz_binary!=0]

pics_binary <- matrix(nrow = length(contrast_mexz_binary_nonzero), ncol = 6)
pics_binary[,1] <- contrast_mexz_binary_nonzero
pics_binary[,2] <- contrast_dyn_res_nonzero
pics_binary[,3] <- contrast_ss_res_nonzero
pics_binary[,4] <- contrast_ratio_nonzero
pics_binary[,5] <- contrast_dyn_res_nonzero1
pics_binary[,6] <- contrast_dyn_res_nonzero2

write.csv(pics_binary,'pics_binary.csv')

pics_cont <- matrix(nrow = length(contrast_mexz_score), ncol = 4)
pics_cont[,1] <- contrast_mexz_score
pics_cont[,2] <- contrast_dyn_res
pics_cont[,3] <- contrast_ss_res
pics_cont[,4] <- contrast_ratio

write.csv(pics_cont,'pics_cont.csv')

