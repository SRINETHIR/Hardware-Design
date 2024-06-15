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
     Commands to install Yosys are as follows:
     
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

Successful installation of Yosys:
![yosys](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/e9448497-7562-479f-b50e-dd6982d35ef0) 

<h3>GTKWave</h3>
Commands to install GTKWave are as follows:

```
sudo apt-get update
sudo apt install gtkwave
```

Successful installation of Gtkwave:
![GTKwave](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/8808c5c5-11b5-448b-956a-29be9d0e0950)


<h3>iverilog</h3>
Commands to install iverilog are as follows:

```
sudo apt-get update
sudo apt-get install iverilog
```

Successful installation of iverilog:
![iverilog](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5835b475-6784-426a-aefa-0f1f47c2b5b8)

</details>

<details>
     <summary>
          <h2 id = 'Week1'>Week1</h2>
     </summary>
     <h3>Day 1</h3>
     
____

Stimulation of a MUX using iverilog and synthesis of the MUX is done using Yosys. The simulation results of the MUX is plotted with a tool called gtkwave. Gtkwave tools use the vcd (value changing dump) file to get the simulation results.
<details>
     <summary>
          <h4 id = 'Simulation'>Simulation</h4>
     </summary>
     
Simulation of RTL Design
     
     
```
iverilog  good_mux.v  tb_good_mux.v
./a.out
gtkwave tb_good_mux.vcd
```

<h4>iverilog</h4>

![1_good_mux_iverilog](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/72636cbd-8991-42b1-a415-6faf9854598e)

<h4>gtkwave</h4>

![2_good_mux_gtkwave](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/256eb1a8-8b87-4e63-9669-5dd08749d3e9)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis'>Synthesis</h4>
     </summary>

<h4>Synthesis using Yosys</h4>
Yosys is a synthesizer used to convert the RTL Design to a netlist.

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

<h3>Day 2</h3>

____

Synthesis of multimodule file – with 2 submodules.<be><br>
Synthesis is important at the submodule level for 2 major reasons:
<ol>
          <li>When there is a presence of multiple instantiations of same component, then the module is synthesised single time and replicated multiple times in the top and need not be synthesized multiple times. Hence, this helps to save time.<br></li>
          <li>Dive and conquer – A massive device is divided in small units and given to the synthesizer tool which gives out the optimized netlist which are then placed together on the top layer. <br></li>
 </ol>

Hierarchical design – the design is constituted of submodules and the hierarchy is preserved

<details>
     <summary>
          <h4 id = 'Synthesis of Multiple Modules'> Synthesis of Multiple Modules <h4>
     </summary>

```
read_liberty -lib <path to the .lib file>
read_verilog <name of the Verilog file>
synth_top <name given>
abc -liberty <path to the .lib file>
show <name given>
```

Hierarchical design generated 

![5_multimodule synth](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4af7455b-d730-44f8-bc94-60155dc21db0)

Netlist generated for the hierarchical design

```
write_verilog -noattr <name given>
!vim <name given>
```
![6_multimodule netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9c23125b-a53e-4afa-8211-5e877a468f8c)

</details>

<details>
     <summary>
          <h4 id = 'Synthesizing flattened multiple module'> Synthesizing flattened multiple module <h4>
     </summary>

Flattened design generation

```
flatten
show
```

![7_multimoduled_flatten](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/73506e63-c6d9-496d-825b-7c77b8ebe9ed)

Flattened netlist generation 

```
write_verilog -noattr <given name: multiple_modules_flat.v>
!vim <given name: multiple_modules_flat.v>
```

![7_multimoduled_flatten_netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/b708604b-18b3-4569-8941-2ba31cbfcae5)

</details>

<details>
     <summary>
          <h4 id = 'Sub module level synthesis'> Sub module level synthesis <h4>
     </summary>

```
read_liberty -lib <path to .lib file>
read_verilog <name of the verilog file>
synth -top sub_module1
abc -liberty  <path to .lib file>
show
```

![8_submodule1_design](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a7b831aa-d032-4104-b5b8-19bd874fbb09)


</details>
</details>

