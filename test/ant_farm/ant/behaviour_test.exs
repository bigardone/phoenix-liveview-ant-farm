defmodule AntFarm.Ant.BehaviourTest do
  use ExUnit.Case, async: true

  alias AntFarm.{Ant.State, Ant.Behaviour}

  setup do
    {:ok, state: State.new("ant-1")}
  end

  describe "process/1" do
    test "when state is resting and focus is 0 it starts walking", %{state: state} do
      state = %{state | state: State.resting_state(), focus: 0}

      assert %State{state: :walking, focus: focus} = Behaviour.process(state)
      assert focus > 0
    end

    test "when state is walking and focus is 0 it starts walking", %{state: state} do
      state = %{state | state: State.walking_state(), focus: 0}

      assert %State{state: :resting, focus: focus} = Behaviour.process(state)
      assert focus > 0
    end

    test "when state is walking and focus is not 0 it keeps walking", %{state: state} do
      state = %{state | state: State.walking_state(), focus: 100}

      assert %State{state: :walking, focus: 99} = Behaviour.process(state)
    end
  end
end
