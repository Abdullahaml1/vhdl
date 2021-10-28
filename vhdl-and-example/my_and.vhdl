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
