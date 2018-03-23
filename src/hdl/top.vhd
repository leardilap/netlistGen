----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2018 02:41:55 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port (
  -- 
  clk : IN STD_LOGIC;
  srst : IN STD_LOGIC;
  -- wr_port
  din : IN STD_LOGIC_VECTOR(71 DOWNTO 0);
  wr_en : IN STD_LOGIC;
  full : OUT STD_LOGIC;
  wr_rst_busy : OUT STD_LOGIC;
  -- rd_port
  rd_en : IN STD_LOGIC;
  dout : OUT STD_LOGIC_VECTOR(71 DOWNTO 0);
  empty : OUT STD_LOGIC;
  valid : OUT STD_LOGIC;
  rd_rst_busy : OUT STD_LOGIC
);
end top;

architecture rtl of top is

signal dout_mult : std_logic_vector (71 downto 0) := (others => '0');
signal rd_en_mult : std_logic := '1';
signal empty_mult : std_logic := '0';
signal rd_rst_busy_mult : std_logic := '0';
signal valid_mult : std_logic := '0';

signal wr_rst_busy_mult : std_logic := '0';
signal dout_kernel : std_logic_vector (71 downto 0) := (others => '0');
signal dout_kernel_valid : std_logic := '0';
signal full_kernel : std_logic := '0';

component fifo72x512
port (
    empty : out STD_LOGIC;
    full : out STD_LOGIC;
    rd_rst_busy : out STD_LOGIC;
    wr_rst_busy : out STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 71 downto 0 );
    valid : out STD_LOGIC;
    rd_en : in STD_LOGIC;
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    wr_en : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 71 downto 0 )
);
end component;
  
begin

in_fifo : fifo72x512 
port map(
    clk => clk,
    srst => srst,
    din => din,
    wr_en => wr_en,
    rd_en => rd_en_mult,
    dout => dout_mult,
    full => full,
    empty => empty_mult,
    valid => valid_mult,
    wr_rst_busy => wr_rst_busy,
    rd_rst_busy => rd_rst_busy_mult
);

kernel_inst : entity work.kernel 
port map( 
  -- 
  clk => clk,
  srst => srst,
  -- wr_port
  din => dout_mult,
  din_valid => valid_mult,
  -- rd_port
  dout => dout_kernel,
  dout_valid => dout_kernel_valid
);

out_fifo : fifo72x512
port map(
    clk => clk,
    srst => srst,
    din => dout_kernel,
    wr_en => dout_kernel_valid,
    rd_en => rd_en,
    dout => dout,
    full => full_kernel,
    empty => empty,
    valid => valid,
    wr_rst_busy => wr_rst_busy_mult,
    rd_rst_busy => rd_rst_busy
);

rd_en_mult <= '1';

end rtl;
