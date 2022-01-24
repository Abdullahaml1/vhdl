LIBRARY ieee;
use IEEE.STD_LOGIC_1164.all;
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

      -- files for vectors and results
      file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
      file results_file: text OPEN WRITE_MODE IS "results.txt";

      -- variables to parse the file
      variable simulation_l, result_l : line;

      variable op_in_file: op_type;
      variable op_vec: bit_vector (2 downto 0);
      variable a_in_file, b_in_file: signed (3 downto 0);
      variable c_out_file: signed (3 downto 0);

      variable pause: time;
      variable message: string (1 TO 44);


    begin
      -- initial values
      op <= add;
      -- a <= "0000";
      -- b <= "0000";

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        -- read (simulation_l, op_in_file);
        -- read (simulation_l, a_in_file);
        -- read (simulation_l, b_in_file);
        read (simulation_l, pause);
        -- read (simulation_l, c_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        op <= op_in_file;
        a <= a_in_file;
        b <= b_in_file;
        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", op="));
        write (result_l, op_vec);
        -- write (result_l, op_in_file);

        write (result_l, string'(", a="));
        write (result_l, to_stdlogicvector(a_in_file));

        write (result_l, string'(", b="));
        -- write (result_l, b_in_file);

        write (result_l, string'(", c="));
        -- write (result_l, c);

        write (result_l, string'(", Actual c="));
        -- write (result_l, c_out_file);


        -- checking for input validation
        if c /= c_out_file then

          write (result_l, string'(" FAILED, Error Messages: "));
          write (result_l, message);

        else
          write (result_l, string'(" Test PASSED"));

        end if;

        -- writing into results file
        writeline (results_file, result_l);
      end loop;

      assert false report "End of Test";
      wait; -- kill the process

    end process testing;

end architecture;

