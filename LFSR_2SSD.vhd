library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LFSR_2SSD is
    port (
        ssd_out    : out std_logic_vector(6 downto 0);
        clk        : in  std_logic;
        reset      : in  std_logic;
        load       : in  std_logic;
        bit_sel    : in  std_logic;
        nr_IN      : in  std_logic_vector(5 downto 1);
        ssd_enable : out std_logic_vector(7 downto 0)
    );
end entity;

architecture ARCH of LFSR_2SSD is
    signal numarare : std_logic_vector(5 downto 1);
    signal feedback : std_logic;
    signal clk_out  : std_logic;
    signal number   : integer range 0 to 31;
    signal unit     : integer range 0 to 9;
    signal tens     : integer range 0 to 3;
    signal counter  : integer range 0 to 50000 := 0;
    signal sel      : std_logic := '0';

    component divizor_de_frecventa 
        port (
            CLK_IN  : in  std_logic;
            CLK_OUT : out std_logic
        );
    end component;

begin

    A1: divizor_de_frecventa port map(
        CLK_IN  => clk,
        CLK_OUT => clk_out
    );

    feedback <= 
        (numarare(4) xor numarare(3)) when bit_sel = '0' else
        (numarare(5) xor numarare(3));

    process(clk_out, reset, load)
    begin
        if reset = '1' then
            numarare <= "00001";
        elsif load = '1' then
            if nr_IN = "00000" then
                numarare <= "00001";
            else
                numarare <= nr_IN;
            end if;
        elsif rising_edge(clk_out) then
            numarare <= numarare(4 downto 1) & feedback;
        end if;
    end process;

    number <= to_integer(unsigned(numarare(4 downto 1))) when bit_sel = '0' else
              to_integer(unsigned(numarare));
    tens  <= number / 10;
    unit  <= number mod 10;

    process(clk)
    begin
        if rising_edge(clk) then
            if counter = 50000 then
                counter <= 0;
                sel <= not sel;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    process(sel, unit, tens)
    begin
        if sel = '0' then
            ssd_enable <= "11111101";
            case tens is
                when 0 => ssd_out <= "1000000";
                when 1 => ssd_out <= "1111001";
                when 2 => ssd_out <= "0100100";
                when 3 => ssd_out <= "0110000";
                when others => ssd_out <= "1111111";
            end case;
        else
            ssd_enable <= "11111110";
            case unit is
                when 0 => ssd_out <= "1000000";
                when 1 => ssd_out <= "1111001";
                when 2 => ssd_out <= "0100100";
                when 3 => ssd_out <= "0110000";
                when 4 => ssd_out <= "0011001";
                when 5 => ssd_out <= "0010010";
                when 6 => ssd_out <= "0000010";
                when 7 => ssd_out <= "1111000";
                when 8 => ssd_out <= "0000000";
                when 9 => ssd_out <= "0010000";
                when others => ssd_out <= "1111111";
            end case;
        end if;
    end process;

end architecture;