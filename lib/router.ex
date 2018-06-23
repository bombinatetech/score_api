defmodule ScoreApi.Router do
    require Logger

    use Plug.Router
    use Plug.Debugger

    plug CORSPlug

    plug Plug.Parsers, parsers: [:urlencoded, :json, :multipart],
                       pass:  ["text/*","application/*"],
                       json_decoder: Poison

    plug Plug.Logger
    plug :match
    plug :dispatch

    # Write all the routers below.
    get "/health" do
        resp = %{
            version: "16.11.23",
            upgrades: %{
              one: "Init.",
              msg: "full deployment"
            } 
        }
        conn
        |> send_resp(200,Poison.encode!(resp))
    end

    #this is discover api
    #discover feed fetch from here.
    #it will be based on user_id.
    #auth or no auth ?? need to discuss.
    put "/ver2/score/topic/:topic_id" do
      :lager.log(:info, self, "~p - Requested for trending feeds",[topic_id])
        {status,response} = with  {:ok,feeds}  <- ScoreApi.ScoringManager.add_topic_to_score_table(topic_id) do
                                  {200,Poison.encode!(feeds)}
               else
                               {:error,msg}        -> {400,Poison.encode!(%{message: msg})}
                               _                   -> {400,Poison.encode!(%{message: "Bad Request"})}
               end
    conn
        |> put_resp_content_type("Content-Type","application/json")
        |> send_resp(status, response)
    end

  # This is 404 route, it has to be last one in this page.
    match _ do
      Logger.info "404 Request."
      conn
      |> send_resp(404, "oops, Ok can't serve you on this url.")
    end

end
