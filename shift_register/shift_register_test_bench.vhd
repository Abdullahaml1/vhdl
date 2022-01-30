LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;


entity shift_register_test_bench is
end entity;


architecture test_bench of shift_register_test_bench is
  component sr is
    generic (width: positive:= 4);
    port (clk, clr, l_in, r_in, s0, s1: in std_logic;
          d: in std_logic_vector(width-1 downto 0);
          q: inout std_logic_vector (width-1 downto 0));
  end component;

  -- signals to RAM
  constant width: positive:=4;

  signal clk, clr, l_in, r_in, s0, s1: std_logic;
  signal d: std_logic_vector(width-1 downto 0);
  signal q: std_logic_vector(width-1 downto 0);

begin
  -- applying inputs to ram
  dut: sr port map(clk, clr, l_in, r_in, s0, s1, d, q);


  -- applying testbench
  testing: process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l : line;
    variable message: string (1 TO 35);
    variable pause: time;

    variable read_in_file, clk_in_file, clr_in_file, l_in_in_file,
      r_in_in_file, s0_in_file, s1_in_file: bit;

    variable d_in_file: bit_vector(width-1 downto 0);
    variable q_out_file: bit_vector (width-1 downto 0);



    --function to map std_logic to bit
    function to_std_logic(b: bit) return std_logic is
      variable b_std_logic: std_logic;

    begin
      case b is
        when '0' => b_std_logic :='0';
        when '1' => b_std_logic :='1';
        when others => null;
      end case;

      return b_std_logic;

    end function;


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
      clk <= '0';
      l_in <= '0';
      r_in <= '0';
      s0 <= '0';
      s1 <= '0';
      clr <= '0';
      d <= "0000";
      wait for 15 ns;


      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, clk_in_file);
        read (simulation_l, clr_in_file);
        read (simulation_l, l_in_in_file);
        read (simulation_l, r_in_in_file);
        read (simulation_l, s0_in_file);
        read (simulation_l, s1_in_file);
        read (simulation_l, d_in_file);
        read (simulation_l, pause);
        read (simulation_l, q_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        clk <= to_std_logic(clk_in_file);
        clr <= to_std_logic(clr_in_file);
        l_in <= to_std_logic(l_in_in_file);
        r_in <= to_std_logic(r_in_in_file);
        s0 <= to_std_logic(s0_in_file);
        s1 <= to_std_logic(s1_in_file);
        d <= to_stdlogicvector(d_in_file);

        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", clk="));
        write (result_l, clk_in_file);

        write (result_l, string'(", clr="));
        write (result_l, clr_in_file);

        write (result_l, string'(", l_in="));
        write (result_l, l_in_in_file);

        write (result_l, string'(", r_in="));
        write (result_l, r_in_in_file);

        write (result_l, string'(", s0="));
        write (result_l, s0_in_file);

        write (result_l, string'(", s1="));
        write (result_l, s1_in_file);

        write (result_l, string'(", d="));
        write (result_l, d_in_file);

        write (result_l, string'(", Actual q="));
        write (result_l, q_out_file);

        write (result_l, string'(", q="));
        write (result_l, to_bstring(q));


        -- checking for input validation
          if q /= to_stdlogicvector(q_out_file) then

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
