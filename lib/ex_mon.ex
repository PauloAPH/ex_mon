defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computerName "Robo"
  @computerMoves [:move_avg, :move_rnd, :move_heal]

  def createPlayer(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def startGame(player) do
    @computerName
    |> createPlayer(:soco ,:chute ,:cura)
    |> Game.start(player)
    Status.printRoundMsg(Game.info())
  end

  def makeMove(move) do
    Game.info()
    |> Map.get(:status)
    |> handleStatus(move)
  end

  defp handleStatus(:game_over, move), do: Status.printRoundMsg(Game.info())

  defp handleStatus(_other, move) do
    move
    |> Actions.fetchMove()
    |> do_Move()

    computerMove(Game.info())
  end

  defp do_Move({:error, move}), do:  Status.printWrongMoveMsg(move)
  defp do_Move({:ok, move}) do
    case move do
      :move_heal -> Actions.cure()
      move -> Actions.attack(move)
    end
    Status.printRoundMsg(Game.info())
  end

  defp computerMove(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computerMoves)}
    do_Move(move)
  end

  defp computerMove(_), do: :ok
end
