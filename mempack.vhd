library ieee;
use ieee.std_logic_1164.all;
package mem_package is
type arr is array (65535 downto 0) of std_logic_vector(7 downto 0);
constant MEM_INIT : arr:= (
0 => "10000000",
1 => "00110011",
2 => "11000000",
3 => "00111010",
4 => "01010000",
5 => "00000011",
6 => "00000001",
7 => "01001100",
8 => "11000010",
9 => "00011111",
10 => "01011000",
11 => "00000011",
12 => "01100000",
13 => "00000011",
others => (others => '0'));
end package mem_package;
