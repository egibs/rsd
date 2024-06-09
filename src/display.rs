use std::fmt;

use super::consts;

pub struct HexAddress(pub u64);

impl fmt::Display for HexAddress {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "0x{:016X} ({} bytes)", self.0, self.0)
    }
}

#[allow(clippy::too_many_arguments)]
pub fn display_program_info(
    header: &[u8],
    elf_type_str: &String,
    elf_type: &u8,
    machine_type_str: &String,
    machine_type: &u16,
    elf_class_str: &String,
    data_encoding_str: &String,
    elf_version: &u8,
    entry_point: &u64,
    phdr_offset: &u64,
    shdr_offset: &u64,
    elf_header_size: &u16,
    phdr_entry_size: &u16,
    phdr_num_entries: &u16,
    shdr_entry_size: &u16,
    shdr_num_entries: &u16,
    shdr_str_index: &u16,
) {
    println!("Full header:");
    for byte in &header[..consts::ELF_HEADER_SIZE] {
        print!("{:02X} ", byte);
    }
    println!("ELF File Type: {} (0x{:02X})", elf_type_str, elf_type);
    println!(
        "Machine Type: {} (0x{:04X})",
        machine_type_str, machine_type
    );
    println!();
    println!("ELF Class: {}", elf_class_str);
    println!("Data Encoding: {}", data_encoding_str);
    println!("ELF Version: {}", elf_version);
    println!("Entry Point Address: {}", entry_point);
    println!("Program Header Table Offset: {}", phdr_offset);
    println!("Section Header Table Offset: {}", shdr_offset);
    println!("ELF Header Size: {} bytes", elf_header_size);
    println!("Program Header Table Entry Size: {} bytes", phdr_entry_size);
    println!(
        "Number of Program Header Table Entries: {}",
        phdr_num_entries
    );
    println!("Section Header Table Entry Size: {} bytes", shdr_entry_size);
    println!(
        "Number of Section Header Table Entries: {}",
        shdr_num_entries
    );
    println!("Section Header String Table Index: {}", shdr_str_index);
}

#[allow(clippy::too_many_arguments)]
pub fn display_segment_info(
    index: &u16,
    segment_type: &u32,
    segment_offset: &u64,
    segment_vaddr: &u64,
    segment_paddr: &u64,
    segment_filesz: &HexAddress,
    segment_memsz: &HexAddress,
    segment_flags: &u32,
) {
    println!("Segment {}:", index);
    println!(
        "  Type: {} (0x{:08X})",
        super::info::get_segment_type(*segment_type),
        segment_type
    );
    println!("  Offset: {}", segment_offset);
    println!("  Virtual Address: {}", segment_vaddr);
    println!("  Physical Address: {}", segment_paddr);
    println!("  File Size: {}", segment_filesz);
    println!("  Memory Size: {}", segment_memsz);
    println!(
        "  Flags: {} (0x{:08X})",
        super::info::get_segment_flags(*segment_flags),
        segment_flags
    );
    println!();
}
