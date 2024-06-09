use std::env;
use std::fmt::Write;
use std::io::{Read, Seek, SeekFrom};

mod consts;
mod display;
mod info;

fn main() {
    // Get the command-line arguments
    let args: Vec<String> = env::args().collect();

    // Check if the program name is provided
    if args.len() != 2 {
        println!("Usage: {} <program_name>", args[0]);
        return;
    }

    // Open the file
    let mut file = info::get_file();

    // Read the ELF header
    let mut header = [0u8; consts::ELF_HEADER_SIZE];
    if let Err(e) = file.read_exact(&mut header) {
        println!("Failed to read the ELF header: {}", e);
        return;
    }

    let magic = &header[..4];
    let magic_string = magic.iter().fold(String::new(), |mut result, b| {
        let _ = write!(result, "{b:02X}");
        result
    });

    // Check if the file is an ELF file
    if magic != consts::ELF_MAGIC {
        println!("{} is not an ELF file ({})", args[1], magic_string);
        return;
    }

    // Extract the ELF file type
    let (elf_type_str, elf_type) = info::get_elf_type(&header);

    let (machine_type_str, machine_type) = info::get_machine_type(&header);

    // Extract the ELF class
    let (elf_class_str, _) = info::get_elf_class(&header);

    // Extract the data encoding
    let (data_encoding_str, _) = info::get_data_encoding(&header);

    // Extract the ELF version
    let elf_version = info::get_elf_version(&header);

    // Extract the entry point address
    let entry_point = info::get_entry_point(&header);

    // Extract the program header table offset
    let phdr_offset = info::get_phdr_offset(&header);

    // Extract the section header table offset
    let shdr_offset = info::get_shdr_offset(&header);

    // Write a function that takes two bytes and returns a u16
    // Extract the ELF header size
    let elf_header_size = info::bits_to_u16(&[header[0x34], header[0x35]]);

    // Extract the program header table entry size
    let phdr_entry_size = info::bits_to_u16(&[header[0x36], header[0x37]]);

    // Extract the number of program header table entries
    let phdr_num_entries = info::bits_to_u16(&[header[0x38], header[0x39]]);

    // Extract the section header table entry size
    let shdr_entry_size = info::bits_to_u16(&[header[0x3A], header[0x3B]]);

    // Extract the number of section header table entries
    let shdr_num_entries = info::bits_to_u16(&[header[0x3C], header[0x3D]]);

    // Extract the section header string table index
    let shdr_str_index = info::bits_to_u16(&[header[0x3E], header[0x3F]]);

    // Print the extracted information
    display::display_program_info(
        &header,
        &elf_type_str,
        &elf_type,
        &machine_type_str,
        &machine_type,
        &elf_class_str,
        &data_encoding_str,
        &elf_version,
        &entry_point,
        &phdr_offset,
        &shdr_offset,
        &elf_header_size,
        &phdr_entry_size,
        &phdr_num_entries,
        &shdr_entry_size,
        &shdr_num_entries,
        &shdr_str_index,
    );

    // Extract the number of program header table entries
    let phdr_num_entries = info::bits_to_u16(&[header[0x38], header[0x39]]);

    // Seek to the program header table offset
    file.seek(SeekFrom::Start(phdr_offset)).unwrap();

    // Print the segment information
    println!("\nSegment Information:");
    for i in 0..phdr_num_entries {
        let mut phdr_entry = [0u8; consts::PHDR_ENTRY_SIZE];
        file.read_exact(&mut phdr_entry).unwrap();

        let segment_type = info::get_phdr_segment_type(&phdr_entry);
        let segment_offset = info::get_phdr_segment_offset(&phdr_entry);
        let segment_vaddr = info::get_phdr_segment_vaddr(&phdr_entry);
        let segment_paddr = info::get_phdr_segment_paddr(&phdr_entry);
        let segment_filesz = info::get_phdr_segment_filesz(&phdr_entry);
        let segment_memsz = info::get_phdr_segment_memsz(&phdr_entry);
        let segment_flags = info::get_phdr_segment_flags(&phdr_entry);

        display::display_segment_info(
            &i,
            &segment_type,
            &segment_offset,
            &segment_vaddr,
            &segment_paddr,
            &segment_filesz,
            &segment_memsz,
            &segment_flags,
        );
    }
}
