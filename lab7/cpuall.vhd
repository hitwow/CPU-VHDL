----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:09:34 11/27/2013 
-- Design Name: 
-- Module Name:    cpuall - Behavioral 
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

entity cpuall is
port(clk: in std_logic;
	  reset: in std_logic;
	  Dbus: inout std_logic_vector(15 downto 0);
	  Abus: out std_logic_vector(15 downto 0);
	  nMREQ: out std_logic;
	  nWR: out std_logic;
	  nRD: out std_logic;
	  nBLE,nBHE: out std_logic;
	  Sd : out std_logic_vector(15 downto 0);
	  Sa : out std_logic_vector(15 downto 0);
	  Sp : out std_logic_vector(15 downto 0);
	  Ct : out std_logic_vector(7 downto 0);
	  CL : out std_logic_vector(3 downto 0));
end cpuall;

architecture Behavioral of cpuall is
component clkblock is
	port(clk : in std_logic;
		reset : in std_logic;
		c1		: out std_logic;
		c2		: out std_logic;
		c3		: out std_logic;
		c4		: out std_logic);
end component;

component ifblock is
    Port ( c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           PC_O : out  STD_LOGIC_VECTOR (15 downto 0);
           IR_I : in  STD_LOGIC_VECTOR (15 downto 0);
           IR_O : out  STD_LOGIC_VECTOR (15 downto 0);
           PC_C : in  STD_LOGIC;
           PC_I : in  STD_LOGIC_VECTOR (15 downto 0);
           IR_R : out  STD_LOGIC;
           reset : in  STD_LOGIC);
end component;

component alublock is
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
end component;

component stblock is
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
end component;

component rewblock is
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
end component;

component stctrblock is
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
end component;

signal c1, c2, c3, c4 : std_logic;
signal n_BLE, n_BHE, n_MREQ, n_RD, n_WR : std_logic;
signal pc_i, pc_o : std_logic_vector(15 downto 0);
signal ir_i, ir_o : std_logic_vector(15 downto 0);
signal pc_c, r_c : std_logic;
signal ir_r : std_logic;
signal z, c : std_logic;
signal ad_o, ad_i : std_logic_vector(15 downto 0);
signal aluout : std_logic_vector(7 downto 0);
signal r_n : std_logic_vector(2 downto 0);
signal r_i, r_o : std_logic_vector(7 downto 0);
signal dt_i, dt_o : std_logic_vector(7 downto 0);
signal rd_o, wr_o : std_logic;
signal a_bus : std_logic_vector(15 downto 0);

begin
	U0 : clkblock port map (clk, reset, c1, c2, c3, c4);
	U1 : ifblock port map (c1, c2, pc_o, ir_i, ir_o, pc_c, pc_i, ir_r, reset);
	U2 : alublock port map (c2, reset, ir_o, ad_o, pc_o, aluout, r_c, r_n, r_i, z, c);
	U3 : stblock port map (c3, reset, ir_o, ad_o, aluout, dt_i, dt_o, rd_o, wr_o, r_o, ad_i);
	U4 : rewblock port map (c4, reset, ir_o, aluout, r_o, ad_o, z, c, r_n, r_c, r_i, pc_c, pc_i);
	U5 : stctrblock port map (rd_o, wr_o, pc_o, ir_r, ad_o, dt_o, dt_i, n_RD, n_WR, a_bus, Dbus, ir_i, n_BHE, n_BLE, n_MREQ);
	
	Abus <= a_bus;
	nBHE <= n_BHE;
	nBLE <= n_BLE;
	nMREQ <= n_MREQ;
	nRD <= n_RD;
	nWR <= n_WR;
	
	Sd <= Dbus;
	Sa <= a_bus;
	Sp <= ir_o;
	
	Ct(7) <= not n_BHE;
	Ct(6) <= not n_BLE;
	Ct(5) <= not n_MREQ;
	Ct(4) <= rd_o;
	Ct(3) <= wr_o;
	Ct(2) <= r_c;
	Ct(1) <= z;
	Ct(0) <= c;	
	CL(3) <= c4;
	CL(2) <= c3;
	CL(1) <= c2;
	CL(0) <= c1;
	
end Behavioral;

