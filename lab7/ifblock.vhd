----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:46:41 11/16/2013 
-- Design Name: 
-- Module Name:    ifblock - Behavioral 
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

entity ifblock is
    Port ( c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           PC_O : out  STD_LOGIC_VECTOR (15 downto 0);
           IR_I : in  STD_LOGIC_VECTOR (15 downto 0);
           IR_O : out  STD_LOGIC_VECTOR (15 downto 0);
           PC_C : in  STD_LOGIC;
           PC_I : in  STD_LOGIC_VECTOR (15 downto 0);
           IR_R : out  STD_LOGIC;
           reset : in  STD_LOGIC);
end ifblock;

architecture Behavioral of ifblock is
signal PC_T : std_logic_vector (15 downto 0);
begin
	process (reset, c1, c2, PC_C, IR_I)
	begin
		if reset='1' then
			PC_T <= "0000000000000000";
			IR_O <= "0000000000000000";
			IR_R <= '0';
		elsif c1='1' then
			IR_R <= '1';
			IR_O <= IR_I;
		else
			IR_R <= '0';
			if c2='0' and c2'event then
				PC_T <= PC_T+1;
			end if;
			if PC_C = '1' then
				PC_T <= PC_I;
			end if;
		end if;
	end process;
	PC_O <= PC_T;
end Behavioral;

