
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;

entity mux_test_bench is
end entity;

architecture test_bench of mux_test_bench is

  component mux is
    port (a, b,c, d: in bit;
          s: in bit_vector(1 downto 0);
          z: out bit);
  end component mux;


  -- defining test signals
  signal in_vector: bit_vector(3 downto 0);
  signal s: bit_vector (1 downto 0);
  signal z: bit;

begin
  -- applying input to the dut
  dut: mux port map (in_vector(3), in_vector(2), in_vector(1), in_vector(0), s, z);

    -- Looping throw test cases
    testing: process is

      -- files for vectors and results
      file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
      file results_file: text OPEN WRITE_MODE IS "results.txt";

      -- variables to parse the file
      variable simulation_l, result_l : line;

      variable in_vector_in_file: bit_vector(3 downto 0);
      variable s_in_file: bit_vector( 1 downto 0);

      variable z_out_file: bit;

      variable pause: time;

      variable message: string (1 TO 44);


    begin
      -- initial values
      in_vector <= "0000";

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, in_vector_in_file);
        read (simulation_l, s_in_file);
        read (simulation_l, pause);
        read (simulation_l, z_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        in_vector <= in_vector_in_file;
        s <= s_in_file;
        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", a,b,c,d="));
        write (result_l, in_vector_in_file);


        write (result_l, string'(", s="));
        write (result_l, s_in_file);

        write (result_l, string'(", z="));
        write (result_l, z);

        write (result_l, string'(", Actual z="));
        write (result_l, z_out_file);


        -- checking for input validation
        if z /= z_out_file then

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

