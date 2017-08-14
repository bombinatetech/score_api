use Mix.Config

#mysql database config.
config :score_api, ScoreApi.Repo,
    adapter: Ecto.Adapters.MySQL,
    database: "oknet",
    username: "ok_master_user",
    password: "OKpass987",
    hostname: "oktalk.cmavudufltgr.ap-southeast-1.rds.amazonaws.com"


config :score_api, :refresh_scores,
  scores_refresh_timer: 1800000