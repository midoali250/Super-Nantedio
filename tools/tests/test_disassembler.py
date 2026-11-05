import contextlib
import io
from pathlib import Path
import sys
import tempfile
import unittest
from types import SimpleNamespace

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from nes_disassembler import NESROM, disassemble

class DisassemblerTest(unittest.TestCase):
    def test_cpu_address_operand_relative_and_truncated(self):
        rom = SimpleNamespace(path=Path('synthetic.nes'), prg_rom=bytes([0xA9, 0x01, 0xD0, 0xFC, 0xAD]))
        with contextlib.redirect_stdout(io.StringIO()):
            result = disassemble(rom)
        self.assertIn('$8000: A9 01    LDA  #$01', result)
        self.assertIn('$8002: D0 FC    BNE  $8000', result)
        self.assertIn('truncated instruction', result)

    def test_real_rom(self):
        root = Path(__file__).resolve().parents[2]
        rom = NESROM(root / 'android/app/src/main/assets/mario.nes')
        with tempfile.TemporaryDirectory() as tmp, contextlib.redirect_stdout(io.StringIO()):
            output = Path(tmp) / 'rom.asm'
            disassemble(rom, output_file=output)
            self.assertGreater(output.stat().st_size, 1000)

if __name__ == '__main__':
    unittest.main()
