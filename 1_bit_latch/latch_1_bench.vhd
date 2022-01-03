library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;


ENTITY bit_latch_bn IS
END ENTITY bit_latch_bn;

ARCHITECTURE test_bench of bit_latch_bn IS

  COMPONENT latch IS 
    PORT ( d, clk: IN bit;
           q, nq: OUT bit);
    END COMPONENT latch;

  SIGNAL d, clk, q, nq: bit;
begin
  dut : latch port map (d, clk, q, nq);

  testing : process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l : line;
    variable d_in_file, clk_in_file, q_out_file, nq_out_file: bit;
    variable pause: time;
    variable message: string (1 TO 44);

    begin

      -- initial values
      d <= '1';
      clk <='0';

      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, d_in_file);
        read (simulation_l, clk_in_file);
        read (simulation_l, pause);
        read (simulation_l, q_out_file);
        read (simulation_l, nq_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        d <= d_in_file;
        clk <= clk_in_file;
        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'("D="));
        write (result_l, d_in_file);

        write (result_l, string'(", clk="));
        write (result_l, clk_in_file);

        write (result_l, string'(", Actual q="));
        write (result_l, q);

        write (result_l, string'(", Actual nq="));
        write (result_l, nq);


        -- checking for input validation
        if q /= q_out_file or nq /= nq_out_file then

          write (result_l, string'("FAILED, Error Messages: "));
          write (result_l, message);

        else
          write (result_l, string'("Test PASSED"));

          end if;

          -- writing into results file
          writeline (results_file, result_l);
        end loop;

        assert false report "End of Test";
        wait;
      end process testing;

END ARCHITECTURE test_bench;


