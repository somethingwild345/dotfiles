local g = vim.g

-- disable header folding
g.vim_markdown_folding_disabled = 1

-- do not use conceal feature, the implementation is not so good
g.vim_markdown_conceal = 0

-- disable math tex conceal feature
g.tex_conceal = ''
g.vim_markdown_math = 1

-- support front matter of various format
g.vim_markdown_frontmatter = 1 -- for YAML format
g.vim_markdown_json_frontmatter = 1 -- for JSON format

-- do not close the preview tab when switching to other buffers
g.mkdp_auto_close = 0
