----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:59:44 11/18/2013 
-- Design Name: 
-- Module Name:    alublock - Behavioral 
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

entity alublock is
    Port ( c2 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           IR_O : in  STD_LOGIC_VECTOR (15 downto 0);
			  AD_O : out std_logic_vector (15 downto 0);
			  PC_O : in std_logic_vector (15 downto 0);
           aluout : out  STD_LOGIC_VECTOR (7 downto 0);
			  Reg_C : in  STD_LOGIC;
           Reg_N : in  STD_LOGIC_VECTOR (2 downto 0);
           Reg_I : in  STD_LOGIC_VECTOR (7 downto 0);
			  Z : out std_logic;
           Cy : out  STD_LOGIC);			  		  
end alublock;

architecture Behavioral of alublock is
type reg IS array(0 to 7) of std_logic_vector(7 downto 0); 
signal R : reg;
signal tc, tz : std_logic;
shared variable aluv : std_logic_vector (8 downto 0);
begin
	process (ir_o, reset, c2, Reg_C)
	
	variable ctr : std_logic_vector (4 downto 0);
	variable r1, r2, x : std_logic_vector (8 downto 0);
	begin
		ctr := IR_O(15 downto 11);
		r1 := '0'&R(conv_integer(IR_O(10 downto 8)));
		r2 := '0'&R(conv_integer(IR_O(2 downto 0)));
		x := '0'&IR_O(7 downto 0);
		if reset='1' then
			tz <= '0';
			tc <= '0';
			aluv := "000000000";
			R(0) <= "00000000";
			R(1) <= "00000000";
			R(2) <= "00000000";
			R(3) <= "00000000";
			R(4) <= "00000000";
			R(5) <= "00000000";
			R(6) <= "00000000";
			R(7) <= "00000000";
			AD_O <= "0000000000000000";
		elsif Reg_C = '1' then
			R(conv_integer(IR_O(10 downto 8))) <= Reg_I;
		elsif c2 = '1' and c2'event then
			AD_O(15 downto 8) <= R(7);
			case ctr is
					when "11111" =>
						tc <= '0';
					when "10111" =>
						tc <= '1';
					when "00000" =>
						aluv := x;
					when "01000" =>
						aluv := r2;
					when "00100" =>
						tz <= '0';
						aluv := r1 + x + tc;						
						tc <= aluv(8);
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "01001" =>
						tz <= '0';
						aluv := r1 + r2 + tc;
						tc <= aluv(8);
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "00101" =>
						tz <= '0';
						aluv := r1 - x - tc;
						tc <= aluv(8);
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "01010" =>
						tz <= '0';
						aluv := r1 - r2 - tc;
						tc <= aluv(8);
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "00110" =>
						tz <= '0';
						aluv := r1 and x;
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "01011" =>
						tz <= '0';
						aluv := r1 and r2;
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "00111" =>
						tz <= '0';
						aluv := r1 or x;
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "01100" =>
						tz <= '0';
						aluv := r1 or r2;
						if aluv(7 downto 0)="00000000" then
							tz <= '1';
						end if;
					when "00001" =>
					AD_O(15 downto 8) <= R(7);
					   AD_O(7 downto 0) <=x(7 downto 0);
						aluv := r1;
					when "00010" =>
						AD_O(7 downto 0) <= x(7 downto 0);
					when "00011" =>
						AD_O(7 downto 0) <= (R(6)+x(7 downto 0));
					when "10000" =>
						AD_O(7 downto 0) <= x(7 downto 0);
					when "11000" =>
						AD_O(7 downto 0) <=r2(7 downto 0);
					when "10001" =>
						if tz = '1' then
							if (IR_O(7) = '0') then
								AD_O <= PC_O + ("00000000"&x(7 downto 0))+1;
							else
								AD_O <= PC_O - ("00000000"&x(7 downto 0))+1;
							end if;
						end if;
					when "10010" =>
						if tc = '1' then
							if (IR_O(7) = '0') then					
								AD_O <= PC_O + ("00000000"&x(7 downto 0))+1;
							else
								AD_O <= PC_O - ("00000000"&x(7 downto 0))+1;
							end if;
						end if;
					when others => NULL;
			end case;			
		end if;
		aluout <= aluv(7 downto 0);
	end process;	
	Z <= tz;
	Cy <= tc;
end Behavioral;