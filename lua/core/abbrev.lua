vim.cmd([[
  cnoreabbrev <expr> W  (getcmdtype() == ':' && getcmdline() ==# 'W')  ? 'w'  : 'W'
  cnoreabbrev <expr> Q  (getcmdtype() == ':' && getcmdline() ==# 'Q')  ? 'q'  : 'Q'
  cnoreabbrev <expr> Wq (getcmdtype() == ':' && getcmdline() ==# 'Wq') ? 'wq' : 'Wq'
  cnoreabbrev <expr> Wqa (getcmdtype() == ':' && getcmdline() ==# 'Wq') ? 'wq' : 'Wqa'
  cnoreabbrev <expr> WQ (getcmdtype() == ':' && getcmdline() ==# 'WQ') ? 'wq' : 'WQ'
  cnoreabbrev <expr> WQa (getcmdtype() == ':' && getcmdline() ==# 'WQ') ? 'wq' : 'WQa'
]])
