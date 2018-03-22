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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
generic (input_file_name : string := "input_data.txt");
end tb_top;

architecture rtl of tb_top is

constant latency : integer := 12;
  -- 
signal clk : STD_LOGIC := '0';
signal srst : STD_LOGIC := '0';
-- wr_port
signal din : STD_LOGIC_VECTOR(71 DOWNTO 0) := (others => '0');
signal wr_en :  STD_LOGIC := '0';
signal full :  STD_LOGIC := '0';
signal wr_rst_busy :  STD_LOGIC := '0';
-- rd_port
signal rd_en :  STD_LOGIC := '1';
signal dout :  STD_LOGIC_VECTOR(71 DOWNTO 0) := (others => '0');
signal empty :  STD_LOGIC := '0';
signal valid :  STD_LOGIC := '0';
signal rd_rst_busy :  STD_LOGIC := '0';

signal cnt : integer := 0;

signal a : std_logic_vector(26 downto 0) := (others => '0');
signal b : std_logic_vector(17 downto 0) := (others => '0');
signal result_kernel : std_logic_vector(26 downto 0) := (others => '0');
type vec_1d_array is array (integer range<>) of std_logic_vector;
signal res : vec_1d_array (latency - 1 downto 0)(26 downto 0) := (others => (others => '0'));

begin

uut_top : entity work.top
port map(
  -- 
  clk => clk,
  srst => srst,
  -- wr_port
  din => din,
  wr_en => wr_en,
  full => full,
  wr_rst_busy => wr_rst_busy,
  -- rd_port
  rd_en => rd_en,
  dout => dout,
  empty => empty,
  valid => valid,
  rd_rst_busy => rd_rst_busy
);

process (clk, srst) is 
  file input_file : text;
  variable l : line;
  variable c : character;
  variable f_status : file_open_status;
  
  variable hex48 : std_logic_vector (47 downto 0);
  variable hex28 : std_logic_vector (27 downto 0);
  variable hex20 : std_logic_vector (19 downto 0);
  variable a : std_logic_vector(26 downto 0);
  variable b : std_logic_vector(17 downto 0);
  variable result_txt : std_logic_vector(26 downto 0);
begin 
  
  if falling_edge(srst) then 
    file_open(f_status, input_file, input_file_name, read_mode);
    readline(input_file, l); -- header
  end if;
  
  if rising_edge(clk) then
    if srst = '1' then
      din <= (others => '0');
      wr_en <= '0';
    elsif (f_status = open_ok) then
      if cnt < 1000 then
        readline(input_file, l);
        hread(l, hex28);
        read(l,c);
        a := hex28(26 downto 0);
        hread(l, hex20);
        read(l,c);
        b := hex20(17 downto 0);
        hread(l, hex48);
        read(l,c);
        hread(l,hex28);
        result_txt := hex28(26 downto 0);
        res(0) <= result_txt;
        din <= a & b & a;
        wr_en <= '1';
        cnt <= cnt + 1;
      else 
        file_close(input_file);
        din <= (others => '0');
        wr_en <= '0';
      end if; --endfile
    else
      din <= (others => '0');
      wr_en <= '0';
    end if; -- status
    for i in 1 to latency - 1 loop
      res(i) <= res(i-1);    
    end loop;
  end if; -- rising edge
end process;



process 
begin 
  srst <= '1';
  wait for 200 ns;
  srst <= '0';
  wait;
end process;

clk <= not clk after 1 ns;

a <= dout(26 downto 0);
b <= dout(44 downto 27);
result_kernel <= dout (71 downto 45);

process (clk) is
begin
  if rising_edge(clk) then
    assert (result_kernel = res(latency-1)) report "output did not match with golden results - " & to_hstring(result_kernel) severity warning;
  end if;
end process;

end rtl;
