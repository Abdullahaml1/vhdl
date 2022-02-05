---------------------------------------------------------------------------
-- an n-bit address, m-bit word Register File with 2 reads and 2 writes
---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file is
  generic(n: positive:=5;
          m: positive:= 32);
  port(write_enable1, write_enable2, write_priority: in std_logic;
       read_reg1, read_reg2: in unsigned(n-1 downto 0);
       write_reg1, write_reg2: in unsigned(n-1 downto 0);
       write_data1, write_data2: in std_logic_vector(m-1 downto 0);
       read_data1, read_data2: out std_logic_vector(m-1 downto 0));
end entity register_file;


architecture rf of register_file is
begin

  rf_p: process(write_enable1, write_enable2, write_priority,
                read_reg1,read_reg2,
                write_reg1, write_reg2, write_data1, write_data2) is

    type DW is array (0 to 2**n -1) of std_logic_vector(m-1 downto 0);
    variable word: DW;
  begin

    -- corner case writing in same register
    if (write_enable1 = '1' and write_enable2 = '1') and
      (write_reg1 = write_reg2) then

      -- choose write_reg2
      if write_priority = '1' then
        word(to_integer(write_reg2)) := write_data2;

      -- choose write_reg1
      else
        word(to_integer(write_reg1)) := write_data1;
      end if;

    -- normal case different registers
    else

      -- write_reg1
      if write_enable1 = '1' then
        word(to_integer(write_reg1)) := write_data1;
      end if;


      -- write_reg2
      if write_enable2 = '1' then
        word(to_integer(write_reg2)) := write_data2;
      end if;

    end if; -- write

    -- reading registers (register file forwarding)
    read_data1 <= word(to_integer(read_reg1));
    read_data2 <= word(to_integer(read_reg2));


  end process rf_p;
end architecture rf;

