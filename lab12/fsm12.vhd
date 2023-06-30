
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm12 is
  Port (
    clk: in std_logic;
    enable: in std_logic;
    a, b: in std_logic;
    car_enter, car_exit: out std_logic
   );
end fsm12;

architecture arch of fsm12 is
    type eg_state_type is (vazio, e1, e2, e3, entrou, es1, es2, es3, saiu);
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
      process(state_reg, a, b)
      begin
         state_next <= state_reg; --default: back to same state
         case state_reg is
            when vazio =>
                if a='0' then
                    if b='0' then
                        state_next <= vazio;
                    else 
                        state_next <= es1;
                    end if;
                else 
                    state_next <= e1;
                end if;
                
            when e1 =>
                    if a='0' then
                        state_next <= vazio;
                    
                    else 
                        if b='0' then
                            state_next <= e1;
                            
                        else 
                            state_next <= e2;
                        
                        end if;
                    end if;

             
             when e2 =>
                    if b='0' then
                         state_next <= e1;
                         
                    else 
                        if a='1' then
                            state_next <= e2;
                            
                        else 
                            state_next <= e3;
                        end if;
                    end if;

                    
               when e3 =>
                        if b='1' then
                           state_next <= e3;
                        else 
                            if a='0' then
                                state_next <= entrou;
                            
                            else
                                state_next <= e2;
                                
                            end if;
                        end if;
                when entrou =>
                        state_next <= vazio;
                     
                when es1 =>
                        if b='0' then
                            state_next <= vazio;
                        else 
                              
                            if a='1' then
                                  state_next <= es2;
                                 
                            else 
                                  state_next <= es1;
                                  
                            end if;
                        end if;
                        
                when es2 =>
                        if a='0' then
                            state_next <= es1;
                        
                        else 
                        
                            if b='1' then
                                state_next <= es2;
                            else 
                                state_next <= es3;
                                
                            end if;
                        end if;
                        
                        
                when es3 =>
                        if a='1' then
                                state_next <= es3;
                        else 
                            if b='0' then
                                state_next <= saiu;
                            else 
                                state_next <= es2;
                            end if;
                        end if;
                when saiu =>
                        state_next <= vazio;
             end case; 
  end process;

--moore output logic:
process(state_reg)
   begin
        case state_reg is 
        when vazio =>
            car_enter <= '0';
            car_exit <= '0';
        when e1 =>
            car_enter <= '0';
            car_exit <= '0';
        when e2 =>
            car_enter <= '0';
            car_exit <= '0';
        when e3 =>
            car_enter <= '0';
            car_exit <= '0';
        when entrou =>
            car_enter <= '1';
            car_exit <= '0';
        when es1 =>
            car_enter <= '0';
            car_exit <= '0';
        when es2 =>
            car_enter <= '0';
            car_exit <= '0';
        when es3 =>
            car_enter <= '0';
            car_exit <= '0';
        when saiu =>
            car_enter <= '0';
            car_exit <= '1';
        
        end case;
   end process;
end arch;
