defmodule AntFarm.Ant do
  @moduledoc """
  Ant GenServer implementation which stores the
  current state of an ant.
  """

  use GenServer

  alias __MODULE__.{State, Behaviour}
  @timeout 60

  @doc false
  def start_link(opts) do
    id = Keyword.fetch!(opts, :id)

    GenServer.start_link(__MODULE__, id, name: name(id))
  end

  def get_state(pid), do: GenServer.call(pid, :get_state)

  def panic(pid), do: GenServer.cast(pid, :panic)

  @impl true
  def init(id) do
    schedule()
    {:ok, State.new(id)}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:perform_actions, state) do
    new_state = Behaviour.process(state)
    schedule()

    {:noreply, new_state}
  end

  @impl true
  def handle_cast(:panic, %State{state: :panicking} = state) do
    {:noreply, state}
  end

  def handle_cast(:panic, state) do
    {:noreply, State.start_panicking(state)}
  end

  defp name(id), do: String.to_atom("ant::" <> id)

  defp schedule do
    Process.send_after(self(), :perform_actions, @timeout)
  end
end
