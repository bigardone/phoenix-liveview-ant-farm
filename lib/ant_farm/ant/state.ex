defmodule AntFarm.Ant.State do
  @moduledoc """
  An ant's state structure
  """

  alias __MODULE__

  @max_walking_focus 50
  @max_resting_focus 10
  @walking_state :walking
  @resting_state :resting
  @states [@walking_state, @resting_state]
  @velocity [-1, 0, 1]
  @speed 1
  @width Application.get_env(:ant_farm, :territory)[:width]
  @height Application.get_env(:ant_farm, :territory)[:height]

  @type position :: {integer, integer}
  @type velocity :: {integer, integer}
  @type state :: :walking | :resting

  @type t :: %State{
          id: String.t(),
          position: position,
          velocity: velocity,
          focus: non_neg_integer,
          state: state,
          speed: float
        }

  defstruct [:id, :position, :velocity, :focus, :state, :speed]

  @doc """
  Generates a new state struct
  """
  def new(id) do
    state = random_state()

    %State{
      id: id,
      position: random_position(),
      velocity: random_velocity(),
      focus: random_focus(state),
      state: state,
      speed: @speed
    }
  end

  @doc """
  Starts walking with a random focus and velocity
  """
  def start_walking(state),
    do: %{
      state
      | state: @walking_state,
        focus: random_focus(@walking_state),
        velocity: random_velocity()
    }

  @doc """
  Keeps walking and losing focus
  """
  def keep_walking(state),
    do: %{
      state
      | state: @walking_state,
        focus: state.focus - 1
    }

  @doc """
  Starts resting
  """
  def start_resting(state),
    do: %{state | state: @resting_state, focus: random_focus(@resting_state), velocity: {0, 0}}

  @doc """
  Keeps resting and losing focus
  """
  def keep_resting(state),
    do: %{state | state: @resting_state, focus: state.focus - 1}

  @doc """
  Sets the velocity
  """
  def set_velocity(state, velocity), do: %{state | velocity: velocity}

  @doc """
  Sets the position
  """
  def set_position(state, position), do: %{state | position: position}

  def resting_state, do: @resting_state

  def walking_state, do: @walking_state

  defp random_state, do: Enum.random(@states)

  defp random_focus(@walking_state), do: :rand.uniform(@max_walking_focus)
  defp random_focus(@resting_state), do: :rand.uniform(@max_resting_focus)

  defp random_velocity, do: {Enum.random(@velocity), Enum.random(@velocity)}

  defp random_position, do: {:rand.uniform(@width), :rand.uniform(@height)}
end
