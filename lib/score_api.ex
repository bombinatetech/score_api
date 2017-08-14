
defmodule ScoreApi do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
    Plug.Adapters.Cowboy.child_spec(:http, ScoreApi.Router, [], [port: 8090,acceptors: 200,max_connections: 20000,compress: true]),
    supervisor(ScoreApi.Repo, []),
    worker(ScoreApi.ScoringManager,[])
    ]

    opts = [strategy: :one_for_one, name: ScoreApi.Supervisor]
     Supervisor.start_link(children, opts) 
  end

end