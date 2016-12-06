--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : 2bytes.vhw
-- /___/   /\     Timestamp : Fri Jul 11 07:10:20 2008
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: loopback2bytes_tb_0
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY loopback2bytes_tb_0 IS
END loopback2bytes_tb_0;

ARCHITECTURE testbench_arch OF loopback2bytes_tb_0 IS
    COMPONENT tope_rof512_uart
        PORT (
            tx_female : Out std_logic;
            LED : Out std_logic_vector (7 DownTo 0);
            rx_female : In std_logic;
            RSTn : In std_logic;
            clk : In std_logic
        );
    END COMPONENT;

    SIGNAL tx_female : std_logic := '0';
    SIGNAL LED : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL rx_female : std_logic := '0';
    SIGNAL RSTn : std_logic := '0';
    SIGNAL clk : std_logic := '0';

    constant PERIOD : time := 20 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : tope_rof512_uart
        PORT MAP (
            tx_female => tx_female,
            LED => LED,
            rx_female => rx_female,
            RSTn => RSTn,
            clk => clk
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                rx_female <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  10010ns
                WAIT FOR 9910 ns;
                rx_female <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  18690ns
                WAIT FOR 8680 ns;
                rx_female <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  62090ns
                WAIT FOR 43400 ns;
                rx_female <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  88130ns
                WAIT FOR 26040 ns;
                rx_female <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  96810ns
                WAIT FOR 8680 ns;
                rx_female <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  105490ns
                WAIT FOR 8680 ns;
                rx_female <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  122850ns
                WAIT FOR 17360 ns;
                rx_female <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  174930ns
                WAIT FOR 52080 ns;
                rx_female <= '1';
                -- -------------------------------------
                WAIT FOR 25090 ns;

            END PROCESS;

    END testbench_arch;

