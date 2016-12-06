library IEEE;
use IEEE.std_logic_1164.all;
entity sort_3x3 is
generic (
vwidth: integer:=8
);
port (
Clk : in std_logic;
RSTn : in std_logic;
w11 : in std_logic_vector((vwidth -1) downto 0);
w12 : in std_logic_vector((vwidth-1) downto 0);
w13 : in std_logic_vector((vwidth -1) downto 0);
w21 : in std_logic_vector((vwidth -1) downto 0);
w22 : in std_logic_vector((vwidth -1) downto 0);
w23 : in std_logic_vector((vwidth -1) downto 0);
w31 : in std_logic_vector((vwidth-1) downto 0);
w32 : in std_logic_vector((vwidth -1) downto 0);
w33 : in std_logic_vector((vwidth -1) downto 0);
DVw : in std_logic;
DVs : out std_logic;
s1 : out std_logic_vector(vwidth -1 downto 0);
s2 : out std_logic_vector(vwidth-1 downto 0);
s3 : out std_logic_vector(vwidth -1 downto 0);
s4 : out std_logic_vector(vwidth -1 downto 0);
s5 : out std_logic_vector(vwidth -1 downto 0);
s6 : out std_logic_vector(vwidth -1 downto 0);
s7 : out std_logic_vector(vwidth -1 downto 0);
s8 : out std_logic_vector(vwidth -1 downto 0);
s9 : out std_logic_vector(vwidth -1 downto 0)
);
end sort_3x3;

architecture sort_3x3 of sort_3x3 is

-- Nivel 1
signal c11_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c11_H: std_logic_vector((vwidth-1) downto 0);   -- Comp Nivel 1
signal c12_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c12_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c13_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c13_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c14_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1
signal c14_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 1  

signal r11: std_logic_vector((vwidth -1) downto 0);


-- Nivel 2
signal c21_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c21_H: std_logic_vector((vwidth-1)  downto 0);  -- Comp Nivel 2
signal c22_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c22_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c23_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c23_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c24_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2
signal c24_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 2  

signal r21: std_logic_vector((vwidth -1) downto 0);

-- Nivel 3
signal c31_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c31_H: std_logic_vector((vwidth-1) downto 0);   -- Comp Nivel 3
signal c32_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c32_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c33_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c33_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c34_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3
signal c34_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 3 

signal r31: std_logic_vector((vwidth -1) downto 0);

-- Nivel 4
signal c41_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 4
signal c41_H: std_logic_vector((vwidth-1) downto 0);   -- Comp Nivel 4
signal c42_L: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 4
signal c42_H: std_logic_vector((vwidth -1) downto 0);  -- Comp Nivel 4

signal r41: std_logic_vector((vwidth -1) downto 0);
signal r42: std_logic_vector((vwidth -1) downto 0);
signal r43: std_logic_vector((vwidth -1) downto 0); 
signal r44: std_logic_vector((vwidth -1) downto 0);
signal r45: std_logic_vector((vwidth -1) downto 0);


-- Nivel 4a
signal c41a_L: std_logic_vector((vwidth -1) downto 0);   -- Comp Nivel 4a
signal c41a_H: std_logic_vector((vwidth-1) downto 0);    -- Comp Nivel 4a
signal c42a_L: std_logic_vector((vwidth -1) downto 0);   -- Comp Nivel 4a
signal c42a_H: std_logic_vector((vwidth -1) downto 0);   -- Comp Nivel 4a
signal c43a_L: std_logic_vector((vwidth -1) downto 0);   -- Comp Nivel 4a
signal c43a_H: std_logic_vector((vwidth -1) downto 0);   -- Comp Nivel 4a

signal r41a: std_logic_vector((vwidth -1) downto 0);
signal r42a: std_logic_vector((vwidth -1) downto 0);
signal r43a: std_logic_vector((vwidth -1) downto 0); 

-- Nivel 4b
signal c41b_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 4b
signal c41b_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 4b
signal c42b_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 4b
signal c42b_H: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 4b

signal r41b: std_logic_vector((vwidth -1) downto 0);
signal r42b: std_logic_vector((vwidth -1) downto 0);
signal r43b: std_logic_vector((vwidth -1) downto 0); 
signal r44b: std_logic_vector((vwidth -1) downto 0);
signal r45b: std_logic_vector((vwidth -1) downto 0);

