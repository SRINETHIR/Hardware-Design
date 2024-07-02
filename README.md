# VSD - Hardware-Development Program
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

The design of the opt_check is optimized by only using a 2 input and gate.

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

The design of the opt_check2 is optimized by only using a 2 input or gate.


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

The design of the opt_check3 is optimized by only using a 3 input and gate.

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

The design of the opt_check4 is optimized by only using a 2-input xor gate.

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

The design of the multiple_module_opt is optimized by only using a 2-input and gate and or gate.

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

The design of the multiple_module_opt2 is optimized by using no standard cells.

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
From the plot, we can see that once the reset is low, Q waits for the next rising edge of the clock to change.

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
From the plot, we can see that remains high regardless of the changes in reset and clock. This is because the clock has no rising edge once the reset goes low from high.

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
From the plot, we can infer that Q does not follow Q1 directly. In the rising edge of the clock, Q1 takes some delay(Tcq) hence the high signal of Q1 is detected lately resulting in Q becoming high in the next rising edge of the clock. Due to this there is an instantaneous drop of the signal Q.

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
From the plot we can infer the Q and Q1 both remain high regardless of  clock and reset.

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

<details>
     <summary>
          <h4 id = 'Simulation of optimized dff_const5.v'> Simulation of optimized dff_const5.v <h4>
     </summary>

Commands to Simulation of optimized dff_const5.v:

```
iverilog <Name of verilog file: dff_const5.v Name of testbench: tb_dff_const5.v>
./a.out
gtkwave <Nmae of vcd file: tb_dff_const5.vcd>

```

Plot of optimized dff_const5.v:
From the plot, we can infer that Q1 becomes high from low as soon as the reset goes low from high. Q follows Q1 in the next rising edge of the clock.

![1_Simulation_const5](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/90afcfaf-057e-489c-b087-0610e043d425)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized dff_const5.v'> Synthesis of optimized dff_const5.v <h4>
     </summary>

Commands to Synthesis of optimized dff_const5.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: dff_const5.v>
synth -top <Given name: dff_const5>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized dff_const5.v:
The design is optimized in such a way that it uses only one flipflop. We can see that only the last bit of the counter toggles and hence only one flipflop is used. The unused bits are completely optimized without using flipflop as it is not related to the primary inputs. Used output - count[0].

![2_Synthesis_const5](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/ec72b940-b1b0-445d-a439-42e4e66eecaa)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized counter_opt.v'> Synthesis of optimized counter_opt.v <h4>
     </summary>

Commands to Synthesis of optimized counter_opt.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: counter_opt.v>
synth -top <Given name: counter_opt>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized counter_opt.v:
All the 3 flipflops are used and the optimized design is shown below

![1_sysnthesis_counteropt](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/8ebe1e29-c2ca-4fbf-8835-9fc9966dd03b)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of optimized counter_opt2.v'> Synthesis of optimized counter_opt2.v <h4>
     </summary>

Commands to Synthesis of optimized counter_opt2.v:

```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Name of verilog file: counter_opt2.v>
synth -top <Given name: counter_opt>
dfflibmap -liberty <path to .lib file>
abc -liberty <path to .lib file>
show

```

Design of optimized counter_opt2.v:

![2_sysnthesis_counteropt2](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/96b5f583-e58c-4980-860c-850c27af60b9)

</details>

<h3>Day 4</h3>
     
____


GLS is a gate-level stimulus. A single testbench will align for both a design and a netlist.
GLS is used to check the logical correctness of a design after the synthesis. GLS used here don't consider delay annotations but generally, it is made sure that the timing of the design is met. The meaning of and, or and many other keywords used in the netlist is mentioned in the gate-level verilog models. GLS is used to verify the functionality of the design.
<br>
<br>
There are many reasons to verify the functionality of the design. One of the major reasons is synthesis and simulation mismatch.
Synthesis and simulation mismatch is mainly due to:
<ol>
     <li> Missing sensitivity test </li>
     <li> Blocking vs Non - Blocking assignments </li>
     <li> Non standard verilog coding </li>
</ol>

Due to this kind of mismatch in the network in synthesis and simulation, it is important to run GLS (Gate Level Synthesis) and match the expected outputs in the simulation. It had to be made sure that there is no synthesis - simulation mismatch due to the various above mentioned reasons.

