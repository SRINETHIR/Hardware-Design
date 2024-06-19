# VSD - Hardware-Development Peogram
The progress made in the VSD-Hardware Development Program :
<details>
     <summary>
          <h2 id = 'Week 0'>Week 0</h2>
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
          <h2 id = 'Week 1'>Week 1</h2>
     </summary>
     <h3>Day 1</h3>
     
____

Stimulation of a 2x1 MUX using iverilog and synthesis of the MUX is done using Yosys. The simulation results of the MUX is plotted with a tool called gtkwave. Gtkwave tools use the vcd (value changing dump) file to get the simulation results.
<details>
     <summary>
          <h4 id = 'Simulation'>Simulation</h4>
     </summary>
     
Commands to simulate the RTL Design and plot it
     
     
```
iverilog  <name of verilog file: good_mux.v> <Name of the test bench: tb_good_mux.v>
./a.out
gtkwave <Nmae of vcd file: tb_good_mux.vcd>
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
Yosys is a synthesizer used to convert the RTL Design to a netlist.<br>
Commands to synthesize and generate the netlist.

```
read_liberty -lib <path to .lib file>
read_verilog <Verilog file name>
synth -top <module name that has to be synthesised>
abc -liberty <path to .lib file>
```

Synthesized design of the good mux

![3_logic design good mux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4c5bb1c7-cd8f-44f0-a31a-32185190d91c)

Commands to generate the netlist of good mux

```
write_verilog <name of the netlist to be generated.v>
write_verilog -noattr <name of the netlist to be generated.v>
```

![4_netlist good mux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7e9bb20d-2b28-4fbd-9b08-d78a98e7c58f)

</details>

<h3>Day 2</h3>

____

Synthesis of multimodule file – with 2 submodules.<br><br>
Synthesis is important at the submodule level for 2 major reasons:
<ol>
          <li>When there is a presence of multiple instantiations of the same component, then the module is synthesized a single time and replicated multiple times in the top and need not be synthesized multiple times. Hence, this helps to save time.<br></li>
          <li>Dive and conquer – A massive device is divided into small units and given to the synthesizer tool which gives out the optimized netlist which is then placed together on the top layer. <br></li>
 </ol>

Hierarchical design – the design is constituted of submodules and the hierarchy is preserved

<details>
     <summary>
          <h4 id = 'Synthesis of Multiple Modules'> Synthesis of Multiple Modules <h4>
     </summary>

Commands used to Synthesize multiple modules hierarchical design:

```
read_liberty -lib <path to the .lib file>
read_verilog <name of the Verilog file>
synth_top <name given>
abc -liberty <path to the .lib file>
show <name given>
```

Hierarchical design generated 

![5_multimodule synth](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4af7455b-d730-44f8-bc94-60155dc21db0)

Generating a netlist for the hierarchical design

Command to generate the netlist of the hierarchical design
```
write_verilog -noattr <name given>
!vim <name given>
```

Netlist 

![6_multimodule netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9c23125b-a53e-4afa-8211-5e877a468f8c)

</details>

<details>
     <summary>
          <h4 id = 'Synthesizing flattened multiple module'> Synthesizing flattened multiple module <h4>
     </summary>

Flattened design generation
Commands to flatten the design generated

```
flatten
show
```
Flattened Design:

![7_multimoduled_flatten](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/73506e63-c6d9-496d-825b-7c77b8ebe9ed)

Commands to flatten and generate the flattened netlist

```
write_verilog -noattr <given name: multiple_modules_flat.v>
!vim <given name: multiple_modules_flat.v>
```

Flattened netlist

![7_multimoduled_flatten_netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/b708604b-18b3-4569-8941-2ba31cbfcae5)

</details>

<details>
     <summary>
          <h4 id = 'Sub module level synthesis'> Sub module level synthesis <h4>
     </summary>

Commands to synthesized design of sub-module:

```
read_liberty -lib <path to .lib file>
read_verilog <name of the verilog file>
synth -top sub_module1
abc -liberty  <path to .lib file>
show
```

Generated design of the submodule:

![8_submodule1_design](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a7b831aa-d032-4104-b5b8-19bd874fbb09)


</details>

<details>
     <summary>
          <h4 id = 'Simulation of Asynchronous reset'> Simulation of Asynchronous reset <h4>
     </summary>

Commands to simulate Asynchronous reset:

```
iverilog <Name of Verilog file: dff_asyncres.v Name of testbench: tb_dff_asyncres.v>
./a.out
gtkwave <Name of the vcd file: tb_dff_asyncres.vcd>

```

Plot for the simulation of Asynchronous reset:

![4_dff_asyncres_simulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/6a07bf59-f8be-4366-a41e-2c72ee9fffa0)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of Asynchronous set'> Simulation of Asynchronous set <h4>
     </summary>

Commands to simulate Asynchronous set:

```
iverilog <Name of Verilog file: dff_async_set.v Name of testbench: tb_dff_async_set.v>
./a.out
gtkwave <Name of the vcd file: tb_dff_async_set.vcd>

