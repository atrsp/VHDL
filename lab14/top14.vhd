----------------------------------------------------------------------------------
-- Company: CasalTech
-- Engineer: Ana Pereira & Vitor Dadalto
-- 
-- Create Date: 17.07.2023 15:44:41
-- Design Name: 
-- Module Name: top14
-- Project Name: 
-- Target Devices: 
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

entity top14 is
  
  Port (
    clk : in std_logic;
    sw : in std_logic_vector (8 downto 0);
    led : out std_logic_vector (3 downto 0)
   );

end top14;

architecture arch of top14 is
begin


end arch;
