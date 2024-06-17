local M = {}

M.colors = function(colors)
    colors.main.white = '#eeffff'
    colors.main.gray = '#717cb4'
    colors.main.black = '#000000'
    colors.main.red = '#f07178'
    colors.main.green = '#c3e88d'
    colors.main.yellow = '#ffcb6b'
    colors.main.blue = '#82aaff'
    colors.main.paleblue = '#b0c9ff'
    colors.main.cyan = '#89ddff'
    colors.main.purple = '#c792ea'
    colors.main.orange = '#f78c6c'
    colors.main.pink = '#ff9cac'

    colors.editor.bg = '#000000'
    colors.editor.bg_alt = '#1a1a1a'
    colors.editor.fg = '#b0bec5'
    colors.editor.text = '#727272'
    colors.editor.comments = '#616161'
    colors.editor.selection = '#404040'
    colors.editor.contrast = '#1a1a1a'
    colors.editor.active = '#323232'
    colors.editor.border = '#292929'
    colors.editor.line_numbers = '#424242'
    colors.editor.highlight = '#3f3f3f'
    colors.editor.disabled = '#474747'
    colors.editor.accent = '#ff9800'
    colors.editor.error = '#ff5370'
    colors.editor.link = '#80cbc4'
    colors.editor.cursor = '#ffcc00'
end

return M