<details>
     <summary>
          <h4 id = 'RTL Simulation of ternary_operator_mux.v'> RTL Simulation of ternary_operator_mux.v <h4>
     </summary>

Commands to RTL Simulation of ternary_operator_mux.v:

```
iverilog <Name of Verilog file: ternary_operator_mux.v> <Nmae of test bench: tb_ternary_operator_mux.v>
./a.out
gtkwave tb_ternary_operator_mux.vdc

```

Plot of RTL simulated ternary_operator_mux.v:
The plot depicts a 2x1 Mux. That is the output y takes the value of i0 when the select is low and the output y takes the value of i1 when the select is high.

![1_ternaryoperator_rtlsimulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/92d12933-f0ed-49d4-b049-7091e19f0743)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of ternary_operator_mux.v'> Synthesis of ternary_operator_mux.v <h4>
     </summary>

Commands to Synthesis of ternary_operator_mux.v:

```
yosys
read_liberty <path to .lib file>
read_verilog <name of Verilog file: ternary_operator_mux.v>
synth -top <Given name: ternary_operator_mux>
abc -liberty <path to .lib file>
write_verilog -noattr <name of netlist: ternary_operator_mux_net.v>
show

```

Design of ternary_operator_mux.v:

![2_ternaryoperator_design](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9fd54f5f-2e67-4a06-87a5-591cae3f03de)

Generated netlist of ternary_operator_mux.v

![3_netlist_ternaryoperator](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/68a3a65d-4ef3-401e-960c-5288c22c16ba)

</details>

<details>
     <summary>
          <h4 id = 'GLS Simulation of ternary_operator_mux.v'> GLS Simulation of ternary_operator_mux.v <h4>
     </summary>

Commands to GLS Simulation of ternary_operator_mux.v:

```
iverilog <Path to primitives.v file > <Path to sky130_fd_sc_hd__tt_025C_1v80.lib> <Name of netlist: ternary_operator_mux_net.v> <Name of testbench: tb_ternary_operator_mux.v>
./a.out
gtkwave tb_ternary_operator_mux.vdc

```

The plot of GLS simulated ternary_operator_mux.v:
We can observe the mismatch in the simulation.

![4_ternaryoperator_GLSsimulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/e792915d-f8eb-4a56-a88c-5c344097578c)

</details>

<details>
     <summary>
          <h4 id = 'RTL Simulation of bad_mux.v'> RTL Simulation of bad_mux.v <h4>
     </summary>

Commands to RTL Simulation of bad_mux.v:

```
iverilog <Name of verilog file: bad_mux.v> <Name of testbench: tb_bad_mux.v>
./a.out
gtkwave <tb_bad_mux.vcd> 

```

Plot of RTL simulated bad_mux.v:

![1_RTLsimulation_badmux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/15b81bfc-5eb0-45f3-9e97-96e4a7092b90)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of bad_mux.v'> Synthesis of bad_mux.v <h4>
     </summary>

Commands to Synthesis of bad_mux.v:

```
yosys
read_liberty <path to .lib file>
read_verilog <name of Verilog file: bad_mux.v>
synth -top <Given name: bad_mux>
abc -liberty <path to .lib file>
write_verilog -noattr <name of netlist: bad_mux_net.v>
show

```

Design of bad_mux.v:

![2_synthesis_badmux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5d3493fb-d6ba-4ad1-8767-3af8d9a240dd)

Generated netlist of bad_mux.v

![3_netlist_badmux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/fcdce4fa-284f-41cd-8f86-7d0973e63e85)

</details>

<details>
     <summary>
          <h4 id = 'GLS Simulation of bad_mux.v'> GLS Simulation of bad_mux.v <h4>
     </summary>

Commands to GLS Simulation of bad_mux.v:

```
iverilog <Path to primitives.v file > <Path to sky130_fd_sc_hd__tt_025C_1v80.lib> <Name of netlist: bad_mux_net.v> <Name of testbench: tb_bad_mux.v>
./a.out
gtkwave tb_bad_mux.vdc

```

The plot of GLS simulated bad_mux.v:

![4_GLSsimulation_badmux](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/c274a043-484a-4b72-bc9d-951748854705)

</details>


<details>
     <summary>
          <h4 id = 'RTL Simulation of blocking_caveat.v'> RTL Simulation of blocking_caveat.v <h4>
     </summary>

