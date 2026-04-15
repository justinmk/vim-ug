vim.keymap.set('n', '<c-g>', function()
  require('ug').ctrl_g()
end)

vim.keymap.set('n', 'Ux', function()
  if vim.v.count > 0 then
    local ok, rv = require('ug').get_pr_url()
    if ok then
      vim.ui.open(rv)
    else
      vim.api.nvim_echo({ { ('ug: %s'):format(rv) } }, false, { err = not ok })
    end
  else
    if not pcall(vim.cmd, '.GBrowse') then
      vim.api.nvim_feedkeys(':.GBrowse @', 'n', false)
    end
  end
end)
