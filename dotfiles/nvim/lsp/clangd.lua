return {
  cmd = { "clangd" },
  filetypes = { "cpp", "c" },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  }
}
