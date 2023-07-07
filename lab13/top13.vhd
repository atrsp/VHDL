----------------------------------------------------------------------------------
-- Company: CasalTech
-- Engineer: Ana Pereira & Vitor Dadalto
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
signal result : std_logic_vector (31 downto 0);
signal car_enter, car_exit : std_logic;
signal db_level_1, db_level_2 : std_logic;
begin

    _fsm_: entity work.fsm12(arch)
    port map(
        clk => clk,
        a => btn(3), -- aqui, vamos substituir o btn pela saida do debounce, e o btn vai entrar na arquitetura do debounce
        b => btn(1), -- aqui, vamos substituir o btn pela saida do debounce, e o btn vai entrar na arquitetura do debounce
        car_enter => car_enter, 
        car_exit => car_exit, 
        enable => enable
    );

    _counter_: entity work.counter(arch)
    port map (
        clk => clk,
        sum => car_enter,
        subt => car_exit,
        q => result
    );

    db_1 : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         reset => '0',
         sw    => btn(3),
         db    => db_level_1
      );
    
    db_2 : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         reset => '0',
         sw    => btn(1),
         db    => db_level_2
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
