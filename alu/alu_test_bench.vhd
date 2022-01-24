LIBRARY ieee;
USE ieee.numeric_bit.ALL;
USE WORK.pack_a.ALL;
use std.textio.all;

entity alu_test_bench is
end entity alu_test_bench;


architecture test_bench of alu_test_bench is

  component alu is
    port(op: in op_type;
         a, b: in signed (3 downto 0);
         c: out signed (3 downto 0));
  end component;

  -- test signals
  signal op: op_type;
  signal a, b, c: signed (3 downto 0);

begin
  --applying inputs to the device under test
  dut: alu port map (op, a, b, c);

    -- Looping throw test cases
    testing: process is


    begin
      -- initial values
      op <= add;
      a <= "0000";
      b <= "0000";
      wait for 15 ns;

      op <= add;
      a <= "1111";
      b <= "1111";
      wait for 15 ns;



      op <= add;
      a <= "1100";
      b <= "0011";
      wait for 15 ns;


      op <= add;
      a <= "0111";
      b <= "0111";
      wait for 15 ns;


      op <= sub;
      a <= "0111";
      b <= "0111";
      wait for 15 ns;


      op <= sub;
      a <= "1100";
      b <= "0011";
      wait for 15 ns;



      op <= mul;
      a <= "0111";
      b <= "0001";
      wait for 15 ns;


      op <= mul;
      a <= "0111";
      b <= "0000";
      wait for 15 ns;


      op <= mul;
      a <= "1111";
      b <= "1100";
      wait for 15 ns;


      op <= mul;
      a <= "1101";
      b <= "0110";
      wait for 15 ns;


      op <= div;
      a <= "1101";
      b <= "0001";
      wait for 15 ns;


      op <= div;
      a <= "1101";
      b <= "0011";
      wait for 15 ns;


      op <= div;
      a <= "1101";
      b <= "0000";
      wait for 15 ns;

     wait; -- kill the process

    end process testing;

end architecture;