-- Nivel 5
signal c51_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 5
signal c51_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 5  
signal c52_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 5
signal c52_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 5  

signal r51: std_logic_vector((vwidth -1) downto 0); 
signal r52: std_logic_vector((vwidth -1) downto 0);
signal r53: std_logic_vector((vwidth -1) downto 0); 
signal r54: std_logic_vector((vwidth -1) downto 0);
signal r55: std_logic_vector((vwidth -1) downto 0);  


-- Nivel 6
signal c61_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 6
signal c61_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 6 

signal r61: std_logic_vector((vwidth -1) downto 0); 
signal r62: std_logic_vector((vwidth -1) downto 0);
signal r63: std_logic_vector((vwidth -1) downto 0); 
signal r64: std_logic_vector((vwidth -1) downto 0);
signal r65: std_logic_vector((vwidth -1) downto 0);  
signal r66: std_logic_vector((vwidth -1) downto 0);
signal r67: std_logic_vector((vwidth -1) downto 0); 

-- Nivel 7
signal c71_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 7
signal c71_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 7 
        
signal r71: std_logic_vector((vwidth -1) downto 0); 
signal r72: std_logic_vector((vwidth -1) downto 0);
signal r73: std_logic_vector((vwidth -1) downto 0); 
signal r74: std_logic_vector((vwidth -1) downto 0);
signal r75: std_logic_vector((vwidth -1) downto 0);  
signal r76: std_logic_vector((vwidth -1) downto 0);
signal r77: std_logic_vector((vwidth -1) downto 0); 


-- Nivel 8
signal c81_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 8
signal c81_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 8 

signal r81: std_logic_vector((vwidth -1) downto 0); 
signal r82: std_logic_vector((vwidth -1) downto 0);
signal r83: std_logic_vector((vwidth -1) downto 0); 
signal r84: std_logic_vector((vwidth -1) downto 0);
signal r85: std_logic_vector((vwidth -1) downto 0);  
signal r86: std_logic_vector((vwidth -1) downto 0);
signal r87: std_logic_vector((vwidth -1) downto 0); 


-- Nivel 9
signal c91_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 9
signal c91_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 9 

signal r91: std_logic_vector((vwidth -1) downto 0); 
signal r92: std_logic_vector((vwidth -1) downto 0);
signal r93: std_logic_vector((vwidth -1) downto 0); 
signal r94: std_logic_vector((vwidth -1) downto 0);
signal r95: std_logic_vector((vwidth -1) downto 0);  
signal r96: std_logic_vector((vwidth -1) downto 0);
signal r97: std_logic_vector((vwidth -1) downto 0); 

-- Nivel 10
signal c101_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 10
signal c101_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 10 

signal r101: std_logic_vector((vwidth -1) downto 0); 
signal r102: std_logic_vector((vwidth -1) downto 0);
signal r103: std_logic_vector((vwidth -1) downto 0); 
signal r104: std_logic_vector((vwidth -1) downto 0);
signal r105: std_logic_vector((vwidth -1) downto 0);  
signal r106: std_logic_vector((vwidth -1) downto 0);
signal r107: std_logic_vector((vwidth -1) downto 0); 


-- Nivel 11
signal c111_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 11
signal c111_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 11 

signal r111: std_logic_vector((vwidth -1) downto 0); 
signal r112: std_logic_vector((vwidth -1) downto 0);
signal r113: std_logic_vector((vwidth -1) downto 0); 
signal r114: std_logic_vector((vwidth -1) downto 0);
signal r115: std_logic_vector((vwidth -1) downto 0);  
signal r116: std_logic_vector((vwidth -1) downto 0);
signal r117: std_logic_vector((vwidth -1) downto 0); 

-- Nivel 12
signal c121_L: std_logic_vector((vwidth -1) downto 0); -- Comp Nivel 12
signal c121_H: std_logic_vector((vwidth-1) downto 0);  -- Comp Nivel 12 

signal r121: std_logic_vector((vwidth -1) downto 0); 
signal r122: std_logic_vector((vwidth -1) downto 0);
signal r123: std_logic_vector((vwidth -1) downto 0); 
signal r124: std_logic_vector((vwidth -1) downto 0);
signal r125: std_logic_vector((vwidth -1) downto 0);  
signal r126: std_logic_vector((vwidth -1) downto 0);
signal r127: std_logic_vector((vwidth -1) downto 0); 


