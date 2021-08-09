cmd = vim.cmd

cmd('au BufWritePost *.cs :silent exec "!dotnet-csharpier %" | e!') -- c# autoformat
cmd('au BufNewFile,BufRead *.cs :set sw=4 ts=4 sts=4') -- c# autoformat

