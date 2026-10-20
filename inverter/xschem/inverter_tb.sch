v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -280 -150 -280 -110 {lab=#net1}
N -280 -150 120 -150 {lab=#net1}
N -280 -50 120 -50 {lab=0}
N 120 -70 120 -50 {lab=0}
N 120 -150 120 -110 {lab=#net1}
N 120 -90 150 -90 {lab=out}
N -230 -140 -230 -110 {lab=in}
N -230 -140 -200 -140 {lab=in}
N -230 -120 -200 -120 {lab=in}
N -200 -120 -200 -110 {lab=in}
N -200 -110 -180 -110 {lab=in}
C {inverter.sym} -30 -90 0 0 {name=x1}
C {vsource.sym} -230 -80 0 0 {name=V1 value="PWL(0 0 20n 0 900n 1.8)" savecurrent=false}
C {vsource.sym} -280 -80 0 0 {name=V2 value=1.8 savecurrent=false}
C {gnd.sym} -170 -50 0 0 {name=l1 lab=0}
C {opin.sym} 150 -90 0 0 {name=p1 lab=out}
C {opin.sym} -200 -140 0 0 {name=p2 lab=in
}
C {code_shown.sym} 0 -180 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {code_shown.sym} 20 10 0 0 {name=s2 only_toplevel=false value=".control
tran 1n 1u
plot V(in) V(out)
.endc"}
