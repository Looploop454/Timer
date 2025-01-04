-- Copyright (C) 2024  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "10/14/2024 15:01:38"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Timer
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Timer_vhd_vec_tst IS
END Timer_vhd_vec_tst;
ARCHITECTURE Timer_arch OF Timer_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Clk : STD_LOGIC;
SIGNAL Hrs : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Mins : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL nRst : STD_LOGIC;
SIGNAL Secs : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL SevenSeg_Hr_Ones : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SevenSeg_Hr_Tens : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SevenSeg_Min_Ones : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SevenSeg_Min_Tens : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SevenSeg_Sec_Ones : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SevenSeg_Sec_Tens : STD_LOGIC_VECTOR(6 DOWNTO 0);
COMPONENT Timer
	PORT (
	Clk : IN STD_LOGIC;
	Hrs : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	Mins : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	nRst : IN STD_LOGIC;
	Secs : BUFFER STD_LOGIC_VECTOR(31 DOWNTO 0);
	SevenSeg_Hr_Ones : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	SevenSeg_Hr_Tens : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	SevenSeg_Min_Ones : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	SevenSeg_Min_Tens : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	SevenSeg_Sec_Ones : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
	SevenSeg_Sec_Tens : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Timer
	PORT MAP (
-- list connections between master ports and signals
	Clk => Clk,
	Hrs => Hrs,
	Mins => Mins,
	nRst => nRst,
	Secs => Secs,
	SevenSeg_Hr_Ones => SevenSeg_Hr_Ones,
	SevenSeg_Hr_Tens => SevenSeg_Hr_Tens,
	SevenSeg_Min_Ones => SevenSeg_Min_Ones,
	SevenSeg_Min_Tens => SevenSeg_Min_Tens,
	SevenSeg_Sec_Ones => SevenSeg_Sec_Ones,
	SevenSeg_Sec_Tens => SevenSeg_Sec_Tens
	);

-- Clk
t_prcs_Clk: PROCESS
BEGIN
	Clk <= '0';
WAIT;
END PROCESS t_prcs_Clk;

-- nRst
t_prcs_nRst: PROCESS
BEGIN
	nRst <= '0';
WAIT;
END PROCESS t_prcs_nRst;
END Timer_arch;
