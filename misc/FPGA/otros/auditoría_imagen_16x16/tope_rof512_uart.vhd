library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity tope_rof512_uart is    
    Port (         tx_female : out std_logic;       
                   rx_female : in std_logic;        
						   slides_SW : in std_logic_vector(3 downto 0);
		   LED : out std_logic_vector(7 downto 0);
		   RSTn : in std_logic;		    
                         clk : in std_logic);       
    end tope_rof512_uart;      
    
 
architecture Comportamiento of tope_rof512_uart is
   
	component ro_filt_3x3                                    
        	port (                                           
			Clk : in std_logic;                      
			RSTn : in std_logic;                     
			D : in std_logic_vector(7 downto 0);     
			Dout : out std_logic_vector(7 downto 0); 
			DV : out std_logic;
			FColPos : out integer;                  
			FRowPos : out integer                   
			);                                      
		end component;                                   
                                   
   
  component uart_tx_plus                                          
    Port (              data_in : in std_logic_vector(7 downto 0);
                   write_buffer : in std_logic;                   
                   reset_buffer : in std_logic;                   
                   en_16_x_baud : in std_logic;                   
                     serial_out : out std_logic;                  
            buffer_data_present : out std_logic;                  
                    buffer_full : out std_logic;                  
               buffer_half_full : out std_logic;                  
                            clk : in std_logic);                  
    end component;
    

  component uart_rx                                                 
    Port (            serial_in : in std_logic;                     
                       data_out : out std_logic_vector(7 downto 0); 
                    read_buffer : in std_logic;                     
                   reset_buffer : in std_logic;                     
                   en_16_x_baud : in std_logic;                     
            buffer_data_present : out std_logic;                    
                    buffer_full : out std_logic;                    
               buffer_half_full : out std_logic;                    
                            clk : in std_logic);                    
  end component;                                                    

signal	rx_data_present3 : std_logic :='0';
signal	rx_data_present2 : std_logic :='0';
signal	datovale : std_logic;
signal	cambio : std_logic :='0';
signal  Dfilt : std_logic_vector(7 downto 0) :="00000000";   
signal  interrupt       : std_logic :='0';              
signal  interrupt_ack   : std_logic;                    
                                                        
                                                        
signal       baud_count : integer range 0 to 26 :=0;    
signal     en_16_x_baud : std_logic;                    
signal    write_to_uart : std_logic;                    
signal    write_to_uart2 : std_logic:='0';              
signal  tx_data_present : std_logic;                    
signal          tx_full : std_logic;                    
signal     tx_half_full : std_logic;                    
signal   read_from_uart : std_logic :='0';              
signal          rx_data : std_logic_vector(7 downto 0); 
signal  rx_data_present : std_logic :='0';              
signal          rx_full : std_logic;                    
signal     rx_half_full : std_logic;                    
                                                        
signal          rx_full2 : std_logic;                   
signal     rx_half_full2 : std_logic;                    
signal previous_rx_half_full : std_logic;               
signal    rx_half_full_event : std_logic;               





signal    pulsoauditoria : std_logic;                
signal    No_auditar : std_logic := '1';              
signal    Pare : std_logic := '0';                       
signal    FColPos : integer;
signal    FRowPos : integer;
signal    Salida_serial : std_logic;
signal    columna : integer;
signal    columna_selec : std_logic_vector(7 downto 0);
signal    FColPosbin : std_logic_vector(7 downto 0);
signal    FRowPosbin : std_logic_vector(7 downto 0);
signal    slides : std_logic_vector(3 downto 0);
signal    salidaReceive2 : std_logic_vector(7 downto 0);

signal    DSRL16 : std_logic:='1';
	
signal    Q   : std_logic := '1';
signal    Q1   : std_logic := '1'; 
signal    Q15   : std_logic := '0'; 
signal    Q152   : std_logic := '0'; 
signal    A0  : std_logic;  
signal    A1  : std_logic;  
signal    A2  : std_logic;  
signal    A3  : std_logic;  
signal    CE  : std_logic;  
signal	LEDetenido  : std_logic := '0';
         
