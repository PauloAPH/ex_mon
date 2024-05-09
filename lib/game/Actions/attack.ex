defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_power 12..35
  @move_rnd_power 10..35

  def attackOpponent(opponent, move) do
    damage = calculatePower(move)

    opponent
    |> Game.fetchPlayer()
    |> Map.get(:life)
    |> calculateTotalLife(damage)
    |> updateOpponentLife(opponent, damage)
  end



  defp calculatePower(:move_avg), do: Enum.random(@move_avg_power)
  defp calculatePower(:move_rnd), do: Enum.random(@move_rnd_power)

  defp calculateTotalLife(life, damage) when life - damage < 0, do: 0
  defp calculateTotalLife(life, damage), do: life - damage

  defp updateOpponentLife(life, opponent,damage) do
    opponent
    |> Game.fetchPlayer()
    |> Map.put(:life, life)
    |> updateGame(opponent,damage)
  end

  def updateGame(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.printMoveMsg(opponent, :attack, damage)
  end
end
