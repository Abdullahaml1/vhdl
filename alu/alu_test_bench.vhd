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


      -- files for vectors and results
      file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
      file results_file: text OPEN WRITE_MODE IS "results.txt";

      -- variables to parse the file
      variable simulation_l, result_l : line;
      variable message: string (1 TO 44);
      variable pause: time;

      variable op_in_file: bit_vector(1 downto 0);
      variable a_in_file, b_in_file: bit_vector(3 downto 0);
      variable c_out_file: bit_vector (3 downto 0);


    begin
      -- initial values
      op <= add;
      a <= "0000";
      b <= "0000";


      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, op_in_file);
        read (simulation_l, a_in_file);
        read (simulation_l, b_in_file);
        read (simulation_l, pause);
        read (simulation_l, c_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs

        case op_in_file is
          when "00"   => op <= add;
          when "01"   => op <= sub;
          when "10"   => op <= mul;
          when "11"   => op <= div;
          when others  => null;
        end case;

        a <= signed(a_in_file);
        b <= signed(b_in_file);
        wait for pause;


        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        case op_in_file is
          when "00"   => write (result_l, string'(", op=add"));
          when "01"   => write (result_l, string'(", op=sub"));
          when "10"   => write (result_l, string'(", op=mul"));
          when "11"   => write (result_l, string'(", op=div"));
          when others  => null;
        end case;


        write (result_l, string'(", a="));
        write (result_l, a_in_file);


        write (result_l, string'(", b="));
        write (result_l, b_in_file);

        write (result_l, string'(", c="));
        write (result_l, to_integer(c));

        write (result_l, string'(", Actual c="));
        write (result_l, c_out_file);


        -- checking for input validation
        if c /= signed(c_out_file) then

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

