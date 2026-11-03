#!/usr/bin/env python3
"""
NES ROM Disassembler - أداة تفكيك ملفات NES ROM
يستخرج الكود البرمجي (6502 assembly) من ملفات NES ROM ويعرضه بشكل مقروء.

المستخدم: python3 nes_disassembler.py <ملف الروم> [خيارات]
"""

import sys
import struct
import argparse
from pathlib import Path


class NESROM:
    """クラス لتمثيل وتفكيك ملف NES ROM"""

    def __init__(self, path):
        self.path = Path(path)
        self.data = self.path.read_bytes()
        self.header = {}
        self.prg_rom = b''
        self.chr_rom = b''
        self.trainer = b''
        self.parse_header()

    def parse_header(self):
        """تحليل رأس ملف iNES"""
        if len(self.data) < 16:
            raise ValueError("الملف صغير جداً ليكون ملف NES صالح")

        # التوقيع السحري "NES\x1A"
        magic = self.data[0:4]
        if magic != b'NES\x1a':
            raise ValueError(f"ليس ملف NES صالح (التوقيع: {magic})")

        self.header['prg_rom_size'] = self.data[4] * 16 * 1024   # وحدات 16KB
        self.header['chr_rom_size'] = self.data[5] * 8 * 1024    # وحدات 8KB
        self.header['flags6'] = self.data[6]
        self.header['flags7'] = self.data[7]
        self.header['mapper'] = (self.data[6] >> 4) | (self.data[7] & 0xF0)
        self.header['mirroring'] = 'Vertical' if (self.data[6] & 1) else 'Horizontal'
        self.header['has_trainer'] = bool(self.data[6] & 0x04)
        self.header['has_battery'] = bool(self.data[6] & 0x02)

        offset = 16
        if self.header['has_trainer']:
            self.trainer = self.data[offset:offset + 512]
            offset += 512

        self.prg_rom = self.data[offset:offset + self.header['prg_rom_size']]
        offset += self.header['prg_rom_size']
        self.chr_rom = self.data[offset:offset + self.header['chr_rom_size']]

    def summary(self):
        """إرجاع ملخص لمحتويات الروم"""
        return {
            'file': str(self.path),
            'size': len(self.data),
            'mapper': self.header['mapper'],
            'mirroring': self.header['mirroring'],
            'prg_rom_kb': self.header['prg_rom_size'] // 1024,
            'chr_rom_kb': self.header['chr_rom_size'] // 1024,
            'has_trainer': self.header['has_trainer'],
            'has_battery': self.header['has_battery'],
        }


