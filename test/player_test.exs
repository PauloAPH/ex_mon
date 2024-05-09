defmodule PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "build/4" do
    test "Create a Player" do
      expetedResponse =
        %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Paulo"
        }
      assert expetedResponse == Player.build("Paulo", :chute, :soco, :cura)
    end
  end


end
