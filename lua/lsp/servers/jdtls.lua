local jdtls = require("jdtls")
local jdtls_path = require("jdtls.path")
local stdpath = vim.fn.stdpath("data")

-- Path to eclipse.jdt.ls launcher jar
local jdtls_root = stdpath .. "/language-servers/eclipse.jdt.ls"
local jdtls_bin = jdtls_root .. "/org.eclipse.jdt.ls.product/target/repository"
local jdtls_launcher_jar = vim.fn.glob(jdtls_bin .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Getting the OS configuration
local os_config = jdtls_bin .. "/config_linux"

-- Adding a workspace directory per project folder
local project_root = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = stdpath .. "/jdtls_workspace_" .. project_root

-- Path to java-debug respository folder
local jdebug_root = stdpath .. "/language-debuggers/java-debug"

-- Path to vscode-java-test
local jtest_root = stdpath .. "/language-debuggers/vscode-java-test"

-- Manually looking for file (I'm really pissed at ths npm)
local plugin_path = jtest_root .. "/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/"
local jar_patterns = {
  vim.fn.glob(jdebug_root .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)[1], -- Glob returns a list, we take the first element
  vim.fn.glob(jtest_root .. "/java-extension/com.microsoft.java.test.plugin/target/*.jar", 1)[1],    -- Same here
  vim.fn.glob(jtest_root .. "/java-extension/com.microsoft.java.test.runner/target/*.jar", 1)[1],   -- And here
}
local bundle_list = vim.tbl_map(
  function (x) return jdtls_path.join(plugin_path, x) end,
  {
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.junit.jupiter.api*.jar',
    'org.junit.jupiter.engine*.jar',
    'org.junit.jupiter.migrationsupport*.jar',
    'org.junit.jupiter.params*.jar',
    'org.junit.vintage.engine*.jar',
    'org.opentest4j*.jar',
    'org.junit.platform.commons*.jar',
    'org.junit.platform.engine*.jar',
    'org.junit.platform.launcher*.jar',
    'org.junit.platform.runner*.jar',
    'org.junit.platform.suite.api*.jar',
    'org.apiguardian*.jar'
  }
)
vim.list_extend(jar_patterns, bundle_list)
local bundles = {}
for _, pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(pattern), "\n")) do
    if bundle ~= "" and
       not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar') and
       not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
      table.insert(bundles, bundle)
    end
  end
end

-- local bundles = {
--   vim.fn.glob(jdebug_root .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
-- }
-- vim.list_extend(bundles, vim.split(vim.fn.glob(jtest_root .. "/server/*.jar", 1), "\n"))

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", jdtls_launcher_jar,
    "-configuration", os_config,
    "-data", workspace_dir,
  },

  root_dir = vim.fs.root(0, {".git", "pom.xml"}),

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationCodeLens = {
        enabled = true
      },
      referencesCodeLens = {
        enabled = true
      },
      references = {
        includeDecompiledSources = true
      },
      inlayHints = {
        parameterNames = {
          enabled = "all"
        }
      },
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        }
      },
      saveActions = {
        organizeImports = true
      },
      signatureHelp = {
        enabled = true
      },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        useBlocks = true
      }
    }
  },

  on_attach = function(client, bufnr)
    jdtls.setup_dap({hotcodereplace = 'auto'})
    jdtls.setup.add_commands()

    -- jdtls specific actions
    vim.keymap.set("n", "<A-o>", jdtls.organize_imports, { silent = true, buffer = bufnr, desc = "JDTLS: Organize Imports" })
    vim.keymap.set("n", "<leader>crv", jdtls.extract_variable, { silent = true, buffer = bufnr, desc = "JDTLS: Extract Variables" })
    vim.keymap.set("n", "<leader>crc", jdtls.extract_constant, { silent = true, buffer = bufnr, desc = "JDTLS: Extract Constant" })
    vim.keymap.set("n", "<leader>crm", jdtls.extract_method, { silent = true, buffer = bufnr, desc = "JDTLS: Extract Methods" })
    vim.keymap.set("v", "<leader>crm", function() jdtls.extract_method(true) end, { silent = true, buffer = bufnr, desc = "[JDTLS] Extract Method (Visual)" })

    -- Debugger actions (nvim-dap + jdtls)
    vim.keymap.set("n", "<leader>dc", jdtls.test_class, { silent = true, buffer = bufnr, desc = "JDTLS: Debug Class Test" })
    vim.keymap.set("n", "<leader>dm", jdtls.test_nearest_method, { silent = true, buffer = bufnr, desc = "JDTLS: Debug Nearest Method" })
  end,

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
  }
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function ()
    print("Java FileType Detected.")
    jdtls.start_or_attach(config)
  end
})

