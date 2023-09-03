defmodule FunEvents.MessageBuilder do


  def build(guest) do
    """
      ¡Llegó el gran día! ¡Nos casamos!
      Eres una persona especial para nosotros y queremos que seas parte de esta celebración tan importante para nosotros.
      Te invitamos a nuestra boda con cariño, Karen&Joss.
      Te enviamos el link de la invitacion en donde podras confirmar tu asistencia.
      #{guest.invite_url_short}
    """
  end
end