-- Nivel 13


signal r131: std_logic_vector((vwidth -1) downto 0); 
signal r132: std_logic_vector((vwidth -1) downto 0);
signal r133: std_logic_vector((vwidth -1) downto 0); 
signal r134: std_logic_vector((vwidth -1) downto 0);
signal r135: std_logic_vector((vwidth -1) downto 0);  
signal r136: std_logic_vector((vwidth -1) downto 0);
signal r137: std_logic_vector((vwidth -1) downto 0); 
signal r138: std_logic_vector((vwidth -1) downto 0);
signal r139: std_logic_vector((vwidth -1) downto 0); 


-- signals for DV coordination
signal dddddddddddddddDV: std_logic:='0';--rst
signal ddddddddddddddDV: std_logic:='0';--rst
signal dddddddddddddDV: std_logic:='0';--este es el original --rst
signal ddddddddddddDV: std_logic:='0';
signal dddddddddddDV: std_logic:='0';
signal ddddddddddDV: std_logic:='0';
signal dddddddddDV: std_logic:='0';
signal ddddddddDV: std_logic:='0';
signal dddddddDV: std_logic:='0';
signal ddddddDV: std_logic:='0';
signal dddddDV: std_logic:='0';
signal ddddDV: std_logic:='0';
signal dddDV: std_logic:='0';
signal ddDV: std_logic:='0';
signal dDV: std_logic:='0';

begin
process(Clk,RSTn)	
begin
if RSTn = '0' then
--Nivel 1
c11_L <= (others=>'0');
c11_H <= (others=>'0');
c12_L <= (others=>'0');
c12_H <= (others=>'0');
c13_L <= (others=>'0');
c13_H <= (others=>'0');
c14_L <= (others=>'0');
c14_H <= (others=>'0');
r11 <= (others=>'0');
		
		
-- Nivel 2
c21_L <= (others=>'0');
c21_H <= (others=>'0');
c22_L <= (others=>'0');
c22_H <= (others=>'0');
c23_L <= (others=>'0');
c23_H <= (others=>'0');
c24_L <= (others=>'0');
c24_H <= (others=>'0');		
r21 <= (others=>'0');

-- Nivel 3
c31_L  <= (others=>'0');
c31_H  <= (others=>'0');
c32_L  <= (others=>'0');
c32_H  <= (others=>'0');
c33_L  <= (others=>'0');
c33_H  <= (others=>'0');
c34_L  <= (others=>'0');
c34_H  <= (others=>'0');		 
r31 <= (others=>'0');
		
-- Nivel 4
c41_L  <= (others=>'0');
c41_H  <= (others=>'0');
c42_L  <= (others=>'0');
c42_H  <= (others=>'0');		
r41 <= (others=>'0');   
r42 <= (others=>'0');
r43 <= (others=>'0');
r44 <= (others=>'0');
r45 <= (others=>'0');
		
-- Nivel 4a
c41a_L <= (others=>'0');
c41a_H <= (others=>'0');
c42a_L <= (others=>'0');
c42a_H <= (others=>'0');
c43a_L <= (others=>'0');
c43a_H <= (others=>'0');
r41a <= (others=>'0');
r42a <= (others=>'0');
r43a <= (others=>'0');
		
-- Nivel 4b
c41b_L <= (others=>'0');
c41b_H <= (others=>'0');
c42b_L <= (others=>'0');
c42b_H <= (others=>'0');
r41b <= (others=>'0');
r42b <= (others=>'0');
r43b <= (others=>'0');
r44b <= (others=>'0');
r45b <= (others=>'0');
		
-- Nivel 5
c51_L <= (others=>'0');
c51_H <= (others=>'0');
c52_L <= (others=>'0');
c52_H <= (others=>'0');		
r51 <= (others=>'0');
r52 <= (others=>'0');
r53 <= (others=>'0');
r54 <= (others=>'0');
r55 <= (others=>'0');
		
		
-- Nivel 6
c61_L <= (others=>'0');
c61_H <= (others=>'0');
r61 <= (others=>'0');
r62 <= (others=>'0');
r63 <= (others=>'0');
r64 <= (others=>'0');
r65 <= (others=>'0');
r66 <= (others=>'0');
r67 <= (others=>'0');
		