Commands to RTL Simulation of blocking_caveat.v:

```
iverilog <Name of verilog file: blocking_caveat.v> <Name of testbench: tb_blocking_caveat.v>
./a.out
gtkwave <tb_blocking_caveat.vcd> 

```

The plot of RTL simulated blocking_caveat.v:
From the plot we can see that, it acts like a flop as d takes the previous value and not the current evaluated value.

![1_RTL_simulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/63b11c84-d295-4f26-aaf3-6f5ca71484b8)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of blocking_caveat.v'> Synthesis of blocking_caveat.v <h4>
     </summary>

Commands to Synthesis of blocking_caveat.v:

```
yosys
read_liberty <path to .lib file>
read_verilog <name of Verilog file: blocking_caveat.v>
synth -top <Given name: blocking_caveat>
abc -liberty <path to .lib file>
write_verilog -noattr <name of netlist: blocking_caveat _net.v>
show

```

Design of blocking_caveat.v:

![2_synthesis](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a35e671b-4702-4e36-ad07-205db1c3d899)

Generated netlist of blocking_caveat.v

![3_netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f2fcf81c-9742-429f-ab37-27b74feee757)

</details>

<details>
     <summary>
          <h4 id = 'GLS Simulation blocking_caveat.v'> GLS Simulation of blocking_caveat.v <h4>
     </summary>

Commands to GLS Simulation of blocking_caveat.v:

```
iverilog <Path to primitives.v file > <Path to sky130_fd_sc_hd__tt_025C_1v80.lib> <Name of netlist: blocking_caveat _net.v> <Name of testbench: tb_ blocking_caveat .v>
./a.out
gtkwave tb_ blocking_caveat.vdc

```

The plot of GLS simulated blocking_caveat.v:
The correct plot can be seen as it takes the current value of d.

![4_GLS_simulation](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5bbeb91a-1948-46fe-a857-4a0e0fa47960)

</details>

</details>

<details>
     <summary>
          <h2 id = 'Week 3'>Week 3</h2>
     </summary>

<h3>What is RISC V? </h3>
     
____

RISC V stands for reduced instruction set computing – five, an open standard instruction set architecture (ISA). RISC V is a 32-bit processor with 31 general-purpose registers. RISC V has a highly optimized set of instructions for high efficiency and performance. RISC V is also highly portable, flexible, and compatible.

<h3> Piplining </h3>

____

Pipelining subdivides a single-cycle processor into five pipeline stages. Hence, Five instructions can be executed simultaneously, one in each stage. Since, each stage has only one – fifth of the entire logic, the clock frequency is approximately five times faster.

![risc](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a669e8f9-8fb3-48d1-8555-4e1ca4d893bf)

The pipelining stages of the architecture are:
<br>
<ol>
<li> Instruction fetch - the instruction to be executed next is fetched from memory. The instruction is retrieved from the address in the program counter (PC), and the PC is then incremented to point to the next instruction.</li><br>
<li> Decode - the fetched instruction is decoded to determine what actions are required. The opcode (operation code) and operands are identified.</li><br>
<li> Execute - the actual computation specified by the instruction is performed. For arithmetic and logic operations, the ALU (Arithmetic Logic Unit) is used.</li><br>
<li> Memory Access – Memory operations are handled in this stage. Data is read from the memory and placed in the register.</li><br>
<li> Write Back - the result is written back to the appropriate register in the register file.</li><br>
</ol>

<details>
     <summary>
          <h4 id = 'Basic of C'> Basic of C <h4>
     </summary>

Code to install leafpad editor

```
sudo snap install leafpad
```
The snippet for commands are used to open the leafpad editor, compile and run the written program 
```
leafpad <Given name of the C file – sum1ton.c> &
gcc <Name of the C file – sum1ton.c>
./a.out
```
C Program that is written in the Leafpad editor

![1_sum1ton_prgm](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/8d1223d6-121a-4710-bfbe-bececc7c96bd)

Output of the C program written 

![2_output_prgm](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/e3e87a48-9ecc-4b1f-9195-6c90c89583a5)
     
</details>


<details>
     <summary>
          <h4 id = 'RISC - V based lab'> RISC - V based lab <h4>
     </summary>

Compiling a C program with a RISC V compiler

The command to display the C code in the terminal is the cat command:
```
cat <Name of the C file: sum1ton.c>
```

