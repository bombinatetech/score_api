defmodule ScoreApi.ScoringManager do
    use GenServer
    require Logger
    
        @spec get_discover_feed(integer,integer) :: [...]
        def add_topic_to_score_table(topic_id) do
                GenServer.call(__MODULE__,{:add_topic,topic_id})
                {:ok,data}  
        end

        def start_link() do
            GenServer.start_link(__MODULE__,[],[name: __MODULE__])
        end     

        def init(_arg) do
            :ets.new(:score_table,[:named_table])
            update_scores()
            Logger.info "ETS storage worker started."
            {:ok, %{ }}
        end

        def handle_call({:add_topic,topic_id},_From,state) do
            case :ets.lookup(:score_table,:topics) of
                [] ->
                    ok;
                data ->
                    if Enum.member?(data, topic_id) do
                        :ok
                    else
                        :ets.insert(:score_table,{topics,[topic_id|data]})
                        :ok
                    end
            end
            {:reply, :ok,state}
        end


        def handle_info(:refresh_scores,state) do
            update_scores()
            {:noreply,state}
        end

        def terminate(reason, state) do
            {:stop,reason,state}            
        end

        #internal functions
        def update_scores() do
            case :ets.lookup(:score_table,:topics) of
                [] ->
                    ok;
                data ->
                    ScoringModel.update_scores(data)
            end
            timer = Application.get_env(:score_api, :refresh_scores)[:scores_refresh_timer]
            :erlang.send_after(timer, self(), :refresh_scores)
            :ok         
        end

end