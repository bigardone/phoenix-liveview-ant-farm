defmodule AntFarm.Ant.Supervisor.Populator do
  alias AntFarm.Ant.Supervisor, as: AntSupervisor

  @population Application.get_env(:ant_farm, :colony)[:population]

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(_opts \\ []) do
    AntSupervisor.populate(@population)
    :ignore
  end
end