begin    -------------------------------------- Comienzo de procesos y portmaps

                                                     --asignaciones
  slides <= slides_SW;                               --asignaciones
  write_to_uart <= datovale and rx_data_present2;    --asignaciones
  tx_female <= Salida_serial;                        --asignaciones
    A0  <= '1';
    A1  <= '1';
    A2  <= '1';
    A3  <= '1';
    CE <= '1';
 
   
 --audit 1 LED(7) <= salidaReceive2(7);                       --asignaciones
 --audit 1 LED(6) <= salidaReceive2(6);                       --asignaciones
 --audit 1 LED(5) <= salidaReceive2(5);                       --asignaciones
 --audit 1 LED(4) <= salidaReceive2(4);                       --asignaciones
 --audit 1 LED(3) <= salidaReceive2(3);                       --asignaciones
 --audit 1 LED(2) <= salidaReceive2(2);                       --asignaciones
 --audit 1 LED(1) <= salidaReceive2(1);                       --asignaciones
 --audit 1 LED(0) <= salidaReceive2(0);                       --asignaciones


   
  filtro: ro_filt_3x3                                                             
  	port map (                                                
			Clk => rx_data_present2,                        
			RSTn => read_from_uart,                               
			D => rx_data,       
			Dout => Dfilt,   
			DV => datovale,
			FColPos => FColPos,
			FRowPos => FRowPos
			);
  
		  process (clk)
		begin
			if clk'event and clk='1' then 
				write_to_uart2 <= write_to_uart;
				rx_data_present2 <= rx_data_present;
			end if;
		end process;
		
		
