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
