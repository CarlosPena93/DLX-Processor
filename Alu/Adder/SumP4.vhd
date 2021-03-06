library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use WORK.constants.all;

entity SumP4 is
	generic(N_BIT:integer;NumBit:integer;CBIT:integer);
	port(
	     A:in std_logic_vector (NumBit-1 downto 0);
	     B:in std_logic_vector (NumBit-1 downto 0);
	     Cin: in std_logic;
	     cout:out std_logic;
	     SUM:out std_logic_vector (NumBit-1 downto 0)
	    );
end SumP4;


architecture structural of SumP4 is

component sum_generator 
	generic(N_BIT:integer;NumBit:integer;CBIT:integer);
	port(
	     A:in std_logic_vector (NumBit-1 downto 0);
	     B:in std_logic_vector (NumBit-1 downto 0);
	     CIN:in std_logic_vector (CBIT-1 downto 0);
	     SUM:out std_logic_vector (NumBit-1 downto 0)
	    );

end component;

component CARRY_GENERATOR2  
	generic(N_BIT:integer;NumBit:integer;CBIT:integer);
	port(
		A: in std_logic_vector(NumBit-1 downto 0);
		B: in std_logic_vector(NumBit-1 downto 0);
		Cin: in std_logic;
		Cout: out std_logic_vector(CBIT-1 downto 0)) ;
end component;


Signal Cbit_signal:std_logic_vector(CBIT-1 downto 0);
Signal Cbit_signal2:std_logic_vector(CBIT-1 downto 0);
signal B_interm: std_logic_vector(NumBit-1 downto 0);


begin

	xors:for I in 0 to NumBit-1 generate
		B_interm(I)<= B(I) xor Cin;
	end generate;

	Cbit_signal(0)<=Cin;-- later on need to use the first carry in order to do the substraction
	Cbit_signal(CBIT-1 downto 1)<= Cbit_signal2(CBIT-2 downto 0);
	cout<=Cbit_signal2(CBIT-1);

	Carrys:CARRY_GENERATOR2-- conects the input and a siignal to the carry generator
	generic map(N_BIT,NumBit,CBIT)
	Port Map (A,B_interm,Cin,cbit_signal2);

	Sums:sum_generator-- conects the  sum generator to the carry generator and to the out
	generic map(N_BIT,NumBit,CBIT)
	Port Map (A,B_interm,cbit_signal,SUM);

end STRUCTURAL;