-- Nivel 7
c71_L <= (others=>'0');
c71_H <= (others=>'0');			
r71 <= (others=>'0');
r72 <= (others=>'0');
r73 <= (others=>'0');
r74 <= (others=>'0');
r75 <= (others=>'0');
r76 <= (others=>'0');
r77 <= (others=>'0');
		
		
-- Nivel 8
c81_L  <= (others=>'0');
c81_H  <= (others=>'0');
r81  <= (others=>'0');
r82  <= (others=>'0');
r83  <= (others=>'0');
r84  <= (others=>'0');
r85  <= (others=>'0');
r86  <= (others=>'0');
r87  <= (others=>'0');
		
		
-- Nivel 9
c91_L   <= (others=>'0');
c91_H   <= (others=>'0');
r91  <= (others=>'0');
r92  <= (others=>'0');
r93  <= (others=>'0');
r94  <= (others=>'0');
r95  <= (others=>'0');
r96  <= (others=>'0');
r97  <= (others=>'0');       
		
-- Nivel 10
c101_L <= (others=>'0');
c101_H <= (others=>'0');
r101 <= (others=>'0');
r102 <= (others=>'0');
r103 <= (others=>'0');
r104 <= (others=>'0');
r105 <= (others=>'0');
r106 <= (others=>'0');
r107 <= (others=>'0');
		
		
-- Nivel 11
c111_L  <= (others=>'0');
c111_H  <= (others=>'0');
r111 <= (others=>'0');
r112 <= (others=>'0');
r113 <= (others=>'0');
r114 <= (others=>'0');
r115 <= (others=>'0');
r116 <= (others=>'0');
r117 <= (others=>'0');
		
-- Nivel 12
c121_L   <= (others=>'0');
c121_H   <= (others=>'0');
r121 <= (others=>'0');
r122 <= (others=>'0');
r123 <= (others=>'0');
r124 <= (others=>'0');
r125 <= (others=>'0');
r126 <= (others=>'0');
r127 <= (others=>'0');		 
		 
s1 <= (others=>'0');
s2 <= (others=>'0');
s3 <= (others=>'0');
s4 <= (others=>'0');
s5 <= (others=>'0');
s6 <= (others=>'0');
s7 <= (others=>'0');
s8 <= (others=>'0');
s9 <= (others=>'0');

		 ddddddddddddDV <= '0';
		 dddddddddddDV <= '0';
		 ddddddddddDV <= '0';
		 dddddddddDV <= '0';
		 ddddddddDV <= '0';
		 dddddddDV <= '0';
		 ddddddDV <= '0';
		 dddddDV <= '0';
		 ddddDV <= '0';
		 dddDV <= '0';
		 ddDV <= '0';
		 dDV <= '0';
		 DVs <= '0';
		 
