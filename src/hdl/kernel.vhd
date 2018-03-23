----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2018 12:20:40 PM
-- Design Name: 
-- Module Name: kernel - rtl
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;
use ieee.std_logic_misc.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity kernel is
port ( 
  -- 
  clk : IN STD_LOGIC;
  srst : IN STD_LOGIC;
  -- wr_port
  din : IN STD_LOGIC_VECTOR(71 DOWNTO 0);
  din_valid : in std_logic;
  -- rd_port
  dout : OUT STD_LOGIC_VECTOR(71 DOWNTO 0);
  dout_valid : OUT STD_LOGIC
);
end kernel;

architecture rtl of kernel is

type vec_1d_array is array (integer range<>) of std_logic_vector;
constant latency : integer := 4;

signal din_pipe : vec_1d_array (latency - 1 downto 0)(71 downto 0) := (others => (others => '0'));
signal valid_pipe : std_logic_vector(latency - 1 downto 0) := (others => '0'); 

signal result : std_logic_vector(47 downto 0) := (others => '0');
signal result_shift : std_logic_vector(26 downto 0) := (others => '0');
constant c_real : real := 200.453 * ( 2.0 ** 21.0 );
constant c : std_logic_vector (47 downto 0) := std_logic_vector(to_signed(integer(c_real), 48));

signal a : std_logic_vector(26 downto 0) := (others => '0');
signal b : std_logic_vector(17 downto 0) := (others => '0');

component op_mult 
  port (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
end component;

begin


op_mult_inst : op_mult 
port map (
    clk => clk,
    a => a,
    b => b,
    c => c,
    p => result
);



process (clk) is

begin 

  if rising_edge(clk) then
      for i in 1 to latency - 1 loop
        din_pipe(i) <= din_pipe(i-1);
        valid_pipe(i) <= valid_pipe(i-1);
      end loop;
      din_pipe(0) <= din;
      valid_pipe(0) <= din_valid;
      dout <= result_shift & din_pipe(latency - 1)(44 downto 0);
      dout_valid <= valid_pipe(latency - 1);
  end if;
  
end process; 

a <= din(26 downto 0);
b <= din(44 downto 27);

result_shift <= std_logic_vector(resize(shift_right(unsigned(result), 21), 27));


end rtl;
