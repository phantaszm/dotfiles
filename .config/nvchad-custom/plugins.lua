local plugins = {
  { "mbbill/undotree",
    lazy = false,
    config = function()
      require "custom.configs.undotree"
    end,
  }
}

return plugins
