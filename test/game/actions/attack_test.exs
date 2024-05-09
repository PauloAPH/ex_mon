defmodule AttackTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Game.Actions.Attack
  alias ExMon.{Game,Player}


  describe "attackOpponent/2" do
    test "Attack a opponet" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)
      msg = capture_io(fn ->
        Attack.attackOpponent(:computer,:move_avg)
      end)
      assert msg =~ "attacked the"
    end
  end
end
