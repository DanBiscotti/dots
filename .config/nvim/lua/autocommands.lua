cmd = vim.cmd

cmd('au BufWritePre *.cs :silent exec "!dotnet-csharpier %" | :e!') -- c# autoformat
