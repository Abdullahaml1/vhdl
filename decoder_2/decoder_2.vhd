---------------------------------------------------------------------------------------
-- Entity and architecture declarations for an address decoder using a CASE statement.
---------------------------------------------------------------------------------------

ENTITY decoder IS
   PORT( address: IN integer;
        decode: OUT bit_vector(1 DOWNTO 0)); 
END ENTITY decoder;

ARCHITECTURE another OF decoder IS
BEGIN 
   Pdec: PROCESS (address) IS
   BEGIN 
     CASE address IS
       WHEN 0 to 7            => decode <= "10"; 
       WHEN 8 to 15           => decode <= "01"; 
       WHEN 16 | 20 | 24 | 28 => decode <= "11"; 
       WHEN OTHERS            => NULL;      -- sequential statement
     END CASE;
   END PROCESS Pdec;
END ARCHITECTURE another;