LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY nios2_ht18 IS

PORT(
	CLOCK_50 : IN STD_LOGIC;
	KEY		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	SW			: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDR	   : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	LEDG		: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	HEX0		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX2		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX3		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX4		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX5		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX6		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX7		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	DRAM_CLK, DRAM_CKE: OUT STD_LOGIC;
	DRAM_ADDR: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	DRAM_BA_0, DRAM_BA_1: BUFFER STD_LOGIC;
	DRAM_CS_N, DRAM_CAS_N, DRAM_RAS_N, DRAM_WE_N: OUT STD_LOGIC;
	DRAM_DQ: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	DRAM_UDQM, DRAM_LDQM: BUFFER STD_LOGIC;
	LCD_DATA : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	LCD_ON	: OUT STD_LOGIC;
	LCD_BLON	: OUT STD_LOGIC;
	LCD_EN	: OUT STD_LOGIC;
	LCD_RS	: OUT STD_LOGIC;
	LCD_RW	: OUT STD_LOGIC;
	SRAM_DQ	: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => 'X');
	SRAM_ADDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	SRAM_LB_N: OUT STD_LOGIC;
	SRAM_UB_N: OUT STD_LOGIC;
	SRAM_CE_N: OUT STD_LOGIC;
	SRAM_OE_N: OUT STD_LOGIC;
	SRAM_WE_N: OUT STD_LOGIC
	);
END nios2_ht18;

ARCHITECTURE Structure OF nios2_ht18 IS
	COMPONENT nios2_ht18_wang_fu
		PORT(
					de2_pio_toggles18_export  : in    std_logic_vector(17 downto 0) := (others => '0'); --  de2_pio_toggles18.export
		de2_pio_greenled9_export  : out   std_logic_vector(8 downto 0);                     --  de2_pio_greenled9.export
		de2_pio_hex_high28_export : out   std_logic_vector(27 downto 0);                    -- de2_pio_hex_high28.export
		de2_pio_hex_low28_export  : out   std_logic_vector(27 downto 0);                    --  de2_pio_hex_low28.export
			de2_pio_key4_export      : in    std_logic_vector(3 downto 0)  := (others => '0'); --      de2_pio_keys4.export
		de2_pio_redled18_export   : out   std_logic_vector(17 downto 0);                    --   de2_pio_redled18.expor	
			clk_clk					: IN STD_LOGIC;
			reset_reset_n			: IN STD_LOGIC;
			dram_clk_clk			: OUT STD_LOGIC;
		--	switches18_export		: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		--	leds_red18_export		: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		--	leds_green9_export	: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		--	keys4_export       	: in    std_logic_vector(3 downto 0);
		--	hex_low28_export   	: out   std_logic_vector(27 downto 0);
		--	hex_high28_export   	: out   std_logic_vector(27 downto 0);
			sdram_wire_addr		: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			sdram_wire_ba			: BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
			sdram_wire_cas_n		: OUT STD_LOGIC;
			sdram_wire_cke			: OUT STD_LOGIC;
			sdram_wire_cs_n		: OUT STD_LOGIC;
			sdram_wire_dq			: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			sdram_wire_dqm			: BUFFER STD_LOGIC_VECTOR(1 DOWNTO 0);
			sdram_wire_ras_n		: OUT STD_LOGIC;
			sdram_wire_we_n		: OUT STD_LOGIC;
	--		lcd_wire_DATA			: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		--	lcd_wire_ON				: OUT STD_LOGIC;
			--lcd_wire_BLON			: OUT STD_LOGIC;
		--	lcd_wire_EN				: OUT STD_LOGIC;
		--	lcd_wire_RS				: OUT STD_LOGIC;
		--	lcd_wire_RW				: OUT STD_LOGIC;
			sram_DQ			: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => 'X');
			sram_ADDR			: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
			sram_LB_N			: OUT STD_LOGIC;
			sram_UB_N			: OUT STD_LOGIC;
			sram_CE_N			: OUT STD_LOGIC;
			sram_OE_N			: OUT STD_LOGIC;
			sram_WE_N			: OUT STD_LOGIC
			);
	END COMPONENT;
	
	
	
	SIGNAL DQM: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL BA: STD_LOGIC_VECTOR( 1 DOWNTO 0);
	SIGNAL ONE: STD_LOGIC;
BEGIN
DRAM_BA_0 <= BA(0);
DRAM_BA_1 <= BA(1);
DRAM_UDQM <= DQM(1);
DRAM_LDQM <= DQM(0);
ONE <= '1';
--Instantiate the Nios II system entity generated by the Qsys tool.
NiosII: nios2_ht18_wang_fu
	PORT MAP(
		clk_clk => CLOCK_50,
		reset_reset_n => ONE,
		dram_clk_clk => DRAM_CLK,
		--switches18_export => SW(17 DOWNTO 0),
		de2_pio_key4_export => KEY(3 DOWNTO 0),
		de2_pio_redled18_export => LEDR(17 DOWNTO 0),
		de2_pio_greenled9_export => LEDG(8 DOWNTO 0),
		de2_pio_hex_low28_export(6 DOWNTO 0) => HEX0(6 DOWNTO 0), 
		de2_pio_hex_low28_export(13 DOWNTO 7) => HEX1(6 DOWNTO 0), 
		de2_pio_hex_low28_export(20 DOWNTO 14) => HEX2(6 DOWNTO 0), 
		de2_pio_hex_low28_export(27 DOWNTO 21) =>HEX3(6 DOWNTO 0),
		de2_pio_hex_high28_export(6 DOWNTO 0) => HEX4(6 DOWNTO 0), 
		de2_pio_hex_high28_export(13 DOWNTO 7) => HEX5(6 DOWNTO 0), 
		de2_pio_hex_high28_export(20 DOWNTO 14) => HEX6(6 DOWNTO 0), 
		de2_pio_hex_high28_export(27 DOWNTO 21) =>HEX7(6 DOWNTO 0),
		sdram_wire_addr => DRAM_ADDR,
		sdram_wire_ba => BA,
		sdram_wire_cas_n => DRAM_CAS_N,
		sdram_wire_cke => DRAM_CKE,
		sdram_wire_cs_n => DRAM_CS_N,
		sdram_wire_dq => DRAM_DQ,
		sdram_wire_dqm => DQM,
		sdram_wire_ras_n => DRAM_RAS_N,
		sdram_wire_we_n => DRAM_WE_N,
		--lcd_wire_DATA => LCD_DATA(7 DOWNTO 0),
		--lcd_wire_ON => LCD_ON,
		--lcd_wire_BLON => LCD_BLON,
		--lcd_wire_EN => LCD_EN,
		--lcd_wire_RS => LCD_RS,
		--lcd_wire_RW => LCD_RW,
		sram_DQ => SRAM_DQ(15 DOWNTO 0),
		sram_ADDR => SRAM_ADDR(17 DOWNTO 0),
		sram_LB_N => SRAM_LB_N,
		sram_UB_N => SRAM_UB_N,
		sram_CE_N => SRAM_CE_N,
		sram_OE_N => SRAM_OE_N,
		sram_WE_N => SRAM_WE_N
	);

	
	
END Structure;