# 6502 opcode table (مختصر للتعليمات الأساسية)
OPCODES = {
    0x00: ('BRK', 'IMP', 1, 7), 0x01: ('ORA', 'IZX', 2, 6), 0x05: ('ORA', 'ZPG', 2, 3),
    0x06: ('ASL', 'ZPG', 2, 5), 0x08: ('PHP', 'IMP', 1, 3), 0x09: ('ORA', 'IMM', 2, 2),
    0x0A: ('ASL', 'ACC', 1, 2), 0x0D: ('ORA', 'ABS', 3, 4), 0x0E: ('ASL', 'ABS', 3, 6),
    0x10: ('BPL', 'REL', 2, 2), 0x11: ('ORA', 'IZY', 2, 5), 0x15: ('ORA', 'ZPX', 2, 4),
    0x16: ('ASL', 'ZPX', 2, 6), 0x18: ('CLC', 'IMP', 1, 2), 0x19: ('ORA', 'ABY', 3, 4),
    0x1D: ('ORA', 'ABX', 3, 4), 0x1E: ('ASL', 'ABX', 3, 7), 0x20: ('JSR', 'ABS', 3, 6),
    0x21: ('AND', 'IZX', 2, 6), 0x24: ('BIT', 'ZPG', 2, 3), 0x25: ('AND', 'ZPG', 2, 3),
    0x26: ('ROL', 'ZPG', 2, 5), 0x28: ('PLP', 'IMP', 1, 4), 0x29: ('AND', 'IMM', 2, 2),
    0x2A: ('ROL', 'ACC', 1, 2), 0x2C: ('BIT', 'ABS', 3, 4), 0x2D: ('AND', 'ABS', 3, 4),
    0x2E: ('ROL', 'ABS', 3, 6), 0x30: ('BMI', 'REL', 2, 2), 0x31: ('AND', 'IZY', 2, 5),
    0x35: ('AND', 'ZPX', 2, 4), 0x36: ('ROL', 'ZPX', 2, 6), 0x38: ('SEC', 'IMP', 1, 2),
    0x39: ('AND', 'ABY', 3, 4), 0x3D: ('AND', 'ABX', 3, 4), 0x3E: ('ROL', 'ABX', 3, 7),
    0x40: ('RTI', 'IMP', 1, 6), 0x41: ('EOR', 'IZX', 2, 6), 0x45: ('EOR', 'ZPG', 2, 3),
    0x46: ('LSR', 'ZPG', 2, 5), 0x48: ('PHA', 'IMP', 1, 3), 0x49: ('EOR', 'IMM', 2, 2),
    0x4A: ('LSR', 'ACC', 1, 2), 0x4C: ('JMP', 'ABS', 3, 3), 0x4D: ('EOR', 'ABS', 3, 4),
    0x4E: ('LSR', 'ABS', 3, 6), 0x50: ('BVC', 'REL', 2, 2), 0x51: ('EOR', 'IZY', 2, 5),
    0x55: ('EOR', 'ZPX', 2, 4), 0x56: ('LSR', 'ZPX', 2, 6), 0x58: ('CLI', 'IMP', 1, 2),
    0x59: ('EOR', 'ABY', 3, 4), 0x5D: ('EOR', 'ABX', 3, 4), 0x5E: ('LSR', 'ABX', 3, 7),
    0x60: ('RTS', 'IMP', 1, 6), 0x61: ('ADC', 'IZX', 2, 6), 0x65: ('ADC', 'ZPG', 2, 3),
    0x66: ('ROR', 'ZPG', 2, 5), 0x68: ('PLA', 'IMP', 1, 4), 0x69: ('ADC', 'IMM', 2, 2),
    0x6A: ('ROR', 'ACC', 1, 2), 0x6C: ('JMP', 'IND', 3, 5), 0x6D: ('ADC', 'ABS', 3, 4),
    0x6E: ('ROR', 'ABS', 3, 6), 0x70: ('BVS', 'REL', 2, 2), 0x71: ('ADC', 'IZY', 2, 5),
    0x75: ('ADC', 'ZPX', 2, 4), 0x76: ('ROR', 'ZPX', 2, 6), 0x78: ('SEI', 'IMP', 1, 2),
    0x79: ('ADC', 'ABY', 3, 4), 0x7D: ('ADC', 'ABX', 3, 4), 0x7E: ('ROR', 'ABX', 3, 7),
    0x81: ('STA', 'IZX', 2, 6), 0x84: ('STY', 'ZPG', 2, 3), 0x85: ('STA', 'ZPG', 2, 3),
    0x86: ('STX', 'ZPG', 2, 3), 0x88: ('DEY', 'IMP', 1, 2), 0x8A: ('TXA', 'IMP', 1, 2),
    0x8C: ('STY', 'ABS', 3, 4), 0x8D: ('STA', 'ABS', 3, 4), 0x8E: ('STX', 'ABS', 3, 4),
    0x90: ('BCC', 'REL', 2, 2), 0x91: ('STA', 'IZY', 2, 6), 0x94: ('STY', 'ZPX', 2, 4),
    0x95: ('STA', 'ZPX', 2, 4), 0x96: ('STX', 'ZPY', 2, 4), 0x98: ('TYA', 'IMP', 1, 2),
    0x99: ('STA', 'ABY', 3, 4), 0x9A: ('TXS', 'IMP', 1, 2), 0x9D: ('STA', 'ABX', 3, 4),
    0xA0: ('LDY', 'IMM', 2, 2), 0xA1: ('LDA', 'IZX', 2, 6), 0xA2: ('LDX', 'IMM', 2, 2),
    0xA4: ('LDY', 'ZPG', 2, 3), 0xA5: ('LDA', 'ZPG', 2, 3), 0xA6: ('LDX', 'ZPG', 2, 3),
    0xA8: ('TAY', 'IMP', 1, 2), 0xAA: ('TAX', 'IMP', 1, 2), 0xAC: ('LDY', 'ABS', 3, 4),
    0xAD: ('LDA', 'ABS', 3, 4), 0xAE: ('LDX', 'ABS', 3, 4), 0xB0: ('BCS', 'REL', 2, 2),
    0xB1: ('LDA', 'IZY', 2, 5), 0xB4: ('LDY', 'ZPX', 2, 4), 0xB5: ('LDA', 'ZPX', 2, 4),
    0xB6: ('LDX', 'ZPY', 2, 4), 0xB8: ('CLV', 'IMP', 1, 2), 0xB9: ('LDA', 'ABY', 3, 4),
    0xBA: ('TSX', 'IMP', 1, 2), 0xBC: ('LDY', 'ABX', 3, 4), 0xBD: ('LDA', 'ABX', 3, 4),
    0xBE: ('LDX', 'ABY', 3, 4), 0xC0: ('CPY', 'IMM', 2, 2), 0xC1: ('CMP', 'IZX', 2, 6),
    0xC4: ('CPY', 'ZPG', 2, 3), 0xC5: ('CMP', 'ZPG', 2, 3), 0xC6: ('DEC', 'ZPG', 2, 5),
    0xC8: ('INY', 'IMP', 1, 2), 0xCA: ('DEX', 'IMP', 1, 2), 0xCC: ('CPY', 'ABS', 3, 4),
    0xCD: ('CMP', 'ABS', 3, 4), 0xCE: ('DEC', 'ABS', 3, 6), 0xD0: ('BNE', 'REL', 2, 2),
    0xD1: ('CMP', 'IZY', 2, 5), 0xD5: ('CMP', 'ZPX', 2, 4), 0xD6: ('DEC', 'ZPX', 2, 5),
    0xD8: ('CLD', 'IMP', 1, 2), 0xD9: ('CMP', 'ABY', 3, 4), 0xDD: ('CMP', 'ABX', 3, 4),
    0xDE: ('DEC', 'ABX', 3, 6), 0xE0: ('CPX', 'IMM', 2, 2), 0xE1: ('SBC', 'IZX', 2, 6),
    0xE4: ('CPX', 'ZPG', 2, 3), 0xE5: ('SBC', 'ZPG', 2, 3), 0xE6: ('INC', 'ZPG', 2, 5),
    0xE8: ('INX', 'IMP', 1, 2), 0xE9: ('SBC', 'IMM', 2, 2), 0xEA: ('NOP', 'IMP', 1, 2),
    0xEC: ('CPX', 'ABS', 3, 4), 0xED: ('SBC', 'ABS', 3, 4), 0xEE: ('INC', 'ABS', 3, 6),
    0xF0: ('BEQ', 'REL', 2, 2), 0xF1: ('SBC', 'IZY', 2, 5), 0xF5: ('SBC', 'ZPX', 2, 4),
    0xF6: ('INC', 'ZPX', 2, 5), 0xF8: ('SED', 'IMP', 1, 2), 0xF9: ('SBC', 'ABY', 3, 4),
    0xFD: ('SBC', 'ABX', 3, 4), 0xFE: ('INC', 'ABX', 3, 6),
}