```

Plot for the simulation of the Asynchronous set:

![5_dff_async_set_simulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/ff1f1381-111f-4fef-90d4-f0d0110a2a8e)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of Synchronous reset'> Simulation of Synchronous reset <h4>
     </summary>

Commands to simulate Synchronous reset:

```
iverilog <Name of Verilog file: dff_syncres.v Name of testbench: tb_dff_syncres.v>
./a.out
gtkwave <Name of the vcd file: tb_dff_syncres.vcd>

```

Plot for the simulation of the Synchronous reset:

![6_dff_syncres_simulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/85e9a1ee-7b5d-414d-8184-e25ed0ec8882)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of Asynchronous reset'> Synthesis of Asynchronous reset <h4>
     </summary>

Commands to simulate Asynchronous reset:

```
read_liberty <path to .lib file>
read_verilog -lib <name of Verilog file: dff_asyncres.v>
synth -top <Name given: dff_asyncres>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of the Asynchronous reset:

![1_dff_asyncres](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a304689a-b89e-46e6-a3df-51751f72f5a9)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of Asynchronous set'> Synthesis of Asynchronous set <h4>
     </summary>

Commands to simulate Asynchronous set:

```
read_liberty <path to .lib file>
read_verilog  -lib <name of Verilog file: dff_async_set.v>
synth -top <Name given: dff_async_set.v >
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of the Asynchronous set:

![2_dff_async_set](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/fd083ad5-5e68-4301-a5d9-03fde722f728)

</details>


<details>
     <summary>
          <h4 id = 'Synthesis of Synchronous reset'> Synthesis of Synchronous reset <h4>
     </summary>

Commands to simulate Synchronous reset:

```
read_liberty <path to .lib file>
read_verilog  -lib <name of Verilog file: dff_async_set.v>
synth -top <Name given: dff_async_set.v >
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of the Synchronous reset:

![3_dff_syncres](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/1bfcc4be-6d3b-4628-8d5c-d3347ff453e3)

</details>
</details>

<details>
     <summary>
          <h2 id = 'Week 2'>Week 2</h2>
     </summary>
          
<h3>Day 3</h3>
     
____

Any logic can be optimized to save the design's power and area. The logic available is generally combinational or sequential based on the components used. Techniques used to optimize combinational logic include constant propagation and boolean logic optimization techniques like K Map and Quine McKlusky.
<br>
<br>
<ol>
     <li> Constant Propagation (direct optimizarion) <br></li>
     <li> Boolean logic optimization <br></li>
     <ul>
          <li> K -Map </li>
          <li> Quine Mcklusky </li>
     </ul>
     </ol>
The sequential logic optimization techniques are majorly divided into Basic and advanced. Sequential constant propagation is one of the basic sequential logic optimizations. Whereas the advanced sequential logic optimization includes state optimization, retiring, and sequential logic cloning.
<br>
<ol>
     <li> Basic sequential logic optimization <br></li>
     <ul>
          <li> Sequential constant propagation - the flop always propagates a constant called the sequential propagation constant when the clock is also involved. </li>
     </ul>
     <li> Advanced sequential logic optimization <br></li>
     <ul>
          <li> State Optimization - Optimization of unused states </li>
          <li> Retiming - Splitting and pushing the combinational logic to decrease timings and increase the frequency. </li>
          <li> Sequential logic cloning - Physical aware synthesis to obtain an optimized floor plan. </li>
     </ul>
     </ol>

<details>
     <summary>
          <h4 id = 'Optimization of opt_check.v'> Optimization of opt_check.v <h4>
     </summary>

Commands to optimize opt_check.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: opt_check.v>
synth -top <Given name: opt_check>
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized opt_check.v:

![1_opt_check](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/87a089aa-0d71-498f-9cb5-9d48bcaab02b)

</details>

<details>
     <summary>
          <h4 id = 'Optimization of opt_check2.v'> Optimization of opt_check2.v <h4>
     </summary>

Commands to optimize opt_check2.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: opt_check2.v>
synth -top <Given name: opt_check2>
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized opt_check2.v:

![2_opt_check2](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5528b3f4-1398-48ba-a94f-f60a88a2f339)

</details>

<details>
     <summary>
          <h4 id = 'Optimization of opt_check3.v'> Optimization of opt_check3.v <h4>
     </summary>

Commands to optimize opt_check3.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: opt_check3.v>
synth -top <Given name: opt_check3>
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized opt_check3.v:

![3_opt_check3](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7a5abb34-f41c-4723-bf93-67cfe91d6da9)

</details>