![abc](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f6b09cf0-8ca0-4e17-88fe-bed500a7e537)

<h2> -O1 optimization of the code </h2>

Command to compile the C program with the RISC V compiler

```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o <Output file name: sum1ton.o> <Input C source file: sum1ton.c>

```
![4_file_generated](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/cbf0dbd0-b435-42ff-9f9e-16c8fbbfa6c1)

Checking if the output file (sum1ton.o) is created after compiling
```
ls -ltr <Output file name: sum1ton.o>
```
![abc](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/0c86c2eb-40c1-4dec-8795-659dbaca09f7)

To see the assembly-level language, the assembly code is a byte addressing the following command is used.

```
riscv64-unknown-elf-objdump -d <Output file name: sum1ton.o>
riscv64-unknown-elf-objdump -d <Output file name: sum1ton.o> | less
/main
```
The number of instructions that are present in the main function with O1 optimization:

(101bc-10184)/4 = E<br>
Decimal (E) = 14

14 instructions of the main function

![5_assemblycode_O1](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/2aa760e8-8c26-4731-afc5-73bbb4d9ee94)

<h2> -Ofast optimization of the code </h2>

The number of instructions is reduced with increased speed by the following code with Ofast optimization(Maximum optimization):

```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o <Output file name: sum1ton.o> <Input C source file: sum1ton.c>
riscv64-unknown-elf-objdump -d <Output file name: sum1ton.o> | less
/main
```

![xyz](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/345f3d98-a4a6-4020-b5e3-4f4307026bca)

Assembly language for reduced instruction set with increased speed.<br>
The number of instructions that are present in the main function with Ofast optimization:

(100dc-100b0)/4 = B<br>
Decimal (B) = 11<br>
11 instructions of the main function

![6_assemblycode_Ofast](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/515df89c-c430-46e2-b453-3524fb98781d)

From the above observation, we can infer that the number of instructions changes as we use different optimization flags. We can see that the Ofast optimization flag (11 instructions) has fewer instructions than when the O1 optimization flag (14 instructions) is used.<br>

`/main` is used to locate the main function of the C program.<br><br>
`riscv64-unknown-elf-gcc` - risc64 indicates the architecture.<br><br>
`elf` - elf is the executable and linkable format is the file format which is generally used for executable files.<br><br>
`lp64` - Indicates that the system uses 64-bit architecture with long integer and pointer.<br><br>
`rv64i` - i stands for interger in 64 bit RISC V.<br>

**General Optimization flags:**

> ` -O1 ` -  This is the optimization flag. This compilation flag optimizes the code without greatly affecting the compilation time. It reduces the code size and improves performance without significantly increasing compilation time. It maintains the speed between space and the speed of the code.
> <br>
> <br>
> ` -Ofast `: The Ofast flag is for maximum code optimization.
> <br>
> <br>
> ` -O0 `: This is the default no-optimization state.
> <br>
> <br>
> ` -O2 `: This is a higher level of optimization. It helps to look for a balance between the compilation time and the run time performance.
> <br>
> <br>
>  ` -O3 `: This is the maximum optimization that involves maximum and aggressive optimization. Try to achieve the ideal performance with compilation time lesser than the execution speed.
> <br>
> <br>
> ` Os `: This flag is used to optimize the code size by reducing the code size, which is useful for efficient memory usage.
  
Command to run the program with RISC V compiler and to execute the program to get the output
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o <Output file name: sum1ton.o> <Input C source file: sum1ton.c>
spike pk <Name of the output file: sum1ton.o>

```
The output is displayed in the terminal

![1_risc_prgmoutput](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f0240a75-f979-46b1-aa43-155acabd8fd5)

Command to open the debugger to debug

```
spike -d pk <Name of the output file: sum1ton.o>

