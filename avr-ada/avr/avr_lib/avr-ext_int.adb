---------------------------------------------------------------------------
-- The AVR-Ada Library is free software;  you can redistribute it and/or --
-- modify it under terms of the  GNU General Public License as published --
-- by  the  Free Software  Foundation;  either  version 2, or  (at  your --
-- option) any later version.  The AVR-Ada Library is distributed in the --
-- hope that it will be useful, but  WITHOUT ANY WARRANTY;  without even --
-- the  implied warranty of MERCHANTABILITY or FITNESS FOR A  PARTICULAR --
-- PURPOSE. See the GNU General Public License for more details.         --
--                                                                       --
-- As a special exception, if other files instantiate generics from this --
-- unit,  or  you  link  this  unit  with  other  files  to  produce  an --
-- executable   this  unit  does  not  by  itself  cause  the  resulting --
-- executable to  be  covered by the  GNU General  Public License.  This --
-- exception does  not  however  invalidate  any  other reasons why  the --
-- executable file might be covered by the GNU Public License.           --
---------------------------------------------------------------------------


--  routines for manging external and pin change interrupts
--
--  names and values are taken from atmega168 data sheet. A newer
--  version of the data sheet mentions atmega48a, atmega48pa,
--  atmega88a, atmega88pa, atmega168a, atmega168pa, atmega328,
--  atmega328p
--

with Interfaces;                   use Interfaces;
with AVR.MCU;

package body AVR.Ext_Int is


   --
   -- external interrupts
   --
   procedure Set_Int0_Sense_Control (Trigger : Trigger_T) is
   begin
      case Trigger is
         when Is_Low      =>
            MCU.EICRA_Bits (MCU.ISC00_Bit) := Low;
            MCU.EICRA_Bits (MCU.ISC01_Bit) := Low;
         when Toggle =>
            MCU.EICRA_Bits (MCU.ISC00_Bit) := High;
            MCU.EICRA_Bits (MCU.ISC01_Bit) := Low;
         when Falling_Edge =>
            MCU.EICRA_Bits (MCU.ISC00_Bit) := Low;
            MCU.EICRA_Bits (MCU.ISC01_Bit) := High;
         when Rising_Edge  =>
            MCU.EICRA_Bits (MCU.ISC00_Bit) := High;
            MCU.EICRA_Bits (MCU.ISC01_Bit) := High;
      end case;
   end Set_Int0_Sense_Control;

   procedure Set_Int1_Sense_Control (Trigger : Trigger_T) is
   begin
      case Trigger is
         when Is_Low      =>
            MCU.EICRA_Bits (MCU.ISC10_Bit) := Low;
            MCU.EICRA_Bits (MCU.ISC11_Bit) := Low;
         when Toggle =>
            MCU.EICRA_Bits (MCU.ISC10_Bit) := High;
            MCU.EICRA_Bits (MCU.ISC11_Bit) := Low;
         when Falling_Edge =>
            MCU.EICRA_Bits (MCU.ISC10_Bit) := Low;
            MCU.EICRA_Bits (MCU.ISC11_Bit) := High;
         when Rising_Edge  =>
            MCU.EICRA_Bits (MCU.ISC10_Bit) := High;
            MCU.EICRA_Bits (MCU.ISC11_Bit) := High;
      end case;
   end Set_Int1_Sense_Control;

   procedure Enable_External_Interrupt_0 is
   begin
      MCU.EIMSK_Bits (MCU.INT0_Bit) := True;
   end Enable_External_Interrupt_0;

   procedure Enable_External_Interrupt_1 is
   begin
      MCU.EIMSK_Bits (MCU.INT1_Bit) := True;
   end Enable_External_Interrupt_1;

   procedure Disable_External_Interrupt_0 is
   begin
      MCU.EIMSK_Bits (MCU.INT0_Bit) := False;
   end Disable_External_Interrupt_0;

   procedure Disable_External_Interrupt_1 is
   begin
      MCU.EIMSK_Bits (MCU.INT1_Bit) := False;
   end Disable_External_Interrupt_1;


   --
   -- pin change interrupts (PCI)
   --

   --  provide a bit pattern for the pin change mask registers
   --  (PCMSK0, PCMSK1, PCMSK2).  If a bit is set, a pin change
   --  interrupt is enabled on the corresponding IO pin.  A cleared
   --  bit in the mask disables the PCI on the corresponding IO pin.
   procedure Select_Pins_For_PCI0 (Mask : Unsigned_8) is
   begin
      MCU.PCMSK0 := Mask;
   end Select_Pins_For_PCI0;

   procedure Select_Pins_For_PCI1 (Mask : Unsigned_8) is
   begin
      MCU.PCMSK1 := Mask;
   end Select_Pins_For_PCI1;

   procedure Select_Pins_For_PCI2 (Mask : Unsigned_8) is
   begin
      MCU.PCMSK2 := Mask;
   end Select_Pins_For_PCI2;

   procedure Enable_Pin_Change_Interrupt_0 is
   begin
      MCU.PCICR_Bits (MCU.PCIE0_Bit) := True;
   end Enable_Pin_Change_Interrupt_0;

   procedure Enable_Pin_Change_Interrupt_1 is
   begin
      MCU.PCICR_Bits (MCU.PCIE1_Bit) := True;
   end Enable_Pin_Change_Interrupt_1;

   procedure Enable_Pin_Change_Interrupt_2 is
   begin
      MCU.PCICR_Bits (MCU.PCIE2_Bit) := True;
   end Enable_Pin_Change_Interrupt_2;

   procedure Disable_Pin_Change_Interrupt_0 is
   begin
      MCU.PCICR_Bits (MCU.PCIE0_Bit) := False;
   end Disable_Pin_Change_Interrupt_0;

   procedure Disable_Pin_Change_Interrupt_1 is
   begin
      MCU.PCICR_Bits (MCU.PCIE1_Bit) := False;
   end Disable_Pin_Change_Interrupt_1;

   procedure Disable_Pin_Change_Interrupt_2 is
   begin
      MCU.PCICR_Bits (MCU.PCIE2_Bit) := False;
   end Disable_Pin_Change_Interrupt_2;


end AVR.Ext_Int;