elsif rising_edge(Clk) then
if DVw = '1' then
		
		-- level 1  
		
			if w11 < w12 then     
			c11_L <= w11;         
			c11_H <= w12;         
			else                  
			c11_L <= w12;         
			c11_H <= w11;         
			end if;
			
			if w13 < w21 then     
			c12_L <= w13;                              
			c12_H <= w21;         
			else                  
			c12_L <= w21;         
			c12_H <= w13;         
			end if;               
			
			if w22 < w23 then     
			c13_L <= w22;         
			c13_H <= w23;         
			else                  
			c13_L <= w23;         
			c13_H <= w22;         
			end if;               
			
			if w31 < w32 then     
			c14_L <= w31;         
			c14_H <= w32;         
			else                  
			c14_L <= w32;         
			c14_H <= w31;         
			end if;               
			
			r11 <= w33;
			
		-- level 2	
		        
			if c11_L < c12_L then
			c21_L <= c11_L;
			c21_H <= c12_L;
			else
			c21_L <= c12_L;
			c21_H <= c11_L;
			end if;
		
			if c11_H < c12_H then
			c22_L <= c11_H;
			c22_H <= c12_H;
			else
			c22_L <= c12_H;
			c22_H <= c11_H;
			end if;

			if c13_L < c14_L then
			c23_L <= c13_L;
			c23_H <= c14_L;
			else
			c23_L <= c14_L;
			c23_H <= c13_L;
			end if;	
			
			if c13_H < c14_H then
			c24_L <= c13_H;
			c24_H <= c14_H;
			else
			c24_L <= c14_H;
			c24_H <= c13_H;
			end if;	
			
			r21 <= r11;
			
		-- level 3
		
			if c21_L < c23_L then
			c31_L <= c21_L;
			c31_H <= c23_L;
			else
			c31_L <= c23_L;
			c31_H <= c21_L;
			end if;
			
			if c21_H < c22_L then
			c32_L <= c21_H;
			c32_H <= c22_L;
			else
			c32_L <= c22_L;
			c32_H <= c21_H;
			end if;	
			
			if c23_H < c24_L then
			c33_L <= c23_H;
			c33_H <= c24_L;
			else
			c33_L <= c24_L;
			c33_H <= c23_H;
			end if;
			
			if c22_H < c24_H then
			c34_L <= c22_H;
			c34_H <= c24_H;
			else
			c34_L <= c24_H;
			c34_H <= c22_H;
			end if;
			
			r31 <= r21;			
			
		-- level 4 
		
			if c32_L < c33_L then   
			c41_L <= c32_L;         
			c41_H <= c33_L;         
			else                      
			c41_L <= c33_L;         
			c41_H <= c32_L;         
			end if;	
			
			if c32_H < c33_H then    
			c42_L <= c32_H;          
			c42_H <= c33_H;          
			else                     
			c42_L <= c33_H;          
			c42_H <= c32_H;          
			end if;   			
			
			 r41 <= r31;
			 r42 <= c31_L;
			 r43 <= c31_H;
			 r44 <= c34_L;
			 r45 <= c34_H;
			 
		-- Nivel 4a
		
			if r43 < c41_L then 
			c41a_L <= r43;       
			c41a_H <= c41_L;       
			else                    
			c41a_L <= c41_L;        
			c41a_H <= r43;       
			end if; 
			
			if c41_H < c42_L then 
			c42a_L <= c41_H;       
			c42a_H <= c42_L;       
			else                    
			c42a_L <= c42_L;        
			c42a_H <= c41_H;       
			end if;  
			
			if c42_H < r44 then 
			c43a_L <= c42_H;       
			c43a_H <= r44;       
			else                    
			c43a_L <= r44;        
			c43a_H <= c42_H;       
			end if;
			
			 r41a <= r41;
			 r42a <= r42; 
			 r43a <= r45;
			 
		-- Nivel 4b
		
			if c41a_H < c42a_L then     -- Nivel 4b
			c41b_L <= c41a_H;           -- Nivel 4b
			c41b_H <= c42a_L;           -- Nivel 4b
			else                        -- Nivel 4b
			c41b_L <= c42a_L;           -- Nivel 4b
			c41b_H <= c41a_H;           -- Nivel 4b
			end if;                     -- Nivel 4b
			                            -- Nivel 4b
			if c42a_H < c43a_L then     -- Nivel 4b
			c42b_L <= c42a_H;           -- Nivel 4b
			c42b_H <= c43a_L;           -- Nivel 4b
			else                        -- Nivel 4b
			c42b_L <= c43a_L;           -- Nivel 4b
			c42b_H <= c42a_H;           -- Nivel 4b
			end if;                     -- Nivel 4b
			                            -- Nivel 4b
			r41b <= r41a;               -- Nivel 4b
			r42b <= r42a;               -- Nivel 4b
			r43b <= c41a_L;             -- Nivel 4b
			r44b <= c43a_H;             -- Nivel 4b
			r45b <= r43a;               -- Nivel 4b
		
		-- Nivel 5
		
			if r41b < r42b then        -- Nivel 5
			c51_L <= r41b;		-- Nivel 5;			
			c51_H <= r42b;             -- Nivel 5
			else                       -- Nivel 5
			c51_L <= r42b;             -- Nivel 5
			c51_H <= r41b;             -- Nivel 5
			end if;                    -- Nivel 5
			                           -- Nivel 5
			if c41b_H < c42b_L then    -- Nivel 5
			c52_L <= c41b_H;	   -- Nivel 5	
			c52_H <= c42b_L;           -- Nivel 5
			else                       -- Nivel 5
			c52_L <= c42b_L;           -- Nivel 5
			c52_H <= c41b_H;           -- Nivel 5
			end if;                    -- Nivel 5
			                           -- Nivel 5
			r51 <= 	r43b;              -- Nivel 5
			r52 <= 	c41b_L;            -- Nivel 5
			r53 <= 	c42b_H;            -- Nivel 5
			r54 <= 	r44b;              -- Nivel 5
			r55 <= 	r45b;              -- Nivel 5
			
		-- Nivel 6
		
			if r51 < c51_H then
			c61_L <= r51;
			c61_H <= c51_H;
			else
			c61_L <= c51_H;
			c61_H <= r51;
			end if;
			
			r61 <=  c51_L;
			r62 <=	r52;
			r63 <=  c52_L;
			r64 <=  c52_H;
			r65 <=  r53;
			r66 <=  r54;
			r67 <=  r55; 
			
		-- level 7
			if r62 < c61_H then
			c71_L <= r62;
			c71_H <= c61_H;
			else
			c71_L <= c61_H;
			c71_H <= r62;
			end if;
			
			r71 <= r61; 
			r72 <= c61_L;
			r73 <= r63;
			r74 <= r64;
			r75 <= r65;
			r76 <= r66;
			r77 <= r67;

		-- level 8
			if r73 < c71_H then
			c81_L <= r73;
			c81_H <= c71_H;
			else
			c81_L <= c71_H;
			c81_H <= r73;
			end if;
			             
			r81 <= r71; 
			r82 <= r72; 
			r83 <= c71_L;
			r84 <= r74;
			r85 <= r75;
			r86 <= r76;
			r87 <= r77;
			
		-- level 9
			if r84 < c81_H then
			c91_L <= r84;		
			c91_H <= c81_H;
			else
			c91_L <= c81_H;
			c91_H <= r84;
			end if;
			
			r91 <= r81; -- L
			r92 <= r82; -- 2L
			r93 <= r83; -- 3L
			r94 <= c81_L; -- 4L
			r95 <= r85;
			r96 <= r86;
			r97 <= r87;
			
		-- level 10
			if r95 < c91_H then
			c101_L <= r95;
			c101_H <= c91_H;
			else
			c101_L <= c91_H;
			c101_H <= r95;
			end if;
			
			r101 <= r91; -- L
			r102 <= r92; -- 2L
			r103 <= r93; -- 3L
			r104 <= r94; -- 4L
			r105 <= c91_L; -- M
			r106 <= r96;
			r107 <= r97;
			
		-- level 11
			if r106 < c101_H then
			c111_L <= r106;
			c111_H <= c101_H;
			else
			c111_L <= c101_H;
			c111_H <= r106;
			end if;
			
			r111 <= r101; 
			r112 <= r102; 
			r113 <= r103; 
			r114 <= r104; 
			r115 <= r105; 
			r116 <= c101_L; 
			r117 <= r107;
		-- level 12
			if r117 < c111_H then
			c121_L <= r117; 
			c121_H <= c111_H; 
			else
			c121_L <= c111_H; 
			c121_H <= r117; 
			end if;
			
		
			
			 r121 <= r111; 
			 r122 <= r112; 
			 r123 <= r113; 
			 r124 <= r114; 
			 r125 <= r115; 
			 r126 <= r116; 
			 r127 <= c111_L; 
						
			 s1 <= r121;            
			 s2 <= r122;            
			 s3 <= r123;            
			 s4 <= r124;            
			 s5 <= r125;            
			 s6 <= r126;            
			 s7 <= r127;            
			 s8 <= c121_L;
			 s9 <= c121_H;
			 

			--ddddddddddddddDV <= dddddddddddddddDV;
			dddddddddddddDV <= ddddddddddddddDV; 
			ddddddddddddDV <= dddddddddddddDV;
			dddddddddddDV <= ddddddddddddDV;
			ddddddddddDV <= dddddddddddDV;
			dddddddddDV <= ddddddddddDV;
			ddddddddDV <= dddddddddDV;
			dddddddDV <= ddddddddDV;
			ddddddDV <= dddddddDV;
			dddddDV <= ddddddDV;
			ddddDV <= dddddDV;
			dddDV <= ddddDV;
			ddDV <= dddDV;
			dDV <= ddDV;
			DVs <= dDV;

	end if;
	
		if DVw = '1' then
			ddddddddddddddDV <= '1';
		end if;
	end if;
	end process;
	end sort_3x3;