```
![1_degger](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a0a07eb4-e45e-4802-bb0c-7cdc00f61259)

Command to run the program counter to rum till a particular address
```
Until pc 0 <Memory location till which the program runs: 100b0>
```

![2_run](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/cd738260-c45a-4408-9830-61000e8d39b8)

To view the contents of the register
```
reg 0 a2
```
![1_content](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/65847b8d-afed-456d-a0ec-2faa7a44d373)

From the current instruction, if we want to run the next instruction, enter is being pressed. Once the enter key is pressed the debugger runs the next instruction.

![1](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a1367484-c30d-4e1c-b5ae-835f339370cc)

We can see from the above screenshot that a value of (0x7a) is moved to the register a2, and hence if we view the value content of the register a2 we can observe the value to be 0x7a.

![1](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7b532840-eb01-4453-b7cf-062891b6c6a3)

The command lui is load upper immediate which load the value to the destination register of the upper immediate where the upper immediate means the bits from 12 to 21 a2[31:12].

</details>

<details>
     <summary>
          <h4 id = 'Simulation of RISC V'> Simulation of RISC V <h4>
     </summary>

Commands to simulate RISC V
```
iverilog <Nmae of Verilog file: risc_v.v> <Name of testbench: risc_v_tb.v>
./a.out
gtkwave <Name of vcd file: risc_v.vcd>

