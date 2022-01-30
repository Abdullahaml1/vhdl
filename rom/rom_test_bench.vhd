LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;


entity rom_test_bench is
end entity;


architecture test_bench of rom_test_bench is
  component rom is
    generic (n: positive:= 3;
             m: positive:= 6);
    port (enable: in std_logic;
          address: in unsigned(n-1 downto 0);
          data: out unsigned (m-1 downto 0));
  end component;

  -- signals to RAM
  constant n: positive:=3;
  constant m: positive:=6;

  signal enable: std_logic;
  signal address: unsigned(n-1 downto 0);
  signal data: unsigned(m-1 downto 0);

begin
  -- applying inputs to ram
  dut: rom port map(enable, address, data);


  -- applying testbench
  testing: process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l : line;
    variable message: string (1 TO 44);
    variable pause: time;

    variable enable_in_file: bit;
    variable address_in_file:bit_vector(n-1 downto 0);
    variable data_out_file: bit_vector (m-1 downto 0);


    -- function to covert std to string
    function to_bstring(sl : std_logic) return string is
      variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
    begin
      sl_str_v := std_logic'image(sl);
      return "" & sl_str_v(2);  -- "" & character to get string
    end function;

    function to_bstring(slv : std_logic_vector) return string is
      alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
      variable sl_str_v : string(1 to 1);  -- String of std_logic
      variable res_v    : string(1 to slv'length);
    begin
      for idx in slv_norm'range loop
        sl_str_v := to_bstring(slv_norm(idx));
        res_v(idx) := sl_str_v(1);
      end loop;
      return res_v;
    end function;


    function to_bstring(slv : unsigned) return string is
      alias    slv_norm : unsigned(1 to slv'length) is slv;
      variable sl_str_v : string(1 to 1);  -- String of std_logic
      variable res_v    : string(1 to slv'length);
    begin
      for idx in slv_norm'range loop
        sl_str_v := to_bstring(slv_norm(idx));
        res_v(idx) := sl_str_v(1);
      end loop;
      return res_v;
    end function;


    begin
      --initial values
      enable <= '1';
      address <="000";
      wait for 15 ns;

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, enable_in_file);
        read (simulation_l, address_in_file);
        read (simulation_l, pause);
        read (simulation_l, data_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs

        case enable_in_file is
          when '0'  => enable <= '0';
          when '1'  => enable <= '1';
          when others => null;
        end case;

        address <= unsigned(to_stdlogicvector(address_in_file));

        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", enable="));
        write (result_l, enable_in_file);

        write (result_l, string'(", address="));
        write (result_l, address_in_file);

        write (result_l, string'(", Actual data="));
        write (result_l, data_out_file);

        write (result_l, string'(", data="));
        write (result_l, to_bstring(data));


        -- checking for input validation
          if data /= unsigned(to_stdlogicvector(data_out_file)) then

            write (result_l, string'(" FAILED, Error Messages: "));
            write (result_l, message);

          else
            write (result_l, string'(" Test PASSED"));

          end if;


        -- writing into results file
        writeline (results_file, result_l);
      end loop;

      assert false report "End of Test" severity note;


    wait; -- kill loop
    end process testing;

end architecture;
