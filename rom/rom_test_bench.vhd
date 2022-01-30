LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;


entity ram_dual_port_test_bench is
end entity;


architecture test_bench of ram_dual_port_test_bench is
  component dual_port_ram is
    generic (n: positive:= 4;
             m: positive:= 4);
    port (r, w: in std_logic;
          address_in: in unsigned(n-1 downto 0);
          address_out: in unsigned(n-1 downto 0);
          data_in: in std_logic_vector (m-1 downto 0);
          data_out: out std_logic_vector (m-1 downto 0));
  end component;

  -- signals to RAM
  constant n: positive:=4;
  constant m: positive:=4;
  signal r,w: std_logic;
  signal address_in: unsigned(n-1 downto 0);
  signal address_out: unsigned(n-1 downto 0);
  signal data_in: std_logic_vector(m-1 downto 0);
  signal data_out: std_logic_vector(m-1 downto 0);

begin
  -- applying inputs to ram
  dut: dual_port_ram port map(r, w, address_in, address_out, data_in, data_out);


  -- applying testbench
  testing: process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l : line;
    variable message: string (1 TO 44);
    variable pause: time;

    variable r_in_file, w_in_file: bit;
    variable address_in_in_file:bit_vector(n-1 downto 0);
    variable address_out_in_file:bit_vector(n-1 downto 0);
    variable data_in_in_file: bit_vector (m-1 downto 0);
    variable data_out_out_file: bit_vector (m-1 downto 0);


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

    begin
      --initial values
      r <= '0';
      w <= '0';
      address_in <= "0000";
      address_out <= "0000";
      data_in <= "0000";
      wait for 15 ns;

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, r_in_file);
        read (simulation_l, w_in_file);
        read (simulation_l, address_in_in_file);
        read (simulation_l, address_out_in_file);
        read (simulation_l, data_in_in_file);
        read (simulation_l, pause);
        read (simulation_l, data_out_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs

        case r_in_file is
          when '0'  => r <= '0';
          when '1'  => r <= '1';
          when others => null;
        end case;


        case w_in_file is
          when '0'  => w <= '0';
          when '1'  => w <= '1';
          when others => null;
        end case;

        address_in <= unsigned(to_stdlogicvector(address_in_in_file));
        address_out <= unsigned(to_stdlogicvector(address_out_in_file));
        data_in <= to_stdlogicvector(data_in_in_file);




        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", r="));
        write (result_l, r_in_file);

        write (result_l, string'(", w="));
        write (result_l, w_in_file);


        write (result_l, string'(", address_in="));
        write (result_l, address_in_in_file);

        write (result_l, string'(", address_out="));
        write (result_l, address_out_in_file);

        write (result_l, string'(", data_in="));
        write (result_l, data_in_in_file);


        write (result_l, string'(", data_out="));
        write (result_l, to_bstring(data_out));


        -- checking for input validation
          if data_out /= to_stdlogicvector(data_out_out_file) then

            write (result_l, string'(" FAILED, Error Messages: "));
            write (result_l, message);

          else
            write (result_l, string'(" Test PASSED"));

          end if;


        -- writing into results file
        writeline (results_file, result_l);
      end loop;

      assert false report "End of Test";


    wait; -- kill loop
    end process testing;

end architecture;
