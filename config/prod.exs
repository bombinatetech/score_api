use Mix.Config

#mysql database config.
config :score_api, ScoreApi.Repo,
    adapter: Ecto.Adapters.MySQL,
    database: "oknet",
    username: "ok_master_user",
    password: "OKpass987",
    hostname: "oktalk.cmavudufltgr.ap-southeast-1.rds.amazonaws.com"

config :lager,
    log_root: '/home/ubuntu/feedApi/log',
    handlers: [
    lager_console_backend: :info,
    lager_file_backend: [file: './error.log', level: :error],
    lager_file_backend: [file: './console.log', level: :info]
    ]


config :feed_api, :trending,
  trending_refresh_timer: 1800000