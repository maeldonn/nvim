return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', 'go.sum' },
  settings = {
    gopls = {
      semanticTokens = true,
    },
  },
}