```
![1_risc_simulationCommands](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/15dea9e9-114a-47f1-b471-815b8f986c8a)

The memory address of each instruction is specified in the Verilog code of the RISC V and we can observe the output of the instructions in the respective memory locations.

![address](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7c7c0275-92d4-4cc8-bfc0-910fb381651b)


|  **Operation**  |  **Memory address**  |  
|  :----:  |  :----:  |  
|  ADD R6, R2, R1  |  32'h02208300  |  
|  SUB R7, R1, R2  |  32'h02209380  |  
|  AND R8, R1, R3  |  32'h0230a400  |  
|  OR R9, R2, R5  |  32'h02513480  |  
|  XOR R10, R1, R4  |  32'h0240c500  |  
|  SLT R1, R2, R4  |  32'h02415580  |  
|  ADDI R12, R4, 5  |  32'h00520600  |  
|  BEQ R0, R0, 15  |  32'h00f00002  |  
|  SW R3, R1, 2  |  32'h00209181  |  
|  LW R13, R1, 2  |  32'h00208681  |  
|  SRL R16, R14, R2  |  32'h00271803  |
|  SLL R15, R1, R2  |  32'h00208783  |

The output waveform of simulated RISC V for each instruction is given below

1. **```ADD R6, R2, R1```**
   
   The ADD instruction is stored in the memory location 32'h02208300.<br>
   The ADD instruction is used to perform integer addition. It adds the values of two source registers and stores the result in a destination register.<br>
   <p align = "center"> R6 = R2 + R1 </p>
   
   Value stored in the register ID_EX_A is 1 <br>
   Value stored in the register ID_EX_B is 2 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 + 2 = 3<br>
   Hexadecimal(3) = 00000003<br>
   Hence the output of the ADD instruction is 00000003
   

   ![1_add](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a1b4060b-aeac-433e-b2fc-5d21453b448c)

----------------------------------------------------------------------------------------------------------------

2. **```SUB R7, R1, R2```**
   
   The SUB instruction is stored in the memory location 32'h02209380.<br>
   The SUB instruction is used to perform integer subtraction. It subtracts the values of two source registers and stores the result in a destination register.<br>
   <p align = "center"> R7 = R2 - R1 </p>
   
   Value stored in the register ID_EX_A is 1 <br>
   Value stored in the register ID_EX_B is 2 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 - 2 = -1<br>
   Hexadecimal(-1) = FFFFFFFF<br>
   Hence the output of the ADD instruction is FFFFFFFF

   ![3_sub](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5d2c5d22-4139-4700-9e59-1e8f26bc99c1)

----------------------------------------------------------------------------------------------------------------

3. **```AND R8, R1, R3```**
   
   The AND instruction is stored in the memory location 32'h0230a400.<br>
   The AND instruction is used to perform a bitwise AND operation between two registers. The result is stored in a destination register.<br>
   <p align = "center"> R8 = R3 & R1 </p>
   
   Value stored in the register ID_EX_A is 3 <br>
   Value stored in the register ID_EX_B is 1 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;binary(3) & binary(1) <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0011 & 0001 = 0001<br>
   Hexadecimal(0001) = 00000001<br>
   Hence the output of the AND instruction is 00000001
   

  ![1_ADD](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f54cb5ab-d5e5-4800-9179-49f18f249a04)

----------------------------------------------------------------------------------------------------------------

4. **```OR R9, R2, R5```**
   
   The OR instruction is stored in the memory location 32'h02513480.<br>
   The OR instruction is used to perform a bitwise OR operation between two registers. The result is stored in a destination register.<br>
   <p align = "center"> R9 = R5 | R2 </p>
   
   Value stored in the register ID_EX_A is 2 <br>
   Value stored in the register ID_EX_B is 5 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;binary(2) & binary(5) <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0010 & 0101 = 0111<br>
   Hexadecimal(0111) = 00000007<br>
   Hence the output of the OR instruction is 00000007

   ![2_OR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4861d223-16ee-4d51-ba7f-4f68a1b65ddb)

----------------------------------------------------------------------------------------------------------------

5. **```XOR R10, R1, R4```**
   
   The XOR instruction is stored in the memory location 32'h0240c500.<br>
   The XOR instruction is used to perform a bitwise XOR operation between two registers. The result is stored in a destination register.<br>
   <p align = "center"> R10 = R4 ^ R1 </p>
   
   Value stored in the register ID_EX_A is 1 <br>
   Value stored in the register ID_EX_B is 4 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;binary(1) ^ binary(4) <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0001 & 0100 = 0101<br>
   Hexadecimal(0101) = 00000005<br>
   Hence the output of the XOR instruction is 00000005

  ![1_XOR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/b7ef59d0-306d-4dac-98af-6e58c90b88c5)

----------------------------------------------------------------------------------------------------------------

6. **```SLT R1, R2, R4```**
   
   The SLT instruction is stored in the memory location 32'h02415580.<br>
   The SLT instruction is used to compare two registers and set a destination register to 1 if the first source register is less than the second source register, otherwise it sets the destination register to 0.
   <p align = "center">
         R1 = SLT R4 R2 <br><br>
   </p>
Logic of SLT: 
> if(R2 < R4){ <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 }<br>
> else{ <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0 }<br><br>
   
   Value stored in the register ID_EX_A is 2 <br>
   Value stored in the register ID_EX_B is 4 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2 < 4 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;= 1<br>
   Hexadecimal(1) = 00000001<br>
   Hence the output of the SLT instruction is 00000001

 ![2_SLT](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/2d09eff7-940c-4f2d-82eb-be060ffebda7)

----------------------------------------------------------------------------------------------------------------

 7. **```ADDI R12, R4, 5```**
   
   The ADDI instruction is stored in the memory location 32'h00520600.<br>
   The ADDI instruction stands for add immediate which is used to perform integer addition between a register and an immediate (constant) value. The result is stored in a destination register.<br>
   <p align = "center"> R12 = R4 + R5 </p>
   
   Value stored in the register ID_EX_A is 4 <br>
   Value stored in the register ID_EX_B (Immediate Constant) is 5 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4 + 5 = 9<br>
   Hexadecimal(9) = 00000009<br>
   Hence the output of the ADDI instruction is 00000009
   
   ![3_ADDI](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/530db46c-ef8c-4150-88f4-dcbdf95d6719)

----------------------------------------------------------------------------------------------------------------

8. **```SW R3, R1, 2```**
   
   The SW instruction is stored in the memory location 32'h00209181.<br>
   The SW stands for store word, which is used for saving data from registers to memory, such as in stack operations, saving variables, and storing results of computations.
   <p align = "center">
         SW source register 2, Source register 1, offset value <br><br>
   </p>

The offset value is added to the address of the source register 1. The value in the source register 2 is stored in the new address obtained after adding the offset value.
Logic of SW: <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Memory[Souce register 1 + offset] = Souce register 2<br><br>

   Value stored in the register ID_EX_A is 1 <br>
   Value stored in the register ID_EX_B is 2 <br>
   The offset value that is added to the program counter is 2 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Memory[1+2] = 2br>
   
![8_sw](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/ec45dff7-ee89-4f49-9750-657b2578fd06)

----------------------------------------------------------------------------------------------------------------

9. **```BNE R0, R1, 20```**
   
   The BNE instruction is stored in the memory location 32'h01409002.<br>
   The BNE stands for branch if not equal, which is used to  compare two registers and branch to a specified address if the values in the registers are not equal
   <p align = "center">
         BNE Source register 1, Source register 2, offset value <br><br>
   </p>

If both the source registers are not equal then an offset value is added to the program counter and is obtained as output.
Logic of BNE: 
> if(R0 != R0){ <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;program counter = program counter + Offset value }<br><br>

   Value stored in the register ID_EX_A is 02 <br>
   Value stored in the register ID_EX_B is 02 <br>
   The offset value that is added to the program counter is 20 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;02 = 02 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=> PC != PC + 20;<br>
   Since the values in the register are equal we can see that the program counter is not a sum of the old program counter and offset value.

   Decimal(1B) + 20 = 47<br>
   Hexadecimal(47) = 2F<br>
   Hence we can observe that the output of the BNE instruction is 00000004 which is not equal to 2F.

![5_](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/8e4e137c-4ec8-4d7b-a2ac-b9251af0800c)

----------------------------------------------------------------------------------------------------------------

10. **```BEQ R0, R0, 15```**
   
   The BEQ instruction is stored in the memory location 32'h00f00002.<br>
   The BEQ stands for branch if equal, which is used to  compare two registers and branch to a specified address if the values in the registers are equal
   <p align = "center">
         BEQ Source register 1, Source register 2, offset value <br><br>
   </p>

If both the source registers are equal then an offset value is added to the program counter and is obtained as output.
Logic of BEQ: 
> if(R0 = R0){ <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;program counter = program counter + Offset value }<br><br>

   Value stored in the register ID_EX_A (R0) is R0 <br>
   Value stored in the register ID_EX_B (R0) is R0 <br>
   The offset value that is added to the program counter is 15 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R0 = R0 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=> PC = PC + 15;<br>

   Decimal(0B) + 15 = 25<br>
   Hexadecimal(25) = 19<br>
   Hence the output of the BEQ instruction is 00000019

![10_BEQ](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/57b6d6f8-fa1b-435d-859d-27fc9fe39c00)

</details>

<details>
     <summary>
          <h4 id = 'Synthesis of RISC V'> Synthesis of RISC V <h4>
     </summary>

Commands to synthesize RISC V
```
yosys
read_liberty -lib <path to .lib file>
read_verilog <Verilog file name: risc_v.v>
synth -top <module name that has to be synthesized>
abc -liberty <path to .lib file>
write_verilog -noattr <Name of Netlist; risc_v_net.v>

