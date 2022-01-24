library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;


entity decoder_2_bench is
end entity decoder_2_bench;


architecture test_bench of decoder_2_bench is

  component decoder is
    port (address: in integer;
          decode: out bit_vector(1 downto 0));
  end component;

  -- defining test signals
  signal address: integer;signal decode: bit_vector(1 downto 0);

  begin
    -- applying inputs to the device under test
    dut: decoder port map (address, decode);

    -- Looping throw test cases
    testing: process is

      -- files for vectors and results
      file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
      file results_file: text OPEN WRITE_MODE IS "results.txt";

      -- variables to parse the file
      variable simulation_l, result_l : line;
      variable address_in_file: integer;
      variable decode_out_file: bit_vector (1 downto 0);
      variable pause: time;
      variable message: string (1 TO 44);


    begin
      -- initial values
      address <=0;

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, address_in_file);
        read (simulation_l, pause);
        read (simulation_l, decode_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        address <= address_in_file;
        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", address="));
        write (result_l, address_in_file);

        write (result_l, string'(", decode="));
        write (result_l, decode);

        write (result_l, string'(", Actual decode="));
        write (result_l, decode_out_file);


        -- checking for input validation
        if decode /= decode_out_file then

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