<details>
     <summary>
          <h4 id = 'Optimization of opt_check4.v'> Optimization of opt_check4.v <h4>
     </summary>

Commands to optimize opt_check4.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: opt_check4.v>
synth -top <Given name: opt_check4>
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized opt_check4.v:

![4_opt_check4](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7aba50b4-62fb-46ca-93ca-7bcb2dcd83eb)

</details>

<details>
     <summary>
          <h4 id = 'Optimization of multiple_module_opt.v'> Optimization of multiple_module_opt.v <h4>
     </summary>

Commands to optimize multiple_module_opt.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: multiple_module_opt.v>
synth -top <Given name: multiple_module_opt>
flatten
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized multiple_module_opt.v:

![5_multiple_module_opt](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/70938d69-d6de-443e-9604-e5e098e9de3b)

</details>

<details>
     <summary>
          <h4 id = 'Optimization of multiple_module_opt2.v'> Optimization of multiple_module_opt2.v <h4>
     </summary>

Commands to optimize multiple_module_opt2.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of Verilog file: multiple_module_opt2.v>
synth -top <Given name: multiple_module_opt2>
flatten
opt_clean -purge
abc -liberty <path to .lib file> 
show

```

Design of optimized multiple_module_opt2.v:

![6_multiple_module_opt2](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/97e9eba5-b9a6-4997-8193-b35f87fbadf3)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of optimized dff_const1.v'> Simulation of optimized dff_const1.v <h4>
     </summary>

Commands to Simulation of optimized dff_const1.v:

```
iverilog <Name of verilog file: dff_const1.v Name of testbench: tb_dff_const1.v>
./a.out
gtkwave <Nmae of vcd file: tb_dff_const1.vcd>

```

Plot of optimized dff_const1.v:

![1_simulation_const1](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5f2bb628-e43c-4624-a822-14066ab676dd)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized dff_const1.v'> Synthesis of optimized dff_const1.v <h4>
     </summary>

Commands to Synthesis of optimized dff_const1.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: dff_const1.v>
synth -top <Given name: dff_const1>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized dff_const1.v:

![2_synthesis_const1](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/0bbb9afc-93ad-488e-a0ee-bd94a565fc04)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of optimized dff_const2.v'> Simulation of optimized dff_const2.v <h4>
     </summary>

Commands to Simulation of optimized dff_const2.v:

```
iverilog <Name of verilog file: dff_const2.v Name of testbench: tb_dff_const2.v>
./a.out
gtkwave <Nmae of vcd file: tb_dff_const2.vcd>

```

Plot of optimized dff_const2.v:

![3_simulation_const2](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/c3d4f977-925c-4252-a4b0-24c73549bbc6)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized dff_const2.v'> Synthesis of optimized dff_const2.v <h4>
     </summary>

Commands to Synthesis of optimized dff_const2.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: dff_const2.v>
synth -top <Given name: dff_const2>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized dff_const2.v:

![4_synthesis_const2](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7368ceeb-6cfe-44ea-888f-99857b97b79c)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of optimized dff_const3.v'> Simulation of optimized dff_const3.v <h4>
     </summary>

Commands to Simulation of optimized dff_const3.v:

```
iverilog <Name of verilog file: dff_const3.v Name of testbench: tb_dff_const3.v>
./a.out
gtkwave <Nmae of vcd file: tb_dff_const3.vcd>

```

Plot of optimized dff_const3.v:

![1_simulation_const3](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/d9ed5d0f-dd4b-40fd-82ed-2205e94c03a0)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized dff_const3.v'> Synthesis of optimized dff_const3.v <h4>
     </summary>

Commands to Synthesis of optimized dff_const3.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: dff_const3.v>
synth -top <Given name: dff_const3>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized dff_const3.v:

![2_synthesis_const3](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/c80cbf9d-272f-4d85-8b54-cd38a6c5d5ff)

</details>

<details>
     <summary>
          <h4 id = 'Simulation of optimized dff_const4.v'> Simulation of optimized dff_const4.v <h4>
     </summary>

Commands to Simulation of optimized dff_const4.v:

```
iverilog <Name of verilog file: dff_const4.v Name of testbench: tb_dff_const4.v>
./a.out
gtkwave <Nmae of vcd file: tb_dff_const4.vcd>

```

Plot of optimized dff_const4.v:

![3_simulation_const4](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/bdfcc35d-3123-439f-b476-a1a5c186d055)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized dff_const4.v'> Synthesis of optimized dff_const4.v <h4>
     </summary>

Commands to Synthesis of optimized dff_const4.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: dff_const4.v>
synth -top <Given name: dff_const4>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized dff_const4.v:

![4_synthesis_const4](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/63313dcc-137d-4cb6-98a3-21f9ce44fa96)

</details>

</details>
     

