library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;
use WORK.constants.all;

entity memory_generic is
 generic(n_bit:integer;data_bit:integer);
 port (
         RESET: 	IN std_logic;
	 ENABLE: 	IN std_logic;
	 RD: 		IN std_logic;
	 WR: 		IN std_logic;
	 ADD_WR: 	IN std_logic_vector(n_bit downto 0);
	 ADD_RD1: 	IN std_logic_vector(n_bit downto 0);
	 DATAIN: 	IN std_logic_vector(data_bit-1 downto 0);
         OUT1: 		OUT std_logic_vector(data_bit-1 downto 0);
end memory_generic;

architecture behavioral of memory_generic is

        -- suggested structures
        subtype REG_ADDR is natural range 0 to n_bit**2-1; -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(data_bit-1 downto 0); 
	signal REGISTERS : REG_ARRAY;
	signal ADD_WR_INT : integer;
	signal ADD_RD1_INT: integer;

	
begin 
	regist: process(RESET,ENABLE)

	begin
		ADD_WR_INT <= to_integer(unsigned(ADD_WR));
		ADD_RD1_INT <= to_integer(unsigned(ADD_RD1));
		
		if RESET = '1' then 
			REGISTERS <= (others => (others => '0'));
		elsif ENABLE = '1' then
			if WR = '1' then
				REGISTERS(ADD_WR_INT) <= DATAIN;
			end if;
			if RD = '1' then
				OUT1 <= REGISTERS(ADD_RD1_INT);
			end if;	
		end if;
	end process;
end behavioral;
