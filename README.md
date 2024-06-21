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

Plot of RTL simulated blocking_caveat.v:
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
     

