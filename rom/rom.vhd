-------------------------------------------
-- A ROM to build a squaring circuit. 
-------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
  GENERIC( n : integer := 3;
           m : integer := 6);
  PORT(	enable: IN std_logic;
		address: IN unsigned (n-1 DOWNTO 0);
		data: OUT unsigned (m-1 DOWNTO 0));
END ENTITY rom;

------------------------------------------------------------------
-- Use a flag to ensure that the ROM is initialize only one time
------------------------------------------------------------------

ARCHITECTURE flag_arch OF rom IS
  TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
  SIGNAL word: rm;
  SIGNAL initialized: boolean := false;
BEGIN
  memory: PROCESS (enable, address) IS 
  
  BEGIN
    IF NOT initialized THEN	
      FOR index IN word'range LOOP
        word(index) <= to_unsigned(index*index, m);
      END LOOP;
	  ASSERT FALSE REPORT "ROM init in flag_arch" SEVERITY note;
      initialized <= true;
    END IF;
    IF enable = '1' THEN
      data <= word(to_integer(address));
    ELSE 
      data <= (OTHERS => 'Z');
    END IF;
  END PROCESS memory;
END ARCHITECTURE flag_arch;

-- -----------------------------
-- -- Using a LOOP statement
-- -----------------------------

-- ARCHITECTURE loop_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   SIGNAL word: rm;
-- BEGIN
--   memory: PROCESS IS 
--   BEGIN
--     FOR index IN word'range LOOP
--       word(index) <= to_unsigned(index*index, m);
--     END LOOP;
-- 	ASSERT FALSE REPORT "ROM init in loop_arch" SEVERITY note;
--     LOOP
--       WAIT ON enable, address;
--       IF enable = '1' THEN
--         data <= word(to_integer(address));
--       ELSE 
--         data <= (OTHERS => 'Z');
--       END IF;
--     END LOOP;
--   END PROCESS memory;
-- END ARCHITECTURE loop_arch;

-- ----------------------------------------------------
-- --- Using a separate process without a sensitivity 
-- --- list to initialize the ROM
-- ----------------------------------------------------

-- ARCHITECTURE init_wait_process_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   SIGNAL word: rm;
--   SIGNAL initialized: boolean := false;
-- BEGIN
--   init_wait_proc: PROCESS IS
--   BEGIN
--     FOR index IN word'range LOOP
--       word(index) <= to_unsigned(index*index, m);
--     END LOOP;
-- 	ASSERT FALSE REPORT "ROM init in init_wait_proc" SEVERITY note;
--     initialized <= true;
--     WAIT;
--   END PROCESS init_wait_proc;

--   memory: PROCESS (initialized, enable, address) IS
--   BEGIN
--     IF initialized THEN
--       IF enable = '1' THEN
--         data <= word(to_integer(address));
--       ELSE 
--         data <= (OTHERS => 'Z');
--       END IF;
--     END IF;
--   END PROCESS memory;
-- END ARCHITECTURE init_wait_process_arch;

-- ----------------------------------------------------
-- --- Using a separate process with a sensitivity 
-- --- list to initialize the ROM
-- ----------------------------------------------------

-- ARCHITECTURE init_sens_process_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   SIGNAL word: rm;
--   SIGNAL initialized: boolean := false;
-- BEGIN
--   init_sens_proc: PROCESS (initialized) IS
--   BEGIN
--     IF NOT initialized THEN
--       FOR index IN word'range LOOP
--         word(index) <= to_unsigned(index*index, m);
--       END LOOP;
--       ASSERT FALSE REPORT "ROM init in init_sens_proc" SEVERITY note;
--       initialized <= true;
--     END IF;
--   END PROCESS init_sens_proc;

--   memory: PROCESS (initialized, enable, address) IS
--   BEGIN
--     IF initialized THEN
--       IF enable = '1' THEN
--         data <= word(to_integer(address));
--       ELSE 
--         data <= (OTHERS => 'Z');
--       END IF;
--     END IF;
--   END PROCESS memory;
-- END ARCHITECTURE init_sens_process_arch;

-- -------------------------------------------
-- --- Initializing the ROM with a function
-- -------------------------------------------

-- ARCHITECTURE funct_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   FUNCTION rom_fill RETURN rm IS
--     VARIABLE memory: rm;
--   BEGIN
--     FOR index IN memory'range LOOP
--       memory(index) := to_unsigned(index*index, m);
--     END LOOP;
-- 	ASSERT FALSE REPORT "ROM init in funct_arch" SEVERITY note;
--     RETURN memory;
--   END FUNCTION rom_fill;

--   constant word: rm := rom_fill;
-- BEGIN
--   memory: PROCESS (enable, address) IS BEGIN
--     IF enable = '1' THEN
--       data <= word(to_integer(address));
--     ELSE 
--       data <= (OTHERS => 'Z');
--     END IF;
--   END PROCESS memory;
-- END ARCHITECTURE funct_arch;

-- ------------------------------------------
-- -- Initializing the ROM from a text file
-- ------------------------------------------

-- LIBRARY ieee;
-- USE std.textio.ALL;
-- USE ieee.std_logic_textio.ALL;

-- ARCHITECTURE file_funct_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   IMPURE FUNCTION rom_fill RETURN rm IS
--     VARIABLE memory: rm;
--     FILE f: text OPEN READ_MODE IS "rom.txt";
--     VARIABLE l: line;
--     VARIABLE read_word: std_logic_vector (m-1 DOWNTO 0);	
--   BEGIN
--     FOR index IN memory'range LOOP
--       readline (f, l);	  
-- 	  read (l, read_word);					-- cannot read unsigned from a file
--       memory(index) := unsigned(read_word);    
--     END LOOP;
-- 	ASSERT FALSE REPORT "ROM init in funct_arch & file" SEVERITY note;
--     RETURN memory;
--   END FUNCTION rom_fill;

--   constant word: rm := rom_fill;
-- BEGIN
--   memory: PROCESS (enable, address) IS BEGIN
--     IF enable = '1' THEN
--       data <= word(to_integer(address));
--     ELSE 
--       data <= (OTHERS => 'Z');
--     END IF;
--   END PROCESS memory;
-- END ARCHITECTURE file_funct_arch;

-- ---------------------------------------------------
-- -- Initializing the ROM using a generate statement
-- ---------------------------------------------------

-- ARCHITECTURE gen_arch OF rom IS
--   TYPE rm IS ARRAY (0 TO 2**n-1) OF unsigned (m-1 DOWNTO 0);
--   SIGNAL word: rm;
-- BEGIN
--     contents: FOR index IN word'range GENERATE
--       word(index) <= to_unsigned(index*index, m);
--     END GENERATE contents;

--   data <= word(to_integer(address)) WHEN enable = '1' ELSE
--           (OTHERS => 'Z');
-- END ARCHITECTURE gen_arch;
