-----------------------------------------------------------------------------
-- Entity and architecture declarations for a 4-1 mux using an IF statement.
-----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux IS 
  PORT( a,b,c,d: IN bit;
        s: IN bit_vector(1 DOWNTO 0);
        z: OUT bit);
END ENTITY mux;

ARCHITECTURE mux OF mux IS BEGIN
  Pmux: PROCESS (a,b,c,d,s) IS 
  BEGIN 
    IF    s = "00" THEN 
      z <= a; 
    ELSIF s = "01" THEN 
      z <= b;
    ELSIF s = "10" THEN 
      z <= c; 
    ELSIF s = "11" THEN 
      z <= d; 
    ELSE
      z <= a;
    END  IF;
  END PROCESS Pmux;
END ARCHITECTURE mux;
