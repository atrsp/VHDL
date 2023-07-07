library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity counter is
   generic(N : integer := 32);
   port(
      clk : in  std_logic;
      sum : in std_logic; 
      subt : in std_logic;
      --max_tick : out std_logic;
      q   : out std_logic_vector (N-1 downto 0)
   );
end counter;

architecture arch of counter is
   signal r_reg  : unsigned(N-1 downto 0);
   signal r_next : unsigned(N-1 downto 0);
begin

   -- register
   process(clk)
   begin
      if (clk'event and clk='1') then
            r_reg <= r_next;
      end if;
   end process;
   
   -- next-state logic
   process (sum, subt, r_reg)
   begin
      if sum = '1' then
         r_next <= r_reg + 1;
      elsif subt = '1' then
         r_next <= r_reg - 1;
      else
         r_next <= r_reg;
      end if;
   end process;

   -- output logic
   q <= std_logic_vector(r_reg);
   --max_tick <= '1' when r_reg=(2**N - 1) else '0';

end arch;