LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;


entity fsm_mealy_2p_test_bench is
end entity;


architecture test_bench of fsm_mealy_2p_test_bench is
  component fsm is
    PORT(clk, reset: IN std_logic;
         x: in std_logic;
         y: out std_logic);

  end component;


  -- signals to priority encoder
  signal clk, reset, x, y: std_logic;

begin
  -- applying inputs to ram
  dut: fsm port map (clk, reset, x, y);


  -- applying testbench
  testing: process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l : line;
    variable message: string (1 TO 35);
    variable pause: time;


    variable clk_in_file: bit;
    variable reset_in_file: bit;
    variable x_in_file: bit;
    variable y_out_file: bit;



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
      reset <= '1';
      clk <= '0';
      x <= '0';
      wait for 15 ns;


      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, clk_in_file);
        read (simulation_l, reset_in_file);
        read (simulation_l, x_in_file);
        read (simulation_l, pause);
        read (simulation_l, y_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs
        clk <= to_std_logic(clk_in_file);
        reset <= to_std_logic(reset_in_file);
        x <= to_std_logic(x_in_file);

        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", reset="));
        write (result_l, reset_in_file);

        write (result_l, string'(", clk="));
        write (result_l, clk_in_file);


        write (result_l, string'(", x="));
        write (result_l, x_in_file);

        write (result_l, string'(", Actual y="));
        write (result_l, y_out_file);

        write (result_l, string'(", y="));
        write (result_l, to_bstring(y));


        -- checking for input validation
          if y /= to_std_logic(y_out_file) then

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
