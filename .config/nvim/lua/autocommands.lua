cmd = vim.cmd

cmd('au BufWritePost *.cs :silent exec "!dotnet-csharpier %" | e!') -- c# autoformat