def _byte(data, offset):
    """Read one byte of the PRG ROM, tolerating the last few bytes of the bank."""
    return data[offset] if 0 <= offset < len(data) else 0


# The lambdas take (pc address, PRG-ROM offset, prg bytes) so that the operand
# reads can never run off the end of the last bank (that used to raise an
# IndexError on the very last instruction of a 128 KB PRG).
ADDRESS_MODES = {
    'IMP': lambda pc, off, data: ('', 0),
    'ACC': lambda pc, off, data: ('A', 0),
    'IMM': lambda pc, off, data: (f'#${_byte(data, off + 1):02X}', 1),
    'ZPG': lambda pc, off, data: (f'${_byte(data, off + 1):02X}', 1),
    'ZPX': lambda pc, off, data: (f'${_byte(data, off + 1):02X},X', 1),
    'ZPY': lambda pc, off, data: (f'${_byte(data, off + 1):02X},Y', 1),
    'ABS': lambda pc, off, data: (f'${_byte(data, off + 2):02X}{_byte(data, off + 1):02X}', 2),
    'ABX': lambda pc, off, data: (f'${_byte(data, off + 2):02X}{_byte(data, off + 1):02X},X', 2),
    'ABY': lambda pc, off, data: (f'${_byte(data, off + 2):02X}{_byte(data, off + 1):02X},Y', 2),
    'IZX': lambda pc, off, data: (f'(${_byte(data, off + 1):02X},X)', 1),
    'IZY': lambda pc, off, data: (f'(${_byte(data, off + 1):02X}),Y', 1),
    'IND': lambda pc, off, data: (f'(${_byte(data, off + 2):02X}{_byte(data, off + 1):02X})', 2),
    'REL': lambda pc, off, data: (
        f'${(pc + 2 + (_byte(data, off + 1) if _byte(data, off + 1) < 128 else _byte(data, off + 1) - 256)) & 0xFFFF:04X}',
        1,
    ),
}


