defmodule EmailsAppWeb.ContactHTML do
  use EmailsAppWeb, :html

  embed_templates "contact_html/*"

  @doc """
  Renders a contact form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def contact_form(assigns)
end
