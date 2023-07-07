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
signal enable : std_logic;
signal result : std_logic_vector (3 downto 0);
signal car_enter, car_exit : std_logic;
signal db_level_1, db_level_2 : std_logic;
begin

    fsm: entity work.fsm13(arch)
    port map(
        clk => clk,
        a => db_level_1, 
        b => db_level_2, 
        car_enter => car_enter, 
        car_exit => car_exit, 
        enable => enable
    );

    counter: entity work.counter(arch)
    port map (
        clk => clk,
        sum => car_enter,
        subt => car_exit,
        q => result
    );

    db1 : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         sw    => btn(3),
         db    => db_level_1
      );
    
    db2 : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         sw    => btn(1),
         db    => db_level_2
      );

    display: entity work.disp_hex_mux
    port map(
      clk => clk,
      reset => '0',
      hex3 => "0000",
      hex2 => "0000",
      hex1 => "0000",
      hex0 => result,
      dp_in => "1111",
      an => an,
      sseg => sseg
    );
    
    enable <= '1';

end arch;
