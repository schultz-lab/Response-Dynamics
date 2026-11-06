library(ape)

phy <- read.tree('PA_tree_pruned.tree')
traits <- read.csv(file = 'resistances.csv', row.names = 1)
traits <- traits[phy$tip.label, ]

mexz_binary <- traits[, 1]
ic50 <- traits[, 6]
mic <- traits[, 7]

contrast_mexz_binary <- pic.ortho(mexz_binary,phy)
contrast_ic50 <- pic.ortho(ic50,phy)
contrast_mic <- pic.ortho(mic,phy)

contrast_mexz_binary_nonzero <- contrast_mexz_binary[contrast_mexz_binary!=0]
contrast_ic50_nonzero <- contrast_ic50[contrast_mexz_binary!=0]
contrast_mic_nonzero <- contrast_mic[contrast_mexz_binary!=0]

pics_binary <- matrix(nrow = length(contrast_mexz_binary_nonzero), ncol = 3)
pics_binary[,1] <- contrast_mexz_binary_nonzero
pics_binary[,2] <- contrast_ic50_nonzero
pics_binary[,3] <- contrast_mic_nonzero

write.csv(pics_binary,'pics_binary.csv')

