defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  def mount(_param, _session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       message: "Guess a number",
       answer: answer()
     )}
  end
  defp answer() do
    :rand.uniform(10)
  end


  def handle_event("guess", %{"number"=> guess}, socket) do
    if guess == "#{socket.assigns.answer}" do
      {:noreply,
       assign(
         socket,
         score: socket.assigns.score + 10,
         message: "Your guess #{guess} Correct! Plus 10 points. Another Go",
         answer: answer()
       )}
    else
      {:noreply,
       assign(
         socket,
         score: socket.assigns.score - 1,
         message: "Your guess #{guess} Wrong!! Minus a point. Try again",
         answer: answer()
       )}
    end
  end
end
