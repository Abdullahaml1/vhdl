------------------------------------------------------------------------
-- A shift register to perform shift right, shift left, and load. 
-- A zero clr signal resets all output bits.
------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sr IS
  GENERIC( width: positive := 4);
  PORT( clk, clr, l_in, r_in, s0, s1: IN std_logic;
        d: IN std_logic_vector (width-1 DOWNTO 0);
        q: INOUT std_logic_vector (width-1 DOWNTO 0));
END ENTITY sr;

ARCHITECTURE sr OF sr IS
BEGIN
  shift: PROCESS (clk, clr) IS
    VARIABLE sel: std_logic_vector (1 DOWNTO 0);
  BEGIN 
    IF clr = '0' THEN
      q <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      sel := s1 & s0; 
      CASE sel IS
        WHEN "00" => NULL;
        WHEN "01" => q <= q(width-2 DOWNTO 0) & r_in;
        WHEN "10" => q <= l_in & q(width-1 DOWNTO 1);
        WHEN "11" => q <= d;
        WHEN OTHERS => NULL;
      END CASE;
    END IF;
  END PROCESS shift;
END ARCHITECTURE sr;
