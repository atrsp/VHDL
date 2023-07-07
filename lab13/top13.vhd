----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.06.2023 09:20:41
-- Design Name: 
-- Module Name: mt_top - arch
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

entity mt_top is
  
  Port (
    clk  : in  std_logic;
    btn: in std_logic_vector(3 downto 1);
    an : out std_logic_vector (3 downto 0);
    sseg : out std_logic_vector (7 downto 0)
   );

end mt_top;

architecture arch of mt_top is
constant N : integer := 49999999; 
signal enable : std_logic;
signal divide_clk : integer range 0 to N;

begin

    disp: entity work.fsm12(arch)
    port map(
        clk => clk,
        a => btn(3), -- aqui, vamos substituir o btn pela saida do debounce, e o btn vai entrar na arquitetura do debounce
        b => btn(1), -- aqui, vamos substituir o btn pela saida do debounce, e o btn vai entrar na arquitetura do debounce
        car_enter => led(0), -- alterar pela saida do display hex
        car_exit => led(1), -- alterar pela saida do display hex
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
