defmodule ScoreApi.ScoringModel do
  alias ScoreApi.Repo

  require Logger

  import Ecto.Query, only: [from: 2]

  def update_scores(topic_ids) do
    joined_ids = "('" <> Enum.join(topic_ids,"','") <> "')"
    query = "update content_topics as ct set ct.score = (POWER((select sum(score) from channel_contents where topic_id=ct.topic_id and status =0),2)/ct.n_vokes) where ct.topic_id in #{joined_ids} "
    case Ecto.Adapters.SQL.query(ScoreApi.Repo,query,[]) do
         {:ok, res}  ->
            {:ok,res}
         {:error, error} ->
            IO.inspect "Error while doing query."
            {:error,error}
         _  ->
            IO.inspect "Something else happned."
            {:error,"Random error."}
    end
  end

end