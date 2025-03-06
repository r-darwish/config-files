local M = {}

---@alias PendingRequests { [string]: boolean }

---@type table<number, PendingRequests>
local pending_requests = {}

local autocmds = require("darwish.autocmds")

---Mark a request as pending
---@param bufnr number
---@param request_id string
local function mark_pending(bufnr, request_id)
  if pending_requests[bufnr] == nil then
    pending_requests[bufnr] = {}
  end

  pending_requests[bufnr][request_id] = true
end

---Mark a request as done
---@param bufnr number
---@param request_id string
local function mark_done(bufnr, request_id)
  if pending_requests[bufnr] == nil then
    return
  end

  pending_requests[bufnr][request_id] = nil
  if #pending_requests[bufnr] == 0 then
    pending_requests[bufnr] = nil
  end
end

---Check if the current buffer has pending requests
---@param bufnr number
---@return boolean
function M.has_pending_requests(bufnr)
  return pending_requests[bufnr] ~= nil
end

vim.api.nvim_create_autocmd("LspRequest", {
  group = autocmds.augroup,
  callback = function(args)
    local bufnr = args.buf
    local request_id = args.data.request_id
    local request = args.data.request

    if request.type == "pending" then
      mark_pending(bufnr, request_id)
    elseif request.type == "cancel" then
      mark_done(bufnr, request_id)
    elseif request.type == "complete" then
      mark_done(bufnr, request_id)
    end
  end,
})

return M
