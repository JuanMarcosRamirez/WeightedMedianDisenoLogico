--------------------------------------------------------------------------
-- Autor: Jorge Márquez

-- Archivo adaptado para la generación de ventanas de 3x3 píxeles para
-- imágenes de tamaño 512x512. El funcionamiento que se expone con detalle
-- en el capítulo 2 del informe.
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;


entity window_3x3 is
	generic (                                                          
		vwidth: integer:=8                                         
		);                                                         
	port (                                                             
		Clk : in std_logic;                                        
		RSTn : in std_logic;                                       
		D : in std_logic_vector(vwidth-1 downto 0);                
		w11 : out std_logic_vector(vwidth -1 downto 0);            
		w12 : out std_logic_vector(vwidth -1 downto 0);            
		w13 : out std_logic_vector(vwidth -1 downto 0);            
		w21 : out std_logic_vector(vwidth -1 downto 0);            
		w22 : out std_logic_vector(vwidth -1 downto 0);            
		w23 : out std_logic_vector(vwidth -1 downto 0);            
		w31 : out std_logic_vector(vwidth -1 downto 0);            
		w32 : out std_logic_vector(vwidth -1 downto 0);            
		w33 : out std_logic_vector(vwidth -1 downto 0);            
		DV : out std_logic:='0'                                    
	);                                                                 
end window_3x3;                                                            


architecture window_3x3 of window_3x3 is                                       

component fifo_512x8x
	port (                                                                 
	din : IN std_logic_VECTOR(7 downto 0);                                 
	wr_en : IN std_logic;                                                  
	wr_clk : IN std_logic;                                                 
	rd_en : IN std_logic;                                                  
	rd_clk : IN std_logic;                                                 
	rst : IN std_logic;                                                    
	dout : OUT std_logic_VECTOR(7 downto 0);                               
	full : OUT std_logic;                                                  
	empty : OUT std_logic;                                                 
	wr_data_count: OUT std_logic_VECTOR(8 downto 0));                      
end component;                                                                 

		
	signal a00 : std_logic_vector(vwidth-1 downto 0); 	              
	signal a11 : std_logic_vector(vwidth-1 downto 0);                     
	signal a12 : std_logic_vector(vwidth-1 downto 0);                     
	signal a13 : std_logic_vector(vwidth-1 downto 0);                     
	signal a21 : std_logic_vector(vwidth-1 downto 0);                     
	signal a22 : std_logic_vector(vwidth-1 downto 0);                     
	signal a23 : std_logic_vector(vwidth-1 downto 0);                     
	signal a31 : std_logic_vector(vwidth-1 downto 0);                     
	signal a32 : std_logic_vector(vwidth-1 downto 0);                     
	signal a33 : std_logic_vector(vwidth-1 downto 0);                     
	--fifoa signals                                                       
	signal clear : std_logic;                                             
	signal wrreqa : std_logic:='1';                                       
	signal rdreqa : std_logic:='0';                                       
	signal ofulla : std_logic;                                            
	signal oemptya : std_logic;                                           
	signal ofifoa : std_logic_vector(vwidth-1 downto 0);                  
	signal ousedwa : std_logic_VECTOR(8 downto 0);                        
	--fifob signals                                                       
	signal wrreqb : std_logic:='0';                                       
	signal rdreqb : std_logic:='0';                                       
	signal ofullb : std_logic;                                            
	signal oemptyb : std_logic;                                           
	signal ofifob : std_logic_vector(vwidth-1 downto 0);                  
	signal ousedwb : std_logic_VECTOR(8 downto 0);                        
	signal dwrreqb: std_logic:='0';                                       
	-- signals for DV coordination                                        
                                                                              
	signal dddddddDV: std_logic :='0';   	                              
	signal ddddddDV: std_logic:='0';                                      
	signal dddddDV: std_logic:='0';                                       
	signal ddddDV: std_logic:='0';                                        
	signal dddDV: std_logic:='0';                                         
	signal ddDV: std_logic:='0';                                          
	signal dDV: std_logic:='0';                                           
	signal ousedwa_temp: integer:=0;                                      
	signal ousedwb_temp: integer:=0;                                      
