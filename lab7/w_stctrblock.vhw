--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : w_stctrblock.vhw
-- /___/   /\     Timestamp : Sun Dec 01 21:54:16 2013
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: w_stctrblock
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY w_stctrblock IS
END w_stctrblock;

ARCHITECTURE testbench_arch OF w_stctrblock IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT stctrblock
        PORT (
            RD_O : In std_logic;
            WR_O : In std_logic;
            PC_O : In std_logic_vector (15 DownTo 0);
            IR_R : In std_logic;
            AD_O : In std_logic_vector (15 DownTo 0);
            DT_O : In std_logic_vector (7 DownTo 0);
            DT_I : Out std_logic_vector (7 DownTo 0);
            nRD : Out std_logic;
            nWR : Out std_logic;
            ABUS : Out std_logic_vector (15 DownTo 0);
            DBUS : InOut std_logic_vector (15 DownTo 0);
            IR_I : Out std_logic_vector (15 DownTo 0);
            nBHE : Out std_logic;
            nBLE : Out std_logic;
            nMERQ : Out std_logic
        );
    END COMPONENT;

    SIGNAL RD_O : std_logic := '0';
    SIGNAL WR_O : std_logic := '0';
    SIGNAL PC_O : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL IR_R : std_logic := '0';
    SIGNAL AD_O : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL DT_O : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL DT_I : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL nRD : std_logic := '0';
    SIGNAL nWR : std_logic := '0';
    SIGNAL ABUS : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL DBUS : std_logic_vector (15 DownTo 0) := "ZZZZZZZZZZZZZZZZ";
    SIGNAL IR_I : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL nBHE : std_logic := '0';
    SIGNAL nBLE : std_logic := '0';
    SIGNAL nMERQ : std_logic := '0';

    BEGIN
        UUT : stctrblock
        PORT MAP (
            RD_O => RD_O,
            WR_O => WR_O,
            PC_O => PC_O,
            IR_R => IR_R,
            AD_O => AD_O,
            DT_O => DT_O,
            DT_I => DT_I,
            nRD => nRD,
            nWR => nWR,
            ABUS => ABUS,
            DBUS => DBUS,
            IR_I => IR_I,
            nBHE => nBHE,
            nBLE => nBLE,
            nMERQ => nMERQ
        );

        PROCESS
            BEGIN
                -- -------------  Current Time:  400ns
                WAIT FOR 400 ns;
                IR_R <= '1';
                DBUS <= "0000000000000010";
                PC_O <= "0000000000000001";
                -- -------------------------------------
                -- -------------  Current Time:  700ns
                WAIT FOR 300 ns;
                IR_R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1200ns
                WAIT FOR 500 ns;
                RD_O <= '1';
                AD_O <= "0000000000000011";
                DBUS <= "0000010000000101";
                -- -------------------------------------
                -- -------------  Current Time:  1500ns
                WAIT FOR 300 ns;
                RD_O <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1800ns
                WAIT FOR 300 ns;
                DBUS <= "ZZZZZZZZZZZZZZZZ";
                -- -------------------------------------
                -- -------------  Current Time:  2200ns
                WAIT FOR 400 ns;
                WR_O <= '1';
                AD_O <= "0000000000000110";
                DT_O <= "00000111";
                -- -------------------------------------
                -- -------------  Current Time:  2600ns
                WAIT FOR 400 ns;
                WR_O <= '0';
                WAIT FOR 7400 ns;

            END PROCESS;

    END testbench_arch;

