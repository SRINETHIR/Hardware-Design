<h1>Implementing and Testing a RISCV at 130nm with Open-Source EDA Tools.</h1>
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


|  **Operation**  |  **Hardcoded ISA**  |  
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

----------------------------------------------------------------------------------------------------------------

1. **```ADD R6, R2, R1```**
   
   The ADD instruction is stored in the memory location 32'h02208300.<br>
   The ADD instruction is used to perform integer addition. It adds the values of two source registers and stores the result in a destination register.<br>
   <p align = "center"> R6 = R2 + R1 </p>
   
   Value stored in the register ID_EX_A is 1 <br>
   Value stored in the register ID_EX_B is 2 <br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 + 2 = 3<br>
   Hexadecimal(3) = 00000003<br>
   Hence the output of the ADD instruction is 00000003
   
![1_ADD](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4ff036f3-fe67-43ef-aba8-28a22a372c72)

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

![2_SUB](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/7331c0bc-a287-4e24-ba0a-4ab6a0deb850)

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
   

 ![3_AND](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f96b3e51-0c17-4a41-b93b-ac68d5e7200d)

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

  ![4_OR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/a5015274-9b63-4aff-8dc7-fd38d326d820)

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

  ![5_XOR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/aa88adfc-49cc-4ae8-bbbb-bcf37baff901)

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

![6_SLT](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/f0544c91-b750-4030-99ad-def3f07de63a)

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
   
 ![7_ADDI](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/2c2899e4-2934-4d53-b298-b755b29c5886)

----------------------------------------------------------------------------------------------------------------

8. **```BEQ R0, R0, 15```**
   
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

![10_BEQ](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/cc5e3721-31cf-4489-b9e2-a7fbd008ac15)

----------------------------------------------------------------------------------------------------------------

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

![1_ADD](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/4b1e4cf3-4864-4f3a-b977-a8e58c1de7e8)

2.  **```SUB R7, R1, R2```**

![2_SUB](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/0f27ad05-8694-472d-b966-02f039eadd14)

3.  **```AND R8, R1, R3```**

![3_AND](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/08a46470-9312-4685-ac27-55323511c51d)

4.  **```OR R9, R2, R5```**

![4_OR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/73468b98-77fb-43f8-8178-b31b62f26492)

5.  **```XOR R10, R1, R4```**

![5_XOR](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/32b5daf0-4bfc-45ac-ba1a-643e7d86061b)

6.  **```SLT R1, R2, R4```**

![6_SLT](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/40ca092a-6045-42ae-978d-0c9819b858ef)

7.  **```ADDI R12, R4, 5```**

![7_ADDI](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/ff46d001-79a6-46c7-9ce4-97023e9b3624)

8.  **```BEQ R0, R0, 15```**

