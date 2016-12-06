--------------------------------------------------------------------------
--
-- Autor: Jorge Márquez

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

component fifo_16x8x
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
	wr_data_count: OUT std_logic_VECTOR(3 downto 0));                      
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
	signal ousedwa : std_logic_VECTOR(3 downto 0);                     
	--fifob signals                                                    
	signal wrreqb : std_logic:='0';                                    
	signal rdreqb : std_logic:='0';                                    
	signal ofullb : std_logic;                                         
	signal oemptyb : std_logic;                                        
	signal ofifob : std_logic_vector(vwidth-1 downto 0);               
	signal ousedwb : std_logic_VECTOR(3 downto 0);                    
	signal dwrreqb: std_logic:='0';                                    
	-- signals for DV coordination                                     
 	signal dddddddddDV: std_logic:='0';--:='0';  --9ds                                                                             
	signal ddddddddDV: std_logic:='0';   --8ds                                    -- Señales
	signal dddddddDV: std_logic :='0';       --04/06/08 7 ds funciona al pelo!	                                      -- Señales	                              
	signal ddddddDV: std_logic:='0';                                     
	signal dddddDV: std_logic:='0';                                      
	signal ddddDV: std_logic:='0';                                       
	signal dddDV: std_logic:='0';                                        
	signal ddDV: std_logic:='0';                                         
	signal dDV: std_logic:='0';                                          
	signal ousedwa_temp: integer:=0;                                     
	signal ousedwb_temp: integer:=0;                                     
begin
	fifoa: fifo_16x8x                      
		port map (                       
			din => a13,                
			wr_en => wrreqa,           
			wr_clk => Clk,             
			rd_en => rdreqa,           
			rd_clk => Clk,             
			rst => clear,              
			dout => ofifoa,            
			full => ofulla,            
			empty => oemptya,          
			wr_data_count => ousedwa   
		);                               
	fifob: fifo_16x8x
	port map (                                
		din => a23,                         
		wr_en => wrreqb,                    
		wr_clk => Clk,                      
		rd_en => rdreqb,                    
		rd_clk => Clk,                      
		rst => clear,                       
		dout => ofifob,                     
		full => ofullb,                     
		empty => oemptyb,                   
		wr_data_count => ousedwb            
	);                                        

clear <= not(RSTn);

clock: process(Clk,RSTn)
	begin                                                 
		if RSTn = '0' then                              
			a11 <= (others=>'0');                     
			a12 <= (others=>'0');                     
			a13 <= (others=>'0');                     
			a21 <= (others=>'0');                     
			a22 <= (others=>'0');                     
			a23 <= (others=>'0');                     
			a31 <= (others=>'0');                     
			a32 <= (others=>'0');                     
			a33 <= (others=>'0');                     
			w11 <= (others=>'0');                     
			w12 <= (others=>'0');                     
			w13 <= (others=>'0');                     
			w21 <= (others=>'0');                     
			w22 <= (others=>'0');                     
			w23 <= (others=>'0');                     
			w31 <= (others=>'0');                     
			w32 <= (others=>'0');                     
			w33 <= (others=>'0');                     
			wrreqa <= '0';                            
			wrreqb <= '0';                               
--			dddddddddDV <= '0'; --9 ds
-- 			ddddddddDV <= '0';  -- 8 ds
-- 			dddddddDV <= '0';   -- 7 ds                  
			ddddddDV <= '0';                             
			dddddDV <= '0';                              
			ddddDV <= '0';                               
			dddDV <= '0';                                
			ddDV <= '0';                                 
			dDV <= '0';                                  
			DV <= '0';                                   
		elsif rising_edge(Clk) then                        
                                                             
			a00 <= D;                                  
		                                                 
			a11 <= a00;                                
			w11 <= a00;                                
		 
			                                           
			w12 <= a11;                                
			a12 <= a11;                                
			                                     
			w13 <= a12;                          
			a13 <= a12;                          
			                                     
			                                     
			w21 <= ofifoa;                       
			a21 <= ofifoa;                       
                                                      
			w22 <= a21;                          
			a22 <= a21;                          
                                                      
			w23 <= a22;                          
			a23 <= a22;                          
                                                      
			w31 <= ofifob;                       
			a31 <= ofifob;                       
                                                      
			w32 <= a31;                          
			a32 <= a31;                          
                                                      
			w33 <= a32;                          
			a33 <= a32;                          
			wrreqa <= '1';                              
			wrreqb <= dwrreqb;                          
			ddddddDV <= dddddddDV;   --04/06/08         
			dddddDV <= ddddddDV;                        
			ddddDV <= dddddDV;                          
			dddDV <= ddddDV;                            
			ddDV <= dddDV;                              
			dDV <= ddDV;                                
			DV <= dDV;                                  
		end if;                                           
	end process;                                            
	
	req: process(Clk)                                
	begin                                            
	if rising_edge(Clk) then                         
		if ousedwa = "1010" then              
			rdreqa <= '1';                      
			dwrreqb <= '1';                     
		end if;                                    
		if ousedwb = "1010" then              
			rdreqb <= '1';                      
			dddddddDV <= '1';   --04/06/08  ds  
		end if;                                    
	end if;                                          
	end process;                                     
end window_3x3;

