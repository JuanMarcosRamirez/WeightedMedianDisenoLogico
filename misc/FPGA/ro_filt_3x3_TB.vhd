--------------------------------------------------------------------------
-- Autor original: Antony Nelson.
-- Modificaciones de esta versión: Jorge Márquez
-- 
-- Esta rutina contiene las modificaciones indicadas en la sección de 
-- Anexos del informe de trabajo de grado PROCESAMIENTO DE IMÁGENES DE 
-- ANGIOGRAFÍA BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
-- 
-- UNIVERSIDAD DE LOS ANDES
-- FACULTAD DE INGENIERÍA
-- ESCUELA DE INGENIERÍA ELÉCTRICA
-- 
-- Mérida, Septiembre, 2008
--
-- Datos para la simulación:
--
-- t_valid = time when output data first becomes valid
-- t_delay = t_valid - 5 ns
-- t_sim_stop = 163835 ns + t_delay + 10 ns   --ojo:para 512x512 son 5253510 ns
-- this is 165305ns for this entity           --ojo:para 512x512 son 5253510 ns
--
-- 
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity ro_filt_3x3_tb is
	generic(
		vwidth : INTEGER := 8;
		order : INTEGER := 5;
		num_cols : INTEGER := 512;
		num_rows : INTEGER := 512 );
end ro_filt_3x3_tb;

architecture TB_ARCHITECTURE of ro_filt_3x3_tb is
	component ro_filt_3x3
	generic(
		vwidth : INTEGER := 8;
		order : INTEGER := 5;
		num_cols : INTEGER := 512;
		num_rows : INTEGER := 512 );
	port(
		Clk : in std_logic;
		RSTn : in std_logic;
		D : in std_logic_vector((vwidth -1) downto 0);
		Dout : out std_logic_vector((vwidth -1) downto 0);
		DV : out std_logic );
	end component;
	signal Clk : std_logic;
	signal RSTn : std_logic;
	signal D : std_logic_vector((vwidth-1) downto 0);
	signal Dout : std_logic_vector((vwidth-1) downto 0);
	signal DV : std_logic;

begin
	UUT : ro_filt_3x3
		port map              --portmap
		(Clk => Clk,          --portmap
		RSTn => RSTn,         --portmap
		D => D,               --portmap
		Dout => Dout,         --portmap
		DV => DV );           --portmap


	read_from_file: process(Clk)                                                               --read_from_file
		variable indata_line: line;                                                        --read_from_file
		variable indata: integer;                                                          --read_from_file
		file input_data_file: text open read_mode is "D:\JORGETESIS\lena512_syp.txt";      --read_from_file
	begin                                                                                      --read_from_file
		if rising_edge(Clk) then                                                           --read_from_file
			readline(input_data_file,indata_line);                                     --read_from_file
			read(indata_line,indata);                                                  --read_from_file
			D <= conv_std_logic_vector(indata,8);                                      --read_from_file
			if endfile(input_data_file) then                                           --read_from_file
				report "end of file -- looping back to start of file";             --read_from_file
				file_close(input_data_file);                                       --read_from_file
				file_open(input_data_file,"D:\JORGETESIS\lena512_syp.txt");        --read_from_file
			end if;                                                                    --read_from_file
		end if;                                                                            --read_from_file
	end process;                                                                               --read_from_file
	
	write_to_file: process(Clk)                                                                 --write_to_file
		variable outdata_line: line;                                                        --write_to_file
		variable outdata: integer:=0;                                                       --write_to_file
		file output_data_file: text open write_mode is "D:\JORGETESIS\lena512_syp.bin";     --write_to_file
	begin                                                                                       --write_to_file
		if rising_edge(Clk) then                                                            --write_to_file
			outdata := CONV_INTEGER(unsigned(Dout));                                    --write_to_file
			if DV = '1' then                                                            --write_to_file
				write(outdata_line,outdata);                                        --write_to_file
				writeline(output_data_file,outdata_line);                           --write_to_file
			end if;                                                                     --write_to_file
		end if;                                                                             --write_to_file
	end process;                                                                                --write_to_file
	
	
	clock_gen: process
	begin
		Clk <= '0';
		wait for 10 ns;
		Clk <= '1';
		wait for 10 ns;
	end process;
	
	
	reset_gen: process
	begin
		RSTn <= '0';
		wait for 20 ns;
		RSTn <= '1';
		wait;
	end process;
end TB_ARCHITECTURE;


configuration TESTBENCH_FOR_ro_filt_3x3 of ro_filt_3x3_tb is
	for TB_ARCHITECTURE
		for UUT : ro_filt_3x3
			use entity work.ro_filt_3x3(ro_filt_3x3);
		end for;
	end for;
end TESTBENCH_FOR_ro_filt_3x3;
