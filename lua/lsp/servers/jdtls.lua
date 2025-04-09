local jdtls = require("jdtls")

-- Path to eclipse.jdt.ls repository folder
local jdtls_root = vim.fn.stdpath("data") .. "/language-servers/eclipse.jdt.ls"
local jdtls_bin = jdtls_root .. "/org.eclipse.jdt.ls.product/target/repository"

-- Path to java-debug respository folder
local jdebug_root = vim.fn.stdpath("data") .. "/language-debuggers/java-debug"

-- Path to vscode-java-test
local jtest_root = vim.fn.stdpath("data") .. "/language-debuggers/vscode-java-test"

-- Find the launcher JAR dynamically
local launcher_jar = vim.fn.glob(jdtls_bin .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local os_config = "config_linux"

local workspace_dir = vim.fn.stdpath("data") .. "/jdtls_workspace" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local bundles = {
  vim.fn.glob(jdebug_root .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
}
vim.list_extend(bundles, vim.split(vim.fn.glob(jtest_root .. "/server/*.jar", 1), "\n"))

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
    "-jar", launcher_jar,
    "-configuration", jdtls_bin .. "/" .. os_config,
    "-data", workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "build.gradle", "pom.xml"}),

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

jdtls.start_or_attach(config)