--  		  process (clk)
--		begin
--			if clk'event and clk='1' then  
--				rx_data_present3 <= rx_data_present2;
--			end if;
--		end process;
  
  
  write_to_uart <= datovale and rx_data_present2;
  
  transmit: uart_tx_plus 
  port map (              data_in => Dfilt, 
                     write_buffer => write_to_uart2,   
                     reset_buffer => '0',              
                     en_16_x_baud => en_16_x_baud,
                       serial_out => Salida_serial,
              buffer_data_present => tx_data_present,
                      buffer_full => tx_full,        
                 buffer_half_full => tx_half_full,   
                              clk => clk );

  receive: uart_rx
  port map (            serial_in => rx_female,
                         data_out => rx_data,
                      read_buffer => '1',  
                     reset_buffer => '0',
                     en_16_x_baud => en_16_x_baud,
              buffer_data_present => rx_data_present,
                      buffer_full => rx_full,        
                 buffer_half_full => rx_half_full,   
                              clk => clk );  

 
  receive2: uart_rx
  port map (            serial_in => Salida_serial,
                         data_out => salidaReceive2,
                      read_buffer => No_auditar,  
                     reset_buffer => '0',
                     en_16_x_baud => en_16_x_baud,
              buffer_data_present => pulsoauditoria,
                      buffer_full => rx_full2,        
                 buffer_half_full => rx_half_full2,   
                              clk => clk );  


	
      process (clk)                                        --desfase 1 cicl
	begin                                                  --desfase 1 cicl
		if clk'event and clk='1' then                  --desfase 1 cicl
			write_to_uart2 <= write_to_uart;       --desfase 1 cicl
			rx_data_present2 <= rx_data_present;   --desfase 1 cicl
		end if;                                        --desfase 1 cicl
	end process;                                           --desfase 1 cicl
		

	Auditoria: process(FColPos)                                    --Audit 1
		begin                                                  --Audit 1
		                                                       --Audit 1
		columna_selec(7) <= '0';                               --Audit 1
		columna_selec(6) <= '0';                               --Audit 1
		columna_selec(5) <= '0';                               --Audit 1
		columna_selec(4) <= '0';                               --Audit 1
		columna_selec(3) <= slides(3);                         --Audit 1
		columna_selec(2) <= slides(2);                         --Audit 1
		columna_selec(1) <= slides(1);                         --Audit 1
		columna_selec(0) <= slides(0);                         --Audit 1
		                                                       --Audit 1
		FColPosbin <= conv_std_logic_vector(FColPos,8);        --Audit 1
		FRowPosbin <= conv_std_logic_vector(FRowPos,8);        --Audit 1
		                                                       --Audit 1
		if FColPosbin = columna_selec then       		--Audit1
									--Audit1
			if FRowPosbin = "00000011" then                --Audit 1
					DSRL16 <= '0';             --Audit 1
					                   		--Audit1
			end if;                                        --Audit 1
		end if;                                                --Audit 1
	end process Auditoria;                                         --Audit 1
	

   -- SRLC16: 16-bit cascadable shift register LUT operating on posedge of clock
   --         Virtex-II/II-Pro, Spartan-3/3E/3A
   -- Xilinx HDL Language Template, version 9.2i
   
   SRLC16_inst : SRLC16
   generic map (
      INIT => X"0000")
   port map (
      Q => Q1,       -- SRL data output
      Q15 => Q15,   -- Carry output (connect to next SRL)
      A0 => A0,     -- Select[0] input
      A1 => A1,     -- Select[1] input
      A2 => A2,     -- Select[2] input
      A3 => A3,     -- Select[3] input
      CLK => CLK,   -- Clock input
      D => DSRL16        -- SRL data input
   );

   -- End of SRLC16_inst instantiation
   
   
   -- SRLC16: 16-bit cascadable shift register LUT operating on posedge of clock
   --         Virtex-II/II-Pro, Spartan-3/3E/3A
   -- Xilinx HDL Language Template, version 9.2i
   
   SRLC16_inst2 : SRLC16
   generic map (
      INIT => X"0000")
   port map (
      Q => Q,       -- SRL data output
      Q15 => Q152,   -- Carry output (connect to next SRL)
      A0 => A0,     -- Select[0] input
      A1 => A1,     -- Select[1] input
      A2 => A2,     -- Select[2] input
      A3 => A3,     -- Select[3] input
      CLK => CLK,   -- Clock input
      D => Q15         -- SRL data input
   );

   -- End of SRLC16_inst instantiation

	                                                      
	Doutfiltro: process(Q)                              --Dout en leds
                                                              --Dout en leds
	begin                                                 --Dout en leds
		
		
		if falling_edge(Q) then   --Dout en leds --LEDetenido='0'
			 LED <= Dfilt;                        --Dout en leds
			 --LEDetenido <= '1';
		end if;                                       --Dout en leds
	end process Doutfiltro;                               --Dout en leds

	
	toggle: process(rx_data_present)                               --toggle
	begin                                                          --toggle
		if rx_data_present'event and rx_data_present='1' then  --toggle
			if cambio='0' then                             --toggle
			cambio <= '1';                                 --toggle
			else                                           --toggle
			cambio <= '0';                                 --toggle
			end if;                                        --toggle
		else                                                   --toggle
		end if;                                                --toggle
	end process toggle;                                            --toggle


	baud_timer: process(clk)                   --Generación de en_16_x_baud
	  begin                                    --Generación de en_16_x_baud
	    if clk'event and clk='1' then          --Generación de en_16_x_baud
	      if baud_count=26 then                --Generación de en_16_x_baud
		 baud_count <= 0;                  --Generación de en_16_x_baud
		 en_16_x_baud <= '1';              --Generación de en_16_x_baud
	       else                                --Generación de en_16_x_baud
		 baud_count <= baud_count + 1;     --Generación de en_16_x_baud
		 en_16_x_baud <= '0';              --Generación de en_16_x_baud
	      end if;                              --Generación de en_16_x_baud
	    end if;                                --Generación de en_16_x_baud
	  end process baud_timer;                  --Generación de en_16_x_baud
	


	inicio: process(rx_female)                       --inicio: señal de rst
	begin                                            --inicio: señal de rst
		if rx_female'event and rx_female='0' then--inicio: señal de rst
			read_from_uart <= '1';           --inicio: señal de rst
		else                                     --inicio: señal de rst
		end if;                                  --inicio: señal de rst
	end process inicio;                              --inicio: señal de rst

end Comportamiento;	  


