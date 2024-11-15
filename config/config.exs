# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :stock_master,
  ecto_repos: [StockMaster.Repo],
  generators: [timestamp_type: :utc_datetime]

config :stock_master, StockMaster.Repo, migration_primary_key: [type: :uuid]

# Configures the endpoint
config :stock_master, StockMasterWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: StockMasterWeb.ErrorHTML, json: StockMasterWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: StockMaster.PubSub,
  live_view: [signing_salt: "4J4oCyL8"],
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg|json)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/your_app_web/views/.*(ex)$},
      ~r{lib/your_app_web/controllers/.*(ex)$},
      ~r{lib/your_app_web/templates/.*(eex)$}
    ]
  ],
  reloadable_compilers: [:gettext, :phoenix, :elixir, :phoenix_swagger]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :stock_master, StockMaster.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  stock_master: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  stock_master: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Swagger
config :stock_master, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: StockMasterWeb.Router,
      endpoint: StockMasterWeb.Endpoint
    ]
  }

config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
