--------------------------------------------------------------------------
--Autor: Jorge Márquez
--fecha: julio 2008
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity tope_tb is
--	generic(
--		vwidth : INTEGER := 8;
--		order : INTEGER := 5;
--		num_cols : INTEGER := 512;
--		num_rows : INTEGER := 512 );
end tope_tb;

architecture TB_ARCHITECTURE of tope_tb is
	component tope_rof512_uart                                                   --componente
--	generic(                                                                --componente
--		vwidth : INTEGER := 8;                                          --componente
--		order : INTEGER := 5;                                           --componente
--		num_cols : INTEGER := 512;                                      --componente
--		num_rows : INTEGER := 512 );                                    --componente
	 Port ( tx_female : out std_logic;       
                rx_female : in std_logic; 
		slides_SW : in std_logic_vector(3 downto 0);					 
		LED : out std_logic_vector(7 downto 0);
		RSTn : in std_logic;		    
                clk : in std_logic);                                            --componente
	end component;                                                          --componente
	
	
	signal slides_SW : std_logic_vector(3 downto 0);	
	signal tx_female :  std_logic:= '0';                         			--decl señales
	signal rx_female :  std_logic:= '0';                         			 --decl señales
	signal LED :  std_logic_vector(7 downto 0) := "00000000";            			         --decl señales
	signal RSTn :  std_logic:= '0';		               			   --decl señales
	signal clk :  std_logic:= '0';                               			         --decl señales
	signal TT :  std_logic:= '0'; 
	signal byteindata: std_logic_vector(7 downto 0) := "00000000"; 

begin
	UUT : tope_rof512_uart
		port map              			--portmap
		(clk => clk,          			--portmap
		RSTn => RSTn,         			--portmap
		LED => LED,           			    --portmap
		slides_SW => slides_SW,
		rx_female => rx_female,        		 --portmap
		tx_female => tx_female );      		     --portmap
		
	rx_female <= byteindata(0);
	
	read_from_file: process(TT)                                                               --read_from_file
		variable indata_line: line;                                                        --read_from_file
		variable indata: integer;                                                          --read_from_file
		file input_data_file: text open read_mode is "C:\MATLAB701\work\lenasyp16x16.ser";      --read_from_file
	begin                                                                                      --read_from_file
		if rising_edge(TT) or falling_edge(TT) then                                                           --read_from_file
			readline(input_data_file,indata_line);                                     --read_from_file
			read(indata_line,indata);                                                  --read_from_file
			byteindata <= conv_std_logic_vector(indata,8);			--original: D <= conv_std_logic_vector(indata,8);
		--	rx_female <= byteindata(0);                              		
			if endfile(input_data_file) then                                           --read_from_file
				report "end of file -- looping back to start of file";             --read_from_file
				file_close(input_data_file);                                       --read_from_file
				file_open(input_data_file,"C:\MATLAB701\work\lenasyp16x16.ser");        --read_from_file
			end if;                                                                    --read_from_file
		end if;                                                                            --read_from_file
	end process;                                                                               --read_from_file
	
--	write_to_file: process(Clk)                                                                 --write_to_file
--		variable outdata_line: line;                                                        --write_to_file
--		variable outdata: integer:=0;                                                       --write_to_file
--		file output_data_file: text open write_mode is "D:\JORGETESIS\proc_HW1lena512_syp.ser";     --write_to_file
--	begin                                                                                       --write_to_file
--		if rising_edge(Clk) then                                                            --write_to_file
--			outdata := CONV_INTEGER(tx_female);                                    --write_to_file  --original: outdata := CONV_INTEGER(unsigned(Dout)); 
--		--	if DV = '1' then                                                            --write_to_file
--				write(outdata_line,outdata);                                        --write_to_file
--				writeline(output_data_file,outdata_line);                           --write_to_file
--		--	end if;                                                                     --write_to_file
--		end if;                                                                             --write_to_file
--	end process;                                                                                --write_to_file
	
	
	clock_gen: process              --reloj
	begin                           --reloj
		Clk <= '0';             --reloj
		wait for 10 ns;         --reloj
		Clk <= '1';             --reloj
		wait for 10 ns;         --reloj
	end process;                    --reloj

	TT_gen: process                --patron de transmisión (8680=~1/115200)
	begin                          --patron de transmisión (8680=~1/115200)
		TT <= '0';             --patron de transmisión (8680=~1/115200)
		wait for 8680 ns;      --patron de transmisión (8680=~1/115200)
		TT <= '1';             --patron de transmisión (8680=~1/115200)
		wait for 8680 ns;      --patron de transmisión (8680=~1/115200)
	end process;             	
	
	reset_gen: process               --reset
	begin                            --reset
		RSTn <= '0';             --reset
		wait for 20 ns;          --reset
		RSTn <= '1';             --reset
		wait;                    --reset
	end process;                     --reset
	
	slides_SW(0)<= '1';
	slides_SW(1)<= '1';
	slides_SW(2)<= '0';
	slides_SW(3)<= '1';
	
	
end TB_ARCHITECTURE;


configuration TESTBENCH_FOR_tope_rof512_uart of tope_tb is
	for TB_ARCHITECTURE
		for UUT : tope_rof512_uart
			use entity work.tope_rof512_uart(comportamiento);
		end for;
	end for;
end TESTBENCH_FOR_tope_rof512_uart;
