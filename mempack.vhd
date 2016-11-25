library ieee;
use ieee.std_logic_1164.all;
package mem_package is
type arr is array (65535 downto 0) of std_logic_vector(7 downto 0);
constant MEM_INIT : arr:= (
0 => "00000001",
1 => "00110010",
2 => "00000001",
3 => "00110100",
4 => "10000010",
5 => "11000010",
6 => "00000100",
7 => "00111000",
8 => "00000101",
9 => "00111010",
10 => "00000000",
11 => "10000000",
others => (others => '0'));
end package mem_package;
