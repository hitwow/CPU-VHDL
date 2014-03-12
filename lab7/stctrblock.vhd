----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:41:53 11/23/2013 
-- Design Name: 
-- Module Name:    stctrblock - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stctrblock is
    Port ( RD_O : in  STD_LOGIC;
           WR_O : in  STD_LOGIC;
           PC_O : in  STD_LOGIC_VECTOR (15 downto 0);
			  IR_R : in  std_logic;
           AD_O : in  STD_LOGIC_VECTOR (15 downto 0);
           DT_O : in  STD_LOGIC_VECTOR (7 downto 0);
           DT_I : out  STD_LOGIC_VECTOR (7 downto 0);
           nRD : out  STD_LOGIC;
           nWR : out  STD_LOGIC;
           ABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           DBUS : inout  STD_LOGIC_VECTOR (15 downto 0);
           IR_I : out  STD_LOGIC_VECTOR (15 downto 0);
           nBHE : out  STD_LOGIC;
           nBLE : out  STD_LOGIC;
           nMERQ : out  STD_LOGIC);
end stctrblock;

architecture Behavioral of stctrblock is
begin
	process (RD_O, WR_O, IR_R)
	begin
		if (IR_R = '1') then
			nRD <= '0';
			nWR <= '1';
			nBHE <= '0';
			nBLE <= '0';
			nMERQ <= '0';
			ABUS <= PC_O;
			IR_I <= DBUS;
			DBUS <= "ZZZZZZZZZZZZZZZZ";
		elsif (RD_O = '1') then
			nRD <= '0';
			nWR <= '1';
			nBHE <= '0';
			nBLE <= '0';
			nMERQ <= '0';
			ABUS <= AD_O;
			DT_I <= DBUS(7 downto 0);
			DBUS <= "ZZZZZZZZZZZZZZZZ";
		elsif (WR_O = '1') then
			nRD <= '1';
			nWR <= '0';
			nBHE <= '0';
			nBLE <= '0';
			nMERQ <= '0';
			ABUS <= AD_O;
			DBUS <= "00000000"&DT_O;
		else
			nRD <= '1';
			nWR <= '1';
			nBHE <= '1';
			nBLE <= '1';
			nMERQ <= '1';
			ABUS <= "0000000000000000";
			IR_I <= "0000000000000000";
			DBUS <= "ZZZZZZZZZZZZZZZZ";
			DT_I <= "00000000";
		end if;
	end process;
end Behavioral;