def disassemble(rom, start_addr=0x8000, end_addr=None, output_file=None):
    """تفكيك كود 6502 من منطقة PRG ROM"""
    prg = rom.prg_rom
    # iNES PRG ROM يبدأ عادة من 0x8000 في مساحة العناوين
    if end_addr is None:
        end_addr = start_addr + len(prg)

    lines = []
    lines.append(f"; نكهة الملف: {rom.path.name}")
    lines.append(f"; حجم PRG ROM: {len(prg)} بايت")
    lines.append(f"; نطاق التفكيك: ${start_addr:04X} - ${end_addr-1:04X}")
    lines.append(";" + "=" * 60)
    lines.append("")

    pc = start_addr
    offset = pc - 0x8000  # بدء PRG من 0x8000

    while pc < end_addr and offset < len(prg):
        opcode = prg[offset]
        if opcode in OPCODES:
            mnemonic, mode, size, cycles = OPCODES[opcode]
            operand_str, operand_len = ADDRESS_MODES[mode](pc, offset, prg)
            # بناء 사طر التفكيك
            hex_bytes = ' '.join(f'{prg[offset + i]:02X}' for i in range(min(size, len(prg) - offset)))
            line = f"${pc:04X}: {hex_bytes:<8} {mnemonic:4} {operand_str}"
            lines.append(line)
            pc += size
            offset += size
        else:
            line = f"${pc:04X}: {opcode:02X}          .byte ${opcode:02X}  ; غير معرّف"
            lines.append(line)
            pc += 1
            offset += 1

    result = '\n'.join(lines)

    if output_file:
        Path(output_file).write_text(result, encoding='utf-8')
        print(f"[+] تم حفظ التفكيك في: {output_file}")
    else:
        print(result)

    return result


def main():
    parser = argparse.ArgumentParser(
        description='أداة تفكيك ملفات NES ROM إلى كود تجميعي 6502'
    )
    parser.add_argument('rom', help='مسار ملف NES ROM')
    parser.add_argument('-o', '--output', help='ملف الإخراج (افتراضي: الطباعة على الشاشة)')
    parser.add_argument('-s', '--start', type=lambda x: int(x, 0), default=0x8000,
                        help='عنوان البدء للتفكيك (افتراضي: 0x8000)')
    parser.add_argument('-e', '--end', type=lambda x: int(x, 0), default=None,
                        help='عنوان النهاية للتفكيك')
    parser.add_argument('--summary', action='store_true',
                        help='عرض ملخص للروم فقط دون التفكيك')

    args = parser.parse_args()

    try:
        rom = NESROM(args.rom)
    except Exception as e:
        print(f"[-] خطأ في فتح الملف: {e}", file=sys.stderr)
        return 2

    if args.summary:
        info = rom.summary()
        print("=== ملخص ملف NES ROM ===")
        for k, v in info.items():
            print(f"  {k}: {v}")
        return 0

    disassemble(rom, args.start, args.end, args.output)
    return 0


if __name__ == '__main__':
    sys.exit(main())
