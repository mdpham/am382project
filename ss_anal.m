global ALPHA BETA k0 m0 k1 m1;
ALPHA=0.286;
BETA=0.432;
k0=0.1;
m0=0.1;
k1=0.01;
m1=0.01;
S=@(alpha) alpha./(k0-alpha.*m0);

s0=ALPHA:0.05:1.3;

S_ss=S(s0);
plot(s0,S_ss);
