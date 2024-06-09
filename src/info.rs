use super::display;
use std::env;
use std::process;

use std::fs::File;

pub fn get_entry_point(header: &[u8]) -> u64 {
    u64::from_le_bytes([
        header[0x18],
        header[0x19],
        header[0x1A],
        header[0x1B],
        header[0x1C],
        header[0x1D],
        header[0x1E],
        header[0x1F],
    ])
}

pub fn get_phdr_offset(header: &[u8]) -> u64 {
    u64::from_le_bytes([
        header[0x20],
        header[0x21],
        header[0x22],
        header[0x23],
        header[0x24],
        header[0x25],
        header[0x26],
        header[0x27],
    ])
}

pub fn get_shdr_offset(header: &[u8]) -> u64 {
    u64::from_le_bytes([
        header[0x28],
        header[0x29],
        header[0x2A],
        header[0x2B],
        header[0x2C],
        header[0x2D],
        header[0x2E],
        header[0x2F],
    ])
}

pub fn get_phdr_segment_type(phdr_entry: &[u8]) -> u32 {
    u32::from_le_bytes([
        phdr_entry[0x04],
        phdr_entry[0x05],
        phdr_entry[0x06],
        phdr_entry[0x07],
    ])
}

pub fn get_phdr_segment_offset(phdr_entry: &[u8]) -> u64 {
    u64::from_le_bytes([
        phdr_entry[0x08],
        phdr_entry[0x09],
        phdr_entry[0x0A],
        phdr_entry[0x0B],
        phdr_entry[0x0C],
        phdr_entry[0x0D],
        phdr_entry[0x0E],
        phdr_entry[0x0F],
    ])
}

pub fn get_phdr_segment_vaddr(phdr_entry: &[u8]) -> u64 {
    u64::from_le_bytes([
        phdr_entry[0x10],
        phdr_entry[0x11],
        phdr_entry[0x12],
        phdr_entry[0x13],
        phdr_entry[0x14],
        phdr_entry[0x15],
        phdr_entry[0x16],
        phdr_entry[0x17],
    ])
}

pub fn get_phdr_segment_paddr(phdr_entry: &[u8]) -> u64 {
    u64::from_le_bytes([
        phdr_entry[0x18],
        phdr_entry[0x19],
        phdr_entry[0x1A],
        phdr_entry[0x1B],
        phdr_entry[0x1C],
        phdr_entry[0x1D],
        phdr_entry[0x1E],
        phdr_entry[0x1F],
    ])
}

pub fn get_phdr_segment_filesz(phdr_entry: &[u8]) -> display::HexAddress {
    display::HexAddress(u64::from_le_bytes([
        phdr_entry[0x20],
        phdr_entry[0x21],
        phdr_entry[0x22],
        phdr_entry[0x23],
        phdr_entry[0x24],
        phdr_entry[0x25],
        phdr_entry[0x26],
        phdr_entry[0x27],
    ]))
}

pub fn get_phdr_segment_memsz(phdr_entry: &[u8]) -> display::HexAddress {
    display::HexAddress(u64::from_le_bytes([
        phdr_entry[0x28],
        phdr_entry[0x29],
        phdr_entry[0x2A],
        phdr_entry[0x2B],
        phdr_entry[0x2C],
        phdr_entry[0x2D],
        phdr_entry[0x2E],
        phdr_entry[0x2F],
    ]))
}

pub fn get_phdr_segment_flags(phdr_entry: &[u8]) -> u32 {
    u32::from_le_bytes([
        phdr_entry[0x30],
        phdr_entry[0x31],
        phdr_entry[0x32],
        phdr_entry[0x33],
    ])
}

pub fn get_file() -> File {
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <file>", args[0]);
        process::exit(1);
    }

    let file = File::open(&args[1]);
    if file.is_err() {
        eprintln!("Failed to open file: {}", args[1]);
        process::exit(1);
    }

    file.unwrap()
}

pub fn get_segment_type(segment_type: u32) -> &'static str {
    match segment_type {
        0x00000000 => "PT_NULL",
        0x00000001 => "PT_LOAD",
        0x00000002 => "PT_DYNAMIC",
        0x00000003 => "PT_INTERP",
        0x00000004 => "PT_NOTE",
        0x00000005 => "PT_SHLIB",
        0x00000006 => "PT_PHDR",
        0x00000007 => "PT_TLS",
        0x6474e550 => "PT_GNU_EH_FRAME",
        0x6474e551 => "PT_GNU_STACK",
        0x6474e552 => "PT_GNU_RELRO",
        _ => "Unknown",
    }
}

pub fn get_segment_flags(segment_flags: u32) -> String {
    let mut flags = String::new();
    match segment_flags {
        0x01 => flags.push('R'),
        0x02 => flags.push('W'),
        0x04 => flags.push('X'),
        _ => flags.push_str("Unknown"),
    }
    flags
}

pub fn get_machine_type(header: &[u8]) -> (String, u16) {
    let machine_type = u16::from_le_bytes([header[0x12], header[0x13]]);
    let machine_type_str = match machine_type {
        0x03 => "x86",
        0x3E => "x86-64",
        0xB7 => "AArch64",
        _ => "Unknown",
    }
    .to_string();
    (machine_type_str, machine_type)
}

pub fn get_elf_type(header: &[u8]) -> (String, u8) {
    let elf_type = header[0x10];
    let elf_type_str = match elf_type {
        0x01 => "Relocatable",
        0x02 => "Executable",
        0x03 => "Shared",
        0x04 => "Core",
        _ => "Unknown",
    }
    .to_string();
    (elf_type_str, elf_type)
}

pub fn get_elf_class(header: &[u8]) -> (String, u8) {
    let elf_class = header[0x04];
    let elf_class_str = match elf_class {
        1 => "32-bit",
        2 => "64-bit",
        _ => "Unknown",
    }
    .to_string();
    (elf_class_str, elf_class)
}

pub fn get_data_encoding(header: &[u8]) -> (String, u8) {
    let data_encoding = header[0x05];
    let data_encoding_str = match data_encoding {
        1 => "Little-endian",
        2 => "Big-endian",
        _ => "Unknown",
    }
    .to_string();
    (data_encoding_str, data_encoding)
}

pub fn bits_to_u16(bits: &[u8; 2]) -> u16 {
    u16::from_le_bytes(*bits)
}

pub fn get_elf_version(header: &[u8]) -> u8 {
    header[0x06]
}
