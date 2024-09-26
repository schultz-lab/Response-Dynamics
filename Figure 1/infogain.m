function [x,G]=infogain(S1,S2)

s=@(p) (-p.*max(-100,log2(p))-(1-p).*max(-100,log2(1-p))).*(p>0).*(p<1);

S1=S1(~isnan(S1));
S2=S2(~isnan(S2));

S=sort([S1 S2]);
N=length(S);
N1=length(S1);
N2=length(S2);
s0=s(N1/N)+s(N2/N);

G=0;
x=0;
for i=1:N-1
    
    xx=(S(i)+S(i+1))/2;
    
    N1a=length(find(S1<xx));
    N1b=length(find(S1>xx));
    N2a=length(find(S2<xx));
    N2b=length(find(S2>xx));
    
    Na=N1a+N2a;
    Nb=N1b+N2b;
    
    sa=s(N1a/Na)+s(N2a/Na);
    sb=s(N1b/Nb)+s(N2b/Nb);
    
    gg=(s0-sa*Na/N-sb*Nb/N)/s0;
    
    if gg>G
        G=gg;
        x=xx;
    end
    
end
