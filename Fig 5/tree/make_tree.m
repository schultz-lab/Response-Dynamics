strains=readtable('convert.csv');

data_acsA = fastaread('PA0887_complete_genes_filtered.fasta');
data_aroE = fastaread('PA0025_complete_genes_filtered.fasta');
data_guaA = fastaread('PA3769_complete_genes_filtered.fasta');
data_mutL = fastaread('PA4946_complete_genes_filtered.fasta');
data_nuoD = fastaread('PA2639_complete_genes_filtered.fasta');
data_ppsA = fastaread('PA1770_complete_genes_filtered.fasta');
data_trpE = fastaread('PA0609_complete_genes_filtered.fasta');

acsA = find_gene(strains,data_acsA);
aroE = find_gene(strains,data_aroE);
guaA = find_gene(strains,data_guaA);
mutL = find_gene(strains,data_mutL);
nuoD = find_gene(strains,data_nuoD);
ppsA = find_gene(strains,data_ppsA);
trpE = find_gene(strains,data_trpE);

genes=struct([]);

for n=1:height(strains)

    genes(n).Header=acsA(n).Header;
    genes(n).Sequence=[acsA(n).Sequence aroE(n).Sequence guaA(n).Sequence mutL(n).Sequence nuoD(n).Sequence ppsA(n).Sequence trpE(n).Sequence];

end

% Compute the pairwise distances between each pair of sequences using the 'GONNET' scoring matrix.
dist = seqpdist(genes);

% Build a phylogenetic tree using an unweighted average distance (UPGMA) method. This tree will be used as a guiding tree in the next step of progressive alignment.
tree = seqlinkage(dist,'average',genes);

phytreewrite('PA_tree.tree', tree)

function gene=find_gene(strains,data)

gene=struct([]);

for n=1:height(strains)

    x=strains{n,1};
    name=['IPC' num2str(x)];

    for m=1:length(data)
        
        if regexp(data(m).Header,[name ' '])

            gene(n).Header=name;
            gene(n).Sequence=data(m).Sequence;

        elseif x==5000 && any(regexp(data(m).Header,['PAO1 ']))

            gene(n).Header='PAO1';
            gene(n).Sequence=data(m).Sequence;

        elseif x==5001 && any(regexp(data(m).Header,['PA14 ']))

            gene(n).Header='PA14';
            gene(n).Sequence=data(m).Sequence;

        end

    end

end

end