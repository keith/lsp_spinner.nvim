--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local uv = vim.loop
local cmd = vim.cmd

local config = {}
local last_redraw = nil
local timer = uv.new_timer()

local function init(_config)
  config = _config
end

local function redraw_logic()
  -- cmd 'redrawstatus!'
  print('redraw !')
  last_redraw = uv.now()
end

local function redraw()
  if not last_redraw or uv.now() - config.redraw_rate >= last_redraw then
    redraw_logic()
  elseif not timer:is_active() then
    timer:start(config.redraw_rate, 0, vim.schedule_wrap(function()
      timer:stop()
      redraw_logic()
    end))
  end
end

local M = {init = init, redraw = redraw}

return M
