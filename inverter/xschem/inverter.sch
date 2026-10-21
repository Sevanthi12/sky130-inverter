v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 5 17.5 -102.5 22.5 -97.5 {name=XXX
dir=inout}
N -20 80 -20 90 {lab=vss}
N -20 90 -0 90 {lab=vss}
N -20 -10 -20 20 {lab=out}
N -20 -90 -20 -70 {lab=vdd}
N -20 -90 -0 -90 {lab=vdd}
N -90 -40 -60 -40 {lab=in}
N -90 -40 -90 50 {lab=in}
N -90 50 -60 50 {lab=in}
N -120 -0 -90 0 {lab=in}
N -20 0 40 -0 {lab=out}
N -20 50 -0 50 {lab=vss}
N -0 50 -0 90 {lab=vss}
N -20 -40 -0 -40 {lab=vdd}
N 0 -80 0 -40 {lab=vdd}
N -10 -80 -0 -80 {lab=vdd}
N -20 -80 -10 -80 {lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} -40 -40 0 0 {name=M1
W=3
L=0.18
nf=3
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {ipin.sym} -120 0 0 0 {name=p1 lab=in
}
C {iopin.sym} 0 90 0 0 {name=p3 lab=vss}
C {iopin.sym} 0 -90 0 0 {name=p4 lab=vdd
}
C {opin.sym} 40 0 0 0 {name=p2 lab=out}
C {sky130_fd_pr/nfet_01v8.sym} -40 50 0 0 {name=M3
W=4.5
L=0.18
nf=3 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
