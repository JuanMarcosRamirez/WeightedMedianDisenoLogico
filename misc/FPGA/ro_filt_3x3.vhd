-------------------------------------------------------------- ------------
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
----------------------------------- ----------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity ro_filt_3x3 is
generic (
vwidth: integer:=8;
order: integer:=5;
num_cols: integer:=512;
num_rows: integer:=512
);
port (
Clk : in std_logic;
RSTn : in std_logic;
D : in std_logic_vector(vwidth-1 downto 0);
Dout : out std_logic_vector(vwidth -1 downto 0);
DV : out std_logic;
FColPos : out integer;
FRowPos : out integer  
);
end ro_filt_3x3;
architecture ro_filt_3x3 of ro_filt_3x3 is
component sort_3x3
generic (
vwidth: integer:=8
);
port (
Clk : in std_logic;
RSTn : in std_logic;
w11 : in std_logic_vector((vwidth -1) downto 0);
w12 : in std_logic_vector((vwidth -1) downto 0);
w13 : in std_logic_vector((vwidth -1) downto 0);
w21 : in std_logic_vector((vwidth-1) downto 0);
w22 : in std_logic_vector((vwidth -1) downto 0);
w23 : in std_logic_vector((vwidth -1) downto 0);
w31 : in std_logic_vector((vwidth -1) downto 0);
w32 : in std_logic_vector((vwidth -1) downto 0);
w33 : in std_logic_vector((vwidth-1) downto 0);
DVw : in std_logic;
DVs : out std_logic;
s1 : out std_logic_vector(vwidth -1 downto 0);
s2 : out std_logic_vector(vwidth -1 downto 0);
s3 : out std_logic_vector(vwidth -1 downto 0);
s4 : out std_logic_vector(vwidth-1 downto 0);
s5 : out std_logic_vector(vwidth -1 downto 0);
s6 : out std_logic_vector(vwidth -1 downto 0);
s7 : out std_logic_vector(vwidth -1 downto 0);
s8 : out std_logic_vector(vwidth -1 downto 0);
s9 : out std_logic_vector(vwidth -1 downto 0)
);
end component sort_3x3;
signal w11: std_logic_vector((vwidth -1) downto 0);
signal w12: std_logic_vector((vwidth -1) downto 0);
signal w13: std_logic_vector((vwidth -1) downto 0);
signal w21: std_logic_vector((vwidth -1) downto 0);
signal w22: std_logic_vector((vwidth-1) downto 0);
signal w23: std_logic_vector((vwidth -1) downto 0);

signal w31: std_logic_vector((vwidth -1) downto 0);
signal w32: std_logic_vector((vwidth -1) downto 0);
signal w33: std_logic_vector((vwidth -1) downto 0);
signal DVw: std_logic;
signal DVs: std_logic;
signal s1: std_logic_vector(vwidth -1 downto 0);
signal s2: std_logic_vector(vwidth -1 downto 0);
signal s3: std_logic_vector(vwidth -1 downto 0);
signal s4: std_logic_vector(vwidth -1 downto 0);
signal s5: std_logic_vector(vwidth-1 downto 0);
signal s6: std_logic_vector(vwidth -1 downto 0);
signal s7: std_logic_vector(vwidth -1 downto 0);
signal s8: std_logic_vector(vwidth -1 downto 0);
signal s9: std_logic_vector(vwidth -1 downto 0);
component window_3x3
generic (
vwidth: integer:=8
);
port (
Clk : in std_logic;
RSTn : in std_logic;
D : in std_logic_vector(vwidth-1 downto 0);
w11 : out std_logic_vector(vwidth -1 downto 0);
w12 : out std_logic_vector(vwidth -1 downto 0);
w13 : out std_logic_vector(vwidth-1 downto 0);
w21 : out std_logic_vector(vwidth -1 downto 0);
w22 : out std_logic_vector(vwidth -1 downto 0);
w23 : out std_logic_vector(vwidth -1 downto 0);
w31 : out std_logic_vector(vwidth -1 downto 0);
w32 : out std_logic_vector(vwidth-1 downto 0);
w33 : out std_logic_vector(vwidth -1 downto 0);
DV : out std_logic:='0'
);
end component window_3x3;
component rc_counter
generic (
num_cols: integer:=512;
num_rows: integer:=512
);
port (
Clk : in std_logic;
RSTn : in std_logic;
En : in std_logic;
ColPos : out integer;
RowPos : out integer
);
end component rc_counter;
signal ColPos: integer:=0;
signal RowPos: integer:=0;
signal ColPos_c: integer:=0; -- corrected positions
signal RowPos_c: integer:=0;
signal rt1: integer:=0;
signal rt2: integer:=0;
signal rt3: integer:=0;
signal rt4: integer:=0;
signal rt5: integer:=0;
signal rt6: integer:=0;
signal rt7: integer:=0;
signal rt8: integer:=0;
signal rt9: integer:=0;
signal rt10: integer:=0;
signal rt11: integer:=0;
signal rt12: integer:=0;
signal rt13: integer:=0;
signal rt14: integer:=0;
signal rt15: integer:=0;
signal rt16: integer:=0;

