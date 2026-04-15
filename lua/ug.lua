local M = {}

function M.ctrl_g()
  local msg = {}
  local fn = vim.fn
  local isfile = 0 == fn.empty(fn.expand('%:p'))
  -- Show file info.
  local oldmsg = vim.trim(fn.execute('norm! 2'..vim.keycode('<c-g>')))
  local mtime = isfile and fn.strftime('%Y-%m-%d %H:%M',fn.getftime(fn.expand('%:p'))) or ''
  table.insert(msg, { ('%s  %s\n'):format(oldmsg:sub(1), mtime) })

  -- Show git branch
  local gitref = 1 == fn.exists('*FugitiveHead') and fn['FugitiveHead'](7) or nil
  if not gitref or gitref == '' then -- Not in a git buffer, try CWD.
    local ok, rv = pcall(vim.system, { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' })
    gitref = ok and vim.trim(rv:wait().stdout)
  end
  if gitref and gitref ~= '' then
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

--- Parses "owner/repo" from a git remote URL (HTTPS or SSH).
--- @param url string
--- @return string?
local function parse_github_repo(url)
  local owner_repo = url:match('[:/]([%w%-%.]+/[%w%-%.]+)$')
  return owner_repo and owner_repo:gsub('%.git$', '')
end

--- Tries to get the GitHub PR URL for the current branch:
--- 1. Get the current branch name.
--- 2. Iterate git remotes, parse each GitHub owner/repo from the URL.
--- 3. For each remote, ask the GitHub API if the repo is a fork.
--- 4. For forks, get the parent repo and search it for a PR whose head
---    matches "{fork_owner}:{branch}".
--- 5. Return the first matching PR URL.
---
--- @return boolean status
--- @return string url or error message
function M.get_pr_url()
  local branch = vim.trim(vim.fn.system({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }))
  local remotes_raw = vim.trim(vim.fn.system({ 'git', 'remote' }))
  if remotes_raw == '' then
    return false, 'no git remotes found'
  end

  --- @return string? pr_url
  local function find_pr(repo, head)
    local endpoint = ('repos/%s/pulls?head=%s&state=all&per_page=1'):format(repo, head)
    local pr_url = vim.trim(vim.fn.system({ 'gh', 'api', endpoint, '--jq', '.[0].html_url // empty' }))
    return pr_url ~= '' and pr_url or nil
  end

  -- Search for the branch name in "fork" remotes.
  for remote in vim.gsplit(remotes_raw, '\n') do
    local url = vim.trim(vim.fn.system({ 'git', 'remote', 'get-url', remote }))
    local owner_repo = parse_github_repo(url)
    if owner_repo then
      local owner = owner_repo:match('^([^/]+)/')
      -- Ask GitHub if this repo is a fork and get its parent.
      local parent = vim.trim(vim.fn.system({
        'gh', 'api', ('repos/%s'):format(owner_repo),
        '--jq', 'select(.fork) | .parent.full_name // empty',
      }))
      if parent ~= '' then
        local pr_url = find_pr(parent, ('%s:%s'):format(owner, branch))
        if pr_url then
          return true, pr_url
        end
      end
    end
  end

  -- No fork-based PR found. Search each remote's repo for a same-repo PR.
  for remote in vim.gsplit(remotes_raw, '\n') do
    local url = vim.trim(vim.fn.system({ 'git', 'remote', 'get-url', remote }))
    local owner_repo = parse_github_repo(url)
    if owner_repo then
      local pr_url = find_pr(owner_repo, branch)
      if pr_url then
        return true, pr_url
      end
    end
  end

  return false, ('no PR found for branch "%s"'):format(branch)
end

return M
