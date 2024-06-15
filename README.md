# VSD - Hardware-Development Peogram

The progress made in the VSD-Hardware Development Program :
<details>
<summary>
<h2 id = 'Week0'>Week0</h2>
</summary>



Installation in UBUNTU
<h3>System Information</h3>
<ol>
     <li>OS: Ubuntu 22.04<br></li>
     <li>RAM: 8 GB<br></li>
     <li>Storage: 40 GB<br></li>
</ol>

<h3>Yosys</h3>

```
sudo apt-get update
git clone https://github.com/YosysHQ/yosys.git
cd yosys
sudo apt install make
sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
make config-gcc
make 
sudo make install
```

![yosys](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/e9448497-7562-479f-b50e-dd6982d35ef0) 


<h3>GTKWave</h3>

```
sudo apt-get update
sudo apt install gtkwave
```

![GTKwave](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/8808c5c5-11b5-448b-956a-29be9d0e0950)


<h3>iverilog</h3>

```
sudo apt-get update
sudo apt-get install iverilog
```

![iverilog](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5835b475-6784-426a-aefa-0f1f47c2b5b8)


</details>
<details>
<summary>
<h2 id = 'Week1'>Week1</h2>
</summary>
<h3>Day 1</h3>
Stimulation of a MUX using iverilog and synthesis of the MUX is done using Yosys. The simulation results of the MUX is plotted with a tool called gtkwave. Gtkwave tools use the vcd (value changing dump) file to get the simulation results.

Simulation of RTL Designs
```
iverilog  good_mux.v  tb_good_mux.v
./a.out
gtkwave tb_good_mux.vcd
```

<h4>iverilog</h4>

![1_good_mux_iverilog](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/72636cbd-8991-42b1-a415-6faf9854598e)

<h4>gtkwave</h4>

![2_good_mux_gtkwave](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/256eb1a8-8b87-4e63-9669-5dd08749d3e9)

<h4>Synthesis using Yosys</h4>
Yosys is a synthesizer used to convert the RTL Design to ma netlist.

```
read_liberty -lib <path to .lib file>
read_verilog <Verilog file name>
synth -top <module name that has to be synthesised>
abc -liberty <path to .lib file>
```

Synthesized design of the good mux

![3_logic design good mux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4c5bb1c7-cd8f-44f0-a31a-32185190d91c)

Generating the netlist of good mux

```
write_verilog <name of the netlist to be generated.v>
write_verilog -noattr <name of the netlist to be generated.v>
```

![4_netlist good mux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7e9bb20d-2b28-4fbd-9b08-d78a98e7c58f)

</details>

