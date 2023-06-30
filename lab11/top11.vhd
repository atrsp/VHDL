
----------------------------------------------------------------------------------
-- Engineer: Ana Tereza Pereira and Vitor Dadalto
-- 
-- Create Date: 23.06.2023 09:25:53
-- Design Name: 
-- Module Name: fsm - arch
-- Project Name: Lab 11
-- Target Devices: FPGA
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mt_top is
  
  Port (
    clk  : in  std_logic;
    sw: in std_logic_vector(1 downto 0);
    an: out std_logic_vector(7 downto 0);
    sseg: out std_logic_vector(7 downto 0)
   );
end mt_top;

architecture arch of mt_top is
constant N : integer := 49999999; 
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin

    an(7 downto 4)<="1111";
    
    disp: entity work.fsm11(arch)
    port map(
        clk => clk,
        en => sw(0),
        cw => sw(1),
        an    => an(3 downto 0),
        sseg  => sseg,
        enable => enable
    );
    
    enable <= '1' when divide_clk = N else '0';
    
    PROCESS (clk)
            BEGIN
                IF (clk'EVENT AND clk='1') THEN
                    divide_clk <= divide_clk+1;
                    IF divide_clk = N THEN
                        divide_clk <= 0;
                    END IF;
                END IF;
         END PROCESS;

end arch;
