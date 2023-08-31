return {
  init = function()
    -- Define global heuristics.
    vim.g.projectionist_heuristics = {
      ["app/&spec/"] = {
        ["app/*.rb"] = {
          alternate = "spec/{}_spec.rb",
        },
        ["app/*.erb"] = {
          alternate = "spec/{}.erb_spec.rb",
        },
        ["spec/*_spec.rb"] = {
          alternate = "app/{}.rb",
        },
        ["spec/*.erb_spec.rb"] = {
          alternate = "app/{}.erb",
        }
      }
    }
  end
}
