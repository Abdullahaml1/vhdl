------------------------------------
-- Synthesis of a priority encoder.
------------------------------------

ENTITY priority IS 
  PORT( sel: IN bit_vector(0 TO 3);
        z: OUT bit_vector(0 TO 2));
END ENTITY priority;

ARCHITECTURE behav OF priority IS BEGIN
  pp: PROCESS (sel) IS
  BEGIN 
    IF sel(0) = '1' THEN
      z <= "000"; 
    ELSIF sel(1) = '1' THEN
      z <= "001"; 
    ELSIF sel(2) = '1' THEN
      z <= "010"; 
    ELSIF sel(3) = '1' THEN
      z <= "011"; 
    ELSE
      z <= "111"; 
    END IF;
  END PROCESS pp;
END ARCHITECTURE behav;