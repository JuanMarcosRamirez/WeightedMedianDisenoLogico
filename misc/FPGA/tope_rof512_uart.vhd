--------------------------------------------------------------------------
-- Autor: Jorge Márquez

-- Archivo para la ejecución del módulo tope en el FPGA
-- 
-- 
-- UNIVERSIDAD DE LOS ANDES
-- FACULTAD DE INGENIERÍA
-- ESCUELA DE INGENIERÍA ELÉCTRICA
-- 
-- Mérida, Septiembre, 2008
--
---------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tope_rof512_uart is    
    Port (         tx_female : out std_logic;       
                   rx_female : in std_logic;        
		   slides_SW : in std_logic_vector(3 downto 0);
		   LED : out std_logic_vector(7 downto 0);
		   RSTn : in std_logic;		    
                         clk : in std_logic);       
    end tope_rof512_uart;      
    
 
architecture Comportamiento of tope_rof512_uart is
   
	component ro_filt_3x3                                    --c.ro_filt_3x3
        	port (                                           --c.ro_filt_3x3
			Clk : in std_logic;                      --c.ro_filt_3x3
			RSTn : in std_logic;                     --c.ro_filt_3x3
			D : in std_logic_vector(7 downto 0);     --c.ro_filt_3x3
			Dout : out std_logic_vector(7 downto 0); --c.ro_filt_3x3
			DV : out std_logic;                      --c.ro_filt_3x3
			FColPos : out integer;                   --c.ro_filt_3x3
			FRowPos : out integer                    --c.ro_filt_3x3
			);                                       --c.ro_filt_3x3
		end component;                                   --c.ro_filt_3x3
                                   
   
  component uart_tx_plus                                          --c.uart_tx_p
    Port (              data_in : in std_logic_vector(7 downto 0);--c.uart_tx_p
                   write_buffer : in std_logic;                   --c.uart_tx_p
                   reset_buffer : in std_logic;                   --c.uart_tx_p
                   en_16_x_baud : in std_logic;                   --c.uart_tx_p
                     serial_out : out std_logic;                  --c.uart_tx_p
            buffer_data_present : out std_logic;                  --c.uart_tx_p
                    buffer_full : out std_logic;                  --c.uart_tx_p
               buffer_half_full : out std_logic;                  --c.uart_tx_p
                            clk : in std_logic);                  --c.uart_tx_p
    end component;
    

  component uart_rx                                                 --c.uart_rx
    Port (            serial_in : in std_logic;                     --c.uart_rx
                       data_out : out std_logic_vector(7 downto 0); --c.uart_rx
                    read_buffer : in std_logic;                     --c.uart_rx
                   reset_buffer : in std_logic;                     --c.uart_rx
                   en_16_x_baud : in std_logic;                     --c.uart_rx
            buffer_data_present : out std_logic;                    --c.uart_rx
                    buffer_full : out std_logic;                    --c.uart_rx
               buffer_half_full : out std_logic;                    --c.uart_rx
                            clk : in std_logic);                    --c.uart_rx
  end component;                                                    --c.uart_rx

signal	rx_data_present3 : std_logic :='0';
signal	rx_data_present2 : std_logic :='0';
signal	datovale : std_logic;
signal	cambio : std_logic :='0';
signal  Dfilt : std_logic_vector(7 downto 0);   
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

begin    -------------------------------------- Comienzo de procesos y portmaps

                                                     --asignaciones
  slides <= slides_SW;                               --asignaciones
  write_to_uart <= datovale and rx_data_present2;    --asignaciones
  tx_female <= Salida_serial;                        --asignaciones
			                             --asignaciones
  LED(7) <= salidaReceive2(7);                       --asignaciones
  LED(6) <= salidaReceive2(6);                       --asignaciones
  LED(5) <= salidaReceive2(5);                       --asignaciones
  LED(4) <= salidaReceive2(4);                       --asignaciones
  LED(3) <= salidaReceive2(3);                       --asignaciones
  LED(2) <= salidaReceive2(2);                       --asignaciones
  LED(1) <= salidaReceive2(1);                       --asignaciones
  LED(0) <= salidaReceive2(0);                       --asignaciones


   
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
		

	Auditoria: process(FColPos)                                     --Audit
		begin                                                   --Audit
		                                                        --Audit
		columna_selec(7) <= '0';                                --Audit
		columna_selec(6) <= '0';                                --Audit
		columna_selec(5) <= '0';                                --Audit
		columna_selec(4) <= '1';                                --Audit
		columna_selec(3) <= slides(3);                          --Audit
		columna_selec(2) <= slides(2);                          --Audit
		columna_selec(1) <= slides(1);                          --Audit
		columna_selec(0) <= slides(0);                          --Audit
		                                                        --Audit
		FColPosbin <= conv_std_logic_vector(FColPos,8);         --Audit
		FRowPosbin <= conv_std_logic_vector(FRowPos,8);         --Audit
		                                                        --Audit
		if FColPosbin = columna_selec then       		--Audit
									--Audit
			if FRowPosbin = "00000010" then                 --Audit
					No_auditar <= '0';              --Audit
					                   		--Audit
			end if;                                         --Audit
		end if;                                                 --Audit
	end process Auditoria;                                          --Audit


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

