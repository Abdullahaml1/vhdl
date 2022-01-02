----------------------------------------------------------
-- Entity and architecture declarations for a 1-bit latch.
----------------------------------------------------------

ENTITY latch IS
  PORT( d, clk: IN bit;
        q, nq: OUT bit);
END ENTITY latch;

ARCHITECTURE behav OF latch IS 
BEGIN
  p1: PROCESS (d, clk) IS 
  BEGIN
    IF clk = '1' THEN
      q <= d; 
      nq <= NOT(d);
    END IF;
  END PROCESS p1;
END ARCHITECTURE behav;