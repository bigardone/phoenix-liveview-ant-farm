defmodule AntFarm.Ant.Behaviour do
  @moduledoc """
  Defines the behaviour for a given ant state
  """

  alias AntFarm.Ant.State

  @max_width 1024
  @max_height 600

  @doc """
  Receives an ant state and takes actions
  """
  def process(%State{state: :resting, focus: 0} = state) do
    # If lost focus in resting it start walking
    State.start_walking(state)
  end

  def process(%State{state: :resting} = state) do
    # If focused on resting it keeps resting
    State.keep_resting(state)
  end

  def process(%State{state: :walking, focus: 0} = state) do
    # If loses foucs while walking, it starts resting
    State.start_resting(state)
  end

  def process(%State{state: :walking, speed: speed, position: {x, y}} = state) do
    # If focused on walking, it keeps walking, setting the a new velocity if it reaches
    # the limits, and the position
    {vx, vy} = velocity = calculate_velocity(state)
    position = {x + vx * speed, y + vy * speed}

    state
    |> State.keep_walking()
    |> State.set_velocity(velocity)
    |> State.set_position(position)
  end

  defp calculate_velocity(%State{position: {x, y}, velocity: {vx, vy}, speed: speed}) do
    new_x = x + vx * speed
    new_y = y + vy * speed

    {
      calculate_new_velocity(new_x, @max_width - 1, vx),
      calculate_new_velocity(new_y, @max_height - 1, vy)
    }
  end

  defp calculate_new_velocity(position, _, velocity) when position <= 1, do: velocity * -1
  defp calculate_new_velocity(position, limit, velocity) when position >= limit, do: velocity * -1
  defp calculate_new_velocity(_, _, velocity), do: velocity
end