begin
	fifoa: fifo_512x8x                                                    
		port map (                          -- port map fifo a
			din => a13,                 -- port map fifo a
			wr_en => wrreqa,            -- port map fifo a
			wr_clk => Clk,              -- port map fifo a
			rd_en => rdreqa,            -- port map fifo a
			rd_clk => Clk,              -- port map fifo a
			rst => clear,               -- port map fifo a
			dout => ofifoa,             -- port map fifo a
			full => ofulla,             -- port map fifo a
			empty => oemptya,           -- port map fifo a
			wr_data_count => ousedwa    -- port map fifo a
		);                                  -- port map fifo a   
	fifob: fifo_512x8x
	port map (                                   -- port map fifo b
		din => a23,                          -- port map fifo b
		wr_en => wrreqb,                     -- port map fifo b
		wr_clk => Clk,                       -- port map fifo b
		rd_en => rdreqb,                     -- port map fifo b
		rd_clk => Clk,                       -- port map fifo b
		rst => clear,                        -- port map fifo b
		dout => ofifob,                      -- port map fifo b
		full => ofullb,                      -- port map fifo b
		empty => oemptyb,                    -- port map fifo b
		wr_data_count => ousedwb             -- port map fifo b
	);                                           -- port map fifo b

clear <= not(RSTn);

clock: process(Clk,RSTn)
	begin                                                         --clock 
		if RSTn = '0' then                                    --clock  
			a11 <= (others=>'0');                         --clock  
			a12 <= (others=>'0');                         --clock  
			a13 <= (others=>'0');                         --clock  
			a21 <= (others=>'0');                         --clock  
			a22 <= (others=>'0');                         --clock  
			a23 <= (others=>'0');                         --clock  
			a31 <= (others=>'0');                         --clock  
			a32 <= (others=>'0');                         --clock  
			a33 <= (others=>'0');                         --clock  
			w11 <= (others=>'0');                         --clock  
			w12 <= (others=>'0');                         --clock  
			w13 <= (others=>'0');                         --clock  
			w21 <= (others=>'0');                         --clock  
			w22 <= (others=>'0');                         --clock  
			w23 <= (others=>'0');                         --clock  
			w31 <= (others=>'0');                         --clock  
			w32 <= (others=>'0');                         --clock  
			w33 <= (others=>'0');                         --clock  
			wrreqa <= '0';                                --clock  
			wrreqb <= '0';                                --clock  

-- 			dddddddDV <= '0';   -- 7 ds                   --clock  
			ddddddDV <= '0';                              --clock  
			dddddDV <= '0';                               --clock  
			ddddDV <= '0';                                --clock  
			dddDV <= '0';                                 --clock  
			ddDV <= '0';                                  --clock  
			dDV <= '0';                                   --clock  
			DV <= '0';                                    --clock  
		elsif rising_edge(Clk) then                           --clock  
                                                                      --clock  
			a00 <= D;                                     --clock  
		                                                      --clock  
			a11 <= a00;                                   --clock  
			w11 <= a00;                                   --clock  
		                                                      --clock 
			                                              --clock 
			w12 <= a11;                                   --clock  
			a12 <= a11;                                   --clock  
			                                              --clock  
			w13 <= a12;                                   --clock  
			a13 <= a12;                                   --clock  
			                                              --clock  
			                                              --clock  
			w21 <= ofifoa;                                --clock  
			a21 <= ofifoa;                                --clock  
                                                                      --clock  
			w22 <= a21;                                   --clock  
			a22 <= a21;                                   --clock  
                                                                      --clock  
			w23 <= a22;                                   --clock  
			a23 <= a22;                                   --clock  
                                                                      --clock  
			w31 <= ofifob;                                --clock  
			a31 <= ofifob;                                --clock  
                                                                      --clock  
			w32 <= a31;                                   --clock  
			a32 <= a31;                                   --clock  
                                                                      --clock  
			w33 <= a32;                                   --clock  
			a33 <= a32;                                   --clock  
			                                              --clock  
			wrreqa <= '1';                                --clock  
			wrreqb <= dwrreqb;                            --clock  
                                                                      --clock  
			ddddddDV <= dddddddDV;   --04/06/08           --clock  
			dddddDV <= ddddddDV;                          --clock  
			ddddDV <= dddddDV;                            --clock  
			dddDV <= ddddDV;                              --clock  
			ddDV <= dddDV;                                --clock  
			dDV <= ddDV;                                  --clock  
			DV <= dDV;                                    --clock  
		end if;                                               --clock  
	end process;                                                  --clock  
	
	req: process(Clk)                                   --  req
	begin                                               --  req
	if rising_edge(Clk) then                            --  req
		if ousedwa = "111111010" then               --  req
			rdreqa <= '1';                      --  req
			dwrreqb <= '1';                     --  req
		end if;                                     --  req
		if ousedwb = "111111010" then               --  req
			rdreqb <= '1';                      --  req
			dddddddDV <= '1';   --04/06/08  ds  --  req
		end if;                                     --  req
	end if;                                             --  req
	end process;                                        --  req
end window_3x3;
