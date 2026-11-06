data = fastaread('IPCD_PA2020.fasta');
strains=readtable('convert.csv');
mexz=struct([]);

for n=1:height(strains)

    x=strains{n,1};
    name=['IPC' num2str(x)];

    for m=1:length(data)
        
        if regexp(data(m).Header,[name ' '])

            mexz(n).Header=name;
            mexz(n).Sequence=nt2aa(data(m).Sequence); % <--- check for original start codon
            mexz(n).SequenceNT=data(m).Sequence;

        elseif x==5000 && any(regexp(data(m).Header,['PAO1 ']))

            mexz(n).Header='PAO1';
            mexz(n).Sequence=nt2aa(data(m).Sequence);
            mexz(n).SequenceNT=data(m).Sequence;

        elseif x==5001 && any(regexp(data(m).Header,['PA14 ']))

            mexz(n).Header='PA14';
            mexz(n).Sequence=nt2aa(data(m).Sequence);
            mexz(n).SequenceNT=data(m).Sequence;

        end

    end

end

% Compute the pairwise distances between each pair of sequences using the 'GONNET' scoring matrix.
dist = seqpdist(mexz,'ScoringMatrix','GONNET');

% Build a phylogenetic tree using an unweighted average distance (UPGMA) method. This tree will be used as a guiding tree in the next step of progressive alignment.
tree = seqlinkage(dist,'average',mexz);

% Perform progressive alignment using the PAM family scoring matrices.
ma = multialign(mexz,tree,'ScoringMatrix',{'pam150','pam200','pam250'},'terminalGapAdjust',true);

% Consensus sequences for AA
consensus = seqconsensus(ma,'gaps','all');
consensus = consensus(consensus~='-');
consensus(end)='*';

mexz2=struct([]);
for n=1:length(mexz)

    [score, aln] = nwalign(mexz(n).Sequence,consensus,'glocal',true);
    mexz2(n).Header=mexz(n).Header;
    mexz2(n).score=score;
    mexz(n).aln=aln;
    
    ii=find(aln(2,:)~='|');
    
    if aln(3,1)=='-'
        x=0;
    else
        x=1;
    end
    for i=2:length(aln)
        if aln(3,i)=='-'
            x(i)=x(i-1);
        else
            x(i)=x(i-1)+1;
        end
    end
           
    mexz2(n).aln=num2str(x(ii));

end

writetable(struct2table(mexz2),'mexz_muts.csv')