signal flag: std_logic:='0';
begin
sort_3x3x: sort_3x3
generic map (
vwidth => 8
)
port map (
Clk => Clk,
RSTn => RSTn,
w11 => w11,
w12 => w12,
w13 => w13,
w21 => w21,
w22 => w22,
w23 => w23,
w31 => w31,
w32 => w32,
w33 => w33,
DVw => DVw,
DVs => DVs,
s1 => s1,
s2 => s2,
s3 => s3,
s4 => s4,
s5 => s5,
s6 => s6,
s7 => s7,
s8 => s8,
s9 => s9
);
window_3x3x: window_3x3
generic map (
vwidth => 8
)
port map (
Clk => Clk,
RSTn => RSTn,
D => D,
w11 => w11,
w12 => w12,
w13 => w13,
w21 => w21,
w22 => w22,
w23 => w23,
w31 => w31,
w32 => w32,
w33 => w33,
DV => DVw
);
rc_counterx: rc_counter
generic map (
num_cols => 512,
num_rows => 512
)
port map (
Clk => Clk,
RSTn => RSTn,
En => RSTn,
ColPos => ColPos,
RowPos => RowPos
);

FColPos <= ColPos;
FRowPos <= RowPos;

ro_filt_proc: process(RSTn,Clk)
begin
if RSTn = '0' then
ColPos_c <= 0;

rt1 <= 0;
rt2 <= 0;
rt3 <= 0;
rt4 <= 0;
rt5 <= 0;
rt6 <= 0;
rt7 <= 0;
rt8 <= 0;
rt9 <= 0;
rt10 <= 0;
rt11 <= 0;
rt12 <= 0;
rt13 <= 0;
rt14 <= 0;
rt15 <= 0;
rt16 <= 0;
RowPos_c <= 0;
Dout <= (others=>'0');
DV <= '0';
flag <= '0';
elsif rising_edge(Clk) then
-- counter correction
ColPos_c <= ((ColPos-17) mod 512);
rt1 <= ((RowPos-1) mod 512);
rt2 <= rt1;
rt3 <= rt2;
rt4 <= rt3;
rt5 <= rt4;
rt6 <= rt5;
rt7 <= rt6;
rt8 <= rt7;
rt9 <= rt8;
rt10 <= rt9;
rt11 <= rt10;
rt12 <= rt11;
rt13 <= rt12;
rt14 <= rt13;
rt15 <= rt14;
rt16 <= rt15;
RowPos_c <= rt16;
-- screen edge detection
if (ColPos_c = num_cols-1) or (RowPos_c = num_rows-1) or (ColPos_c
= num_cols-2) or (RowPos_c = 0) then
Dout <= (others=>'0');
else
if order = 1 then
Dout <= s1;
elsif order = 2 then
Dout <= s2;
elsif order = 3 then
Dout <= s3;
elsif order = 4 then
Dout <= s4;
elsif order = 5 then
Dout <= s5;
elsif order = 6 then
Dout <= s6;
elsif order = 7 then
Dout <= s7;
elsif order = 8 then
Dout <= s8;
elsif order = 9 then
Dout <= s9;
end if;
end if;
if ColPos >= 17 and RowPos >= 1 then
DV <= '1';
flag <= '1';
elsif flag = '1' then

DV <= '1';
else
DV <= '0';
end if;
end if;
end process;
end ro_filt_3x3;