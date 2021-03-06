use Mix.Config

#mysql database config.
config :score_api, ScoreApi.Repo,
    adapter: Ecto.Adapters.MySQL,
    database: "vokal_staging",
    username: "oktalk_test",
    password: "oktalk_test",
    hostname: "test.cmavudufltgr.ap-southeast-1.rds.amazonaws.com"


config :score_api, :refresh_scores,
  scores_refresh_timer: 1800000