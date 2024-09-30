
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic
	(
		ADDR_WIDTH : integer := 15 -- Specify your actual ROM size to save LEs and unnecessary block RAM usage.
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture rtl of controller_rom2 is

	signal addr1 : integer range 0 to 2**ADDR_WIDTH-1;

	--  build up 2D array to hold the memory
	type word_t is array (0 to 3) of std_logic_vector(7 downto 0);
	type ram_t is array (0 to 2 ** ADDR_WIDTH - 1) of word_t;

	signal ram : ram_t:=
	(

     0 => (x"cc",x"fb",x"49",x"ff"),
     1 => (x"49",x"da",x"c1",x"87"),
     2 => (x"c1",x"87",x"dd",x"e3"),
     3 => (x"d9",x"df",x"c2",x"4d"),
     4 => (x"c3",x"02",x"bf",x"97"),
     5 => (x"87",x"f3",x"cc",x"87"),
     6 => (x"bf",x"de",x"df",x"c2"),
     7 => (x"e1",x"c8",x"c2",x"4b"),
     8 => (x"e9",x"c0",x"05",x"bf"),
     9 => (x"49",x"fd",x"c3",x"87"),
    10 => (x"c3",x"87",x"fd",x"e2"),
    11 => (x"f7",x"e2",x"49",x"fa"),
    12 => (x"c3",x"49",x"73",x"87"),
    13 => (x"1e",x"71",x"99",x"ff"),
    14 => (x"ce",x"fb",x"49",x"c0"),
    15 => (x"c8",x"49",x"73",x"87"),
    16 => (x"1e",x"71",x"29",x"b7"),
    17 => (x"c2",x"fb",x"49",x"c1"),
    18 => (x"c5",x"86",x"c8",x"87"),
    19 => (x"df",x"c2",x"87",x"f9"),
    20 => (x"9b",x"4b",x"bf",x"e2"),
    21 => (x"c2",x"87",x"dd",x"02"),
    22 => (x"49",x"bf",x"dd",x"c8"),
    23 => (x"70",x"87",x"d6",x"c7"),
    24 => (x"87",x"c4",x"05",x"98"),
    25 => (x"87",x"d2",x"4b",x"c0"),
    26 => (x"c6",x"49",x"e0",x"c2"),
    27 => (x"c8",x"c2",x"87",x"fb"),
    28 => (x"87",x"c6",x"58",x"e1"),
    29 => (x"48",x"dd",x"c8",x"c2"),
    30 => (x"49",x"73",x"78",x"c0"),
    31 => (x"cd",x"05",x"99",x"c2"),
    32 => (x"49",x"eb",x"c3",x"87"),
    33 => (x"70",x"87",x"e1",x"e1"),
    34 => (x"02",x"99",x"c2",x"49"),
    35 => (x"4c",x"fb",x"87",x"c2"),
    36 => (x"99",x"c1",x"49",x"73"),
    37 => (x"c3",x"87",x"cd",x"05"),
    38 => (x"cb",x"e1",x"49",x"f4"),
    39 => (x"c2",x"49",x"70",x"87"),
    40 => (x"87",x"c2",x"02",x"99"),
    41 => (x"49",x"73",x"4c",x"fa"),
    42 => (x"cd",x"05",x"99",x"c8"),
    43 => (x"49",x"f5",x"c3",x"87"),
    44 => (x"70",x"87",x"f5",x"e0"),
    45 => (x"02",x"99",x"c2",x"49"),
    46 => (x"df",x"c2",x"87",x"d4"),
    47 => (x"c9",x"02",x"bf",x"ea"),
    48 => (x"88",x"c1",x"48",x"87"),
    49 => (x"58",x"ee",x"df",x"c2"),
    50 => (x"4c",x"ff",x"87",x"c2"),
    51 => (x"49",x"73",x"4d",x"c1"),
    52 => (x"cd",x"05",x"99",x"c4"),
    53 => (x"49",x"f2",x"c3",x"87"),
    54 => (x"70",x"87",x"cd",x"e0"),
    55 => (x"02",x"99",x"c2",x"49"),
    56 => (x"df",x"c2",x"87",x"db"),
    57 => (x"48",x"7e",x"bf",x"ea"),
    58 => (x"03",x"a8",x"b7",x"c7"),
    59 => (x"48",x"6e",x"87",x"cb"),
    60 => (x"df",x"c2",x"80",x"c1"),
    61 => (x"c2",x"c0",x"58",x"ee"),
    62 => (x"c1",x"4c",x"fe",x"87"),
    63 => (x"49",x"fd",x"c3",x"4d"),
    64 => (x"87",x"e4",x"df",x"ff"),
    65 => (x"99",x"c2",x"49",x"70"),
    66 => (x"c2",x"87",x"d5",x"02"),
    67 => (x"02",x"bf",x"ea",x"df"),
    68 => (x"c2",x"87",x"c9",x"c0"),
    69 => (x"c0",x"48",x"ea",x"df"),
    70 => (x"87",x"c2",x"c0",x"78"),
    71 => (x"4d",x"c1",x"4c",x"fd"),
    72 => (x"ff",x"49",x"fa",x"c3"),
    73 => (x"70",x"87",x"c1",x"df"),
    74 => (x"02",x"99",x"c2",x"49"),
    75 => (x"df",x"c2",x"87",x"d9"),
    76 => (x"c7",x"48",x"bf",x"ea"),
    77 => (x"c0",x"03",x"a8",x"b7"),
    78 => (x"df",x"c2",x"87",x"c9"),
    79 => (x"78",x"c7",x"48",x"ea"),
    80 => (x"fc",x"87",x"c2",x"c0"),
    81 => (x"c0",x"4d",x"c1",x"4c"),
    82 => (x"c0",x"03",x"ac",x"b7"),
    83 => (x"66",x"c4",x"87",x"d1"),
    84 => (x"82",x"d8",x"c1",x"4a"),
    85 => (x"c6",x"c0",x"02",x"6a"),
    86 => (x"74",x"4b",x"6a",x"87"),
    87 => (x"c0",x"0f",x"73",x"49"),
    88 => (x"1e",x"f0",x"c3",x"1e"),
    89 => (x"f7",x"49",x"da",x"c1"),
    90 => (x"86",x"c8",x"87",x"dc"),
    91 => (x"c0",x"02",x"98",x"70"),
    92 => (x"a6",x"c8",x"87",x"e2"),
    93 => (x"ea",x"df",x"c2",x"48"),
    94 => (x"66",x"c8",x"78",x"bf"),
    95 => (x"c4",x"91",x"cb",x"49"),
    96 => (x"80",x"71",x"48",x"66"),
    97 => (x"bf",x"6e",x"7e",x"70"),
    98 => (x"87",x"c8",x"c0",x"02"),
    99 => (x"c8",x"4b",x"bf",x"6e"),
   100 => (x"0f",x"73",x"49",x"66"),
   101 => (x"c0",x"02",x"9d",x"75"),
   102 => (x"df",x"c2",x"87",x"c8"),
   103 => (x"f3",x"49",x"bf",x"ea"),
   104 => (x"c8",x"c2",x"87",x"ca"),
   105 => (x"c0",x"02",x"bf",x"e5"),
   106 => (x"c2",x"49",x"87",x"dd"),
   107 => (x"98",x"70",x"87",x"c7"),
   108 => (x"87",x"d3",x"c0",x"02"),
   109 => (x"bf",x"ea",x"df",x"c2"),
   110 => (x"87",x"f0",x"f2",x"49"),
   111 => (x"d0",x"f4",x"49",x"c0"),
   112 => (x"e5",x"c8",x"c2",x"87"),
   113 => (x"f4",x"78",x"c0",x"48"),
   114 => (x"87",x"ea",x"f3",x"8e"),
   115 => (x"5c",x"5b",x"5e",x"0e"),
   116 => (x"71",x"1e",x"0e",x"5d"),
   117 => (x"e6",x"df",x"c2",x"4c"),
   118 => (x"cd",x"c1",x"49",x"bf"),
   119 => (x"d1",x"c1",x"4d",x"a1"),
   120 => (x"74",x"7e",x"69",x"81"),
   121 => (x"87",x"cf",x"02",x"9c"),
   122 => (x"74",x"4b",x"a5",x"c4"),
   123 => (x"e6",x"df",x"c2",x"7b"),
   124 => (x"c9",x"f3",x"49",x"bf"),
   125 => (x"74",x"7b",x"6e",x"87"),
   126 => (x"87",x"c4",x"05",x"9c"),
   127 => (x"87",x"c2",x"4b",x"c0"),
   128 => (x"49",x"73",x"4b",x"c1"),
   129 => (x"d4",x"87",x"ca",x"f3"),
   130 => (x"87",x"c7",x"02",x"66"),
   131 => (x"70",x"87",x"da",x"49"),
   132 => (x"c0",x"87",x"c2",x"4a"),
   133 => (x"e9",x"c8",x"c2",x"4a"),
   134 => (x"d9",x"f2",x"26",x"5a"),
   135 => (x"00",x"00",x"00",x"87"),
   136 => (x"00",x"00",x"00",x"00"),
   137 => (x"00",x"00",x"00",x"00"),
   138 => (x"4a",x"71",x"1e",x"00"),
   139 => (x"49",x"bf",x"c8",x"ff"),
   140 => (x"26",x"48",x"a1",x"72"),
   141 => (x"c8",x"ff",x"1e",x"4f"),
   142 => (x"c0",x"fe",x"89",x"bf"),
   143 => (x"c0",x"c0",x"c0",x"c0"),
   144 => (x"87",x"c4",x"01",x"a9"),
   145 => (x"87",x"c2",x"4a",x"c0"),
   146 => (x"48",x"72",x"4a",x"c1"),
   147 => (x"5e",x"0e",x"4f",x"26"),
   148 => (x"0e",x"5d",x"5c",x"5b"),
   149 => (x"ff",x"7e",x"71",x"1e"),
   150 => (x"1e",x"6e",x"4b",x"d4"),
   151 => (x"49",x"ee",x"df",x"c2"),
   152 => (x"87",x"f1",x"d5",x"fe"),
   153 => (x"4d",x"70",x"86",x"c4"),
   154 => (x"c3",x"c3",x"02",x"9d"),
   155 => (x"f6",x"df",x"c2",x"87"),
   156 => (x"49",x"6e",x"4c",x"bf"),
   157 => (x"87",x"e6",x"e7",x"fe"),
   158 => (x"c8",x"48",x"d0",x"ff"),
   159 => (x"d6",x"c1",x"78",x"c5"),
   160 => (x"15",x"4a",x"c0",x"7b"),
   161 => (x"c0",x"82",x"c1",x"7b"),
   162 => (x"04",x"aa",x"b7",x"e0"),
   163 => (x"d0",x"ff",x"87",x"f5"),
   164 => (x"c8",x"78",x"c4",x"48"),
   165 => (x"d3",x"c1",x"78",x"c5"),
   166 => (x"c4",x"7b",x"c1",x"7b"),
   167 => (x"02",x"9c",x"74",x"78"),
   168 => (x"c2",x"87",x"fc",x"c1"),
   169 => (x"c8",x"7e",x"de",x"ce"),
   170 => (x"c0",x"8c",x"4d",x"c0"),
   171 => (x"c6",x"03",x"ac",x"b7"),
   172 => (x"a4",x"c0",x"c8",x"87"),
   173 => (x"c2",x"4c",x"c0",x"4d"),
   174 => (x"bf",x"97",x"cf",x"db"),
   175 => (x"02",x"99",x"d0",x"49"),
   176 => (x"1e",x"c0",x"87",x"d2"),
   177 => (x"49",x"ee",x"df",x"c2"),
   178 => (x"87",x"e5",x"d7",x"fe"),
   179 => (x"49",x"70",x"86",x"c4"),
   180 => (x"87",x"ef",x"c0",x"4a"),
   181 => (x"1e",x"de",x"ce",x"c2"),
   182 => (x"49",x"ee",x"df",x"c2"),
   183 => (x"87",x"d1",x"d7",x"fe"),
   184 => (x"49",x"70",x"86",x"c4"),
   185 => (x"48",x"d0",x"ff",x"4a"),
   186 => (x"c1",x"78",x"c5",x"c8"),
   187 => (x"97",x"6e",x"7b",x"d4"),
   188 => (x"48",x"6e",x"7b",x"bf"),
   189 => (x"7e",x"70",x"80",x"c1"),
   190 => (x"ff",x"05",x"8d",x"c1"),
   191 => (x"d0",x"ff",x"87",x"f0"),
   192 => (x"72",x"78",x"c4",x"48"),
   193 => (x"87",x"c5",x"05",x"9a"),
   194 => (x"e5",x"c0",x"48",x"c0"),
   195 => (x"c2",x"1e",x"c1",x"87"),
   196 => (x"fe",x"49",x"ee",x"df"),
   197 => (x"c4",x"87",x"f9",x"d4"),
   198 => (x"05",x"9c",x"74",x"86"),
   199 => (x"ff",x"87",x"c4",x"fe"),
   200 => (x"c5",x"c8",x"48",x"d0"),
   201 => (x"7b",x"d3",x"c1",x"78"),
   202 => (x"78",x"c4",x"7b",x"c0"),
   203 => (x"87",x"c2",x"48",x"c1"),
   204 => (x"26",x"26",x"48",x"c0"),
   205 => (x"26",x"4c",x"26",x"4d"),
   206 => (x"1e",x"4f",x"26",x"4b"),
   207 => (x"66",x"c4",x"4a",x"71"),
   208 => (x"72",x"87",x"c5",x"05"),
   209 => (x"87",x"c6",x"fc",x"49"),
   210 => (x"1e",x"00",x"4f",x"26"),
   211 => (x"bf",x"f4",x"cd",x"c2"),
   212 => (x"c2",x"b9",x"c1",x"49"),
   213 => (x"ff",x"59",x"f8",x"cd"),
   214 => (x"ff",x"c3",x"48",x"d4"),
   215 => (x"48",x"d0",x"ff",x"78"),
   216 => (x"ff",x"78",x"e1",x"c8"),
   217 => (x"78",x"c1",x"48",x"d4"),
   218 => (x"78",x"71",x"31",x"c4"),
   219 => (x"c0",x"48",x"d0",x"ff"),
   220 => (x"4f",x"26",x"78",x"e0"),
   221 => (x"00",x"00",x"00",x"00"),
		others => (others => x"00")
	);
	signal q1_local : word_t;

	-- Altera Quartus attributes
	attribute ramstyle: string;
	attribute ramstyle of ram: signal is "no_rw_check";

begin  -- rtl

	addr1 <= to_integer(unsigned(addr(ADDR_WIDTH-1 downto 0)));

	-- Reorganize the read data from the RAM to match the output
	q(7 downto 0) <= q1_local(3);
	q(15 downto 8) <= q1_local(2);
	q(23 downto 16) <= q1_local(1);
	q(31 downto 24) <= q1_local(0);

	process(clk)
	begin
		if(rising_edge(clk)) then 
			if(we = '1') then
				-- edit this code if using other than four bytes per word
				if (bytesel(3) = '1') then
					ram(addr1)(3) <= d(7 downto 0);
				end if;
				if (bytesel(2) = '1') then
					ram(addr1)(2) <= d(15 downto 8);
				end if;
				if (bytesel(1) = '1') then
					ram(addr1)(1) <= d(23 downto 16);
				end if;
				if (bytesel(0) = '1') then
					ram(addr1)(0) <= d(31 downto 24);
				end if;
			end if;
			q1_local <= ram(addr1);
		end if;
	end process;
  
end rtl;

