defmodule AntFarmWeb.AntFarmView do
  use Phoenix.LiveView

  alias AntFarm.Ant.Supervisor, as: Colony

  @timeout 60

  def render(assigns) do
    AntFarmWeb.PageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    if connected?(socket), do: schedule()
    ants = Colony.ants()
    {:ok, assign(socket, ants: ants)}
  end

  def handle_info(:tick, socket) do
    schedule()
    ants = Colony.ants()
    {:noreply, assign(socket, ants: ants)}
  end

  defp schedule do
    Process.send_after(self(), :tick, @timeout)
  end
end
