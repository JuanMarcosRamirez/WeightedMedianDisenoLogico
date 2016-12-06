library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tope_rof512_uart is     --Entidad
    Port (   --17/05/08 cambio I      tx_female : out std_logic;       --Entidad
    		LED : out std_logic_vector(7 downto 0);
                   rx_female : in std_logic;        --Entidad
		   RSTn : in std_logic;		    --Entidad
                         clk : in std_logic);       --Entidad
    end tope_rof512_uart;      --Entidad
    
 
architecture Comportamiento of tope_rof512_uart is-----------------Arquitectura
   
	                         
   
--17/05/08 cambio I   component uart_tx_plus                                          --comp uart_tx_plus
--17/05/08 cambio I     Port (              data_in : in std_logic_vector(7 downto 0);--comp uart_tx_plus
--17/05/08 cambio I                    write_buffer : in std_logic;                   --comp uart_tx_plus
--17/05/08 cambio I                    reset_buffer : in std_logic;                   --comp uart_tx_plus
--17/05/08 cambio I                    en_16_x_baud : in std_logic;                   --comp uart_tx_plus
--17/05/08 cambio I                      serial_out : out std_logic;                  --comp uart_tx_plus
--17/05/08 cambio I             buffer_data_present : out std_logic;                  --comp uart_tx_plus
--17/05/08 cambio I                     buffer_full : out std_logic;                  --comp uart_tx_plus
--17/05/08 cambio I                buffer_half_full : out std_logic;                  --comp uart_tx_plus
--17/05/08 cambio I                             clk : in std_logic);                  --comp uart_tx_plus
--17/05/08 cambio I     end component;
    

  component uart_rx                                                 --comp uart_rx
    Port (            serial_in : in std_logic;                     --comp uart_rx
                       data_out : out std_logic_vector(7 downto 0); --comp uart_rx
                    read_buffer : in std_logic;                     --comp uart_rx
                   reset_buffer : in std_logic;                     --comp uart_rx
                   en_16_x_baud : in std_logic;                     --comp uart_rx
            buffer_data_present : out std_logic;                    --comp uart_rx
                    buffer_full : out std_logic;                    --comp uart_rx
               buffer_half_full : out std_logic;                    --comp uart_rx
                            clk : in std_logic);                    --comp uart_rx
  end component;                                                    --comp uart_rx
signal	cambio : std_logic :='0';
signal  Dfilt : std_logic_vector(7 downto 0);   
signal  interrupt       : std_logic :='0';               --se�ales
signal  interrupt_ack   : std_logic;                     --se�ales
                                                         --se�ales
                                                         --se�ales
signal       baud_count : integer range 0 to 26 :=0;     --se�ales
signal     en_16_x_baud : std_logic;                     --se�ales
signal    write_to_uart : std_logic;                     --se�ales
signal  tx_data_present : std_logic;                     --se�ales
signal          tx_full : std_logic;                     --se�ales
signal     tx_half_full : std_logic;                     --se�ales
signal   read_from_uart : std_logic :='0';                     --se�ales
signal          rx_data : std_logic_vector(7 downto 0);  --se�ales
signal  rx_data_present : std_logic;                     --se�ales
signal          rx_full : std_logic;                     --se�ales
signal     rx_half_full : std_logic;                     --se�ales
                                                         --se�ales
signal previous_rx_half_full : std_logic;                --se�ales
signal    rx_half_full_event : std_logic;                --se�ales



begin    --------------------------------------------- Comienzo de procesos y portmaps 


  interrupt_control: process(clk)                                  --Control de transmisi�n
  begin                                                            --Control de transmisi�n
    if clk'event and clk='1' then                                  --Control de transmisi�n
                                                                   --Control de transmisi�n
      -- detect change in state of the 'rx_half_full' flag.        --Control de transmisi�n
      previous_rx_half_full <= rx_half_full;                       --Control de transmisi�n
      rx_half_full_event <= previous_rx_half_full xor rx_half_full;--Control de transmisi�n
                                                                   --Control de transmisi�n
      -- processor interrupt waits for an acknowledgement          --Control de transmisi�n
      if interrupt_ack='1' then                                    --Control de transmisi�n
         interrupt <= '0';                                         --Control de transmisi�n
        elsif rx_half_full_event='1' then                          --Control de transmisi�n
         interrupt <= '1';                                         --Control de transmisi�n
        else                                                       --Control de transmisi�n
         interrupt <= interrupt;                                   --Control de transmisi�n
      end if;                                                      --Control de transmisi�n
                                                                   --Control de transmisi�n
    end if;                                                        --Control de transmisi�n
  end process interrupt_control;                                   --Control de transmisi�n
                                                                    
  
  
  
--17/05/08 cambio I   transmit: uart_tx_plus 
--17/05/08 cambio I   port map (              data_in => rx_data, 
--17/05/08 cambio I                      write_buffer => rx_data_present,   
--17/05/08 cambio I                      reset_buffer => '0',              
--17/05/08 cambio I                      en_16_x_baud => en_16_x_baud,
--17/05/08 cambio I                        serial_out => tx_female,
--17/05/08 cambio I               buffer_data_present => tx_data_present,--Pruebo: desconectado
--17/05/08 cambio I                       buffer_full => tx_full,        --Pruebo: desconectado
--17/05/08 cambio I                  buffer_half_full => tx_half_full,   --Pruebo: desconectado
--17/05/08 cambio I                               clk => clk );
--17/05/08 cambio I 
  receive: uart_rx
  port map (            serial_in => rx_female,
                         data_out => rx_data,
                      read_buffer => read_from_uart,   -- Atenci�n:fijar read_from_uart (indica lectura en el macro)
                     reset_buffer => '0',
                     en_16_x_baud => en_16_x_baud,
              buffer_data_present => rx_data_present,--Pruebo: desconectado
                      buffer_full => rx_full,        --Pruebo: desconectado
                 buffer_half_full => rx_half_full,   --Pruebo: desconectado
                              clk => clk );  
	LED(7) <= cambio;
	LED(6) <= rx_data(6);
	LED(5) <= rx_data(5);
	LED(4) <= rx_data(4);
	LED(3) <= rx_data(3);
	LED(2) <= rx_data(2);
	LED(1) <= rx_data(1);
	LED(0) <= rx_data(0);
	
	toggle: process(rx_data_present) 
	begin
		if rx_data_present'event and rx_data_present='1' then
			if cambio='0' then
			cambio <= '1';
			else
			cambio <= '0';
			end if;
		else
		end if;
	end process toggle;
	
	
	
	baud_timer: process(clk)                   --Generaci�n de en_16_x_baud
	  begin                                    --Generaci�n de en_16_x_baud
	    if clk'event and clk='1' then          --Generaci�n de en_16_x_baud
	      if baud_count=26 then                --Generaci�n de en_16_x_baud
		 baud_count <= 0;                  --Generaci�n de en_16_x_baud
		 en_16_x_baud <= '1';              --Generaci�n de en_16_x_baud
	       else                                --Generaci�n de en_16_x_baud
		 baud_count <= baud_count + 1;     --Generaci�n de en_16_x_baud
		 en_16_x_baud <= '0';              --Generaci�n de en_16_x_baud
	      end if;                              --Generaci�n de en_16_x_baud
	    end if;                                --Generaci�n de en_16_x_baud
	  end process baud_timer;                  --Generaci�n de en_16_x_baud
	
	inicio: process(rx_female) 
	begin
		if rx_female'event and rx_female='0' then
			read_from_uart <= '1';
		else
		end if;
	end process inicio;
end Comportamiento;	  

