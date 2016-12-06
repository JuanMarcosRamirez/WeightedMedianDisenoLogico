--------------------------------------------------------------------------
-- filename: rc_counter.vhd-- author: Tony Nelson-- date: 12/22/99---- detail: row/column counter---- limits: none------------------------------------------- --------------------------------
library IEEE;use IEEE.std_logic_1164.all;
entity rc_counter is
generic (
num_cols: integer:=16;
num_rows: integer:=16
);
port (
Clk : in std_logic;
RSTn : in std_logic;
En : in std_logic;
ColPos : out integer;
RowPos : out integer
);
end rc_counter;
architecture rc_counter of rc_counter is
begin
process(RSTn,Clk,En)
variable ColPos_var: integer:=0;
variable RowPos_var: integer:=0;
begin
if RSTn = '0' then
ColPos_var := -1;
ColPos <= 0;
RowPos_var := 0;
RowPos <= 0;
elsif rising_edge(Clk) then
if En = '1' then
ColPos_var := ColPos_var +1;
if ColPos_var = num_cols then
RowPos_var := RowPos_var +1;
ColPos_var := 0;
if RowPos_var = num_rows then
RowPos_var := 0;
end if;
end if;
ColPos <= ColPos_var;
RowPos <= RowPos_var;
end if;
end if;
end process;
end rc_counter;

