--------------------------------------------------------------------------
--Autor: Jorge Márquez
--
-- Este banco de prueba lee los datos 
-- seriales de un archivo de texto y
-- los introduce en la entrada rx_female del módulo de recepción
--
-- Este código se encuentra también en la sección de 
-- Apéndices del informe de trabajo de grado PROCESAMIENTO DE IMÁGENES DE 
-- ANGIOGRAFÍA BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
-- 
-- UNIVERSIDAD DE LOS ANDES
-- FACULTAD DE INGENIERÍA
-- ESCUELA DE INGENIERÍA ELÉCTRICA
-- 
-- Mérida, Septiembre, 2008
--
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity tope_tb is

end tope_tb;

architecture TB_ARCHITECTURE of tope_tb is
	component tope_rof512_uart                                        
                                                                          
	 Port ( tx_female : out std_logic;                                
                rx_female : in std_logic;                                 
		LED : out std_logic_vector(7 downto 0);                   
		RSTn : in std_logic;		                          
                clk : in std_logic);                                      
	end component;                                                    
	                                                                  
	                                                                  
	signal tx_female :  std_logic:= '0';                         		
	signal rx_female :  std_logic:= '0';                         		
	signal LED :  std_logic_vector(7 downto 0) := "00000000";         
	signal RSTn :  std_logic:= '0';		               			
	signal clk :  std_logic:= '0';                               		
	signal TT :  std_logic:= '0';                                     
	signal byteindata: std_logic_vector(7 downto 0) := "00000000";    

begin
	UUT : tope_rof512_uart
		port map              			
		(clk => clk,          			
		RSTn => RSTn,         			
		LED => LED,           			
		rx_female => rx_female,       
		tx_female => tx_female );     
		
	rx_female <= byteindata(0);  
	
	read_from_file: process(TT)                                                               
		variable indata_line: line;                                                       
		variable indata: integer;                                                         
		file input_data_file: text open read_mode is "C:\MATLAB701\work\lena512_syp_inicializ.ser";   
	begin                                                                                      
		if rising_edge(TT) or falling_edge(TT) then                                             
			readline(input_data_file,indata_line);                                     
			read(indata_line,indata);                                                  
			byteindata <= conv_std_logic_vector(indata,8);			
	                            		
			if endfile(input_data_file) then                                           
				report "Finaliza el archivo -- se vuelve a leer desde el principio..."; 
				file_close(input_data_file);                                      
				file_open(input_data_file,"C:\MATLAB701\work\lena512_syp_inicializ.ser");        
			end if;                                                                    
		end if;                                                                       
	end process;                                                                     
	
                                                                      
	
	
	clock_gen: process        --reloj
	begin                     --reloj
		Clk <= '0';            --reloj
		wait for 10 ns;        --reloj
		Clk <= '1';            --reloj
		wait for 10 ns;        --reloj
	end process;              --reloj

	TT_gen: process           --patron de transmisión (8680=~1/115200)
	begin                     --patron de transmisión (8680=~1/115200)
		TT <= '0';             --patron de transmisión (8680=~1/115200)
		wait for 8680 ns;      --patron de transmisión (8680=~1/115200)
		TT <= '1';             --patron de transmisión (8680=~1/115200)
		wait for 8680 ns;      --patron de transmisión (8680=~1/115200)
	end process;             	
	
	reset_gen: process          --reset
	begin                       --reset
		RSTn <= '0';             --reset
		wait for 20 ns;          --reset
		RSTn <= '1';             --reset
		wait;                    --reset
	end process;                --reset
end TB_ARCHITECTURE;


configuration TESTBENCH_FOR_tope_rof512_uart of tope_tb is
	for TB_ARCHITECTURE
		for UUT : tope_rof512_uart
			use entity work.tope_rof512_uart(comportamiento);
		end for;
	end for;
end TESTBENCH_FOR_tope_rof512_uart;
