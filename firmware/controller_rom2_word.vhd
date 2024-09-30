library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
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

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"ccfb49ff",
     1 => x"49dac187",
     2 => x"c187dde3",
     3 => x"d9dfc24d",
     4 => x"c302bf97",
     5 => x"87f3cc87",
     6 => x"bfdedfc2",
     7 => x"e1c8c24b",
     8 => x"e9c005bf",
     9 => x"49fdc387",
    10 => x"c387fde2",
    11 => x"f7e249fa",
    12 => x"c3497387",
    13 => x"1e7199ff",
    14 => x"cefb49c0",
    15 => x"c8497387",
    16 => x"1e7129b7",
    17 => x"c2fb49c1",
    18 => x"c586c887",
    19 => x"dfc287f9",
    20 => x"9b4bbfe2",
    21 => x"c287dd02",
    22 => x"49bfddc8",
    23 => x"7087d6c7",
    24 => x"87c40598",
    25 => x"87d24bc0",
    26 => x"c649e0c2",
    27 => x"c8c287fb",
    28 => x"87c658e1",
    29 => x"48ddc8c2",
    30 => x"497378c0",
    31 => x"cd0599c2",
    32 => x"49ebc387",
    33 => x"7087e1e1",
    34 => x"0299c249",
    35 => x"4cfb87c2",
    36 => x"99c14973",
    37 => x"c387cd05",
    38 => x"cbe149f4",
    39 => x"c2497087",
    40 => x"87c20299",
    41 => x"49734cfa",
    42 => x"cd0599c8",
    43 => x"49f5c387",
    44 => x"7087f5e0",
    45 => x"0299c249",
    46 => x"dfc287d4",
    47 => x"c902bfea",
    48 => x"88c14887",
    49 => x"58eedfc2",
    50 => x"4cff87c2",
    51 => x"49734dc1",
    52 => x"cd0599c4",
    53 => x"49f2c387",
    54 => x"7087cde0",
    55 => x"0299c249",
    56 => x"dfc287db",
    57 => x"487ebfea",
    58 => x"03a8b7c7",
    59 => x"486e87cb",
    60 => x"dfc280c1",
    61 => x"c2c058ee",
    62 => x"c14cfe87",
    63 => x"49fdc34d",
    64 => x"87e4dfff",
    65 => x"99c24970",
    66 => x"c287d502",
    67 => x"02bfeadf",
    68 => x"c287c9c0",
    69 => x"c048eadf",
    70 => x"87c2c078",
    71 => x"4dc14cfd",
    72 => x"ff49fac3",
    73 => x"7087c1df",
    74 => x"0299c249",
    75 => x"dfc287d9",
    76 => x"c748bfea",
    77 => x"c003a8b7",
    78 => x"dfc287c9",
    79 => x"78c748ea",
    80 => x"fc87c2c0",
    81 => x"c04dc14c",
    82 => x"c003acb7",
    83 => x"66c487d1",
    84 => x"82d8c14a",
    85 => x"c6c0026a",
    86 => x"744b6a87",
    87 => x"c00f7349",
    88 => x"1ef0c31e",
    89 => x"f749dac1",
    90 => x"86c887dc",
    91 => x"c0029870",
    92 => x"a6c887e2",
    93 => x"eadfc248",
    94 => x"66c878bf",
    95 => x"c491cb49",
    96 => x"80714866",
    97 => x"bf6e7e70",
    98 => x"87c8c002",
    99 => x"c84bbf6e",
   100 => x"0f734966",
   101 => x"c0029d75",
   102 => x"dfc287c8",
   103 => x"f349bfea",
   104 => x"c8c287ca",
   105 => x"c002bfe5",
   106 => x"c24987dd",
   107 => x"987087c7",
   108 => x"87d3c002",
   109 => x"bfeadfc2",
   110 => x"87f0f249",
   111 => x"d0f449c0",
   112 => x"e5c8c287",
   113 => x"f478c048",
   114 => x"87eaf38e",
   115 => x"5c5b5e0e",
   116 => x"711e0e5d",
   117 => x"e6dfc24c",
   118 => x"cdc149bf",
   119 => x"d1c14da1",
   120 => x"747e6981",
   121 => x"87cf029c",
   122 => x"744ba5c4",
   123 => x"e6dfc27b",
   124 => x"c9f349bf",
   125 => x"747b6e87",
   126 => x"87c4059c",
   127 => x"87c24bc0",
   128 => x"49734bc1",
   129 => x"d487caf3",
   130 => x"87c70266",
   131 => x"7087da49",
   132 => x"c087c24a",
   133 => x"e9c8c24a",
   134 => x"d9f2265a",
   135 => x"00000087",
   136 => x"00000000",
   137 => x"00000000",
   138 => x"4a711e00",
   139 => x"49bfc8ff",
   140 => x"2648a172",
   141 => x"c8ff1e4f",
   142 => x"c0fe89bf",
   143 => x"c0c0c0c0",
   144 => x"87c401a9",
   145 => x"87c24ac0",
   146 => x"48724ac1",
   147 => x"5e0e4f26",
   148 => x"0e5d5c5b",
   149 => x"ff7e711e",
   150 => x"1e6e4bd4",
   151 => x"49eedfc2",
   152 => x"87f1d5fe",
   153 => x"4d7086c4",
   154 => x"c3c3029d",
   155 => x"f6dfc287",
   156 => x"496e4cbf",
   157 => x"87e6e7fe",
   158 => x"c848d0ff",
   159 => x"d6c178c5",
   160 => x"154ac07b",
   161 => x"c082c17b",
   162 => x"04aab7e0",
   163 => x"d0ff87f5",
   164 => x"c878c448",
   165 => x"d3c178c5",
   166 => x"c47bc17b",
   167 => x"029c7478",
   168 => x"c287fcc1",
   169 => x"c87edece",
   170 => x"c08c4dc0",
   171 => x"c603acb7",
   172 => x"a4c0c887",
   173 => x"c24cc04d",
   174 => x"bf97cfdb",
   175 => x"0299d049",
   176 => x"1ec087d2",
   177 => x"49eedfc2",
   178 => x"87e5d7fe",
   179 => x"497086c4",
   180 => x"87efc04a",
   181 => x"1edecec2",
   182 => x"49eedfc2",
   183 => x"87d1d7fe",
   184 => x"497086c4",
   185 => x"48d0ff4a",
   186 => x"c178c5c8",
   187 => x"976e7bd4",
   188 => x"486e7bbf",
   189 => x"7e7080c1",
   190 => x"ff058dc1",
   191 => x"d0ff87f0",
   192 => x"7278c448",
   193 => x"87c5059a",
   194 => x"e5c048c0",
   195 => x"c21ec187",
   196 => x"fe49eedf",
   197 => x"c487f9d4",
   198 => x"059c7486",
   199 => x"ff87c4fe",
   200 => x"c5c848d0",
   201 => x"7bd3c178",
   202 => x"78c47bc0",
   203 => x"87c248c1",
   204 => x"262648c0",
   205 => x"264c264d",
   206 => x"1e4f264b",
   207 => x"66c44a71",
   208 => x"7287c505",
   209 => x"87c6fc49",
   210 => x"1e004f26",
   211 => x"bff4cdc2",
   212 => x"c2b9c149",
   213 => x"ff59f8cd",
   214 => x"ffc348d4",
   215 => x"48d0ff78",
   216 => x"ff78e1c8",
   217 => x"78c148d4",
   218 => x"787131c4",
   219 => x"c048d0ff",
   220 => x"4f2678e0",
   221 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
