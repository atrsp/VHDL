
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm11 is
  Port (
    clk: in std_logic;
    --reset: in std_logic;
    enable: in std_logic;
    en, cw: in std_logic;
    an: out std_logic_vector(3 downto 0);
    sseg: out std_logic_vector(7 downto 0)
   );
end fsm11;

architecture arch of fsm11 is
    type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal state_reg, state_next: eg_state_type;
   
begin

-- state register
   process(clk)
   begin
      if (clk'event and clk='1') then
         if (enable='1') then
                  state_reg <= state_next;
           end if;
      end if;
   end process;
   
   -- next-state/output logic
      process(state_reg, en, cw)
      begin
         state_next <= state_reg; --default: back to same state
         case state_reg is
            when s0 =>
                if en='1' then
                    if cw='1' then
                        state_next <= s1;
                    else 
                        state_next <= s7;
                    end if;
                end if;
                
            when s1 =>
                    if en='1' then
                        if cw='1' then
                            state_next <= s2;
                        else 
                            state_next <= s0;
                        end if;
                    end if;
             
             when s2 =>
                    if en='1' then
                        if cw='1' then
                            state_next <= s3;
                        else 
                            state_next <= s1;
                        end if;
                    end if;
                    
               when s3 =>
                        if en='1' then
                            if cw='1' then
                                state_next <= s4;
                            else 
                                state_next <= s2;
                            end if;
                        end if;
                        
                        
                when s4 =>
                        if en='1' then
                            if cw='1' then
                                state_next <= s5;
                            else 
                                state_next <= s3;
                            end if;
                        end if;
                        
                when s5 =>
                        if en='1' then
                            if cw='1' then
                                state_next <= s6;
                            else 
                                state_next <= s4;
                            end if;
                        end if;
                        
                when s6 =>
                        if en='1' then
                            if cw='1' then
                                state_next <= s7;
                            else 
                                state_next <= s5;
                            end if;
                        end if;
                        
                when s7 =>
                        if en='1' then
                            if cw='1' then
                                state_next <= s0;
                            else 
                                state_next <= s6;
                            end if;
                        end if;
             end case; 
  end process;
  
   --moore output logic
   process(state_reg)
   begin
        case state_reg is 
        when s0 =>
            an(3 downto 0) <= "0111";
            sseg(6 downto 0) <= "0011100";
        when s1 =>
            an(3 downto 0) <= "1011";
            sseg(6 downto 0) <= "0011100";
        when s2 =>
            an(3 downto 0) <= "1101";
            sseg(6 downto 0) <= "0011100";
        when s3 =>
            an(3 downto 0) <= "1110";
            sseg(6 downto 0) <= "0011100";
        when s4 =>
            an(3 downto 0) <= "1110";
            sseg(6 downto 0) <= "0100011";
        when s5 =>
            an(3 downto 0) <= "1101";
            sseg(6 downto 0) <= "0100011";
        when s6 =>
            an(3 downto 0) <= "1011";
            sseg(6 downto 0) <= "0100011";
        when s7 =>
            an(3 downto 0) <= "0111";
            sseg(6 downto 0) <= "0100011";
        
        end case;
   end process;

    sseg(7) <= '1';
end arch;