![10_BEQ](https://github.com/SRINETHIR/Hardware-Design/assets/141196086/cd2d229e-732d-4716-9cca-0e456418a459)


We can observe from the waveforms that the output of the Simulated waveform and GLS output waveform match and there is no mismatch.

</details>

</details>


<details>
     <summary>
          <h2 id = 'Week 4'>Week 4</h2>
     </summary>
     <h3>Installing OpenSTA</h3>

     git clone https://github.com/parallaxsw/OpenSTA.git
     cd OpenSTA
     mkdir build
     cd build
     cmake ..
     make

sta for static timing analysis

![1](https://github.com/user-attachments/assets/4c5e36fb-ac44-4e14-bf4e-345d2a059a3c)

Tcl file configuration to perform the static timing analysis

![tcl](https://github.com/user-attachments/assets/6865e26e-6dbf-44a2-a3b8-13370bc6c748)

STA for fast library

![4_sta_ff](https://github.com/user-attachments/assets/1d132e74-84b9-4558-98ee-38c7e03e8ea6)

STA for slow library

![5_sta_ss](https://github.com/user-attachments/assets/329a0db9-58ae-486c-b97b-b7918fa600f5)
![6_sta_ss_2](https://github.com/user-attachments/assets/53e7dd10-6154-4854-abcb-43174c601ba8)

STA for typical library

![7_sta_tt_1](https://github.com/user-attachments/assets/864ab847-29f1-4f49-bbda-84b7935a9859)
![8_sta_tt_2](https://github.com/user-attachments/assets/efc2e84f-fb1a-47e4-bb66-bd56dce1d13b)

TCL file to generate the output files

![tcll_report](https://github.com/user-attachments/assets/ef2159c6-1bd1-4f1c-bcd2-f51950814256)


Output files generated

![out](https://github.com/user-attachments/assets/f909fed2-9f06-4f6c-8b5f-3b672f74e9bc)

TNS

![8_TNS](https://github.com/user-attachments/assets/da29767a-60dc-4a1f-9dd7-7fb26a533e45)

WNS

![9_WNS](https://github.com/user-attachments/assets/122a1782-4572-4c1a-a916-969bfbf4b4ec)


</details>
<details>
     <summary>
          <h2 id = 'Week 5'>Week 5</h2>
     </summary>
SDC constraints

![d_sdc](https://github.com/user-attachments/assets/660dadb3-d417-4883-b5d2-173639cf061c)

TCL file

![c_tcl](https://github.com/user-attachments/assets/62964f8a-373e-45d6-8a37-9252d5ed810d)

SDC exported

![a_export_sdc1](https://github.com/user-attachments/assets/6762003e-0aa1-495d-bc4b-e99bdb01ee7a)

![b_export_sdc2](https://github.com/user-attachments/assets/0fcc6129-5c5d-44c3-9d53-4a4597bbf0c9)

</details>

<details>
     <summary>
          <h2 id = 'Week 6'>Week 6</h2>
     </summary>

A chip design contains various components inside the chip. A few of those components are listed below:

1.  **```PADS```** - Pads are used to send the signals inside the chip. Signals move from inside to outside or outside to inside through these pads.<br><br>
2.  **```CORE```** - All the digital logic of the chip is present inside the core of the chip (like OR gate, AND gate, etc.)<br><br>
3.  **```DIE```** - Die is the sides of the entire chip that surrounds the core of the chip.<br><br>
4.  **```FOUNDARY IPs```** - The blocks which are present in the core of the chip like ADC, DAC, SRAM, etc are the boundary IPs. The performance of the electronic devices depends on the boundary IPs.<br><br>
5.  **```MACROS```** - Macros are mostly purely digital logic. But when compared to macros, foundry IPs require some amount of intelligence to continue.<br>

<h2>RISC V instruction set architecture (ISA)</h2>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Software applications are composed of small functions that are compiled and executed. These functions are translated into hardware-specific instructions by a compiler, which is then converted into binary machine language using an assembler. The compiler's instructions serve as an intermediate layer between the C language and binary language. To implement these instructions and produce binary output, an RTL (Register Transfer Level) description language is used. The netlist, synthesized from the RTL, is then converted into hardware through physical design implementation.

<h2>ASIC flow - Application-specific integrated circuits flow</h2>
Major elements that are required to design ASIC are:
<ul>
     <li>Hardware description language</li>
     <li>EDA tools</li>
     <li>PDKs-Process design kits</li>
</ul>
The OpenLane Architecture and the OpenLane flow stages are depicted below:
<br><br>

![1](https://github.com/user-attachments/assets/3c5da553-29dd-4e27-86b6-58952d9fd3ee) 

<br><br>
The simplified flow from RTL to GDSII is as given below:
<br><br>

![2](https://github.com/user-attachments/assets/45c22368-97be-4c00-af2c-6b9553635232)
<br><br>
<details>
     <summary>
          <h4 id = 'Design preparation Setup'>Design preparation Setup</h4>
     </summary>

The below set of code is used for the basic design preparation setup of OpenLane

```
docker
./flow.tcl -interactive
package require openlane 0.9
```
**```Docker```** - This command is used to provide a suitable environment for the OpenLane flow to run.<br><br>
**```./flow.tcl -interactive```** - This command runs the flow.tcl script in interactive mode. The -interactive flag likely indicates that the script will require user input or will run in a mode where the user can interact with it in real time.<br><br>
**```package require openlane 0.9```** - This command inputs and loads all the OpenLnae packages of version 0.9 which are required.<br><br><br>

![3](https://github.com/user-attachments/assets/3fb6a977-c397-4085-9611-d509fe26d73e)

 The design that we need to run the OpenLane flow is kept in the designs folder inside the OpenLane folder. Each design is present as a folder which has the src folder, config file, and skywater130 nm pdk(process design kit). Inside the src folder it contains the Verilog design file and the sdc constraints used for timing analysis.<br>

 ```
prep -design <Design folder name>
 ```
The above command sets up the necessary files and configurations for the design process. It creates a specific location from where the flow fetches the file and merges the lef files and the tlef files.<br>
Once the preparation is complete a run folder is created which has a folder with the date of creation. The config.tcl file inside the run folder makes sure that it shows the default parameters.

![1](https://github.com/user-attachments/assets/3471ce15-b948-41d7-89ee-cdafd31c428e)

</details>

<h3>The different stages of OpenLane flow are explained in detail below:</h3>

<details>
     <summary>
          <h4 id = 'Synthesis'>Synthesis</h4>
     </summary>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synthesis is the digital design process where the high-level behavioral description of a circuit (usually written in hardware description languages like Verilog or VHDL) is translated into a gate-level netlist. This gate-level netlist is composed of logic gates and flip-flops, which are the fundamental building blocks of digital circuits. These blocks are from the Standard cell libraries.<br>
Once the preparation is complete the command used to synthesize is given below,
```
run_synthesis
```
The above command is to run both yosys synthesis and ABC. Once the synthesis is complete reports and results will be generated in the respective folder.<br>

![2](https://github.com/user-attachments/assets/f5b7acb3-9d86-4916-98da-5181fca658e5)

The Flop Ratio is calculated by,
```math
Flop\ Ratio = \frac{Number\ of\ D\ Flip\ Flops}{Total\ Number\ of\ Cells}
```
```math
Percentage\ of\ DFF's = Flop\ Ratio * 100
```
<br>
From the synthesized report we get the number of D flipflops and total number of cells as,<br>

![4](https://github.com/user-attachments/assets/c1a7f03b-c566-46be-8574-1e38cfcc130a)
<br><br>
From the synthesized report we can calculate the flop ratio as,
```math
Flop\ Ratio = \frac{1618}{7138} = 0.2266741384
```
```math
Percentage\ of\ DFF's = 0.2266741384 * 100 = 22.66741384\ \%
```
</details>
<details>
     <summary>
          <h4 id = 'Floor and power planning'>Floor and power planning</h4>
     </summary>

In floor planning, there are various steps involved in floor planning,
<h3>Width and height of core and die</h3>
<br>
Defining the dimensions of the chip is mostly dependent on the dimensions of the logic gates used that is the standard cells. Dimensions of the wire used to connect the cells also play a major role in defining the dimensions of the chip.<br><br>

**```CORE```** - A core is the section of the chip where the fundamental logic of the design is placed. <br><br>
**```DIE```** - Core is inside the die. Die encapsulates the core, which is the small semiconductor material specimen on which the fundamental circuit is fabricated.<br><br>
When the circuit which includes the standard cells and flipflops together completely occupies the complete core then it means that it has 100% utilization of the core.<br>
Utilization of the core is given by,

```math
Utilization\ Factor = \frac{Area\ occupied\ by\ Netlist}{Total\ Area\ of\ Core}
```
```math
Percentage\ of\ Utilization\ Factor = Utilization\ Factor * 100
```

When the utilization factor is 1 the the core is completely occupied by the cells no external cells can be added to the core. Ideally, the utilization factor percentage is taken to be 50%  or 60%.<br>
The aspect ratio is the ratio between the height of the chip to the width of the chip.

```math
Aspect\ Ratio = \frac{Height}{Width}
```
```math
Percentage\ of\ Aspect\ Ratio = Aspect\ Ratio * 100
```

For a square chip, the Aspect ratio is equal to 1.<br>
Extra area in the core is kept ideally for optimization to place some buffers.
<br>
<h3>Pre Placed cells</h3>
<br>
A single netlist can be divided into multiple subblocks that can be used together and separately according to the needs. Preplaced cells can be used multiple times. The functionality of the replaced cells is implemented once and instantiated multiple times in the netlist. The placement of these preplaced cells or IPs is called Floor Planning. Preplaced cells are placed even before placement and routing. These pre-placed cells are not moved during the placement and routing and remain in the fixed place.
<br><br>
<h3>De-Coupling Capacitors</h3>
The preplaced cells have to be surrounded by de-coupling capacitors. Whenever a logic state is switching from logic 0 to logic 1, the supply voltage has to send some charge, which charge the capacitor from 0 to 1. This current requirement is met by the supply voltage. Similarly while shifting from logic 1 to logic 0, Vss takes the charge and discharges the capacitor. But practically, when a power supply flows through a piece of wire there is a drop due to the resistance and inductance associated with the wire.<br>
When the output at the end of the wire goes below the noise margin then logic 1 is not detected as 1.
Decoupling capacitors are huge capacitors filled with charge which are connected parallel to the circuit. The equivalent voltage across the decoupling capacitor is the input voltage. Once the preplaced cells are surrounded by de-coupling capacitors, local communication is taken care.
<br><br>
<h3>Power Planning</h3>
The signal that travels from one pre-placed cell to another pre-placed cell requires some extra power from the power supply to maintain the logic. Decoupling capacitor can't be placed all over the chip as it is not feasible and hence require the power supply. When a 16-bit bus is connected to an inverter, all the capacitors charged to be discharge to 0 through the ground which causes a ground bounce. And only one ground is available to discharge. Ground buses can settle later. But when the size of the ground bounce Ghosts is greater than the noise margin then it enters to an undefined state which is not predictable. Similarly, when all capacitors, try to charge simultaneously It causes a voltage group as it demands from a single main supply. Both the problem of voltage droop and ground bounce is due to the presence of only one single source power supply. <>When there are multiple source power supplies and multiple Vdd, power can be taken from the nearest power supply, or drop current can be dropped to the nearest ground.
<br><br>
<h3>Pin placement</h3>
Complete knowledge of the design is required for the pin placement. Clock ports are bigger than the data ports. As the clock ports drives, all the cells are completely on the chip and hence the clock ports requires the least resistance.
As higher the area, lower will be the resistance and hence clog ports are bigger.
<br><br>
<h3>Logical cell placement blockage</h3>
Automated placement and routing tools do not place any cells in a particular area where the io pins are placed (DIE). Therefore, the area is reserved for pen location.
<br><br>

Run the below command to get the floor plan of the design,
```
run_floorplan
```
<br>

![1](https://github.com/user-attachments/assets/c30babf5-f5d6-4c1c-b73b-6ead34eb0ef1)
<br>
To view the layout after the floorplan, run the below command in the floorplan results directory:

```
magic -T <path to .tech file> lef read <path to .lef file> def read <name of .def file> &
```
<br>
     
![2](https://github.com/user-attachments/assets/28533f8c-b224-4426-90c8-b16f18f8f859)
<br>

Screenshot of the floorplan viewed with magic:
<br>
![1](https://github.com/user-attachments/assets/3765a953-31c8-41c4-b443-7269b2cb8026)
<br>
We could observe that the ports are placed equidistant as mentioned:
<br>
![1](https://github.com/user-attachments/assets/6c2986cf-a554-4c6f-b727-222ba41c37a3)
<br>
Metal layers are configured correctly:
<br>
![1](https://github.com/user-attachments/assets/07a4be58-7529-4047-948c-8f3cf9a31a5f)
<br>
De-Coupling capacitor:
<br>
![1](https://github.com/user-attachments/assets/bfb25dbd-3a23-48ed-bd95-6d9665a869e2)
<br>
All the unplaced standard cells are placed in the left corner:
<br>
![2](https://github.com/user-attachments/assets/84c27a20-c77d-44c8-887a-a35671dbb50f)
<br>
</details>
<details>
     <summary>
          <h4 id = 'Placement'>Placement</h4>
     </summary>

Run the below command to complete the placement of the design,
```
run_placement
```
<br>

![1](https://github.com/user-attachments/assets/bce1c1d0-6c03-43c6-bcac-0e4beaad5d7c)
<br>

![2](https://github.com/user-attachments/assets/ac5add61-9c21-4efe-9b80-536efb41c933)
<br>

To view the layout after the floorplan, run the below command in the floorplan results directory:

```
magic -T <path to .tech file> lef read <path to .lef file> def read <name of .def file> &
```
<br>

![3](https://github.com/user-attachments/assets/390cc80a-6e02-4d19-8caa-370a394b5204)
<br>

Layout after placement:
<br>
![1](https://github.com/user-attachments/assets/ded63354-9208-4b00-aba5-2f4a44d35ebc)

</details>
<details>
     <summary>
          <h4 id = 'SPICE extraction and post layout spice Simulation'>SPICE extraction and post layout spice Simulation </h4>
     </summary>

Git clone the repository **```(https://github.com/nickson-jose/vsdstdcelldesign.git)```** to get the already built .mag file which is already built for the inverter using the command.
```
git clone <HTPPS web URL to clone: https://github.com/nickson-jose/vsdstdcelldesign.git>
```
The clone folder has the .mag file **```(skt130A_inv.mag)```** for the invertor,
<br>

![1](https://github.com/user-attachments/assets/6bd121d2-da07-4360-a5a4-fb860d04f594)

<br>
Command to open the .mag file to view the layout of the inverter:

```
magic -T <Name of .tech file: sky130A.tech> <Nmae of .mag file: sky130A_inv.mag> &
```

![2](https://github.com/user-attachments/assets/8d6e2b1b-21fb-4bf8-9c95-16e1101d602e)

<br>
The layout of the inverter is viewed with magic:

![1](https://github.com/user-attachments/assets/da1d92ab-f1c6-4de3-b3fc-ac26b2716822)

<br>
Checking the NMOS and PMOS of the inverter layout:<br>

![nmos](https://github.com/user-attachments/assets/2199ff66-5fc1-4993-b2a1-fb77109a64cb)
<br>
![pmos](https://github.com/user-attachments/assets/07b736c9-61bb-4d9f-978d-25c79e7d6e2d)
<br><br>
Checking if the drain of PMOS and drain of NMOS is connected and to output:<br>
To check if any two parts of the inverter layout are connected, press S three times so that all the connected region gets highlighted.
<br>
![1](https://github.com/user-attachments/assets/ff052d66-b194-4b12-82cf-a6db994f40c6)

<br>
Source of PMOS connected Vdd
<br>

![1](https://github.com/user-attachments/assets/4a16a12d-4efa-4064-a4b7-f2e5c002ab45)

<br>
Source of NMOS connected Vss (Ground).
<br>

![2](https://github.com/user-attachments/assets/700bcbb8-4238-4c44-b0dc-6b836fee9ca4)
<br>

<h4>SPICE extraction:</h4><br>
Command to extract the ext file from magic:

```
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
<br>

![2](https://github.com/user-attachments/assets/0b011cbf-2874-47a3-8e96-c55bd5f42360)
<br>

Creating the Spice file with the ext file:
<br> 

![1](https://github.com/user-attachments/assets/99338de5-a30f-464a-a2c8-db4d197f01da)
<br> 

![2](https://github.com/user-attachments/assets/5d19b549-baf3-47fc-9fc6-efd242c3d2c8)
<br>

Once these commands are done we can observe the spice file being created in the location,
<br>

![1](https://github.com/user-attachments/assets/db157108-4b42-4e76-9e97-e57be1065c88)
<br>

The created spice file:
<br>

![2_spicefile](https://github.com/user-attachments/assets/7a4e7183-9783-4ca8-946b-8c410ee513fc)

<br>

Dimension of the grid in the layout:<br>
![1_dimension](https://github.com/user-attachments/assets/ac9beb37-41f9-41b7-89a6-a7cc451588e0)
<br>
Edit the spice file according to the layout.<br>

![2](https://github.com/user-attachments/assets/415e1ee1-c1aa-45ef-9192-520bf6eb8f17)
 
<br>
<h4>SPICE simulation:</h4><br>

To get the waveform and simulate it with ngspice run the following commands:
```
ngspice <Nae of the spice file: sky130_inv.spice>
plot y vs time a
```
![1](https://github.com/user-attachments/assets/a1497ffc-3a99-4b15-8635-8861b15a8fbd)

<br>
Fall transition delay is the time taken to fall from 80% of the maximum value(Vdd) to 20% to the maximum value(Vdd). Similarly, rise transition delay is the time taken to rise from 20% to the maximum value(Vdd) to 80% of the maximum value(Vdd).

Rise transition delay:
<br>
```math
Rise\ transition\ time = Time\ taken\ for\ output\ to\ rise\ to\ 80\% - Time\ taken\ for\ output\ to\ rise\ to\ 20\%
```
```math
20\%\ of\ VDD = 0.66
```
```math
80\%\ of\ VDD = 2.64
```
<br>
20% Of the VDD = 0.66:
<br>

![20](https://github.com/user-attachments/assets/105be3a4-a3ef-45ee-917f-f3566e5de8f1)
<br>
80% Of the VDD:
<br>

![80](https://github.com/user-attachments/assets/0ea6e46d-e134-4676-8ee1-e1690f278139)
<br>

```math
Rise\ transition\ time = 2.20467 - 2.16824 = 0.036943\ ns = 36.943\ ps
```

<br>
Fall transition delay:
<br>

```math
Fall\ transition\ time = Time\ taken\ for\ output\ to\ fall\ to\ 20\% - Time\ taken\ for\ output\ to\ fall\ to\ 80\%
```
```math
20\%\ of\ VDD = 0.66
```
```math
80\%\ of\ VDD = 2.64
```
<br>
20% Of the VDD = 0.66:
<br>

![20](https://github.com/user-attachments/assets/faa96529-5269-47b6-86d5-ddeddb5dca1b)
<br>
80% Of the VDD:
<br>

![80](https://github.com/user-attachments/assets/663cb8f6-848a-4d91-b4f2-4130ee774398)
<br>

```math
Rise\ transition\ time = 8.06645 - 8.04008 = 0.02637\ ns = 26.37\ ps
```
Rise Cell delay is the difference between the time taken by the output to reach 50% and the time taken by the input to reach 50% when the output is rising. Whereas, Fall cell delay is the difference between the time taken by the output to reach 50% and the time taken by the input to reach 50% when the output is falling.<br>

Rise Cell Delay:

```math
Rise\ Cell\ Delay = Time\ taken\ for\ output\ to\ rise\ to\ 50\% - Time\ taken\ for\ input\ to\ fall\ to\ 50\%
```
```math
50\%\ of\ VDD = 1.65
```
<br>
Time taken for the input to fall to 50% of the output:
<br>

![fall](https://github.com/user-attachments/assets/221cef1f-a0b3-4a16-9c1b-4b006ce5be33)
<br>
Time taken for the output to rise to 50% of the output:
<br>

![rise](https://github.com/user-attachments/assets/ad97e794-d5f2-423a-919f-cdfe22b36871)

```math
Rise\ Cell\ Delay = 2.18661 - 2.14992 = 0.03669\ ns = 36.69\ ps
```
<br>
Fall Cell Delay:
<br>

```math
Fall\ Cell\ Delay = Time\ taken\ for\ output\ to\ fall\ to\ 50\% - Time\ taken\ for\ input\ to\ rise\ to\ 50\%
```
```math
50\%\ of\ 3.3\ V = 1.65\ V
```
<br>
Time taken for the input to rise to 50% of the output:
<br>

![rise](https://github.com/user-attachments/assets/cacfaa9c-da32-488a-a69f-1975e5ff7d9e)
<br>
Time taken for the output to fall to 50% of the output:
<br>

![fall](https://github.com/user-attachments/assets/02d69dda-2963-4ccf-977e-8073988892cc)
<br>

```math
Fall\ Cell\ Delay = 4.05326 - 4.05004 = 0.00322\ ns = 3.22\ ps
```

<br>
</details>
<details>
     <summary>
          <h4 id = 'Condtions for custom designed cell layout'>Condtions for custom designed cell layout</h4>
     </summary>

lef file has information regarding input ports, output ports, power, and grid information. No information regarding the logic is present in the lef file. The lef file is enough for placement and routing. Lef file can be extracted from the .mag file. <br>

Guidelines that have to be followed in making a standard cell set are:
1) The input and output ports must be at the intersection of vertical and horizontal tracks.
2) The standard cell's width must be an even multiple of the track pitch.
3) The cell's height should be an odd multiple of vertical pitch.
<br><br>
tracks.info of sky130_fd_sc_hd
<br>

![2](https://github.com/user-attachments/assets/9ab56fb8-7df2-43c6-8eaf-43b61e808515)

<br>
Command to convert grig info to track info:
```
grid Xspacing Yspacing Xorgin Yorgin
```
<br>

![1](https://github.com/user-attachments/assets/c0460dee-edeb-42fd-a996-58d1a8aeea33)
<br>

We could see that the input and output ports is at the intersection of the vertical and horizontal tracks. This make sure that the route can reach the port from both y and x direction. 
![1](https://github.com/user-attachments/assets/e1cb53ad-f6a4-436e-9f55-813e31544dc0)

<br>
<br>
X pitch from the track info is 0.46 um
<br>

![1](https://github.com/user-attachments/assets/311669b5-1b1c-4817-9d49-feaeb4af7b92)


The width of the standard cell should be an odd multiple of x pitch.<br>
 hence,<br>

![1](https://github.com/user-attachments/assets/3b3dff59-2bed-4269-8013-91dcd14df8b0)
<br>

 ```math
 0.5 + 1 + 1 + 0.5 = 3
```
 ```math
Width\ of\ standard\ cell = 0.46 * 3 = 1.38\ um
```
 
<br>
Similarly, the height of the standard cell should be an even multiple of y pitch
<br>

![1](https://github.com/user-attachments/assets/f97f0670-267c-4d5a-9ac9-ff580514cc3b)

<br>

```math
 0.5 + 1 +1 + 1 + 1 + 1 + 1 + 1 + 0.5 = 8
```
 ```math
Height\ of\ standard\ cell = 0.34 * 8 = 2.72\ um
```
</details>

<details>
     <summary>
          <h4 id = 'Extracting lef file'>Extracting lef file</h4>
     </summary>

Run the command in the magic tkcon window to save the layout with the preferred name
<br>
```
save <Name of the .mag file: sky130_vsdinv.mag>
```
<br>

![1_save](https://github.com/user-attachments/assets/83e50ef3-613e-4541-9132-12be8671750a)
<br>

Command to create and extract the lef file<br>
```
lef write <Name of the left file: sky130_vsdinv.lef> 
```
<br>

![1](https://github.com/user-attachments/assets/26da5f48-ec38-4c5e-b59c-4a24e4f8ebe7)
<br>

Screenshot of generated lef file:
<br>

![1](https://github.com/user-attachments/assets/9bdb24c5-7194-45f8-9bab-f293e0cd96f9)
<br>

Copy and move the generated lef files and the Sky Water Lib file for different processes to the src folder of your design.
<br>
![2](https://github.com/user-attachments/assets/4852131d-8daf-4a1a-b48f-b48be5ae5b89)
<br>

Edit the config.tcl file to add the lef file to the OpenLnae flow.<br>
Include these commands in the config.tcl file of the design.<br>
```
set ::env(LIB_SYNTH) "$::env(OPENLANE_ROOT)/designs/riscv/src/sky130_fd_sc_hd__typical.lib"
set ::env(LIB_FASTEST) "$::env(OPENLANE_ROOT)/designs/riscv/src/sky130_fd_sc_hd__fast.lib"
set ::env(LIB_SLOWEST) "$::env(OPENLANE_ROOT)/designs/riscv/src/sky130_fd_sc_hd__slow.lib"
set ::env(LIB_TYPICAL) "$::env(OPENLANE_ROOT)/designs/riscv/src/sky130_fd_sc_hd__typical.lib"

set ::env(EXTRA_LEFS) [glob $::env(OPENLANE_ROOT)/designs/$::env(DESIGN_NAME)/src/*.lef]
```
![1](https://github.com/user-attachments/assets/ae33a081-df95-4c0a-9e45-3a0b077920e2)
<br>
</details>

<details>
     <summary>
          <h4 id = 'Including the lef file with the custom riscv design'>Including the lef file with the custom riscv design</h4>
     </summary>

To continue with old already existing OpenLane run files use the following command:
```
docker
./flow.tcl -interactive
prep -design <design name: riscv> -tag <Name of the run folder: 02-08_14-37> -overwrite
```
![1](https://github.com/user-attachments/assets/7bd9135f-7dd2-49c5-b189-2978675b7700)
<br>
Run the following commands to include the lef file into the OpenLane flow:
```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
![1](https://github.com/user-attachments/assets/d16eae5a-5639-49a5-8dec-c540c3fc164c)
<br>

Now run the synthesis part<br>
We could see 562 instances of our invertor cell in the riscv design<br>
![1](https://github.com/user-attachments/assets/e44b2458-2266-4060-9dc7-b9d6d69914ce)

Ckenkig if the lef file of sky130_vsdinv is added to merged.lef<br>
![1](https://github.com/user-attachments/assets/247a8ed4-81a5-4632-b688-c28619486540)

<br>
As we get errors if run the floor plan all at once, we can perform the floor plan step by step with the below commands
<br>

```
init_floorplan
place_io
tap_decap_or
```
![2_floorplan](https://github.com/user-attachments/assets/4f9bd03b-d45e-4a6f-8e28-6c917b37738a)

</details>

<details>
     <summary>
          <h4 id = 'Placement'>Placement</h4>
     </summary>

Performing the placement once the floor plan is done<br>

```
run_placement
```

![3_placement](https://github.com/user-attachments/assets/7e344595-7080-4288-a0ae-c3853f0e06f4)

<br>
Move to the placement folder in the result to view the layout after placement. Run the command to view the layout with magic:
<br>

```
cd Desktop/work/tools/openlane_working_dir/openlane/designs/riscv/runs/04-08_08-02/results/placement/
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read riscv.placement.def &
```
<br>
![2](https://github.com/user-attachments/assets/2364ba07-26b9-436f-a26a-e613bbf5a18a)
<br>

Layout once placement is done:
<br>

![2](https://github.com/user-attachments/assets/45c06223-508b-4a4e-964a-470fb52122e5)
<br>
Instances of vsdiat plugged in the layout 
<br>

![2](https://github.com/user-attachments/assets/540376b7-4061-411f-a77c-ef01171cee19)
<br>
The overlap in the cell layout is the abutment that ensures that power and ground are shared between the cells.<br>
To expand and view the internal layers of the layout run the below command in the tkcon window of magic by selecting the section.<br>

```
expand
```
<br>

![2](https://github.com/user-attachments/assets/94ccbd6f-79f6-471e-9aa3-c692bbc8fe00)

</details>

<details>
     <summary>
          <h4 id = 'Static timing Analysis'>Static timing Analysis</h4>
     </summary>

In OpenLANE Static timing Analysis is performed with OpenSTA.<br>
Post Synthesis we can observe the TNS and WNS.
<br>

![1_tns_wns_0](https://github.com/user-attachments/assets/c0780db9-f114-4df2-bd76-06679989ed5a)
<br>

if there is total negative slack and worst negative slack try reducing it by upscaling the cells by replacing the cell with a bigger cell.<br>

Create a config file to run OpenSTA for the design.
<br>

![2_pre_staconf](https://github.com/user-attachments/assets/52d7b88f-66d4-4e84-a2da-f1968fa1a881)
<br>

Once we run OpenSTA with the command below we can observe the tns and wns of the design.<br>
```
sta <name of conf file: pre_sta.conf>
````
![5_before replacing cell](https://github.com/user-attachments/assets/aab57de0-f71a-4a18-aec2-1a819c0309b7).

<br>
Looking at the delays we can replace the cell with a bigger cell to reduce the delay and to generate a timing report.<br>

```
replace_cell instance lib_cell
report_checks -fields {net cap slew input_pins} -digits 4
```
<br>
We can observe that the slack delay is reduced once the cell is replaced.
<br>

![6_reduced slack](https://github.com/user-attachments/assets/a715f134-62b8-4871-9c0e-670fe74a8372).

Once the cells are replaced, they will be altered in the netlist. So do not synthesize the design again else the alterations in the netlist will be lost.<br>
The command used to replace the old netlist is,<br>
```
write_verilog /home/vsduser/Desktop/work/tools/openlane_working_dir/openlane/designs/riscv/runs/04-08_08-02/results/synthesis/riscv.synthesis.v
```
<br>
Perform floorplan and placement for the altered netlist.

</details>

<details>
     <summary>
          <h4 id = 'Clock tree Synthesis'>Clock tree Synthesis</h4>
     </summary>

To run the clock tree synthesis use the following command in the OpenLane flow command,<br>
```
run_cts
```
<br>
Once the cts is complete we can observe that a cts file will be added in the results of the synthesis folder.<br>

![1](https://github.com/user-attachments/assets/b23f4dc7-5612-4cd7-b3ec-744492d82baf)

<br>

For OpenLane timing analysis in OpenROAD, run the following commands to get the timing reports after cts.<br>
```
openroad
read_lef /openLANE_flow/designs/riscv/runs/24-03_10-03/tmp/merged.lef
read_def /openLANE_flow/designs/riscv/runs/24-03_10-03/results/cts/riscv.cts.def
write_db riscv_cts.db
read_db riscv_cts.db
read_verilog /openLANE_flow/designs/riscv/runs/24-03_10-03/results/synthesis/picorv32a.synthesis_cts.v
read_liberty -max /openLANE_flow/designs/riscv/src/sky130_fd_sc_hd__slow.lib
read_liberty -min /openLANE_flow/designs/riscv/src/sky130_fd_sc_hd__fast.lib 
read_sdc /openLANE_flow/designs/riscv/src/riscv_sdc.sdc
set_propagated_clock [all_clocks]
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4

```

![1](https://github.com/user-attachments/assets/57d5790b-5864-4356-9d35-3ba49ff83583)

<br>
The timing reports are displayed,<br>

![1](https://github.com/user-attachments/assets/a5ed0573-4475-4a02-bf05-960b5e941a49)

![2](https://github.com/user-attachments/assets/22ca960a-9aea-4e1c-83b7-dc1ccc269b81)
<br>
<br>
Clock tree Synthesis for typical corner<br>

```
openroad
read_db riscv_cts.db
read_verilog /openLANE_flow/designs/riscv/runs/04-08_08-02/results/synthesis/riscv.synthesis_cts.v            
read_liberty /openLANE_flow/designs/riscv/src/sky130_fd_sc_hd__typical.lib
link_design riscv
read_sdc /openLANE_flow/designs/riscv/src/riscv_sdc.sdc
set_propagated_clock [all_clocks]
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4
```
<br>

![1](https://github.com/user-attachments/assets/56c891fd-6097-4ada-8d8c-d5a32dc78d8f)
<br>
Timing reports with typical corners,
<br>
![2](https://github.com/user-attachments/assets/56998bb3-7e4a-48b9-8ece-99a68adb55ce)
![3](https://github.com/user-attachments/assets/4d3b41db-85dc-44ca-b556-be89fa9b2946)
<br>

</details>
<details>
     <summary>
          <h4 id = 'Routing'>Routing</h4>
     </summary>

To generate the power distribution network run the below command<br>
```
run_pdn
```
<br>

![1](https://github.com/user-attachments/assets/16655acb-5287-4b5d-a134-db41f693b894)
<br>

Command to view the Power distribution network in Magic,<br>

```
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read 32-pdn.def &
```
<br>

![1](https://github.com/user-attachments/assets/233c2b22-a85a-41e8-bfcd-27b9db8f3555)
![2](https://github.com/user-attachments/assets/0d6177a2-6ef7-4711-8481-47bffee114dc)
![3](https://github.com/user-attachments/assets/0a985a6e-2118-439a-93c0-6bab45565f9a)
<br>

Run the below command to perform routing,<br>
```
run_routing
```

<br>
View the def file in magic<br>
Run the command inside the results in the routing folder.

```
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.lef def read riscv.def &
```

![1](https://github.com/user-attachments/assets/a1ca5c94-0f02-4bf4-9a31-0c94a86997e0)
![2](https://github.com/user-attachments/assets/b1636a23-8ac6-47b5-8f39-dd37746f9497)
![3](https://github.com/user-attachments/assets/5e3d2132-bbed-4d89-b5b8-ae1184f9695f)

</details>
<details>
     <summary>
          <h4 id = 'DRC'>DRC</h4>
     </summary>
To find the problems in DRC and to fix them, get and tar the drc_tests.tgz. Move to drc_tests to work further<br>

```
wget http://opencircuitdesign.com/open_pdks/archive/drc_tests.tgz
tar xfz drc_tests.tgz
cd drc_tests
gvim .magicrc
magic -d XR &
```

![1](https://github.com/user-attachments/assets/05409561-d6d5-42f9-ad46-cf0764c2b418)

<br>
.magicrc file
<br>

![2](https://github.com/user-attachments/assets/e08a4770-d4e2-4eb6-86a1-d6a2204ccb8f)
<br>

Opening the magic tool
<br>
![3](https://github.com/user-attachments/assets/902c7e3c-5ddf-4c87-b393-afde6c259478)

<br>
Opening met3.mag in the magic tool to fix the errors in them
<br>

![4](https://github.com/user-attachments/assets/b13947b9-f60d-43e1-a17b-1e64a51597bd)
![5](https://github.com/user-attachments/assets/3edf7ddb-cca3-4435-bdd0-cc07cc108aaf)
<br>
To know the error in the selected region type 
```
drc why
```

![6](https://github.com/user-attachments/assets/dbe132f6-4757-49a6-8ac1-081b7759afb3)
<br>

Creating contact cuts in the metal 3 contacts were created. These contact cuts are not present in the layout.<br>

![7](https://github.com/user-attachments/assets/0f22ef9c-2739-4136-b68c-c7b49364583b)
<br>
Loading poly into magic
<br>
![8](https://github.com/user-attachments/assets/f31cc900-12aa-4ed6-ab06-d1ce22911366)
<br>
To know the error in the selected region run 
```
what
```
![9](https://github.com/user-attachments/assets/857d2b5a-c44c-4c85-9b93-7bdcb0210d05)
<br>
To know the dimensions of the selected area run
```
box
```
![10](https://github.com/user-attachments/assets/07a9ff6a-d1a3-44ff-a449-abf482119d05)
<br>
We could see that the DRC error is because the distance between the two poly layers is not sufficient and below the required value
<br>
Updated DRC in sky130A.tech file
<br>
![1](https://github.com/user-attachments/assets/90c002d7-a085-4f16-8a52-db57b6ec98e0)
![2](https://github.com/user-attachments/assets/364106bb-e52a-420c-aee0-47f96ebce681)
<br>
Commands to implement updated sky130A.tech file in magic<br>
```
tech load sky130A.tech
drc check
drc why
```
![1](https://github.com/user-attachments/assets/d4ff9483-6410-4f4f-a909-6ca28c3308d1)
<br>


</details>

</details>


<details>
     <summary>
          <h2 id = 'Week 7'>Week 7</h2>
     </summary>

PDN generation<br>
![1_pdn](https://github.com/user-attachments/assets/e2db2ad7-f219-4711-8d80-1b02f756a4ed)

<br>
Fast route guide

![2_fastroute guide](https://github.com/user-attachments/assets/75b7f684-85aa-4804-91d4-e4bb3b6fd7da)

</details>

<details>
     <summary>
          <h2 id = 'Week 8'>Week 8</h2>
     </summary>

TCL file <br>
![1+txcl](https://github.com/user-attachments/assets/59ff69c7-a586-4686-8e02-2fc6c89c7510)
<br>

Total negative slack <br>
![1](https://github.com/user-attachments/assets/ced3c9a5-1f7b-40b8-aa47-c6038d1d957c)

![2_tns](https://github.com/user-attachments/assets/5837cd1b-5b38-40c6-b521-9e68cb020ff4)


<br>
Worst negative slack <br>

![2](https://github.com/user-attachments/assets/c365a4d7-e569-4948-bf0e-ca68f2a00d1e)

![1_wns](https://github.com/user-attachments/assets/984b5b06-66d7-4388-b149-5613555b70ea)
<br>
Post Routing:<br>

![3](https://github.com/user-attachments/assets/2767716e-112e-4fae-a9aa-678c31165dfe)

</details>

