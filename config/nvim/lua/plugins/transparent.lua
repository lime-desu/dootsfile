-- disable transpareny if inside tmux session
if vim.env.TERM_PROGRAM == "tmux" then
  return {
    {
      "xiyaowong/nvim-transparent",
      config = function()
        require("transparent").setup({
          enable = true, -- boolean: enable transparent
          exclude = {}, -- table: groups you don't want to clear
          ignore_linked_group = true, -- boolean: don't clear a group that links to another group
        })
      end,
    },
  }
end
