defmodule ExMon.Game.Status do
  alias ExMon.Game
  alias ExMon.Game.Status

  def printRoundMsg(%{status: :started,  turn: player} = info) do
    IO.puts("\nThe game is started")
    IO.inspect(info)
    IO.puts("------------------------------------------------------------------\n")
  end


  def printRoundMsg(%{status: :continue, turn: player} = info) do
    IO.puts("\nIt's #{player} turn")
    IO.inspect(info)
    IO.puts("------------------------------------------------------------------\n")
  end

  def printRoundMsg(%{status: :game_over}) do
    IO.puts("\nGame Over")
  end

  def printWrongMoveMsg(move) do
    IO.puts("\n---------------------Invalid move: #{move} ---------------------------------------------\n")
  end


  def printMoveMsg(:computer, :attack, damage) do
    IO.puts("\n==== The Player attacked the computer dealing #{damage} damage ===\n")
  end

  def printMoveMsg(:player, :attack, damage) do
    IO.puts("\n==== The Computer attacked the player dealing #{damage} damage ===\n")
  end

  def printMoveMsg(player, :heal, life) do
    IO.puts("\n The #{player} healled itself to #{life} life points\n")
  end


end
