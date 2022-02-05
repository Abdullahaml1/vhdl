LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;


entity register_file_test_bench is
end entity;


architecture test_bench of register_file_test_bench is
  component register_file is
    generic(n: positive:= 4;
            m: positive:= 4);
    port(write_enable1, write_enable2, write_priority: in std_logic;
         read_reg1, read_reg2: in unsigned(n-1 downto 0);
         write_reg1, write_reg2: in unsigned(n-1 downto 0);
         write_data1, write_data2: in std_logic_vector(m-1 downto 0);
         read_data1, read_data2: out std_logic_vector(m-1 downto 0));
  end component;



  -- signals to RF
  constant n: positive:= 4;
  constant m: positive:= 4;

  signal write_enable1, write_enable2, write_priority: std_logic;
  signal read_reg1, read_reg2: unsigned(n-1 downto 0);
  signal write_reg1, write_reg2: unsigned(n-1 downto 0);
  signal write_data1, write_data2: std_logic_vector(m-1 downto 0);
  signal read_data1, read_data2: std_logic_vector(m-1 downto 0);

begin
  -- applying inputs to ram
  dut: register_file port map(write_enable1, write_enable2, write_priority, read_reg1, read_reg2, write_reg1, write_reg2, write_data1, write_data2, read_data1, read_data2);


  -- applying testbench
  testing: process is

    -- files for vectors and results
    file vectors_file: text OPEN READ_MODE IS "test_vectors.txt";
    file results_file: text OPEN WRITE_MODE IS "results.txt";

    -- variables to parse the file
    variable simulation_l, result_l, empty_l : line;
    variable message: string (1 TO 50);
    variable pause: time;


    variable write_enable1_in_file, write_enable2_in_file: bit;
    variable write_priority_in_file: bit;
    variable read_reg1_in_file: bit_vector(n-1 downto 0);
    variable read_reg2_in_file: bit_vector(n-1 downto 0);
    variable write_reg1_in_file: bit_vector(n-1 downto 0);
    variable write_reg2_in_file: bit_vector(n-1 downto 0);
    variable write_data1_in_file: bit_vector(m-1 downto 0);
    variable write_data2_in_file: bit_vector(m-1 downto 0);

    variable read_data1_out_file: bit_vector(m-1 downto 0);
    variable read_data2_out_file: bit_vector(m-1 downto 0);



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

    begin
      --initial values
      write_enable1 <='1';
      write_enable2 <='1';
      write_priority <='0';

      read_reg1 <= (others => '0');
      read_reg2 <= (others => '0');

      write_reg1 <= (others => '0');
      write_reg2 <= (others => '0');
      write_data1 <= (others => '0');
      write_data2 <= (others => '0');
      wait for 15 ns;

      -- first title line
      readline (vectors_file, simulation_l);
      -- test vectors file parsing
      while not endfile (vectors_file) loop

        -- reading simulation data from file
        readline (vectors_file, simulation_l);
        read (simulation_l, write_enable1_in_file);
        read (simulation_l, write_enable2_in_file);
        read (simulation_l, write_priority_in_file);
        read (simulation_l, read_reg1_in_file);
        read (simulation_l, read_reg2_in_file);
        read (simulation_l, write_reg1_in_file);
        read (simulation_l, write_reg2_in_file);
        read (simulation_l, write_data1_in_file);
        read (simulation_l, write_data2_in_file);
        read (simulation_l, pause);
        read (simulation_l, read_data1_out_file);
        read (simulation_l, read_data2_out_file);
        read (simulation_l, message);

        -- Applying simulation inputs

        --initial values
        write_enable1 <= to_std_logic(write_enable1_in_file);
        write_enable2 <= to_std_logic(write_enable2_in_file);
        write_priority <= to_std_logic(write_priority_in_file);

        read_reg1 <= unsigned(to_stdlogicvector(read_reg1_in_file));
        read_reg2 <= unsigned(to_stdlogicvector(read_reg2_in_file));

        write_reg1 <= unsigned(to_stdlogicvector(write_reg1_in_file));
        write_reg2 <= unsigned(to_stdlogicvector(write_reg2_in_file));

        write_data1 <= to_stdlogicvector(write_data1_in_file);
        write_data2 <= to_stdlogicvector(write_data2_in_file);


        wait for pause;

        -- writing output to results file
        write (result_l, string'("Time is now: "));
        write (result_l, NOW);

        write (result_l, string'(", write_enable1="));
        write (result_l, write_enable1_in_file);

        write (result_l, string'(", write_enable2="));
        write (result_l, write_enable2_in_file);

        write (result_l, string'(", write_priority="));
        write (result_l, write_priority_in_file);

        write (result_l, string'(", read_reg1="));
        write (result_l, read_reg1_in_file);

        write (result_l, string'(", read_reg2="));
        write (result_l, read_reg2_in_file);

        write (result_l, string'(", write_reg1="));
        write (result_l, write_reg1_in_file);

        write (result_l, string'(", write_reg2="));
        write (result_l, write_reg2_in_file);

        write (result_l, string'(", write_data1="));
        write (result_l, write_data1_in_file);

        write (result_l, string'(", write_data2="));
        write (result_l, write_data2_in_file);

        write (result_l, string'(", actual read_data1="));
        write (result_l, read_data1_out_file);

        write (result_l, string'(", actual read_data2="));
        write (result_l, read_data2_out_file);

        write (result_l, string'(", read_data1="));
        write (result_l, to_bstring(read_data1));

        write (result_l, string'(", read_data2="));
        write (result_l, to_bstring(read_data2));


        -- checking for input validation
        if (read_data1 /= to_stdlogicvector(read_data1_out_file)) or
        (read_data2 /= to_stdlogicvector(read_data2_out_file))then

            write (result_l, string'(" FAILED, Error Messages: "));
            write (result_l, message);

          else
            write (result_l, string'(" Test PASSED"));

          end if;


        -- writing into results file
        writeline (results_file, result_l);
        writeline (results_file, empty_l);
      end loop;

      assert false report "End of Test";


    wait; -- kill loop
    end process testing;

end architecture;
