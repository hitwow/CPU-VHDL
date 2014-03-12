----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:28:35 11/23/2013 
-- Design Name: 
-- Module Name:    rewblock - Behavioral 
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

entity rewblock is
    Port ( c4 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           IR_O : in  STD_LOGIC_VECTOR (15 downto 0);
           aluout : in  STD_LOGIC_VECTOR (7 downto 0);
           Reg_O : in  STD_LOGIC_VECTOR (7 downto 0);
           AD_O : in  STD_LOGIC_VECTOR (15 downto 0);
			  Z : in std_logic;
			  Cy : in std_logic;
           Reg_N : out  STD_LOGIC_VECTOR (2 downto 0);
           Reg_C : out  STD_LOGIC;
           Reg_I : out  STD_LOGIC_VECTOR (7 downto 0);
           PC_C : out  STD_LOGIC;
           PC_I : out  STD_LOGIC_VECTOR (15 downto 0));
end rewblock;

architecture Behavioral of rewblock is
begin
	process(ir_o, c4, reset)
	variable ctr : std_logic_vector (4 downto 0);
	begin
		if reset = '1' then
			Reg_N <= "000";
			Reg_C <= '0';
			Reg_I <= "00000000";
			PC_C <= '0';
			PC_I <= "0000000000000000";
		elsif c4 = '1' then
			ctr := IR_O(15 downto 11);
			case ctr is
				when "00000"|"01000"|"00100"|"01001"|"01010"|"00110"|"01011"|"00111"|"01100"|"00101" =>
					Reg_N <= IR_O(10 downto 8);
					Reg_C <= '1';
					Reg_I <= aluout;
				when "00010"|"00011"|"11000" =>
					Reg_N <= IR_O(10 downto 8);
					Reg_C <= '1';
					Reg_I <= Reg_O;
				when "10000" =>
					PC_C <= '1';
					PC_I <= AD_O;
				when "10001" =>
					if Z = '1' then
						PC_C <= '1';
						PC_I <= AD_O;
					end if;
				when "10010" =>
					if Cy = '1' then
						PC_C <= '1';
						PC_I <= AD_O;
					end if;
				when others => NULL;
			end case;
		else
			PC_C <= '0';
			Reg_C <= '0';
		end if;
	end process;
end Behavioral;

