defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "Start the game state" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end


  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)
      expectedResponse = %{
        computer: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Computer"
          },
          player: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Paulo"
          },
          status: :started,
          turn: :player
      }
      assert Game.info() == expectedResponse
    end
  end

  describe "update/1" do
    test "returns the game state update" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)
      expectedResponse = %{
        computer: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Computer"
          },
          player: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Paulo"
          },
          status: :started,
          turn: :player
      }

      assert Game.info() == expectedResponse

      newState = %{
        computer: %Player{
            life: 85,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Computer"
          },
          player: %Player{
            life: 20,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Paulo"
          },
          status: :started,
          turn: :player
      }
      Game.update(newState)
      expectedResponse = %{newState | turn: :computer, status: :continue}
      assert expectedResponse == Game.info()
    end
  end

  describe "player/0" do
    test "Returns the player" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)
      expectedResponse = %ExMon.Player{
            life: 100,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
            name: "Paulo"
          }
          assert expectedResponse == Game.player()
    end
  end

  describe "turn/0" do
    test "Returns the current turn" do
      player = Player.build("Paulo", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)
      Game.start(computer, player)
      assert :player == Game.turn()
    end
  end


end