```

We can see that the netlist for the RISC V design has been created in the directory 

![5_riscv_netlist](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f27a45df-766b-4369-a87b-55d6c201734a)

</details>

<details>
     <summary>
          <h4 id = 'GLS Simulation of RISC V'> GLS Simulation of RISC V <h4>
     </summary>

Commands for GLS simulation RISC V
```
iverilog <Path to primitives.v file > <Path to sky130_fd_sc_hd__tt_025C_1v80.lib> <Name of netlist: risc_v_net.v> <Name of testbench: risc_v_tb.v>
./a.out
gtkwave risc_v.vdc

```

![3_risc_GLSsimulationCommands](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7a0392dc-28b5-4819-87bc-9396fa3b1939)

The output waveform of Gate level simulated (GLS) RISC V for each instruction

1. **```ADD R6, R2, R1```**

![1_add](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9f31f98e-cc98-4a36-9cf0-14caf6aa1088)

2.  **```SUB R7, R1, R2```**

![2_sub](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/c6a36537-fc71-457a-8ea8-0be8f142ab4f)

3.  **```AND R8, R1, R3```**

![3_and](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7027b284-7dbc-4f73-82fa-8f5faf46f2a3)

4.  **```OR R9, R2, R5```**

![4_or](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9ca618a4-1d72-4fda-8c19-c1d2b13c6eca)

5.  **```XOR R10, R1, R4```**

![5_xor](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/bbd1d802-3d43-4ad5-9f68-ddebb7467013)

6.  **```SLT R1, R2, R4```**

![6_slt](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/38e891bf-be58-40d6-8ad0-260aece889d1)

7.  **```ADDI R12, R4, 5```**

![7_addi](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/5eca2325-6247-4bb8-b228-beb5023eb1af)

8.  **```SW R3, R1, 2```**

![SW](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/65f24ab9-8a1b-444b-8352-b0db5e26e211)

9.  **```BNE R0, R1, 20```**

![9_bne](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/9a1d650e-b8dd-4841-bf9d-6e87183e1e76)

10.  **```BEQ R0, R0, 15```**

![8_beq](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/b8dbb1ec-43b5-40e4-88ad-24cf5547d38f)


We can observe from the waveforms that the output of the Simulated waveform and GLS output waveform match and there is no mismatch.

</details>

</details>
     

