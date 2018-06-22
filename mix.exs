defmodule ScoreApi.Mixfile do
  use Mix.Project

  def project do
    [app: :score_api,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger,
                    :cors_plug,
                    :cowboy,
                    :plug,
                    :mariaex,
                    :ecto,
                    :httpotion,
                    :httpoison,
                    :poison,
                    :mariaex,
                    :ecto,
                    :joken,
                    :os_mon
                    ],
    included_applications: [              
                    :lager,
                    :parse_trans,
                    :uuid
                    ],
           
     mod: {ScoreApi, []}]
  end

  defp deps do
    [
    {:lager, github: "basho/lager"},
      {:cors_plug, "~> 1.1"},
      {:cowboy, "~> 1.0.4"},
      {:plug, "~> 1.2.2"},
      {:poison, "~>2.1"},
      {:mariaex, "~> 0.7.5", override: true},
      {:ecto, "~> 1.1.7"},
      {:httpotion, "~> 3.0.0"},
      {:joken, "~> 1.2"},
      {:httpoison, "~> 0.7"},
      {:uuid, "~> 1.1"},
      {:distillery, "~> 1.5"}
      ]
  end
end