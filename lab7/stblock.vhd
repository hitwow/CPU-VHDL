----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:36 11/20/2013 
-- Design Name: 
-- Module Name:    stblock - Behavioral 
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

entity stblock is
    Port ( c3 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           IR_O : in  STD_LOGIC_VECTOR (15 downto 0);
			  AD_O : in  STD_LOGIC_VECTOR (15 downto 0);
			  aluout : in  STD_LOGIC_VECTOR (7 downto 0);
           DT_I : in  STD_LOGIC_VECTOR (7 downto 0);
			  DT_O : out std_logic_vector (7 downto 0);
           RD_O : out  STD_LOGIC;
           WR_O : out  STD_LOGIC;
           Reg_O : out  STD_LOGIC_VECTOR (7 downto 0);           
			  AD_I : out std_logic_vector (15 downto 0));
end stblock;

architecture Behavioral of stblock is

begin
process (ir_o, c3, reset, DT_I)
variable ctr : std_logic_vector (4 downto 0);
begin
	ctr := IR_O(15 downto 11);
	if reset = '1' then
		DT_O <= "00000000";
		RD_O <= '0';
		WR_O <= '0';
		Reg_O <= "00000000";
		AD_I <= "0000000000000000";
	elsif c3 = '1' then				
		case ctr is
			when "00001" =>
				DT_O <= aluout;
				AD_I <= AD_O;
				WR_O <= '1';
				RD_O <= '0';
			when "00010"|"00011"|"11000" =>
				AD_I <= AD_O;
				RD_O <= '1';
				WR_O <= '0';
				Reg_O <= DT_I;
			when others => NULL;
		end case;
	else
		RD_O <= '0';
		WR_O <= '0';
	end if;
end process;
end Behavioral;

