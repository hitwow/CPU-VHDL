--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : w_clkblock.vhw
-- /___/   /\     Timestamp : Mon Nov 18 18:42:04 2013
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: w_clkblock
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY w_clkblock IS
END w_clkblock;

ARCHITECTURE testbench_arch OF w_clkblock IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT clkblock
        PORT (
            clk : In std_logic;
            reset : In std_logic;
            c1 : Out std_logic;
            c2 : Out std_logic;
            c3 : Out std_logic;
            c4 : Out std_logic
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '1';
    SIGNAL c1 : std_logic := '0';
    SIGNAL c2 : std_logic := '0';
    SIGNAL c3 : std_logic := '0';
    SIGNAL c4 : std_logic := '0';

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : clkblock
        PORT MAP (
            clk => clk,
            reset => reset,
            c1 => c1,
            c2 => c2,
            c3 => c3,
            c4 => c4
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
                -- -------------  Current Time:  85ns
                WAIT FOR 85 ns;
                reset <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4885ns
                WAIT FOR 4800 ns;
                reset <= '1';
                -- -------------------------------------
                WAIT FOR 5315 ns;

            END PROCESS;

    END testbench_arch;

