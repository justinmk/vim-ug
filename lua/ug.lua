local function ctrl_g()
  local msg = {}
  local fn = vim.fn
  local isfile = 0 == fn.empty(fn.expand('%:p'))
  -- Show file info.
  local oldmsg = vim.trim(fn.execute('norm! 2'..vim.keycode('<c-g>')))
  local mtime = isfile and fn.strftime('%Y-%m-%d %H:%M',fn.getftime(fn.expand('%:p'))) or ''
  table.insert(msg, { ('%s  %s\n'):format(oldmsg:sub(1), mtime) })
  -- Show git branch
  local gitref = 1 == fn.exists('*FugitiveHead') and fn['FugitiveHead'](7) or nil
  if gitref then
    table.insert(msg, { ('branch: %s\n'):format(gitref) })
  end
  -- Show current directory.
  table.insert(msg, { ('dir: %s\n'):format(fn.fnamemodify(fn.getcwd(), ':~')) })
  -- Show current session.
  table.insert(msg, { ('ses: %s\n'):format(#vim.v.this_session > 0 and fn.fnamemodify(vim.v.this_session, ':~') or '?') })
  -- Show process id.
  table.insert(msg, { ('PID: %s\n'):format(fn.getpid()) })
  -- Show current context.
  -- https://git.savannah.gnu.org/cgit/diffutils.git/tree/src/diff.c?id=eaa2a24#n464
  table.insert(msg, {
    fn.getline(fn.search('\\v^[[:alpha:]$_]', 'bn', 1, 100)),
    'Identifier',
  })
  vim.api.nvim_echo(msg, false, {})
end

vim.keymap.set('n', '<c-g>', ctrl_g)

