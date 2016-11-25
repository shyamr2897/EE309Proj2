library ieee;
use ieee.std_logic_1164.all;
package mem_package is
type arr is array (65535 downto 0) of std_logic_vector(7 downto 0);
constant MEM_INIT : arr:= (
0 => "00000000",
1 => "01000000",
2 => "00001000",
3 => "00000100",
4 => "00011000",
5 => "00000100",
6 => "00010000",
7 => "00000100",
8 => "00000010",
9 => "11000010",
10 => "11100000",
11 => "00000111",
12 => "11100000",
13 => "00000111",
14 => "00000000",
15 => "10000000",
others => (others => '0'));
end package mem_package;
