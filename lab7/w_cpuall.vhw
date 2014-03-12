--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : w_cpuall.vhw
-- /___/   /\     Timestamp : Tue Dec 03 08:14:15 2013
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: w_cpuall
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY w_cpuall IS
END w_cpuall;

ARCHITECTURE testbench_arch OF w_cpuall IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT cpuall
        PORT (
            clk : In std_logic;
            reset : In std_logic;
            Dbus : InOut std_logic_vector (15 DownTo 0);
            Abus : Out std_logic_vector (15 DownTo 0);
            nMREQ : Out std_logic;
            nWR : Out std_logic;
            nRD : Out std_logic;
            nBLE : Out std_logic;
            nBHE : Out std_logic;
            Sd : Out std_logic_vector (15 DownTo 0);
            Sa : Out std_logic_vector (15 DownTo 0);
            Sp : Out std_logic_vector (15 DownTo 0);
            Ct : Out std_logic_vector (7 DownTo 0);
            CL : Out std_logic_vector (3 DownTo 0)
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '1';
    SIGNAL Dbus : std_logic_vector (15 DownTo 0) := "ZZZZZZZZZZZZZZZZ";
    SIGNAL Abus : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL nMREQ : std_logic := '0';
    SIGNAL nWR : std_logic := '0';
    SIGNAL nRD : std_logic := '0';
    SIGNAL nBLE : std_logic := '0';
    SIGNAL nBHE : std_logic := '0';
    SIGNAL Sd : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL Sa : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL Sp : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL Ct : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL CL : std_logic_vector (3 DownTo 0) := "0000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : cpuall
        PORT MAP (
            clk => clk,
            reset => reset,
            Dbus => Dbus,
            Abus => Abus,
            nMREQ => nMREQ,
            nWR => nWR,
            nRD => nRD,
            nBLE => nBLE,
            nBHE => nBHE,
            Sd => Sd,
            Sa => Sa,
            Sp => Sp,
            Ct => Ct,
            CL => CL
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
                Dbus <= "0000000000000001";
                -- -------------------------------------
                -- -------------  Current Time:  285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  885ns
                WAIT FOR 600 ns;
                Dbus <= "0000000100000010";
                -- -------------------------------------
                -- -------------  Current Time:  1085ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  1685ns
                WAIT FOR 600 ns;
                Dbus <= "0000011100000011";
                -- -------------------------------------
                -- -------------  Current Time:  1885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  2485ns
                WAIT FOR 600 ns;
                Dbus <= "0000100000000010";
                -- -------------------------------------
                -- -------------  Current Time:  2685ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  3285ns
                WAIT FOR 600 ns;
                Dbus <= "0001001000000010";
                -- -------------------------------------
                -- -------------  Current Time:  3485ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  3685ns
                WAIT FOR 200 ns;
                Dbus <= "0000000000000001";
                -- -------------------------------------
                -- -------------  Current Time:  3885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  4085ns
                WAIT FOR 200 ns;
                Dbus <= "0100011000000001";
                -- -------------------------------------
                -- -------------  Current Time:  4285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  4885ns
                WAIT FOR 600 ns;
                Dbus <= "0001110000000101";
                -- -------------------------------------
                -- -------------  Current Time:  5085ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  5285ns
                WAIT FOR 200 ns;
                Dbus <= "0000000000000110";
                -- -------------------------------------
                -- -------------  Current Time:  5485ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  5685ns
                WAIT FOR 200 ns;
                Dbus <= "1100010100000010";
                -- -------------------------------------
                -- -------------  Current Time:  5885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  6085ns
                WAIT FOR 200 ns;
                Dbus <= "0000000000000111";
                -- -------------------------------------
                -- -------------  Current Time:  6285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  6485ns
                WAIT FOR 200 ns;
                Dbus <= "0100100000000001";
                -- -------------------------------------
                -- -------------  Current Time:  6685ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  7285ns
                WAIT FOR 600 ns;
                Dbus <= "0010000011111101";
                -- -------------------------------------
                -- -------------  Current Time:  7485ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  8085ns
                WAIT FOR 600 ns;
                Dbus <= "0010100100000001";
                -- -------------------------------------
                -- -------------  Current Time:  8285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  8885ns
                WAIT FOR 600 ns;
                Dbus <= "1000100000000101";
                -- -------------------------------------
                -- -------------  Current Time:  9085ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  9685ns
                WAIT FOR 600 ns;
                Dbus <= "0101010000000010";
                -- -------------------------------------
                -- -------------  Current Time:  9885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  10485ns
                WAIT FOR 600 ns;
                Dbus <= "1011100000000000";
                -- -------------------------------------
                -- -------------  Current Time:  10685ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  11285ns
                WAIT FOR 600 ns;
                Dbus <= "1001000000001000";
                -- -------------------------------------
                -- -------------  Current Time:  11485ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  12085ns
                WAIT FOR 600 ns;
                Dbus <= "1111100000000000";
                -- -------------------------------------
                -- -------------  Current Time:  12285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  12885ns
                WAIT FOR 600 ns;
                Dbus <= "0011010000000111";
                -- -------------------------------------
                -- -------------  Current Time:  13085ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  13685ns
                WAIT FOR 600 ns;
                Dbus <= "0101110000000010";
                -- -------------------------------------
                -- -------------  Current Time:  13885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  14485ns
                WAIT FOR 600 ns;
                Dbus <= "0011110000000010";
                -- -------------------------------------
                -- -------------  Current Time:  14685ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  15285ns
                WAIT FOR 600 ns;
                Dbus <= "0110010000000010";
                -- -------------------------------------
                -- -------------  Current Time:  15485ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  16085ns
                WAIT FOR 600 ns;
                Dbus <= "1000000000001001";
                -- -------------------------------------
                -- -------------  Current Time:  16285ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  16885ns
                WAIT FOR 600 ns;
                Dbus <= "1000100000000101";
                -- -------------------------------------
                -- -------------  Current Time:  17085ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  17685ns
                WAIT FOR 600 ns;
                Dbus <= "1001000000001000";
                -- -------------------------------------
                -- -------------  Current Time:  17885ns
                WAIT FOR 200 ns;
                Dbus <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                WAIT FOR 2315 ns;

            END PROCESS;

    END testbench_arch;

