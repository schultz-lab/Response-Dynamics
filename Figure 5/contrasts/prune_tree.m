tree=phytreeread('PA_tree.tree');

ind = getbyname(tree,'IPC86');
tree = prune(tree,ind);
ind = getbyname(tree,'IPC88');
tree = prune(tree,ind);
ind = getbyname(tree,'IPC300');
tree = prune(tree,ind);
ind = getbyname(tree,'IPC1258');
tree = prune(tree,ind);
ind = getbyname(tree,'IPC1360');
tree = prune(tree,ind);

pointers=get(tree,'Pointers');
distances=get(tree,'Distances');
names=get(tree,'LeafNames');
distances(distances==0)=1e-06;
tree=phytree(pointers,distances,names);

phytreewrite('PA_tree_pruned.tree', tree)