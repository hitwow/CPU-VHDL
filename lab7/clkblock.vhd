----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:09:32 11/16/2013 
-- Design Name: 
-- Module Name:    clkblock - Behavioral 
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

entity clkblock is
	port(clk : in std_logic;
		reset : in std_logic;
		c1		: out std_logic;
		c2		: out std_logic;
		c3		: out std_logic;
		c4		: out std_logic);
end clkblock;

architecture Behavioral of clkblock is
signal t : std_logic_vector(3 downto 0);
begin
	process (reset, clk)
		begin
		if reset = '1' then
			t <= "0000";
		else
			if clk'event and clk='1' then
				case t is
					when "0000" => t <= "0001";
					when "0001" => t <= "0010";
					when "0010" => t <= "0100";
					when "0100" => t <= "1000";
					when "1000" => t <= "0001";
					when others => t <= "0000";
				end case;
			end if;
		end if;		
	end process;
	c1 <= t(0);
	c2 <= t(1);
	c3 <= t(2);
	c4 <= t(3);
end Behavioral;

