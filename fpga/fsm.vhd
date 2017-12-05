-- fsm.vhd: Finite State Machine
-- Author(s): 
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (TEST_1X, TEST_2X, TEST_3X, TEST_4X, TEST_5X, TEST_6X, TEST_7X, TEST_8A, TEST_9A, TEST_10A, TEST_8B, TEST_9B, TEST_10B, PRINT_MESSAGE_FAIL, PRINT_MESSAGE_SUC, FINISH, FAIL, FINAL);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST_1X;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_1X =>
      next_state <= TEST_1X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(1) = '1') then 
	 next_state <= TEST_2X;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_2X =>
      next_state <= TEST_2X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(0) = '1') then 
	 next_state <= TEST_3X;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_3X =>
      next_state <= TEST_3X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(6) = '1') then 
	 next_state <= TEST_4X;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_4X =>
      next_state <= TEST_4X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(1) = '1') then 
	 next_state <= TEST_5X;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_5X =>
      next_state <= TEST_5X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(4) = '1') then 
	 next_state <= TEST_6X;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_6X =>
      next_state <= TEST_6X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(5) = '1') then 
	 next_state <= TEST_7x;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_7X =>
      next_state <= TEST_7X;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(9) = '1') then 
	 next_state <= TEST_8A;
      elsif (KEY(7) = '1') then 
	 next_state <= TEST_8B;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_8A =>
      next_state <= TEST_8A;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(4) = '1') then 
	 next_state <= TEST_9A;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_9A =>
      next_state <= TEST_9A;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(0) = '1') then 
	 next_state <= TEST_10A;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_10A =>
      next_state <= TEST_10A;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(4) = '1') then 
	 next_state <= FINAL;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_8B =>
      next_state <= TEST_8B;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(4) = '1') then 
	 next_state <= TEST_9B;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_9B =>
      next_state <= TEST_9B;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(1) = '1') then 
	 next_state <= TEST_10B;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST_10B =>
      next_state <= TEST_10B;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL;
      elsif (KEY(8) = '1') then 
	 next_state <= FINAL;
      elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_FAIL =>
      next_state <= PRINT_MESSAGE_FAIL;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_SUC =>
      next_state <= PRINT_MESSAGE_SUC;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST_1X; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FAIL =>
      next_state <= FAIL;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_FAIL; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINAL =>
      next_state <= FINAL;
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_SUC;
   elsif KEY(15 downto 0) /= "0000000000000000" then
	 next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST_1X;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_FAIL =>
      FSM_MX_MEM     <= '0';
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_SUC =>
      FSM_MX_MEM     <= '1';
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;

