# Compiling VHDL using opensource software

## Installation
on ubuntu 
```bash
sudo apt-get install ghdl gtkwave
```
`ghdl` for the compiler and `gtkwave` for viewing the simulation

## simple example (and)
```
$ mkdir my_and
$ cd my_and
```
write these files
`my_and.vhdl`
```vhdl
library ieee;                                                                   
use ieee.std_logic_1164.all;                                                    
                                                                                
                                                                                
entity my_and is                                                                
            port (                                                              
                    a: in       std_ulogic;                                     
                    b: in       std_ulogic;                                     
                    o: out       std_ulogic                                     
                );                                                              
end my_and;                                                                     
                                                                                
architecture behave of my_and is                                                
begin                                                                           
        o <= a and b;                                                           
end behave;                    
```

testbench file `my_and_testbench`
```vhdl
library ieee;                                                                   
use ieee.std_logic_1164.all;                                                    
                                                                                
                                                                                
entity my_and_testbench is                                                      
end my_and_testbench;                                                           
                                                                                
                                                                                
                                                                                
architecture test of my_and_testbench is                                        
                                                                                
        component my_and                                                        
            port (                                                              
                    a: in       std_ulogic;                                     
                    b: in       std_ulogic;                                     
                    o: out       std_ulogic                                     
                );                                                              
        end component;                                                          
                                                                                
        signal a, b, o : std_ulogic;                                            
                                                                                
begin                                                                           
    testing: my_and port map( a=>a, b=>b,  o=>o);                               
                                                                                
    process begin                                                               
                                                                                
        a<='X';                                                                 
        b<='X';                                                                 
        wait for 1 ns;                                                          
                                                                                
                                                                                
        a<='0';                                                                 
        b<='0';                                                                 
        wait for 1 ns;                                                          
                                                                                
                                                                                
        a<='0';                                                                 
        b<='1';                                                                 
        wait for 1 ns;                                                          
                                                                                
                                                                                
        a<='1';                                                                 
        b<='0';                                                                 
       wait for 1 ns;                                                          
                                                                                
        a<='1';                                                                 
        b<='1';                                                                 
        wait for 1 ns;                                                          
                                                                                
        assert false report "End of Test";                                      
        wait; --wiat for ever means end the test                                
                                                                                
    end process;                                                                
end test;                                                              
```

### check the syntax
```
$ ghdl -s my_and.vhdl
$ ghdl -s my_and_testbench.vhdl
```



### Analyze the modules
```
$ ghdl -a my_and.vhdl
$ ghdl -a my_and_testbench.vhdl
```

### enerprete the modules
```
$ ghdl -e my_and_testbench
```
the name of the test module not the filename


### run the test
```
$ ghdl -r my_and_testbench
```
the name of the test module not the filename

### run the test and extract simulating results
```
$ ghdl -r my_and_testbench --vcd==results.vcd
```
popping out the results in ".vcd" file format

### plot the results using gtkwave
```bash
gtkwave results.vcd
```
will pop out a window that contain the simulation results:
1. click on the module name in `SST menu` on the upper left cornce
2. drag and drop register form the lower right menu to `signals meny`
3. zoom in out with `ctl key` and mouse wheel









# Resources
* [opensouce EDA tool list](https://opencores.org/howto/eda)
* [ghdl docs](https://ghdl.github.io/ghdl/index.html)
* [youtube getting started video](https://www.youtube.com/watch?v=dvLeDNbXfFw)
