library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;

entity register_file is
 generic(registern:integer := 32);
 port ( CLK: 		IN std_logic;
         RESET: 	IN std_logic;
	 ENABLE: 	IN std_logic;
	 RD1: 		IN std_logic;
	 RD2: 		IN std_logic;
	 WR: 		IN std_logic;
	 ADD_WR: 	IN std_logic_vector(4 downto 0);
	 ADD_RD1: 	IN std_logic_vector(4 downto 0);
	 ADD_RD2: 	IN std_logic_vector(4 downto 0);
	 DATAIN: 	IN std_logic_vector(63 downto 0);
         OUT1: 		OUT std_logic_vector(63 downto 0);
	 OUT2: 		OUT std_logic_vector(63 downto 0));
end register_file;

architecture A of register_file is

        -- suggested structures
        subtype REG_ADDR is natural range 0 to 31; -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(63 downto 0); 
	signal REGISTERS : REG_ARRAY;
	signal ADD_WR_INT : integer;
	signal ADD_RD1_INT: integer;
	signal ADD_RD2_INT: integer;

	
begin 
	regist: process(CLK,RESET,ENABLE)


	begin
		ADD_WR_INT <= to_integer(unsigned(ADD_WR));
		ADD_RD1_INT <= to_integer(unsigned(ADD_RD1));
		ADD_RD2_INT <= to_integer(unsigned(ADD_RD2));
		if CLK'event and CLK='1' then
			if RESET = '1' then 
				REGISTERS <= (others => (others => '0'));
			elsif ENABLE = '1' then
				if WR = '1' then
					REGISTERS(ADD_WR_INT) <= DATAIN;
				end if;
				if RD1 = '1' then
					OUT1 <= REGISTERS(ADD_RD1_INT);-- when CLK = '1';
				end if;
				if RD2 = '1' then
					OUT2 <= REGISTERS(ADD_RD2_INT);
				end if;
			end if;
		end if;
	end process;

end A;

----


configuration CFG_RF_BEH of register_file is
  for A
  end for;
end configuration;
