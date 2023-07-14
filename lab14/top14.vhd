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
    --sw_prior : in std_logic_vector (15 downto 13);
    sw : in std_logic_vector(15 downto 0);
    led : out std_logic_vector (3 downto 0)
   );

end top14;

architecture arch of top14 is

  signal enable: std_logic;
  signal cod_prio_out: std_logic_vector(1 downto 0);
  signal mux_out, ffd_out, inc_4bits_out: std_logic_vector(3 downto 0);

  begin
    
    --divisor de clock
    div_clk_unity: entity work.div_clk
    port map(
      clk => clk,
      en => enable
    );

    --codificador de prioridade
    cod_prio_unity: entity work.cod_prio
    port map(
      r => sw(15 downto 13),
      pcode => cod_prio_out
    );
    
    --Somador de 4 bits
    inc_4bits_unity: entity work.inc_4bits
    port map(
      inc_in => ffd_out,
      inc_out => inc_4bits_out
    );


    --primeiro bloco--------------------------------------------
    mux_4x1_unity1: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(0),
      i(0) => ffd_out(0),
      i(1) => ffd_out(1),
      i(2) => inc_4bits_out(0),
      i(3) => sw(0)
    );

    ffd_unity1: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(0),
      Q => ffd_out(0)
    );

    --segundo bloco-----------------------------------------------
    mux_4x1_unity2: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(1),
      i(0) => ffd_out(1),
      i(1) => ffd_out(2),
      i(2) => inc_4bits_out(1),
      i(3) => sw(1)
    );

    ffd_unity2: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(1),
      Q => ffd_out(1)
    );

    --terceiro bloco------------------------------------------------
      mux_4x1_unity3: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(2),
      i(0) => ffd_out(2),
      i(1) => ffd_out(3),
      i(2) => inc_4bits_out(2),
      i(3) => sw(2)
    );

    ffd_unity3: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(2),
      Q => ffd_out(2)
    );
    
    --quarto bloco---------------------------------------------------
     mux_4x1_unity4: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(3),
      i(0) => ffd_out(3),
      i(1) => sw(6),
      i(2) => inc_4bits_out(3),
      i(3) => sw(3)
    );

    ffd_unity4: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(3),
      Q => ffd_out(3)
    );

    led <= ffd_out; --leds recebem a saÃ­da dos flip flops

end arch;
