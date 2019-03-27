defmodule AntFarm.Ant.Supervisor.Populator do
  alias AntFarm.Ant.Supervisor, as: AntSupervisor

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  @doc false
  def start_link(_opts \\ []) do
    AntSupervisor.populate(500)
    :ignore
  end
end
