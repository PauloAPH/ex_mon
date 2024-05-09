defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player

  import ExUnit.CaptureIO

  describe "createPlayer/4" do
    test "Return a player" do
      expetedResponse =
        %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Paulo"
        }
      assert expetedResponse == ExMon.createPlayer("Paulo", :chute, :soco, :cura)
    end
  end


  describe "startGame/1" do
    test "When the game start returns a msg" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      msg = capture_io(fn ->
        assert ExMon.startGame(player) == :ok
      end)
      assert msg =~ "The game is started"
    end
  end

  describe "makeMove/1" do
    setup do
      player = Player.build("Paulo", :chute, :soco, :cura)
      capture_io(fn ->
        ExMon.startGame(player)
      end)
      :ok
    end

    test "when the move is valid, do the move and the computer make a move" do
      msg =
        capture_io(fn ->
          ExMon.makeMove(:chute)
        end)
      assert msg =~ "The Player attacked the computer dealing"
      assert msg =~ "It's computer turn"
      assert msg =~ "It's player turn"
      assert msg =~ "status: :continue"
    end

    test "when the move is invalid return a error msg" do
      msg =
        capture_io(fn ->
        ExMon.makeMove(:wrong)
      end)
      assert msg =~ "Invalid move: wrong"
    end
  end


end
