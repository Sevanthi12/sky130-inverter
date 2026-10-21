# sky130-inverter
# CMOS Inverter Design using SkyWater SKY130 PDK

In this project I designed a CMOS inverter using the open-source SKY130 PDK and
open-source EDA tools. I went through the full flow: schematic, simulation,
layout, DRC and LVS.

## Tools Used
- **Xschem** – schematic capture
- **Ngspice-47** – simulation
- **Magic** – layout, DRC and extraction
- **Netgen** – LVS
- **open_pdks (SKY130A)** – installed at `/usr/local/share/pdk`

All tools were run on Ubuntu inside a VirtualBox VM.

---

## 1. Setting up the project folders

```
mkdir -p ~/Desktop/inverter/{xschem,mag,netgen}
cd ~/Desktop/inverter/xschem
cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit ~/.spiceinit
cd ../mag
ln -s /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
cd ../netgen
ln -s /usr/local/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl setup.tcl
```

Since my PDK is in `/usr/local/share/pdk` (not `/usr/share/pdk`), I set:
```
export PDK_ROOT=/usr/local/share/pdk
export PDK=sky130A
```

I checked that Xschem loads the SKY130 library by opening the `sky130_tests/top.sch` example.

![xschem test](https://github.com/Sevanthi12/sky130-inverter/blob/main/resources/lab1/xshem_test.jpeg)

---

## 2. Inverter schematic (Xschem)

| Device | Type | W (µm) | L (µm) | nf |
|--------|------|--------|--------|----|
| M1 | pfet_01v8 | 3 | 0.18 | 3 |
| M3 | nfet_01v8 | 4.5 | 0.18 | 3 |

PMOS source and body go to `vdd`, NMOS source and body go to `vss`.
Pins: `in`, `out`, `vdd`, `vss`.

![schematic](https://github.com/Sevanthi12/sky130-inverter/blob/main/resources/lab1/xschem_inv.jpeg)

I then created a symbol for the inverter:

![symbol](https://github.com/Sevanthi12/sky130-inverter/blob/main/resources/lab1/xshem_sym.jpeg)

---

## 3. Testbench and simulation

Testbench `inverter_tb.sch`:
- V2 = 1.8 V supply
- V1 = `PWL(0 0 20n 0 900n 1.8)` (slow ramp input)

```
.control
tran 1n 1u
plot V(in) V(out)
.endc
```

![testbench](https://github.com/Sevanthi12/sky130-inverter/blob/main/resources/lab1/xshem_tb.jpeg)

**Result:** The output stays at 1.8 V while the input is low and switches to 0 V
at around 0.4 µs, when the input is about 0.8 V. So the inverter works correctly.

---

## 4. Layout in Magic

For LVS I exported the schematic netlist as a subcircuit
(*Simulation → LVS netlist: Top level is a .subckt*). It is saved in
`~/.xschem/simulations/inverter.spice`.

The layout was created in Magic with the SKY130 device cells:
```
cd ~/Desktop/inverter/mag
magic -d X11 inverter
```

DRC result: **0 errors**

![layout](Resources/Lab1/mag_layout.jpeg)

Extracting the layout netlist:
```
% port makeall
% extract all
% ext2spice lvs
% ext2spice
```

---

## 5. LVS (Netgen)

```
cd ~/Desktop/inverter/netgen
netgen -batch lvs "../mag/inverter.spice inverter" "../xschem/inverter.spice inverter" setup.tcl comp.out
```

Result: **Circuits match uniquely.**

![lvs](https://github.com/Sevanthi12/sky130-inverter/blob/main/resources/lab1/lvs_output.png)

---

## Problems I faced and how I fixed them

| Problem | Fix |
|---------|-----|
| `can't read "USER_CONF_DIR"` when opening xschem | The apt version (2.8) was too old, so I built xschem 3.x from source |
| SKY130 symbols not found in xschem | Added `/usr/local/share/pdk/sky130A/libs.tech/xschem` to `XSCHEM_LIBRARY_PATH` |
| ngspice error `Pclm is not positive` | Copied the PDK `spinit` to `~/.spiceinit` (sets `ngbehavior=hsa`) |
| Output did not switch in simulation | PWL times were missing units (`0.5` instead of `0.5u`) |
| Magic `BadAlloc` error with `-d XR` | Used `magic -d X11` (VM has low video memory) |
| LVS: 5 nets vs 4 nets | PMOS body pin was floating (`net1`); connected it to `vdd` |
| LVS: cell has no elements | Enabled `.subckt` export in xschem and gave the cell name to netgen |
| LVS: top level cell failed pin matching | Layout labels were not ports; fixed with `port makeall` and re-extracted |
| Extracted netlist showed all nodes on `vss` | My routed layout had a short between out, vdd and vss; found it by reading the extracted netlist |

## What I learned
- How the full analog flow works in open-source tools: schematic → simulation → layout → DRC → extraction → LVS
- Netgen compares pins by name, not order, and labels must be ports
- Reading the extracted netlist is the quickest way to find shorts and floating nodes<img width="1107" height="766" alt="image" src="https://github.com/user-attachments/assets/6ca3587f-488b-4bd6-8041-ca85914ff5e0" />
